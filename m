Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUfF-0003bC-4T
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:45:29 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 33/43] PKRAM: atomically add and remove link pages
Date: Wed,  6 May 2020 17:41:59 -0700
Message-Id: <1588812129-8596-34-git-send-email-anthony.yznaga@oracle.com>
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

Add and remove pkram_link pages from a pkram_obj atomically to prepare
for multithreading.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 5f4e4d12865f..042c14dedc25 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -551,22 +551,31 @@ static void pkram_truncate(void)
 
 static void pkram_add_link(struct pkram_link *link, struct pkram_obj *obj)
 {
-	link->link_pfn = obj->link_pfn;
-	obj->link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 *head = &obj->link_pfn;
+
+	do {
+		link->link_pfn = *head;
+	} while (cmpxchg64(head, link->link_pfn, link_pfn) != link->link_pfn);
 }
 
 static struct pkram_link *pkram_remove_link(struct pkram_obj *obj)
 {
 	struct pkram_link *current_link;
+	__u64 *head = &obj->link_pfn;
+	__u64 head_pfn = *head;
+
+	while (head_pfn) {
+		current_link = pfn_to_kaddr(head_pfn);
+		if (cmpxchg64(head, head_pfn, current_link->link_pfn) == head_pfn) {
+			current_link->link_pfn = 0;
+			return current_link;
+		}
 
-	if (!obj->link_pfn)
-		return NULL;
-
-	current_link = pfn_to_kaddr(obj->link_pfn);
-	obj->link_pfn = current_link->link_pfn;
-	current_link->link_pfn = 0;
+		head_pfn = *head;
+	}
 
-	return current_link;
+	return NULL;
 }
 
 static void pkram_stream_init(struct pkram_stream *ps,
-- 
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
