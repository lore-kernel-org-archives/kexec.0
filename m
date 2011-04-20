Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e37.co.us.ibm.com ([32.97.110.158])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QCTla-0005jq-5v
	for kexec@lists.infradead.org; Wed, 20 Apr 2011 09:32:10 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3K9TJWA026859
	for <kexec@lists.infradead.org>; Wed, 20 Apr 2011 03:29:19 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3K9W47d161878
	for <kexec@lists.infradead.org>; Wed, 20 Apr 2011 03:32:04 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3K9W4hG028086
	for <kexec@lists.infradead.org>; Wed, 20 Apr 2011 03:32:04 -0600
Message-ID: <4DAEA812.4050901@in.ibm.com>
Date: Wed, 20 Apr 2011 15:02:02 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: [PATCH] Fix memory access errors for kexec PPC
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: horms@verge.net.au

Hi,

I was trying the kexec for ppc32 and came across a couple of memory errors
while running with glibc.

The attached patch is the outcome of the glibc's alerts !
We define buf[MAXBYTES-1] and issue  fread(buf, 1, MAXBYTES, file), which glibc
reports an error.

Also there is a typo in the realloc_memory_ranges() code for ppc which causes in
a double free().

Kindly apply.


Thanks
Suzuki


---

Signed-off-by: Suzuki K. Poulose <suzuki@in.ibm.com>

diff --git a/kexec/arch/ppc/crashdump-powerpc.c b/kexec/arch/ppc/crashdump-powerpc.c
index 7bfad20..7853dbe 100644
--- a/kexec/arch/ppc/crashdump-powerpc.c
+++ b/kexec/arch/ppc/crashdump-powerpc.c
@@ -83,7 +83,7 @@ static int get_crash_memory_ranges(struct memory_range **range, int *ranges)
  	int memory_ranges = 0;
  	char device_tree[256] = "/proc/device-tree/";
  	char fname[256];
-	char buf[MAXBYTES-1];
+	char buf[MAXBYTES];
  	DIR *dir, *dmem;
  	FILE *file;
  	struct dirent *dentry, *mentry;
diff --git a/kexec/arch/ppc/kexec-ppc.c b/kexec/arch/ppc/kexec-ppc.c
index ab76d6f..837021f 100644
--- a/kexec/arch/ppc/kexec-ppc.c
+++ b/kexec/arch/ppc/kexec-ppc.c
@@ -196,7 +196,7 @@ static int realloc_memory_ranges(void)
  	if (!memory_range)
  		goto err;
  
-	base_memory_range = (struct memory_range *) realloc(memory_range,
+	base_memory_range = (struct memory_range *) realloc(base_memory_range,
  			memory_range_len);
  	if (!base_memory_range)
  		goto err;
@@ -319,7 +319,7 @@ static int get_devtree_details(unsigned long kexec_flags)
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
