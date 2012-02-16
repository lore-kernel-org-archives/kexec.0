Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rxs9X-0001CN-U4
 for kexec@lists.infradead.org; Thu, 16 Feb 2012 03:37:05 +0000
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Thu, 16 Feb 2012 09:06:57 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1G3ar7U2822158
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 09:06:53 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1G3ar6N025786
 for <kexec@lists.infradead.org>; Thu, 16 Feb 2012 14:36:53 +1100
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Subject: [PATCH v1 3/4] [makedumpfile][ppc] Define platform descriptors for
 page translation
Date: Thu, 16 Feb 2012 09:06:47 +0530
Message-ID: <20120216033632.7972.13594.stgit@suzukikp>
In-Reply-To: <20120216033411.7972.77705.stgit@suzukikp>
References: <20120216033411.7972.77705.stgit@suzukikp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

This patch introduces the 'platform' descriptor and an infrastructure
to dynamically probe the platform where the core was generated.

struct platform {
        char *name;		/* name of the platform */
        int pgdir_shift;
        int ptrs_per_pte;
        int pte_size;		/* size of a pte (32/64) */
} base_platform;

The above structure would hold the definitions for page translation for the
platform where the core was generated.

We maintain a list of probe functions, defined for each platform, which can
check if the 'platform string' (obtained by reading the kernel variable
 'powerpc_base_platform') matches one of its variants and update the descriptor
with the specific values. There is a default probe function -at the end of the list - 
which would set the default values for the translation.

get_machdep_info_ppc() will call ppc_probe_base_platform() to scan through
the list of known platform probes to identify the running platform and update
the descriptor accordingly.

This infrastructure will be used for the vmalloc translation for PPC. Since there
are a variety of platforms out there with different translation schemes, this 
infrastructure would help us to support all of them with very little overhead.

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
---

 arch/ppc.c     |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 makedumpfile.c |    2 ++
 makedumpfile.h |   16 +++++++++++++---
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/arch/ppc.c b/arch/ppc.c
index 2ca0dc5..0ad2cf4 100644
--- a/arch/ppc.c
+++ b/arch/ppc.c
@@ -25,6 +25,56 @@
 #include "../elf_info.h"
 #include "../makedumpfile.h"
 
+#define MAX_PLATFORM_LEN	64	/* length of platform string */
+
+struct platform {
+	char *name;
+	int pgdir_shift;
+	int ptrs_per_pte;
+	int pte_size;
+} base_platform;
+
+typedef int (*probe_func_t)(char *, struct platform *);
+
+static int probe_default_platform(char *, struct platform*);
+
+probe_func_t probe_platforms[] = {
+	probe_default_platform,		/* This should be at the end of the list */
+	NULL
+};
+
+static int probe_default_platform(char *s, struct platform *p)
+{
+	/* Accept as the default platform */
+	p->name = strdup(s);
+	p->pgdir_shift = DEFAULT_PGDIR_SHIFT;
+	p->ptrs_per_pte = DEFAULT_PTRS_PER_PTE;
+	p->pte_size = DEFAULT_PTE_SIZE;
+
+	return TRUE;
+}
+
+static void
+ppc_probe_base_platform(void)
+{
+	unsigned long ptr;
+	char ppc_platform[MAX_PLATFORM_LEN];
+	int i;
+
+
+	if (SYMBOL(powerpc_base_platform) == NOT_FOUND_SYMBOL ||
+	    !readmem(VADDR, SYMBOL(powerpc_base_platform), &ptr, sizeof(ptr)) ||
+	    !read_string(VADDR, ptr, ppc_platform, MAX_PLATFORM_LEN - 1))
+		/* lets fallback to default if we couldn't find the platform */
+		ppc_platform[0] = '\0';
+
+	for(i = 0; probe_platforms[i] != NULL; i++) {
+		probe_func_t probe = probe_platforms[i];
+		if(probe(ppc_platform, &base_platform))
+			break;
+	}
+}
+
 int
 get_machdep_info_ppc(void)
 {
@@ -63,6 +113,9 @@ get_machdep_info_ppc(void)
 	info->vmalloc_start = vmalloc_start;
 	DEBUG_MSG("vmalloc_start: %lx\n", vmalloc_start);
 
+	ppc_probe_base_platform();
+	DEBUG_MSG("Using '%s' platform VM definitions\n", base_platform.name);
+
 	return TRUE;
 }
 
diff --git a/makedumpfile.c b/makedumpfile.c
index e978e1c..2550edc 100644
--- a/makedumpfile.c
+++ b/makedumpfile.c
@@ -855,6 +855,8 @@ get_symbol_info(void)
 	if (SYMBOL(__per_cpu_offset) != NOT_FOUND_SYMBOL)
 		SYMBOL_ARRAY_LENGTH_INIT(__per_cpu_offset, "__per_cpu_offset");
 
+	SYMBOL_INIT(powerpc_base_platform, "powerpc_base_platform");
+
 	return TRUE;
 }
 
diff --git a/makedumpfile.h b/makedumpfile.h
index f7603d7..3a5152c 100644
--- a/makedumpfile.h
+++ b/makedumpfile.h
@@ -539,9 +539,13 @@ do { \
 #define _SECTION_SIZE_BITS	(24)
 #define _MAX_PHYSMEM_BITS	(44)
 
-#define PGDIR_SHIFT		(22)
-#define PTRS_PER_PTE		(1024)
-#define PTE_SIZE		(sizeof(unsigned long))
+#define DEFAULT_PGDIR_SHIFT	(22)
+#define DEFAULT_PTRS_PER_PTE	(1024)
+#define DEFAULT_PTE_SIZE	(sizeof(unsigned long))
+
+#define PGDIR_SHIFT		(base_platform.pgdir_shift)
+#define PTRS_PER_PTE		(base_platform.ptrs_per_pte)
+#define PTE_SIZE		(base_platform.pte_size)
 
 #define _PAGE_PRESENT		(0x1)
 
@@ -1018,6 +1022,12 @@ struct symbol_table {
 	unsigned long long	high_memory;
 
 	/*
+	 * PPC platform string pointer. Used for
+	 * vmalloc translation.
+	 */
+	unsigned long long	powerpc_base_platform;
+
+	/*
 	 * for sadump
 	 */
 	unsigned long long	linux_banner;


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
