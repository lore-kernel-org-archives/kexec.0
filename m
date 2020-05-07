Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUeR-0008Lk-1W
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:36 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 20/43] PKRAM: disable feature when running the kdump kernel
Date: Wed,  6 May 2020 17:41:46 -0700
Message-Id: <1588812129-8596-21-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
References: <1588812129-8596-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-doc@vger.kernel.org, gustavo@embeddedor.com, peterz@infradead.org, kexec@lists.infradead.org, paul.c.lai@intel.com, dave.hansen@linux.intel.com, mhocko@kernel.org, lei.l.li@intel.com, nivedita@alum.mit.edu, ziqian.lzq@antfin.com, hpa@zytor.com, ardb@kernel.org, ashok.raj@intel.com, bhe@redhat.com, corbet@lwn.net, masahiroy@kernel.org, rafael.j.wysocki@intel.com, hughd@google.com, willy@infradead.org, rppt@linux.ibm.com, mingo@redhat.com, vdavydov.dev@gmail.com, ying.huang@intel.com, Thomas.Lendacky@amd.com, kevin.tian@intel.com, jroedel@suse.de, keescook@chromium.org, dan.j.williams@intel.com, bp@alien8.de, zhiyuan.lv@intel.com, luto@kernel.org, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, dima@golovin.in, yang.shi@linux.alibaba.com, ndesaulniers@google.com, zhenzhong.duan@oracle.com, guro@fb.com, minchan@kernel.org, ebiederm@xmission.com, jason.zeng@intel.com, hannes@cmpxchg.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, daniel.kiper@oracle.com

The kdump kernel should not preserve or restore pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 95e691382721..4d4d836fea53 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -193,7 +194,7 @@ void __init pkram_reserve(void)
 {
 	int err = 0;
 
-	if (!pkram_sb_pfn)
+	if (!pkram_sb_pfn || is_kdump_kernel())
 		return;
 
 	pr_info("PKRAM: Examining preserved memory...\n");
@@ -305,6 +306,9 @@ static void pkram_show_banned(void)
 	int i;
 	unsigned long n, total = 0;
 
+	if (is_kdump_kernel())
+		return;
+
 	pr_info("PKRAM: banned regions:\n");
 	for (i = 0; i < nr_banned; i++) {
 		n = banned[i].end - banned[i].start + 1;
@@ -1223,7 +1227,7 @@ static int __init pkram_init_sb(void)
 
 static int __init pkram_init(void)
 {
-	if (pkram_init_sb()) {
+	if (!is_kdump_kernel() && pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
 		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
