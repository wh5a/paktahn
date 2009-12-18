(in-package :pak)

(defun install-local-package (path)
  "Install PKGBUILD from path locally.
If not found, install the package remotely as usual."
  (when (rootp)
    (error "You're running Paktahn as root; makepkg will not work.~%~
            Try running as a normal user and Paktahn will invoke `sudo' as necessary."))
  (let ((orig-dir (current-directory)))
    (handler-case
        (progn
          (info "Install ~A locally." path)

          ;; get dependencies, display, install
          (setf (current-directory) path)
          (multiple-value-bind (deps make-deps) (get-pkgbuild-dependencies)
            (format t "~%deps: ~S~%makedeps: ~S~%" deps make-deps)
            (setf (current-directory) orig-dir)
            (mapcar 'install-local-package (append deps make-deps)))
          (setf (current-directory) path)

          (run-makepkg)
          (install-pkg-tarball))
      (condition ()
        (info "Install ~A remotely." path)
        (setf (current-directory) orig-dir)
        (install-package path))
      (:no-error ()
        (setf (current-directory) orig-dir)))))
