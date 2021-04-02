Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lSH1E-00Ck8h-Jv
 for kexec@lists.infradead.org; Fri, 02 Apr 2021 10:27:18 +0000
From: Simon Horman <horms@verge.net.au>
Subject: [PATCH kexec-tools 3/7] build: uninstall kexec_test
Date: Fri,  2 Apr 2021 12:17:33 +0200
Message-Id: <20210402101737.1886-4-horms@verge.net.au>
In-Reply-To: <20210402101737.1886-1-horms@verge.net.au>
References: <20210402101737.1886-1-horms@verge.net.au>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: Simon Horman <horms@verge.net.au>

kexec_test is installed but not uninstalled.
Correct this oversight.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 Makefile.in | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index dc7fb07..4fe1016 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -181,15 +181,19 @@ UNINSTALL_KDUMP = $(sbindir)/kdump
 UNINSTALL_KDUMP_MANPAGE = $(mandir)/man8/kdump.8
 UNINSTALL_KEXEC = $(sbindir)/kexec
 UNINSTALL_KEXEC_MANPAGE = $(mandir)/man8/kexec.8
+UNINSTALL_KEXEC_TEST = $(pkglibdir)/kexec_test
 UNINSTALL_VMCORE_DMESG = $(sbindir)/vmcore-dmesg
 UNINSTALL_VMCORE_DMESG_MANPAGE = $(mandir)/man8/vmcore-dmesg.8
 
 TARGETS:=$(BINARIES) $(MAN_PAGES)
 targets: $(TARGETS)
 
+UNINSTALL_TARGETS_i386:=$(UNINSTALL_KEXEC_TEST)
+UNINSTALL_TARGETS_x86_64:=$(UNINSTALL_KEXEC_TEST)
 UNINSTALL_TARGETS:=$(UNINSTALL_KDUMP) $(UNINSTALL_KDUMP_MANPAGE) \
 		   $(UNINSTALL_KEXEC) $(UNINSTALL_KEXEC_MANPAGE) \
-		   $(UNINSTALL_VMCORE_DMESG) $(UNINSTALL_VMCORE_DMESG_MANPAGE)
+		   $(UNINSTALL_VMCORE_DMESG) $(UNINSTALL_VMCORE_DMESG_MANPAGE) \
+		   $(UNINSTALL_TARGETS_$(ARCH))
 uninstall-targets: $(UNINSTALL_TARGETS)
 
 Makefile: Makefile.in config.status
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
