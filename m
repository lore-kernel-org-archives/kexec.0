Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1e6rx4-0001Vf-5t
 for kexec@lists.infradead.org; Tue, 24 Oct 2017 05:40:35 +0000
Message-Id: <20171024053901.703527837@redhat.com>
Date: Tue, 24 Oct 2017 13:31:48 +0800
From: dyoung@redhat.com
Subject: [PATCH 1/3] kdump: extend crashkernel=range:size to dynamically
 increase reservation size
MIME-Version: 1.0
Content-Disposition: inline; filename=kdump-crashkernel-size-scale.patch
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: bhe@redhat.com, corbet@lwn.net, yinghai@kernel.org, akpm@linux-foundation.org, dyoung@redhat.com, vgoyal@redhat.com

crashkernel=range:size syntax allows to reserve specified size for system
with total memory fall into the specified range. For example:
crashkernel=2G-3G:128M,3G-:256M reserves 128M for system with memory >=2G
and memory <3G, and reserves 256M for system with memory >= 3G

In the above case 256M as a fixed value which can not fulfill very huge 
systems with large memory and IO devices. As memory size increases usually
minimum memory requirement for booting will also increase. It is nearly
impossible for a kernel to run with a fixed limited memory size for all
kinds of systems.

Thus extend the crashkernel=range:size to let user specify the scaling
ratio in kernel cmdline like below:
crashkernel=range:size^order, for example:
crashkernel=2G-:128M^14 reserve 128M + (total_memory - 128M) >> 14
for machines with over 2G memory.

Also s/start-[end]/[start]-end/ in kernel-parameters.txt according to code

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt |   10 ++++--
 Documentation/kdump/kdump.txt                   |    7 ++--
 kernel/crash_core.c                             |   35 +++++++++++++++++++++---
 3 files changed, 41 insertions(+), 11 deletions(-)

--- linux-x86.orig/kernel/crash_core.c
+++ linux-x86/kernel/crash_core.c
@@ -31,7 +31,7 @@ static unsigned char *vmcoreinfo_data_sa
 /*
  * This function parses command lines in the format
  *
- *   crashkernel=ramsize-range:size[,...][@offset]
+ *   crashkernel=ramsize-range:size[,...][@offset][^order]
  *
  * The function returns 0 on success and -EINVAL on failure.
  */
@@ -41,6 +41,7 @@ static int __init parse_crashkernel_mem(
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	bool infinite_end = false;
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -93,13 +94,21 @@ static int __init parse_crashkernel_mem(
 		/* match ? */
 		if (system_ram >= start && system_ram < end) {
 			*crash_size = size;
+			if (end == ULLONG_MAX)
+				infinite_end = true;
 			break;
 		}
 	} while (*cur++ == ',');
 
-	if (*crash_size > 0) {
-		while (*cur && *cur != ' ' && *cur != '@')
+	if (*crash_size <= 0)
+		goto out;
+
+	while (*cur && *cur != ' ') {
+		if (*cur != '@' && *cur != '^') {
 			cur++;
+			continue;
+		}
+
 		if (*cur == '@') {
 			cur++;
 			*crash_base = memparse(cur, &tmp);
@@ -107,10 +116,28 @@ static int __init parse_crashkernel_mem(
 				pr_warn("Memory value expected after '@'\n");
 				return -EINVAL;
 			}
-		}
+			cur = tmp;
+		} else if (*cur == '^' && infinite_end ) {
+			unsigned long long shift, size;
+
+			cur++;
+			shift = memparse(cur, &tmp);
+			if (cur == tmp) {
+				pr_warn("Memory reservation scale order expected after '^'\n");
+				return -EINVAL;
+			}
+			size = (system_ram - *crash_size) >> shift;
+			size = *crash_size + roundup(size, 1ULL << 20);
+			if (size < system_ram)
+				*crash_size = size;
+			cur = tmp;
+		} else
+			cur++;
 	}
 
 	return 0;
+out:
+	return -EINVAL;
 }
 
 /*
--- linux-x86.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-x86/Documentation/admin-guide/kernel-parameters.txt
@@ -680,12 +680,14 @@
 			is selected automatically. Check
 			Documentation/kdump/kdump.txt for further details.
 
-	crashkernel=range1:size1[,range2:size2,...][@offset]
+	crashkernel=range1:size1[,range2:size2,...][@offset][^order]
 			[KNL] Same as above, but depends on the memory
 			in the running system. The syntax of range is
-			start-[end] where start and end are both
-			a memory unit (amount[KMG]). See also
-			Documentation/kdump/kdump.txt for an example.
+			[start]-end where start and end are both
+			a memory unit (amount[KMG]). In case the end of the
+			range is infinity '^order' can be used to scale
+			the size to size + (total_mem - start) >> 2^order
+			See also Documentation/kdump/kdump.txt for an example.
 
 	crashkernel=size[KMG],high
 			[KNL, x86_64] range could be above 4G. Allow kernel
--- linux-x86.orig/Documentation/kdump/kdump.txt
+++ linux-x86/Documentation/kdump/kdump.txt
@@ -267,19 +267,20 @@ been removed from the machine.
 
 The syntax is:
 
-    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset]
+    crashkernel=<range1>:<size1>[,<range2>:<size2>,...][@offset][^order]
     range=start-[end]
 
 For example:
 
-    crashkernel=512M-2G:64M,2G-:128M
+    crashkernel=512M-2G:64M,2G-:128M^14
 
 This would mean:
 
     1) if the RAM is smaller than 512M, then don't reserve anything
        (this is the "rescue" case)
     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
-    3) if the RAM size is larger than 2G, then reserve 128M
+    3) if the RAM size is larger than 2G, then reserve:
+       128M + (total_mem - 128M) >> 14
 
 
 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
