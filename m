Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Ruuol-00018O-GH
 for kexec@lists.infradead.org; Tue, 07 Feb 2012 23:51:24 +0000
Received: by yenm4 with SMTP id m4so3497228yen.36
 for <kexec@lists.infradead.org>; Tue, 07 Feb 2012 15:51:21 -0800 (PST)
From: Tyler Hall <tylerwhall@gmail.com>
Subject: [PATCH] Fix out-of-tree build
Date: Tue,  7 Feb 2012 18:50:05 -0500
Message-Id: <1328658605-25688-1-git-send-email-tylerwhall@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: horms@verge.net.au, Tyler Hall <tylerwhall@gmail.com>

Use automatic variables for prerequisites when copying man pages and
include a makefile relative to $(srcdir).

Signed-off-by: Tyler Hall <tylerwhall@gmail.com>
---
 kdump/Makefile          |    2 +-
 kexec/Makefile          |    2 +-
 kexec/arch/ppc/Makefile |    2 +-
 vmcore-dmesg/Makefile   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kdump/Makefile b/kdump/Makefile
index 1e2b72c..5dfa928 100644
--- a/kdump/Makefile
+++ b/kdump/Makefile
@@ -22,7 +22,7 @@ $(KDUMP): $(KDUMP_OBJS)
 
 $(KDUMP_MANPAGE): kdump/kdump.8
 	$(MKDIR) -p     $(MANDIR)/man8
-	cp kdump/kdump.8 $(KDUMP_MANPAGE)
+	cp $^ $(KDUMP_MANPAGE)
 echo::
 	@echo "KDUMP_SRCS $(KDUMP_SRCS)"
 	@echo "KDUMP_DEPS $(KDUMP_DEPS)"
diff --git a/kexec/Makefile b/kexec/Makefile
index 2137cab..8c815b5 100644
--- a/kexec/Makefile
+++ b/kexec/Makefile
@@ -82,7 +82,7 @@ $(KEXEC): CPPFLAGS+=-I$(srcdir)/kexec/arch/$(ARCH)/include
 
 $(KEXEC_MANPAGE): kexec/kexec.8
 	@$(MKDIR) -p     $(MANDIR)/man8
-	cp kexec/kexec.8 $(KEXEC_MANPAGE)
+	cp $^ $(KEXEC_MANPAGE)
 echo::
 	@echo "KEXEC_SRCS $(KEXEC_SRCS)"
 	@echo "KEXEC_DEPS $(KEXEC_DEPS)"
diff --git a/kexec/arch/ppc/Makefile b/kexec/arch/ppc/Makefile
index 3dba7cf..41242a5 100644
--- a/kexec/arch/ppc/Makefile
+++ b/kexec/arch/ppc/Makefile
@@ -1,7 +1,7 @@
 #
 # kexec ppc (linux booting linux)
 #
-include kexec/arch/ppc/libfdt/Makefile.libfdt
+include $(srcdir)/kexec/arch/ppc/libfdt/Makefile.libfdt
 
 ppc_KEXEC_SRCS =  kexec/arch/ppc/kexec-ppc.c
 ppc_KEXEC_SRCS += kexec/arch/ppc/kexec-elf-ppc.c
diff --git a/vmcore-dmesg/Makefile b/vmcore-dmesg/Makefile
index 5a6d84a..42c218a 100644
--- a/vmcore-dmesg/Makefile
+++ b/vmcore-dmesg/Makefile
@@ -21,7 +21,7 @@ $(VMCORE_DMESG): $(VMCORE_DMESG_OBJS)
 
 $(VMCORE_DMESG_MANPAGE): vmcore-dmesg/vmcore-dmesg.8
 	$(MKDIR) -p     $(MANDIR)/man8
-	cp vmcore-dmesg/vmcore-dmesg.8 $(VMCORE_DMESG_MANPAGE)
+	cp $^ $(VMCORE_DMESG_MANPAGE)
 echo::
 	@echo "VMCORE_DMESG_SRCS $(VMCORE_DMESG_SRCS)"
 	@echo "VMCORE_DMESG_DEPS $(VMCORE_DMESG_DEPS)"
-- 
1.7.9


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
