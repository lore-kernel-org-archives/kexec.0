Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRLti-004voK-DJ
 for kexec@lists.infradead.org; Tue, 30 Mar 2021 21:27:43 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC v2 28/43] x86/mm/numa: add numa_isolate_memblocks()
Date: Tue, 30 Mar 2021 14:36:03 -0700
Message-Id: <1617140178-8773-29-git-send-email-anthony.yznaga@oracle.com>
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

Provide a way for a caller external to numa to ensure memblocks in the
memblock reserved list do not cross node boundaries and have a node id
assigned to them.  This will be used by PKRAM to ensure initialization of
page structs for preserved pages can be deferred and multithreaded
efficiently.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 arch/x86/include/asm/numa.h |  4 ++++
 arch/x86/mm/numa.c          | 32 ++++++++++++++++++++------------
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index e3bae2b60a0d..632b5b6d8cb3 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -41,6 +41,7 @@ static inline void set_apicid_to_node(int apicid, s16 node)
 }
 
 extern int numa_cpu_node(int cpu);
+extern void __init numa_isolate_memblocks(void);
 
 #else	/* CONFIG_NUMA */
 static inline void set_apicid_to_node(int apicid, s16 node)
@@ -51,6 +52,9 @@ static inline int numa_cpu_node(int cpu)
 {
 	return NUMA_NO_NODE;
 }
+static inline void numa_isolate_memblocks(void)
+{
+}
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5eb4dc2b97da..dd85098f9d72 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -473,6 +473,25 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
 	return true;
 }
 
+void __init numa_isolate_memblocks(void)
+{
+	int i;
+
+	/*
+	 * Iterate over all memory known to the x86 architecture,
+	 * and use those ranges to set the nid in memblock.reserved.
+	 * This will split up the memblock regions along node
+	 * boundaries and will set the node IDs as well.
+	 */
+	for (i = 0; i < numa_meminfo.nr_blks; i++) {
+		struct numa_memblk *mb = numa_meminfo.blk + i;
+		int ret;
+
+		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
+		WARN_ON_ONCE(ret);
+	}
+}
+
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -491,19 +510,8 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	 * used by the kernel, but those regions are not split up
 	 * along node boundaries yet, and don't necessarily have their
 	 * node ID set yet either.
-	 *
-	 * So iterate over all memory known to the x86 architecture,
-	 * and use those ranges to set the nid in memblock.reserved.
-	 * This will split up the memblock regions along node
-	 * boundaries and will set the node IDs as well.
 	 */
-	for (i = 0; i < numa_meminfo.nr_blks; i++) {
-		struct numa_memblk *mb = numa_meminfo.blk + i;
-		int ret;
-
-		ret = memblock_set_node(mb->start, mb->end - mb->start, &memblock.reserved, mb->nid);
-		WARN_ON_ONCE(ret);
-	}
+	numa_isolate_memblocks();
 
 	/*
 	 * Now go over all reserved memblock regions, to construct a
-- 
1.8.3.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
