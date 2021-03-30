Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2130.oracle.com ([141.146.126.79])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLuM-004vz7-PO
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:20 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 37/43] shmem: PKRAM: enable bulk loading of preserved pages
 into shmem
Date: Tue, 30 Mar 2021 14:36:12 -0700
Message-Id: <1617140178-8773-38-git-send-email-anthony.yznaga@oracle.com>
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

Make use of new interfaces for loading and inserting preserved pages
into a shmem file in bulk.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 354c2b58962c..24a1ebb4af59 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -328,20 +328,31 @@ static inline void pkram_load_report_one_done(void)
 static int do_load_file_content(struct pkram_stream *ps, struct address_space *mapping, struct mm_struct *mm)
 {
 	PKRAM_ACCESS(pa, ps, pages);
+	struct page **pages;
+	unsigned int nr_pages;
 	unsigned long index;
-	struct page *page;
-	int err = 0;
+	int i, err;
+
+	pages = kzalloc(PKRAM_PAGES_BUFSIZE, GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
 
 	do {
-		page = pkram_load_file_page(&pa, &index);
-		if (!page)
+		err = pkram_load_file_pages(&pa, pages, &nr_pages, &index);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
 			break;
+		}
+
+		err = shmem_insert_pages(mm, mapping->host, index, pages, nr_pages);
 
-		err = shmem_insert_page(mm, mapping->host, index, page);
-		put_page(page);
+		for (i = 0; i < nr_pages; i++)
+			put_page(pages[i]);
 		cond_resched();
 	} while (!err);
 
+	kfree(pages);
 	pkram_finish_access(&pa, err == 0);
 	return err;
 }
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
