Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QF1g8-0001ux-Jc
	for kexec@lists.infradead.org; Wed, 27 Apr 2011 10:09:05 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3RA3Jcm021969
	for <kexec@lists.infradead.org>; Wed, 27 Apr 2011 04:03:19 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3RA9r8j058984
	for <kexec@lists.infradead.org>; Wed, 27 Apr 2011 04:09:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3RA8O7D018487
	for <kexec@lists.infradead.org>; Wed, 27 Apr 2011 04:08:24 -0600
Message-ID: <4DB7EB31.10704@in.ibm.com>
Date: Wed, 27 Apr 2011 15:38:49 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: [PATCH] Fix memory errors on ppc
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Fix memory errors on ppc

  Fixes buffer overflow and improper realloc() in realloc_memory_ranges().

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

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
index ab76d6f..96fbc12 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -192,11 +192,12 @@ static int realloc_memory_ranges(void)
  	max_memory_ranges++;
  	memory_range_len = sizeof(struct memory_range) * max_memory_ranges;
  
-	memory_range = (struct memory_range *) malloc(memory_range_len);
+	memory_range = (struct memory_range *) realloc(memory_range,
+							memory_range_len);
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

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
