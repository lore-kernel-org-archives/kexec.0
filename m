Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IRNYl-0007N8-UC
	for kexec@lists.infradead.org; Sat, 01 Sep 2007 08:38:26 +0100
Subject: [PATCH 1/2] Fix kernel panic in kdump on INIT
From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
In-Reply-To: <1188632093.3930.6.camel@kane-linux>
References: <1188632093.3930.6.camel@kane-linux>
Date: Sat, 01 Sep 2007 16:36:26 +0900
Message-Id: <1188632186.3930.8.camel@kane-linux>
Mime-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: linux-ia64 <linux-ia64@vger.kernel.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org

Fix the problem that kdump on INIT causes a kernel panic if kdump
kernel image is not configured. The cause of this problem is
machine_kexec_on_init() is using printk in INIT context. It should
use ia64_mca_printk() instead.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 arch/ia64/kernel/crash.c   |    2 +-
 arch/ia64/kernel/mca_drv.h |    2 --
 include/asm-ia64/mca.h     |    2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.23-rc4/arch/ia64/kernel/crash.c
===================================================================
--- linux-2.6.23-rc4.orig/arch/ia64/kernel/crash.c
+++ linux-2.6.23-rc4/arch/ia64/kernel/crash.c
@@ -119,7 +119,7 @@ static void
 machine_kdump_on_init(void)
 {
 	if (!ia64_kimage) {
-		printk(KERN_NOTICE "machine_kdump_on_init(): "
+		ia64_mca_printk(KERN_NOTICE "machine_kdump_on_init(): "
 				"kdump not configured\n");
 		return;
 	}
Index: linux-2.6.23-rc4/arch/ia64/kernel/mca_drv.h
===================================================================
--- linux-2.6.23-rc4.orig/arch/ia64/kernel/mca_drv.h
+++ linux-2.6.23-rc4/arch/ia64/kernel/mca_drv.h
@@ -118,7 +118,5 @@ struct mca_table_entry {
 
 extern const struct mca_table_entry *search_mca_tables (unsigned long addr);
 extern int mca_recover_range(unsigned long);
-extern void ia64_mca_printk(const char * fmt, ...)
-	 __attribute__ ((format (printf, 1, 2)));
 extern void ia64_mlogbuf_dump(void);
 
Index: linux-2.6.23-rc4/include/asm-ia64/mca.h
===================================================================
--- linux-2.6.23-rc4.orig/include/asm-ia64/mca.h
+++ linux-2.6.23-rc4/include/asm-ia64/mca.h
@@ -151,6 +151,8 @@ extern void ia64_mca_cmc_vector_setup(vo
 extern int  ia64_reg_MCA_extension(int (*fn)(void *, struct ia64_sal_os_state *));
 extern void ia64_unreg_MCA_extension(void);
 extern u64 ia64_get_rnat(u64 *);
+extern void ia64_mca_printk(const char * fmt, ...)
+	 __attribute__ ((format (printf, 1, 2)));
 
 struct ia64_mca_notify_die {
 	struct ia64_sal_os_state *sos;



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
