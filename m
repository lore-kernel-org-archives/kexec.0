Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VdgxX-0002Nx-Ra
 for kexec@lists.infradead.org; Tue, 05 Nov 2013 13:46:20 +0000
Subject: [PATCH 2/3] makedumpfile: hugepage filtering: add excluding
 hugepage messages
From: Jingbai Ma <jingbai.ma@hp.com>
Date: Tue, 05 Nov 2013 21:45:53 +0800
Message-ID: <20131105134553.32112.58435.stgit@k.asiapacific.hpqcorp.net>
In-Reply-To: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
References: <20131105134532.32112.78008.stgit@k.asiapacific.hpqcorp.net>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: ptesarik@suse.cz, d.hatayama@jp.fujitsu.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: bhe@redhat.com, tom.vaden@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, anderson@redhat.com, ebiederm@xmission.com, vgoyal@redhat.com

Add messages for print_info.

Signed-off-by: Jingbai Ma <jingbai.ma@hp.com>
---
 print_info.c |   12 +++++++-----
 print_info.h |    2 ++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/print_info.c b/print_info.c
index 06939e0..978d9fb 100644
--- a/print_info.c
+++ b/print_info.c
@@ -103,17 +103,19 @@ print_usage(void)
 	MSG("      The maximum of Dump_Level is 31.\n");
 	MSG("      Note that Dump_Level for Xen dump filtering is 0 or 1.\n");
 	MSG("\n");
-	MSG("            |         cache    cache\n");
-	MSG("      Dump  |  zero   without  with     user    free\n");
-	MSG("      Level |  page   private  private  data    page\n");
-	MSG("     -------+---------------------------------------\n");
+	MSG("            |         cache    cache                    free    active\n");
+	MSG("      Dump  |  zero   without  with     user    free    huge    huge\n");
+	MSG("      Level |  page   private  private  data    page    page    page\n");
+	MSG("     -------+----------------------------------------------------------\n");
 	MSG("         0  |\n");
 	MSG("         1  |   X\n");
 	MSG("         2  |           X\n");
 	MSG("         4  |           X        X\n");
 	MSG("         8  |                            X\n");
 	MSG("        16  |                                    X\n");
-	MSG("        31  |   X       X        X       X       X\n");
+	MSG("        32  |                                            X\n");
+	MSG("        64  |                                            X       X\n");
+	MSG("       127  |   X       X        X       X       X       X       X\n");
 	MSG("\n");
 	MSG("  [-E]:\n");
 	MSG("      Create DUMPFILE in the ELF format.\n");
diff --git a/print_info.h b/print_info.h
index 01e3706..8461df6 100644
--- a/print_info.h
+++ b/print_info.h
@@ -35,6 +35,8 @@ void print_execution_time(char *step_name, struct timeval *tv_start);
 #define PROGRESS_HOLES		"Checking for memory holes  "
 #define PROGRESS_UNN_PAGES 	"Excluding unnecessary pages"
 #define PROGRESS_FREE_PAGES 	"Excluding free pages       "
+#define PROGRESS_FREE_HUGE	"Excluding free huge pages  "
+#define PROGRESS_ACTIVE_HUGE	"Excluding active huge pages"
 #define PROGRESS_ZERO_PAGES 	"Excluding zero pages       "
 #define PROGRESS_XEN_DOMAIN 	"Excluding xen user domain  "
 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
