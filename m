Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLti-004voP-Sn
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:43 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 14/43] PKRAM: prevent inadvertent use of a stale superblock
Date: Tue, 30 Mar 2021 14:35:49 -0700
Message-Id: <1617140178-8773-15-git-send-email-anthony.yznaga@oracle.com>
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

When pages have been saved to be preserved by the current boot, set
a magic number on the super block to be validated by the next kernel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/pkram.c b/mm/pkram.c
index dab6657080bf..8670d1633a9d 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -22,6 +22,7 @@
 
 #include "internal.h"
 
+#define PKRAM_MAGIC		0x706B726D
 
 /*
  * Represents a reference to a data page saved to PKRAM.
@@ -112,6 +113,8 @@ struct pkram_region_list {
  * The structure occupies a memory page.
  */
 struct pkram_super_block {
+	__u32	magic;
+
 	__u64	node_pfn;		/* first element of the node list */
 	__u64	region_list_pfn;
 	__u64	nr_regions;
@@ -180,6 +183,11 @@ void __init pkram_reserve(void)
 		err = PTR_ERR(pkram_sb);
 		goto out;
 	}
+	if (pkram_sb->magic != PKRAM_MAGIC) {
+		pr_err("PKRAM: invalid super block\n");
+		err = -EINVAL;
+		goto out;
+	}
 	/* An empty pkram_sb is not an error */
 	if (!pkram_sb->node_pfn) {
 		pkram_sb = NULL;
@@ -993,6 +1001,7 @@ static void __pkram_reboot(void)
 	 */
 	memset(pkram_sb, 0, PAGE_SIZE);
 	if (!err && node_pfn) {
+		pkram_sb->magic = PKRAM_MAGIC;
 		pkram_sb->node_pfn = node_pfn;
 		pkram_sb->region_list_pfn = rl_pfn;
 		pkram_sb->nr_regions = nr_regions;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
