Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SltTR-0006UD-RP
 for kexec@lists.infradead.org; Tue, 03 Jul 2012 03:08:26 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1260B3EE0B6
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:06 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id F073145DE4F
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:05 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id DA30C45DE4E
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:05 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id CE53A1DB8037
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:05 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 877191DB802F
 for <kexec@lists.infradead.org>; Tue,  3 Jul 2012 12:08:05 +0900 (JST)
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Subject: [PATCH 7/8] Add help message
Date: Tue, 03 Jul 2012 12:08:04 +0900
Message-ID: <20120703030804.16633.72963.stgit@localhost6.localdomain6>
In-Reply-To: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
References: <20120703030552.16633.42523.stgit@localhost6.localdomain6>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Signed-off-by: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
---

 print_info.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/print_info.c b/print_info.c
index 61cafed..1b455b2 100644
--- a/print_info.c
+++ b/print_info.c
@@ -39,6 +39,12 @@ print_usage(void)
 #else
 	MSG("  disabled ('-l' option will be ignored.)\n");
 #endif
+	MSG("snappy support:\n");
+#ifdef USESNAPPY
+	MSG("  enabled\n");
+#else
+	MSG("  disabled ('-p' option will be ignored.)\n");
+#endif
 	MSG("\n");
 	MSG("Usage:\n");
 	MSG("  Creating DUMPFILE:\n");
@@ -83,10 +89,10 @@ print_usage(void)
 	MSG("\n");
 	MSG("\n");
 	MSG("Available options:\n");
-	MSG("  [-c|-l]:\n");
-	MSG("      Compress dump data by each page using zlib for -c option and lzo for\n");
-	MSG("      -l option. A user cannot specify either of these options with -E option,\n");
-	MSG("      because the ELF format does not support compressed data.\n");
+	MSG("  [-c|-l|-p]:\n");
+	MSG("      Compress dump data by each page using zlib for -c option, lzo for -l option\n");
+	MSG("      or snappy for -p option. A user cannot specify either of these options with\n");
+	MSG("      -E option, because the ELF format does not support compressed data.\n");
 	MSG("      THIS IS ONLY FOR THE CRASH UTILITY.\n");
 	MSG("\n");
 	MSG("  [-d DL]:\n");
@@ -222,7 +228,7 @@ print_usage(void)
 	MSG("      Overwrite DUMPFILE even if it already exists.\n");
 	MSG("\n");
 	MSG("  [-h]:\n");
-	MSG("      Show help message and LZO support status (enabled/disabled).\n");
+	MSG("      Show help message and LZO/snappy support status (enabled/disabled).\n");
 	MSG("\n");
 	MSG("  [-b <order>]\n");
 	MSG("      Specify the cache 2^order pages in ram when generating vmcore info\n");


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
