Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOdt9-00AuoF-42
 for kexec@lists.infradead.org; Fri, 10 Sep 2021 10:37:22 +0000
Received: by mail-pj1-f69.google.com with SMTP id
 h10-20020a17090a470a00b00196ead30459so1139018pjg.0
 for <kexec@lists.infradead.org>; Fri, 10 Sep 2021 03:33:50 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
Subject: [PATCH 09/11] makedumpfile: Add zstd help message
Date: Fri, 10 Sep 2021 18:33:16 +0800
Message-Id: <20210910103318.292017-10-ltao@redhat.com>
In-Reply-To: <20210910103318.292017-1-ltao@redhat.com>
References: <20210910103318.292017-1-ltao@redhat.com>
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
Cc: k-hagio-ab@nec.com, Tao Liu <ltao@redhat.com>, Coiby Xu <coxu@redhat.com>

Signed-off-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 print_info.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/print_info.c b/print_info.c
index 8b28554..e4bfefc 100644
--- a/print_info.c
+++ b/print_info.c
@@ -38,6 +38,11 @@ show_version(void)
 	MSG("snappy\tenabled\n");
 #else
 	MSG("snappy\tdisabled\n");
+#endif
+#ifdef USEZSTD
+	MSG("zstd\tenabled\n");
+#else
+	MSG("zstd\tdisabled\n");
 #endif
 	MSG("\n");
 }
@@ -57,20 +62,26 @@ print_usage(void)
 	MSG("  enabled\n");
 #else
 	MSG("  disabled ('-p' option will be ignored.)\n");
+#endif
+	MSG("zstd support:\n");
+#ifdef USEZSTD
+	MSG("  enabled\n");
+#else
+	MSG("  disabled ('-z' option will be ignored.)\n");
 #endif
 	MSG("\n");
 	MSG("Usage:\n");
 	MSG("  Creating DUMPFILE:\n");
-	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] [-e] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile    [-c|-l|-p|-z|-E] [-d DL] [-e] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("    DUMPFILE\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE with filtered kernel data specified through filter config\n");
 	MSG("  file or eppic macro:\n");
-	MSG("  # makedumpfile    [-c|-l|-p|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
+	MSG("  # makedumpfile    [-c|-l|-p|-z|-E] [-d DL] -x VMLINUX [--config FILTERCONFIGFILE]\n");
 	MSG("    [--eppic EPPICMACRO] VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Outputting the dump data in the flattened format to the standard output:\n");
-	MSG("  # makedumpfile -F [-c|-l|-p|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
+	MSG("  # makedumpfile -F [-c|-l|-p|-z|-E] [-d DL] [-x VMLINUX|-i VMCOREINFO] VMCORE\n");
 	MSG("\n");
 	MSG("  Rearranging the dump data in the flattened format to a readable DUMPFILE:\n");
 	MSG("  # makedumpfile -R DUMPFILE\n");
@@ -94,26 +105,27 @@ print_usage(void)
 	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE of Xen:\n");
-	MSG("  # makedumpfile [-c|-l|-p|-E] [--xen-syms XEN-SYMS|--xen-vmcoreinfo VMCOREINFO]\n");
+	MSG("  # makedumpfile [-c|-l|-p|-z|-E] [--xen-syms XEN-SYMS|--xen-vmcoreinfo VMCOREINFO]\n");
 	MSG("    VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Filtering domain-0 of Xen:\n");
-	MSG("  # makedumpfile [-c|-l|-p|-E] -d DL -x vmlinux VMCORE DUMPFILE\n");
+	MSG("  # makedumpfile [-c|-l|-p|-z|-E] -d DL -x vmlinux VMCORE DUMPFILE\n");
 	MSG("\n");
 	MSG("  Generating VMCOREINFO of Xen:\n");
 	MSG("  # makedumpfile -g VMCOREINFO --xen-syms XEN-SYMS\n");
 	MSG("\n");
 	MSG("\n");
 	MSG("  Creating DUMPFILE from multiple VMCOREs generated on sadump diskset configuration:\n");
-	MSG("  # makedumpfile [-c|-l|-p] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
+	MSG("  # makedumpfile [-c|-l|-p|-z] [-d DL] -x VMLINUX --diskset=VMCORE1 --diskset=VMCORE2\n");
 	MSG("    [--diskset=VMCORE3 ..] DUMPFILE\n");
 	MSG("\n");
 	MSG("\n");
 	MSG("Available options:\n");
-	MSG("  [-c|-l|-p]:\n");
+	MSG("  [-c|-l|-p|-z]:\n");
 	MSG("      Compress dump data by each page using zlib for -c option, lzo for -l option\n");
-	MSG("      or snappy for -p option. A user cannot specify either of these options with\n");
-	MSG("      -E option, because the ELF format does not support compressed data.\n");
+	MSG("      snappy for -p option, or zstd for -z option. A user cannot specify either of\n");
+	MSG("      these options with -E option, because the ELF format does not support\n");
+	MSG("      compressed data.\n");
 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
 	MSG("\n");
 	MSG("  [-e]:\n");
-- 
2.29.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
