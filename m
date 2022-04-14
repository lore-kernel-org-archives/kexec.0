From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Thu, 14 Apr 2022 19:57:20 +0800
Subject: [PATCH v22 9/9] docs: kdump: Update the crashkernel description for
 arm64
In-Reply-To: <20220414115720.1887-1-thunder.leizhen@huawei.com>
References: <20220414115720.1887-1-thunder.leizhen@huawei.com>
Message-ID: <20220414115720.1887-10-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Now arm64 has added support for "crashkernel=X,high" and
"crashkernel=Y,low", and implements "crashkernel=X[@offset]" in the
same way as x86. So update the Documentation.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 3f1cc5e317ed4a5..ae0aa63ffe82f59 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -795,7 +795,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
@@ -808,20 +808,20 @@
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, X86-64] range could be above 4G. Allow kernel
+			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
 			to allocate physical memory region from top, so could
 			be above 4G if system have more than 4G ram installed.
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
-			devices won't run out. Kernel would try to allocate at
+			devices won't run out. Kernel would try to allocate
 			at least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
-- 
2.25.1


