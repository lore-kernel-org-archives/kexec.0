Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLu5-004vvr-Qk
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:28:03 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 33/43] PKRAM: atomically add and remove link pages
Date: Tue, 30 Mar 2021 14:36:08 -0700
Message-Id: <1617140178-8773-34-git-send-email-anthony.yznaga@oracle.com>
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

Add and remove pkram_link pages from a pkram_obj atomically to prepare
for multithreading.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 08144c18d425..382ccf6f789f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -535,33 +535,42 @@ static void pkram_truncate(void)
 static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
 {
 	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 *tail = pds->tail_link_pfnp;
+	__u64 tail_pfn;
 
-	if (!*pds->head_link_pfnp) {
+	do {
+		tail_pfn = *tail;
+	} while (cmpxchg64(tail, tail_pfn, link_pfn) != tail_pfn);
+
+	if (!tail_pfn) {
 		*pds->head_link_pfnp = link_pfn;
-		*pds->tail_link_pfnp = link_pfn;
 	} else {
-		struct pkram_link *tail = pfn_to_kaddr(*pds->tail_link_pfnp);
+		struct pkram_link *prev_tail = pfn_to_kaddr(tail_pfn);
 
-		tail->link_pfn = link_pfn;
-		*pds->tail_link_pfnp = link_pfn;
+		prev_tail->link_pfn = link_pfn;
 	}
 }
 
 static struct pkram_link *pkram_remove_link(struct pkram_data_stream *pds)
 {
-	struct pkram_link *link;
+	__u64 *head = pds->head_link_pfnp;
+	__u64 head_pfn = *head;
 
-	if (!*pds->head_link_pfnp)
-		return NULL;
+	while (head_pfn) {
+		struct pkram_link *link = pfn_to_kaddr(head_pfn);
 
-	link = pfn_to_kaddr(*pds->head_link_pfnp);
-	*pds->head_link_pfnp = link->link_pfn;
-	if (!*pds->head_link_pfnp)
-		*pds->tail_link_pfnp = 0;
-	else
-		link->link_pfn = 0;
+		if (cmpxchg64(head, head_pfn, link->link_pfn) == head_pfn) {
+			if (!*head)
+				*pds->tail_link_pfnp = 0;
+			else
+				link->link_pfn = 0;
+			return link;
+		}
 
-	return link;
+		head_pfn = *head;
+	}
+
+	return NULL;
 }
 
 static struct pkram_link *pkram_new_link(struct pkram_data_stream *pds, gfp_t gfp_mask)
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
