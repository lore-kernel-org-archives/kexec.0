Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfd-0003ut-4N
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:00 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 39/43] shmem: optimize adding pages to the LRU in
 shmem_insert_pages()
Date: Wed,  6 May 2020 17:42:05 -0700
Message-Id: <1588812129-8596-40-git-send-email-anthony.yznaga@oracle.com>
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

Reduce LRU lock contention when inserting shmem pages by staging pages
to be added to the same LRU and adding them en masse.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ca5edf580f24..678a396ba8d3 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -789,9 +789,12 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	struct mem_cgroup *memcg;
+	struct lru_splice splice;
 	int i, err;
 	int nr = 0;
 
+	memset(&splice, 0, sizeof(splice));
+
 	for (i = 0; i < npages; i++)
 		nr += compound_nr(pages[i]);
 
@@ -866,7 +869,7 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		}
 
 		if (!PageLRU(pages[i]))
-			lru_cache_add_anon(pages[i]);
+			lru_splice_add_anon(pages[i], &splice);
 
 		flush_dcache_page(pages[i]);
 		SetPageUptodate(pages[i]);
@@ -875,6 +878,9 @@ int shmem_insert_pages(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 		unlock_page(pages[i]);
 	}
 
+	if (splice.pgdat)
+		add_splice_to_lru_list(&splice);
+
 	return 0;
 
 out_truncate:
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
