Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2130.oracle.com ([156.151.31.86])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLtt-004vuY-CR
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:57 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 30/43] memblock: PKRAM: mark memblocks that contain preserved
 pages
Date: Tue, 30 Mar 2021 14:36:05 -0700
Message-Id: <1617140178-8773-31-git-send-email-anthony.yznaga@oracle.com>
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

To support deferred initialization of page structs for preserved pages,
separate memblocks containing preserved pages by setting a new flag
when adding them to the memblock reserved list.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 include/linux/memblock.h | 6 ++++++
 mm/pkram.c               | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index d13e3cd938b4..39c53d08d9f7 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -37,6 +37,7 @@ enum memblock_flags {
 	MEMBLOCK_HOTPLUG	= 0x1,	/* hotpluggable region */
 	MEMBLOCK_MIRROR		= 0x2,	/* mirrored region */
 	MEMBLOCK_NOMAP		= 0x4,	/* don't add to kernel direct mapping */
+	MEMBLOCK_PRESERVED	= 0x8,	/* preserved pages region */
 };
 
 /**
@@ -248,6 +249,11 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 	return m->flags & MEMBLOCK_NOMAP;
 }
 
+static inline bool memblock_is_preserved(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_PRESERVED;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/pkram.c b/mm/pkram.c
index b8d6b549fa6c..08144c18d425 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -1607,6 +1607,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 		} else if (pkr->base + pkr->size <= r->base) {
 			rgn->base = pkr->base;
 			rgn->size = pkr->size;
+			rgn->flags = MEMBLOCK_PRESERVED;
 			memblock_set_region_node(rgn, MAX_NUMNODES);
 
 			nr_preserved +=  (rgn->size >> PAGE_SHIFT);
@@ -1636,6 +1637,7 @@ int __init pkram_create_merged_reserved(struct memblock_type *new)
 		rgn = &new->regions[k];
 		rgn->base = pkr->base;
 		rgn->size = pkr->size;
+		rgn->flags = MEMBLOCK_PRESERVED;
 		memblock_set_region_node(rgn, MAX_NUMNODES);
 
 		nr_preserved += (rgn->size >> PAGE_SHIFT);
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
