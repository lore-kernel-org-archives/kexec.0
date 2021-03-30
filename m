Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuj-004w40-PU
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:46 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 43/43] PKRAM: improve index alignment of pkram_link entries
Date: Tue, 30 Mar 2021 14:36:18 -0700
Message-Id: <1617140178-8773-44-git-send-email-anthony.yznaga@oracle.com>
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

To take advantage of optimizations when adding pages to the page cache
via shmem_insert_pages(), improve the likelihood that the pages array
passed to shmem_insert_pages() starts on an aligned index.  Do this
when preserving pages by starting a new pkram_link page when the current
page is aligned and the next aligned page will not fit on the pkram_link
page.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index b63b2a3958e7..3f43809c8a85 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -911,9 +911,20 @@ static int __pkram_save_page(struct pkram_access *pa, struct page *page,
 {
 	struct pkram_data_stream *pds = &pa->pds;
 	struct pkram_link *link = pds->link;
+	int align, align_cnt;
+
+	if (PageTransHuge(page)) {
+		align = 1 << (HPAGE_PMD_ORDER + XA_CHUNK_SHIFT - (HPAGE_PMD_ORDER % XA_CHUNK_SHIFT));
+		align_cnt = align >> HPAGE_PMD_ORDER;
+	} else {
+		align = XA_CHUNK_SIZE;
+		align_cnt = XA_CHUNK_SIZE;
+	}
 
 	if (!link || pds->entry_idx >= PKRAM_LINK_ENTRIES_MAX ||
-	    index != pa->pages.next_index) {
+	    index != pa->pages.next_index ||
+	    (IS_ALIGNED(index, align) &&
+	    (pds->entry_idx + align_cnt > PKRAM_LINK_ENTRIES_MAX))) {
 		link = pkram_new_link(pds, pa->ps->gfp_mask);
 		if (!link)
 			return -ENOMEM;
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
