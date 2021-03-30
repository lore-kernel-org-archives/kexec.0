Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLu6-004vw2-R1
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:04 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 20/43] PKRAM: disable feature when running the kdump kernel
Date: Tue, 30 Mar 2021 14:35:55 -0700
Message-Id: <1617140178-8773-21-git-send-email-anthony.yznaga@oracle.com>
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
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
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: willy@infradead.org, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org, rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com, ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org, nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org, nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com, martin.b.radev@gmail.com, andreyknvl@google.com, daniel.kiper@oracle.com, rafael.j.wysocki@intel.com, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com, guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org, iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com, david@redhat.com, richard.weiyang@gmail.com, vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com, lei.l.li@intel.com, daniel.m.jordan@oracle.com, steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, kexec@lists.infradead.org

The kdump kernel should not preserve or restore pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 8700fd77dc67..aea069cc49be 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/crash_dump.h>
 #include <linux/err.h>
 #include <linux/gfp.h>
 #include <linux/highmem.h>
@@ -189,7 +190,7 @@ void __init pkram_reserve(void)
 {
 	int err = 0;
 
-	if (!pkram_sb_pfn)
+	if (!pkram_sb_pfn || is_kdump_kernel())
 		return;
 
 	pr_info("PKRAM: Examining preserved memory...\n");
@@ -286,6 +287,9 @@ static void pkram_show_banned(void)
 	int i;
 	unsigned long n, total = 0;
 
+	if (is_kdump_kernel())
+		return;
+
 	pr_info("PKRAM: banned regions:\n");
 	for (i = 0; i < nr_banned; i++) {
 		n = banned[i].end - banned[i].start + 1;
@@ -1315,7 +1319,7 @@ static int __init pkram_init_sb(void)
 
 static int __init pkram_init(void)
 {
-	if (pkram_init_sb()) {
+	if (!is_kdump_kernel() && pkram_init_sb()) {
 		register_reboot_notifier(&pkram_reboot_notifier);
 		register_shrinker(&banned_pages_shrinker);
 		sysfs_update_group(kernel_kobj, &pkram_attr_group);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
