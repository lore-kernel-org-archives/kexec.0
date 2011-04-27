Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1QF3Uo-0002tl-Ud
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 12:05:35 +0000
Date: Wed, 27 Apr 2011 21:05:26 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Fix memory errors on ppc
Message-ID: <20110427120526.GE25693@verge.net.au>
References: <4DB7EB31.10704@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4DB7EB31.10704@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

On Wed, Apr 27, 2011 at 03:38:49PM +0530, Suzuki Poulose wrote:
> Fix memory errors on ppc
> 
>  Fixes buffer overflow and improper realloc() in realloc_memory_ranges().
> 
> Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

Thanks.

For some reason I still had trouble applying your patch,
so I applied it manually. I have pushed the following:

From 806ef8870539a6c74a2a98188d0207a038b16f77 Mon Sep 17 00:00:00 2001
From: Suzuki Poulose <suzuki@in.ibm.com>
Date: Wed, 27 Apr 2011 15:38:49 +0530
Subject: [PATCH] Fix memory errors on ppc

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


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
