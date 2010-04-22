Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-vw0-f49.google.com ([209.85.212.49])
	by bombadil.infradead.org with esmtp (Exim 4.69 #1 (Red Hat Linux))
	id 1O4zC0-00081t-OE
	for kexec@lists.infradead.org; Thu, 22 Apr 2010 16:23:57 +0000
Received: by mail-vw0-f49.google.com with SMTP id 3so1969792vws.36
	for <kexec@lists.infradead.org>; Thu, 22 Apr 2010 09:23:56 -0700 (PDT)
From: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Subject: [PATCH 5/5] kexec: update documentation
Date: Thu, 22 Apr 2010 18:23:12 +0200
Message-Id: <1271953392-6324-6-git-send-email-v.mayatskih@gmail.com>
In-Reply-To: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
References: <1271953392-6324-1-git-send-email-v.mayatskih@gmail.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Cong Wang <amwang@redhat.com>, Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, Haren Myneni <hbabu@us.ibm.com>, Ingo Molnar <mingo@redhat.com>, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Vivek Goyal <vgoyal@redhat.com>

Mention new crashkernel= syntax in documentation.

Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
---
 Documentation/kdump/kdump.txt       |   40 +++++++++++++++++++++++++++++++++++
 Documentation/kernel-parameters.txt |   19 +++++++++++-----
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index cab61d8..9f93d17 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -266,7 +266,47 @@ This would mean:
     2) if the RAM size is between 512M and 2G (exclusive), then reserve 64M
     3) if the RAM size is larger than 2G, then reserve 128M
 
+Avoiding memory reservation problem on large systems
+====================================================
 
+For large systems with huge amount of memory dump-capture kernel
+requires more memory to handle properly old kernel's pages. However,
+it raises issues with h/w-dependent limitations on some platforms. For
+example, on x86-64 system kernel and initrd still have to be placed in
+first 2 gigabytes, because kernel starts executing in 32-bit mode, and
+kdump purgatory code can jump only to 32-bit signed addresses. This
+limitation is a real problem in cases, when dump-capturing region is
+large and cannot fit in good area. For such cases it's possible to use
+special crashkernel syntax:
+
+    crashkernel=<low>/<high>
+
+<low> and <high> are memory regions for dump-capture kernel in usual
+crashkernel format (size@offset). For example:
+
+    crashkernel=64M/1G@4G
+
+This would mean to allocate 64M of memory at the lowest valid address
+and to allocate 1G at physical address 4G.
+
+New syntax for extended format (in case of memory dependent
+reservation):
+
+    crashkernel=<range1>:<low_size1>[/<high_size1>]
+                [,<range2>:<low_size2>[/high_size2],...]
+                [@low_offset][/high_offset]
+    range=start-[end]
+
+For example:
+
+    crashkernel=2G-32G:256M,32G-:256M/1G@0/8G
+
+This would mean:
+
+    1) if the RAM is smaller than 2G, then don't reserve anything
+    2) if the RAM size is between 2G and 32G (exclusive), then reserve 256M
+    3) if the RAM size is larger than 32G, then reserve 256M at first suitable
+    address (offset 0 means automatically) and reserve 1G at address 8G
 
 Boot into System Kernel
 =======================
diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index e2202e9..5e9f234 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -568,16 +568,23 @@ and is between 256 and 4096 characters. It is defined in the file
 			Format:
 			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
 
-	crashkernel=nn[KMG]@ss[KMG]
-			[KNL] Reserve a chunk of physical memory to
-			hold a kernel to switch to with kexec on panic.
-
-	crashkernel=range1:size1[,range2:size2,...][@offset]
-			[KNL] Same as above, but depends on the memory
+	crashkernel=	[KNL]
+		nn[KMG]@ss[KMG]
+			Reserve a chunk of physical memory to hold a
+			kernel to switch to with kexec on panic.
+		nn1[KMG]@ss1[KMG]/nn2[KMG]@ss2[KMG]
+			Same as above, but reserve 2 chunks of
+			physical memory.
+
+	crashkernel=	[KNL]
+		range1:size1[,range2:size2,...][@offset]
+			Same as above, but depends on the memory
 			in the running system. The syntax of range is
 			start-[end] where start and end are both
 			a memory unit (amount[KMG]). See also
 			Documentation/kdump/kdump.txt for a example.
+		range1:size1lo/size1hi[,range2:size2lo/size2hi,...][@offset_lo][/offset_hi]
+			Same as above, but reserve 2 chunks of memory.
 
 	cs89x0_dma=	[HW,NET]
 			Format: <dma>
-- 
1.7.0.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
