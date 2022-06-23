#!/usr/bin/python3
from wsgiref.handlers import CGIHandler
from flask import Flask
from flask import render_template, request
import psycopg2
import psycopg2.extras

## SGBD configs
DB_HOST = "db.tecnico.ulisboa.pt"
DB_USER = "ist199265"
DB_DATABASE = DB_USER
DB_PASSWORD = "xafn9934"
DB_CONNECTION_STRING = "host=%s dbname=%s user=%s password=%s" % (
    DB_HOST,
    DB_DATABASE,
    DB_USER,
    DB_PASSWORD,
)

app = Flask(__name__)

@app.route("/")
def list_home():
    dbConn = None
    cursor = None
    try:
        return render_template("index.html")
    except Exception as e:
        return str(e)


#a)
#Inserir e Remover categorias
@app.route("/categorias")
def list_categorias2():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM categoria;"
        cursor.execute(query)
        return render_template("categorias.html", cursor=cursor)
    except Exception as e:
        return str(e)  # Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()


@app.route("/categorias-insert-form")
def categorias_insert_form():
    try:
        return render_template("categorias-insert-form.html", params=request.args)
    except Exception as e:
        return str(e)

@app.route("/categorias-insert-apply", methods=["POST"])
def categorias_insert_apply():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        new_name = request.form["new_name"]
        query = "INSERT INTO categoria VALUES('{s}');".format(s=new_name)
        data = (new_name)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/categorias-remove")
def categorias__remove():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        param = request.args
        nome = param.get('nome')
        query = "DELETE FROM evento_reposicao WHERE ean in (SELECT ean FROM produto WHERE cat = '{s}'); \
                DELETE FROM responsavel_por WHERE nome_cat ='{s}'; \
                DELETE FROM planograma WHERE ean in (SELECT ean FROM produto WHERE cat = '{s}'); \
                DELETE FROM prateleira WHERE nome ='{s}'; \
                DELETE FROM tem_categoria WHERE nome ='{s}'; \
                DELETE FROM produto WHERE cat = '{s}'; \
                DELETE FROM tem_outra WHERE categoria='{s}'; \
                DELETE FROM categoria_simples WHERE nome = '{s}'; \
                DELETE FROM tem_outra WHERE super_categoria='{s}'; \
                DELETE FROM super_categoria WHERE nome = '{s}'; \
                DELETE FROM categoria WHERE nome = '{s}';".format(s=nome)
        data = (nome)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()


# (b)
# Inserir e remover um retalhista, com todas suas as responsabilidades de reposições de produtos, 
# garantindo que esta operação seja atómica

@app.route("/retalhistas")
def list_retalhistas():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM retalhista;"
        cursor.execute(query)
        return render_template("retalhistas.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route("/retalhistas-insert-form")
def retalhistas_insert_form():
    try:
        return render_template("retalhistas-insert-form.html")
    except Exception as e:
        return str(e)

@app.route("/retalhistas-insert-apply", methods=["POST"])
def retalhistas_insert_apply():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        new_tin = request.form["new_tid"]
        new_name = request.form["new_name"]
        query = 'INSERT INTO retalhista VALUES(%s, %s);'
        data = (new_tin, new_name)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

@app.route("/retalhistas-remove")
def retalhistas_remove():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        params = request.args
        tin1 = tin2 = tin3 = params.get('tin')
        query = 'DELETE FROM evento_reposicao WHERE tin = %s; \
                 DELETE FROM responsavel_por WHERE tin = %s; \
                 DELETE FROM retalhista WHERE tin = %s;'
        data = (tin1, tin2, tin3)
        cursor.execute(query, data)
        return query
    except Exception as e:
        return str(e)
    finally:
        dbConn.commit()
        cursor.close()
        dbConn.close()

#c
#Listar todos os eventos de reposição de uma IVM, apresentando o número de unidades repostas por categoria de produto 

@app.route("/ivms")
def list_ivm():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM ivm;"
        cursor.execute(query)
        return render_template("ivms.html", cursor=cursor)
    except Exception as e:
        return str(e)  # Renders a page with the error.
    finally:
        cursor.close()
        dbConn.close()

@app.route("/ivm-evento-reposicao")
def ivm_repo_event():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        params = request.args
        num_serie_ivm = params.get('num_serie')
        query = 'SELECT *\
            FROM evento_reposicao\
            WHERE num_serie = %s;'
        data = (num_serie_ivm)
        cursor.execute(query, data)
        return render_template("ivm-evento-reposicao.html",cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route("/ivm-evento-reposicao-overview")
def ivm_repo_event_overview():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        params = request.args
        num_serie_ivm = params.get('num_serie')
        query = "SELECT cat, SUM(unidades)\
             FROM evento_reposicao natural join produto\
             WHERE num_serie = %s GROUP BY cat;"
        data = (num_serie_ivm)
        cursor.execute(query, data)
        return render_template("ivm-evento-reposicao-overview.html",cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

#
# (d)
# Listar todas as sub-categorias de uma super-categoria, a todos os níveis de profundidade.
#

@app.route("/sub-categorias")
def list_sub_categorias():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        query = "SELECT * FROM super_categoria;"
        cursor.execute(query)
        return render_template("sub-categorias.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()

@app.route("/sub-categorias-deepened")
def list_sub_categorias_deepened():
    dbConn = None
    cursor = None
    try:
        dbConn = psycopg2.connect(DB_CONNECTION_STRING)
        cursor = dbConn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        params = request.args
        to_deepen = params.get('to_deepen')
        query = "SELECT categoria AS sub_categoria FROM tem_outra WHERE super_categoria = '{s}';".format(s=to_deepen)
        data = (to_deepen)
        cursor.execute(query, data)
        return render_template("sub-categorias-deepened.html", cursor=cursor)
    except Exception as e:
        return str(e)
    finally:
        cursor.close()
        dbConn.close()
    



CGIHandler().run(app)




