Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfk-0003zu-8k
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:08 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 26/43] mm: shmem: when inserting,
 handle pages already charged to a memcg
Date: Wed,  6 May 2020 17:41:52 -0700
Message-Id: <1588812129-8596-27-git-send-email-anthony.yznaga@oracle.com>
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

If shmem_insert_page() is called to insert a page that was preserved
using PKRAM on the current boot (i.e. preserved page is restored without
an intervening kexec boot), the page will still be charged to a memory
cgroup because it is never freed. Don't try to charge it again.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 13475073fb52..1f3b43b8fa34 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -693,6 +693,7 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 	struct mem_cgroup *memcg;
 	pgoff_t hindex = index;
 	bool on_lru = PageLRU(page);
+	bool has_memcg = page->mem_cgroup ? true : false;
 
 	if (index > (MAX_LFS_FILESIZE >> PAGE_SHIFT))
 		return -EFBIG;
@@ -738,20 +739,24 @@ int shmem_insert_page(struct mm_struct *mm, struct inode *inode, pgoff_t index,
 
 	__SetPageReferenced(page);
 
-	err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
-					PageTransHuge(page));
-	if (err)
-		goto out_unlock;
+	if (!has_memcg) {
+		err = mem_cgroup_try_charge_delay(page, mm, gfp, &memcg,
+						PageTransHuge(page));
+		if (err)
+			goto out_unlock;
+	}
 
 	err = shmem_add_to_page_cache(page, mapping, hindex,
 					NULL, gfp & GFP_RECLAIM_MASK);
 	if (err) {
-		mem_cgroup_cancel_charge(page, memcg,
-			PageTransHuge(page));
+		if (!has_memcg)
+			mem_cgroup_cancel_charge(page, memcg,
+						PageTransHuge(page));
 		goto out_unlock;
 	}
-	mem_cgroup_commit_charge(page, memcg, on_lru,
-			PageTransHuge(page));
+	if (!has_memcg)
+		mem_cgroup_commit_charge(page, memcg, on_lru,
+					PageTransHuge(page));
 
 	if (!on_lru)
 		lru_cache_add_anon(page);
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
