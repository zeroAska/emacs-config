(define-skeleton hello-world-skeleton
  "Write a greeting"
  "Type name of user: "
  "hello, " str "!")

(define-skeleton c-tri-author-skeleton
  "authorship declare header with c style"
  "Type file name: "
  "/*******************************************************************************\n* Copyright TRI\n*\n* @File " str "\n* @author Ray Zhang\n* @date " (today) "\n*\n*******************************************************************************/\n" )


(define-skeleton sharp-tri-author-skeleton
  "authorship declare header with #"
  "Type file name: "
  "################################################################################\n# Copyright TRI\n#\n# @File " str "\n# @author Ray Zhang\n# @date " (today) "\n#\n###############################################################################\n" )


(define-skeleton c-header-skeleton
  "Add C header"
  "Type file name without extension: "
  "#ifndef __" str "_H__\n\#define __" str "_H__\n\n\#endif")
