Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLvX-004wC1-GF
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:29:34 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 39/43] shmem: optimize adding pages to the LRU in
 shmem_insert_pages()
Date: Tue, 30 Mar 2021 14:36:14 -0700
Message-Id: <1617140178-8773-40-git-send-email-anthony.yznaga@oracle.com>
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

Reduce LRU lock contention when inserting shmem pages by staging pages
to be added to the same LRU and adding them en masse.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index c3fa72061d8a..63299da75166 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -845,6 +845,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	gfp_t gfp = mapping_gfp_mask(mapping);
+	LRU_SPLICE(splice);
 	int i, err;
 	int nr = 0;
 
@@ -908,7 +909,7 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 
 	for (i = 0; i < npages; i++) {
 		if (!PageLRU(pages[i]))
-			lru_cache_add(pages[i]);
+			lru_splice_add(pages[i], &splice);
 
 		flush_dcache_page(pages[i]);
 		SetPageUptodate(pages[i]);
@@ -917,6 +918,8 @@ int shmem_insert_pages(struct mm_struct *charge_mm, struct inode *inode,
 		unlock_page(pages[i]);
 	}
 
+	add_splice_to_lru_list(&splice);
+
 	return 0;
 
 out_release:
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
