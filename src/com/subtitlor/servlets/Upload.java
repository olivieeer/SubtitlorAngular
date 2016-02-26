package com.subtitlor.servlets;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;

public class Upload extends HttpServlet {

    public static final int   TAILLE_TAMPON    = 10240;
    public static final int   MAX_SIZE         = 10 * 1024 * 1024; // 10Mb
    private ServletFileUpload uploader         = null;
    private static final long serialVersionUID = 1L;
    private File              file;
    private File              filesDir;
    private FileItem          fileItem;
    private String            fileDescription;

    @Override
    public void init() throws ServletException {
        DiskFileItemFactory fileFactory = new DiskFileItemFactory();
        filesDir = (File) getServletContext().getAttribute( "FILES_DIR_FILE" );
        fileFactory.setRepository( filesDir );
        this.uploader = new ServletFileUpload( fileFactory );
    }

    @Override
    protected void doGet( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {

        /* Récupération de la date courante */
        DateTime dt = new DateTime();
        /* Conversion de la date en String selon le format défini */
        org.joda.time.format.DateTimeFormatter formatter = DateTimeFormat.forPattern( "dd/MM/yyyy HH:mm:ss" );
        String date = dt.toString( formatter );
        request.setAttribute( "disparaitreBouttonEditer", "disparaitreBouttonEditer" );
        this.getServletContext().getRequestDispatcher( "/WEB-INF/upload.jsp" ).forward( request, response );
    }

    @Override
    public void doPost( HttpServletRequest request, HttpServletResponse response )
            throws ServletException, IOException {
        String description = null;
        // StringBuffer jb = new StringBuffer();
        // String line = null;
        // try {
        // BufferedReader reader = request.getReader();
        // while ( ( line = reader.readLine() ) != null )
        // jb.append( line );
        // System.out.println( line );
        // } catch ( Exception e ) {
        // /* report an error */ }
        // System.out.println( jb.toString() );
        // System.out.println( jb.toString() );
        // JSONObject jsonObject = null;
        // jsonObject = new JSONObject( jb.toString() );
        // String essai = (String) jsonObject.get( "lastname" );
        if ( !ServletFileUpload.isMultipartContent( request ) ) {
            throw new ServletException( "Content type is not multipart/form-data" );
        }
        try {

            FileItemFactory factory = new DiskFileItemFactory();

            // Create a new file upload handler
            ServletFileUpload upload = new ServletFileUpload( factory );
            List<FileItem> uploadItems = upload.parseRequest( request );

            for ( FileItem uploadItem : uploadItems ) {
                if ( uploadItem.isFormField() ) {
                    String fieldName = uploadItem.getFieldName();
                    fileDescription = uploadItem.getString();
                }
            }
            Iterator<FileItem> fileUploadItemsIterator = uploadItems.iterator();
            while ( fileUploadItemsIterator.hasNext() ) {
                fileItem = fileUploadItemsIterator.next();
                if ( fileItem.getName() == null ) {
                    continue;
                }
                // System.out.println( "FileName=" + fileItem.getName() );
                // System.out.println( "ContentType=" +
                // fileItem.getContentType() );
                // System.out.println( "Size in bytes=" + fileItem.getSize() );
                file = new File(
                        request.getServletContext().getAttribute( "FILES_DIR" ) + File.separator + fileItem.getName() );
                String filename;
                filename = file.getName();
                if ( filename != null && !filename.isEmpty() && !filename.equals( "tmpfiles" ) ) {
                    // Corrige un bug du fonctionnement d'Internet Explorer
                    filename = filename.substring( filename.lastIndexOf( '/' ) + 1 )
                            .substring( filename.lastIndexOf( '\\' ) + 1 );
                    String extension = filename.substring( filename.indexOf( "." ) );
                    if ( !extension.equals( ".srt" ) ) {
                        request.setAttribute( "erreurPasFichierSrt", new String( "erreurPasFichierSrt" ) );
                        request.setAttribute( "disparaitreBouttonEditer", "disparaitreBouttonEditer" );
                    } else {
                        System.out.println( "Absolute Path at server=" + file.getAbsolutePath() );
                        fileItem.write( file );
                        System.out.println( "File " + fileItem.getName() + " uploaded successfully." );
                        request.setAttribute( "succesUpload", "succesUpload" );
                        request.getSession().setAttribute( "fileItem", fileItem );
                        request.getSession().setAttribute( "nomFichier", fileItem.getName() );
                        request.getSession().setAttribute( "Fichierdescription", fileDescription );
                        request.getSession().setAttribute( "pathFile", file.getAbsolutePath() );
                        String pathFile = file.getAbsolutePath();
                        int nbDerniereSlash = pathFile.lastIndexOf( "\\" );
                        pathFile = pathFile.substring( 0, nbDerniereSlash + 1 );
                        request.getSession().setAttribute( "pathFileTomcat", pathFile );
                    }
                } else {
                    request.setAttribute( "disparaitreBouttonEditer", "disparaitreBouttonEditer" );
                    request.setAttribute( "erreurPasDeFichierSelectionne",
                            new String( "erreurPasDeFichierSelectionne" ) );
                }
            }

        } catch ( FileUploadException e ) {
            request.setAttribute( "errorFileUpload", e.getMessage() );
        } catch ( Exception e ) {
            request.setAttribute( "errorFileUpload", e.getMessage() );
        }
        this.getServletContext().getRequestDispatcher( "/WEB-INF/upload.jsp" ).forward( request, response );
    }

}
