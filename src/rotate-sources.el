
(defun bcreate-test ( input-file )
  "Create a google test file"
  (interactive "sFile: " )
  (bcreate-generic " --test " input-file))

(defun bcreate-cpp ( input-file )
  "Create an implentation cpp file"
  (interactive "sFile: ")
  (bcreate-generic " --cpp " input-file)) 

(defun bcreate-generic ( type input-file )
  "Create either a cpp or t.cpp file depending on given type"
  (shell-command-on-region (point-min) (point-max) (concat "generate.py " type input-file) t))

(defun rotate-sources-create ( &optional arg )
  "Rotate the sourced .h -> .cpp -> t.cpp"
  (interactive)
  (defun option ( choice)
    ( if (string= choice ".cpp")
	" --cpp "
      " --test "))
  (defun load-rotation ( header-file file-to-load file-ext )
    (if (string= file-ext ".h")
	(switch-to-buffer (find-file-noselect file-to-load))
      (cond
       ((file-exists-p file-to-load)
	(switch-to-buffer (find-file-noselect file-to-load)))
       ((get-buffer (file-name-nondirectory file-to-load))
	(switch-to-buffer (find-file-noselect file-to-load)))
       (t
	 (switch-to-buffer (find-file-noselect file-to-load))
	 (bcreate-generic (option file-ext)  header-file)))))
  (let* ( (current-file (if arg arg (buffer-file-name)))
	  (current-base (file-name-sans-extension current-file))
	  (current-ext  (file-name-extension current-file))
	  (current-ext-second (file-name-extension current-base))
	  (current-base-second (file-name-sans-extension current-base)))
    (cond
     ((string= current-ext-second "t")
      (load-rotation (concat current-base-second ".h") (concat current-base-second ".h") ".h"))
     ((string= current-ext "h")
      (load-rotation (concat current-base ".h") (concat current-base ".cpp") ".cpp" ))
     ((string= current-ext "cpp")
      (load-rotation (concat current-base ".h") (concat current-base ".t.cpp") ".t.cpp"))
     )))

(defun rotate-sources ( &optional arg )
  (interactive)
  (defun load-rotation ( file-to-load )
        (switch-to-buffer (find-file-noselect file-to-load)))
  (let* ( (current-file (if arg arg (buffer-file-name)))
                  (current-base (file-name-sans-extension current-file))
                  (current-ext  (file-name-extension current-file))
                  (current-ext-second (file-name-extension current-base))
                  (current-base-second (file-name-sans-extension current-base)))
        (cond
         ((string= current-ext-second "t")
          (load-rotation (concat current-base-second ".h")))
         ((string= current-ext "h")
          (load-rotation (concat current-base ".cpp")))
         ((string= current-ext "cpp")
          (load-rotation (concat current-base ".t.cpp")))
         )))

