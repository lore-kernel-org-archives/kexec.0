Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XP6ec-0000cD-Jg
 for kexec@lists.infradead.org; Wed, 03 Sep 2014 09:15:03 +0000
From: Baoquan He <bhe@redhat.com>
Subject: [PATCH 1/2] supplement the description of option --mem-usage
Date: Wed,  3 Sep 2014 17:13:07 +0800
Message-Id: <1409735588-2430-1-git-send-email-bhe@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec@lists.infradead.org
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, Baoquan He <bhe@redhat.com>, vgoyal@redhat.com

For now option --mem-usage is only used for x86-64, so supplement the
description in man page and help message.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 makedumpfile.8 | 1 +
 print_info.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/makedumpfile.8 b/makedumpfile.8
index e6a2dac..0211cd9 100644
--- a/makedumpfile.8
+++ b/makedumpfile.8
@@ -536,6 +536,7 @@ it is necessary to specfiy [\-x \fIVMLINUX\fR] or [\-i \fIVMCOREINFO\fR].
 
 .TP
 \fB\-\-mem-usage\fR
+This option is only for x86_64.
 This option is used to show the page numbers of current system in different
 use. It should be executed in 1st kernel. By the help of this, user can know
 how many pages is dumpable when different dump_level is specified. It analyzes
diff --git a/print_info.c b/print_info.c
index a1232f4..f6342d3 100644
--- a/print_info.c
+++ b/print_info.c
@@ -268,6 +268,7 @@ print_usage(void)
 	MSG("      necessary to specfiy [-x VMLINUX] or [-i VMCOREINFO].\n");
 	MSG("\n");
 	MSG("  [--mem-usage]:\n");
+	MSG("      This option is only for x86_64.\n");
 	MSG("      This option is used to show the page numbers of current system in different\n");
 	MSG("      use. It should be executed in 1st kernel. By the help of this, user can know\n");
 	MSG("      how many pages is dumpable when different dump_level is specified. It analyzes\n");
-- 
1.8.5.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
