Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfj-000409-Jz
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:46:06 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 43/43] PKRAM: improve index alignment of pkram_link entries
Date: Wed,  6 May 2020 17:42:09 -0700
Message-Id: <1588812129-8596-44-git-send-email-anthony.yznaga@oracle.com>
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

To take advantage of optimizations when adding pages to the page cache
via shmem_insert_pages(), improve the likelihood that the pages array
passed to shmem_insert_pages() starts on an aligned index.  Do this
when preserving pages by starting a new pkram_link page when the current
page is aligned and the next aligned page will not fit on the pkram_link
page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index ef092aa5ce7a..416c3ca4411b 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -913,11 +913,21 @@ static int __pkram_save_page(struct pkram_stream *ps,
 {
 	struct pkram_link *link = ps->link;
 	struct pkram_obj *obj = ps->obj;
+	int order, align, align_cnt;
 	pkram_entry_t p;
-	int order;
+
+	if (PageTransHuge(page)) {
+		align = 1 << (HPAGE_PMD_ORDER + XA_CHUNK_SHIFT - (HPAGE_PMD_ORDER % XA_CHUNK_SHIFT));
+		align_cnt = align >> HPAGE_PMD_ORDER;
+	} else {
+		align = XA_CHUNK_SIZE;
+		align_cnt = XA_CHUNK_SIZE;
+	}
 
 	if (!link || ps->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
-	    index != ps->next_index) {
+	    index != ps->next_index ||
+	    (IS_ALIGNED(index, align) &&
+	    (ps->entry_idx + align_cnt > PKRAM_LINK_ENTRIES_MAX))) {
 		struct page *link_page;
 
 		link_page = pkram_alloc_page((ps->gfp_mask & GFP_RECLAIM_MASK) |
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
