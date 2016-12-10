Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1cFVQv-0002BK-QE
 for kexec@lists.infradead.org; Sat, 10 Dec 2016 00:22:34 +0000
Received: by mail-pg0-x244.google.com with SMTP id x23so3734882pgx.3
 for <kexec@lists.infradead.org>; Fri, 09 Dec 2016 16:22:12 -0800 (PST)
From: Robert LeBlanc <robert@leblancnet.us>
Subject: [PATCH] Add +~800M crashkernel explaination
Date: Fri,  9 Dec 2016 17:22:02 -0700
Message-Id: <20161210002202.19829-1-robert@leblancnet.us>
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
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robert LeBlanc <robert@leblancnet.us>

When trying to configure crashkernel greater than about 800 MB, the
kernel fails to allocate memory on x86 and x86_64. This is due to an
undocumented limit that the crashkernel and other low memory items must
be allocated below 896 MB unless the ",high" option is given. This
updates the documentation to explain this and what I understand the
limitations to be on the option.

Signed-off-by: Robert LeBlanc <robert@leblancnet.us>
---
 Documentation/kdump/kdump.txt | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index b0eb27b..aa3efa8 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -256,7 +256,9 @@ While the "crashkernel=size[@offset]" syntax is sufficient for most
 configurations, sometimes it's handy to have the reserved memory dependent
 on the value of System RAM -- that's mostly for distributors that pre-setup
 the kernel command line to avoid a unbootable system after some memory has
-been removed from the machine.
+been removed from the machine. If you need to allocate more than ~800M
+for x86 or x86_64 then you must use the simple format as the format
+',high' conflicts with the separators of ranges.
 
 The syntax is:
 
@@ -282,11 +284,21 @@ Boot into System Kernel
 1) Update the boot loader (such as grub, yaboot, or lilo) configuration
    files as necessary.
 
-2) Boot the system kernel with the boot parameter "crashkernel=Y@X",
+2) Boot the system kernel with the boot parameter "crashkernel=Y[@X | ,high]",
    where Y specifies how much memory to reserve for the dump-capture kernel
-   and X specifies the beginning of this reserved memory. For example,
-   "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
-   starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
+   and X specifies the beginning of this reserved memory or ',high' to load in
+   high memory. For example, "crashkernel=64M@16M" tells the system
+   kernel to reserve 64 MB of memory starting at physical address
+   0x01000000 (16MB) for the dump-capture kernel.
+
+   Specifying "crashkernel=1G,high" tells the system kernel to reserve 1 GB
+   of memory using high memory for the dump-capture kernel, there may also
+   be some low memory allocated as well. If you need more than ~800M for
+   the crash kernel to operate (volumes on FC/iSCSI, large volumes, systemd
+   added to the previous, etc), you need to specify ',high' since without
+   it crashkerenel has to try and fit under 896M along with some other
+   items and will fail to allocate memory. High memory may only be relevant
+   on x86 and x86_64.
 
    On x86 and x86_64, use "crashkernel=64M@16M".
 
-- 
2.10.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
