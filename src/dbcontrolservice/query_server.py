import grpc
from concurrent import futures
import mysql.connector
import query_service_pb2
import query_service_pb2_grpc

class QueryServiceServicer(query_service_pb2_grpc.QueryServiceServicer):
    def __init__(self):
        self.connection = mysql.connector.connect(
            host='mysql',
            user='root',
            password='rootpassword',
            database='dbcontrolservice_db'
        )
        self.cursor = self.connection.cursor()

    def ExecuteQuery(self, request, context):
        query = request.sql_query
        self.cursor.execute(query)
        
        # Commit the transaction if the query modifies the database
        if query.strip().upper().startswith(('INSERT', 'UPDATE', 'DELETE')):
            self.connection.commit()
        
        # Fetch the results (for SELECT queries)
        results = [str(row) for row in self.cursor.fetchall()]
        return query_service_pb2.QueryResponse(results=results)

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    query_service_pb2_grpc.add_QueryServiceServicer_to_server(QueryServiceServicer(), server)
    server.add_insecure_port('[::]:50055')
    print("Attempting to start gRPC server on port 50055")
    server.start()
    print("gRPC server started successfully")
    server.wait_for_termination()

if __name__ == '__main__':
    serve()
