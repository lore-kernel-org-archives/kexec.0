Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KIvrQ-0003WU-BO
	for kexec@lists.infradead.org; Wed, 16 Jul 2008 01:31:16 +0000
Date: Wed, 16 Jul 2008 10:31:12 +0900
From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: PATCH] Add .gitignore to ignore auto genrated files.
Message-ID: <20080716013112.GC19192%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Disposition: inline
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org

Add .gitignore to ignore auto genrated files.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp
---
 .gitignore       |   19 +++++++++++++++++++
 kexec/.gitignore |    1 +
 2 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 .gitignore
 create mode 100644 kexec/.gitignore

diff --git a/.gitignore b/.gitignore
new file mode 100644
index 0000000..f382a0a
--- /dev/null
+++ b/.gitignore
@@ -0,0 +1,19 @@
+#
+# Normal rules
+#
+*~
+*.a
+*.d
+*.o
+*.ro
+
+# generated files
+Makefile
+autom4te.cache/
+bin/
+build/
+config.log
+config.status
+configure
+include/config.h.in
+include/config.h
diff --git a/kexec/.gitignore b/kexec/.gitignore
new file mode 100644
index 0000000..aae25d2
--- /dev/null
+++ b/kexec/.gitignore
@@ -0,0 +1 @@
+purgatory.c
-- 
1.5.6



-- 
yamahata

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
