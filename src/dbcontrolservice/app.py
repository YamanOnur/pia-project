from flask import Flask, request, render_template
import grpc
import query_service_pb2
import query_service_pb2_grpc

app = Flask(__name__)

# gRPC client setup
def run_query(sql_query):
    with grpc.insecure_channel('dbcontrolservice:50055') as channel:
        stub = query_service_pb2_grpc.QueryServiceStub(channel)
        request = query_service_pb2.QueryRequest(sql_query=sql_query)
        response = stub.ExecuteQuery(request)
        return response.results

@app.route('/', methods=['GET', 'POST'])
def query_form():
    query_result = None
    if request.method == 'POST':
        sql_query = request.form['query']
        try:
            query_result = run_query(sql_query)  # Send the query via gRPC
        except grpc.RpcError as e:
            query_result = [f"gRPC error: {e.details()}"]

    return render_template('index.html', query_result=query_result)

if __name__ == '__main__':
    app.run(debug=True)
