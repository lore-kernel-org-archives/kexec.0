Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWUgk-0004kP-Bi
 for kexec@lists.infradead.org; Thu, 07 May 2020 00:47:06 +0000
From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC 27/43] x86/mm/numa: add numa_isolate_memblocks()
Date: Wed,  6 May 2020 17:41:53 -0700
Message-Id: <1588812129-8596-28-git-send-email-anthony.yznaga@oracle.com>
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
index bbfde3d2662f..f9e05f4eb1c6 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -40,6 +40,7 @@ static inline void set_apicid_to_node(int apicid, s16 node)
 }
 
 extern int numa_cpu_node(int cpu);
+extern void __init numa_isolate_memblocks(void);
 
 #else	/* CONFIG_NUMA */
 static inline void set_apicid_to_node(int apicid, s16 node)
@@ -50,6 +51,9 @@ static inline int numa_cpu_node(int cpu)
 {
 	return NUMA_NO_NODE;
 }
+static inline void numa_isolate_memblocks(void)
+{
+}
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 59ba008504dc..df0065e24ea5 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -475,6 +475,25 @@ static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
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
@@ -493,19 +512,8 @@ static void __init numa_clear_kernel_node_hotplug(void)
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
2.13.3


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
