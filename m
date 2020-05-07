Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUej-0000Ru-Fn
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:44:59 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 25/43] mm: shmem: specify the mm to use when inserting pages
Date: Wed,  6 May 2020 17:41:51 -0700
Message-Id: <1588812129-8596-26-git-send-email-anthony.yznaga@oracle.com>
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

Explicitly specify the mm to pass to shmem_insert_page() when
the pkram_stream is initialized rather than use the mm of the
current thread.  This will allow for multiple kernel threads to
target the same mm when inserting pages in parallel.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/pkram.h | 1 +
 mm/pkram.c            | 1 +
 mm/shmem_pkram.c      | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/pkram.h b/include/linux/pkram.h
index b47b3aef16e3..cbb79d2803c0 100644
--- a/include/linux/pkram.h
+++ b/include/linux/pkram.h
@@ -18,6 +18,7 @@ struct pkram_stream {
 
 	unsigned long next_index;
 	struct address_space *mapping;
+	struct mm_struct *mm;
 
 	/* byte data */
 	struct page *data_page;
diff --git a/mm/pkram.c b/mm/pkram.c
index 4d4d836fea53..a5e539052af6 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -565,6 +565,7 @@ static void pkram_stream_init(struct pkram_stream *ps,
 	memset(ps, 0, sizeof(*ps));
 	ps->gfp_mask = gfp_mask;
 	ps->node = node;
+	ps->mm = current->mm;
 }
 
 static void pkram_stream_init_obj(struct pkram_stream *ps, struct pkram_obj *obj)
diff --git a/mm/shmem_pkram.c b/mm/shmem_pkram.c
index 3fa9cfbe0003..c97d64393822 100644
--- a/mm/shmem_pkram.c
+++ b/mm/shmem_pkram.c
@@ -236,7 +236,7 @@ static int load_file_content(struct pkram_stream *ps)
 		if (!page)
 			break;
 
-		err = shmem_insert_page(current->mm, ps->mapping->host, index, page);
+		err = shmem_insert_page(ps->mm, ps->mapping->host, index, page);
 		put_page(page);
 	} while (!err);
 
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
