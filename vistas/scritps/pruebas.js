var objetoDataTables_miembros = $("#tabla_de_miembros").DataTable({
    language: {
        emptyTable: "No hay datos disponibles en la tabla.",
        info: "Del _START_ al _END_ de _TOTAL_ ",
        infoEmpty: "Mostrando 0 registros de un total de 0.",
        infoFiltered: "(filtrados de un total de _MAX_ registros)",
        infoPostFix: "(actualizados)",
        lengthMenu: "Mostrar _MENU_ registros",
        loadingRecords: "Cargando...",
        processing: "Procesando...",
        search: "Buscar:",
        searchPlaceholder: "Dato para buscar",
        zeroRecords: "No se han encontrado coincidencias.",
        paginate: {
            first: "Primera",
            last: "Última",
            next: "Siguiente",
            previous: "Anterior",
        },
        aria: {
            sortAscending: "Ordenación ascendente",
            sortDescending: "Ordenación descendente",
        },
    },
    lengthMenu: [
        [5, 10, 20, 25, 50, -1],
        [5, 10, 20, 25, 50, "Todos"],
    ],
    iDisplayLength: 5,
    bJQueryUI: false,
    ajax: "datos_externos_04.php",
    columns: [{
            data: 0
        },
        {
            data: 1
        },
        {
            data: 2,
            orderable: false,
            searchable: false
        },
        {
            data: 3
        },
    ],
});
$("label").addClass("form-inline");
$('select, input[type="search"]').addClass("form-control input-sm");

//--------------------------------------
