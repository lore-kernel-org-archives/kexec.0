From: Suzuki Poulose <suzuki@in.ibm.com>
Date: Wed, 27 Apr 2011 15:38:49 +0530
Subject: [PATCH] Fix memory errors on ppc
Message-ID: <mailman.211.1303905936.1530.kexec@lists.infradead.org>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Fixes buffer overflow and improper realloc() in realloc_memory_ranges().

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>
(manually applied)
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 kexec/arch/ppc/crashdump-powerpc.c |    2 +-
 kexec/arch/ppc/kexec-ppc.c         |    7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index eb82122..371137c 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -79,7 +79,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
 	int memory_ranges = 0;
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
 	DIR *dir, *dmem;
 	FILE *file;
 	struct dirent *dentry, *mentry;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index ab76d6f..db00b96 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -192,11 +192,12 @@ static int realloc_memory_ranges(void)
 	max_memory_ranges++;
 	memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
 
-	memory_range = (struct memory_range *) malloc(memory_range_len);
+	memory_range = (struct memory_range *) realloc(memory_range,
+						       memory_range_len);
 	if (!memory_range)
 		goto err;
 
-	base_memory_range = (struct memory_range *) realloc(memory_range,
+	base_memory_range = (struct memory_range *) realloc(base_memory_range,
 			memory_range_len);
 	if (!base_memory_range)
 		goto err;
@@ -319,7 +320,7 @@ static int get_devtree_details(unsigned long kexec_flags)
 	unsigned long long htab_base, htab_size;
 	unsigned long long kernel_end;
 	unsigned long long initrd_start, initrd_end;
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
 	char device_tree[256] = "/proc/device-tree/";
 	char fname[256];
 	DIR *dir, *cdir;
-- 
1.7.4.1


