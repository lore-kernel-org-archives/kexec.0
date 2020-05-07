Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfO-0003io-CU
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:36 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 37/43] shmem: PKRAM: enable bulk loading of preserved pages into
 shmem
Date: Wed,  6 May 2020 17:42:03 -0700
Message-Id: <1588812129-8596-38-git-send-email-anthony.yznaga@oracle.com>
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

Make use of new interfaces for loading and inserting preserved pages
into a shmem file in bulk.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/shmem_pkram.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 4992b6c3e54e..435488368104 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -315,18 +315,29 @@ static inline void pkram_load_report_one_done(void)
 static int do_load_file_content(struct pkram_stream *ps)
 {
 	unsigned long index;
-	struct page *page;
-	int err = 0;
+	int i, err;
+
+	err = pkram_prepare_load_pages(ps);
+	if (err)
+		return err;
 
 	do {
-		page = pkram_load_page(ps, &index, NULL);
-		if (!page)
+		err = pkram_load_pages(ps, &index);
+		if (err) {
+			if (err == -ENODATA)
+				err = 0;
 			break;
+		}
 
-		err = shmem_insert_page(ps->mm, ps->mapping->host, index, page);
-		put_page(page);
+		err = shmem_insert_pages(ps->mm, ps->mapping->host, index,
+					 ps->pages, ps->nr_pages);
+
+		for (i = 0; i < ps->nr_pages; i++)
+			put_page(ps->pages[i]);
 	} while (!err);
 
+	pkram_finish_load_pages(ps);
+
 	return err;
 }
 
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
