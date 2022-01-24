From: Zhen Lei <thunder.leizhen@huawei.com>
Date: Mon, 24 Jan 2022 16:47:08 +0800
Subject: [PATCH v20 5/5] kdump: update Documentation about crashkernel
In-Reply-To: <20220124084708.683-1-thunder.leizhen@huawei.com>
References: <20220124084708.683-1-thunder.leizhen@huawei.com>
Message-ID: <20220124084708.683-6-thunder.leizhen@huawei.com>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

From: Chen Zhou <chenzhou10@huawei.com>

For arm64, the behavior of crashkernel=X has been changed, which
tries low allocation in DMA zone and fall back to high allocation
if it fails.

We can also use "crashkernel=X,high" to select a high region above
DMA zone, which also tries to allocate at least 256M low memory in
DMA zone automatically and "crashkernel=Y,low" can be used to allocate
specified size low memory.

So update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kdump/kdump.rst       | 11 +++++++++--
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index cb30ca3df27c9b2..d4c287044be0c70 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -361,8 +361,15 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
-   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   On arm64, use "crashkernel=X" to try low allocation in DMA zone and
+   fall back to high allocation if it fails.
+   We can also use "crashkernel=X,high" to select a high region above
+   DMA zone, which also tries to allocate at least 256M low memory in
+   DMA zone automatically.
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y at X" if you really have to reserve memory from
+   specified start address X. Note that the start address of the kernel,
+   X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9ed9..65780c2ca830be0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -792,6 +792,9 @@
 			[KNL, X86-64] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, ARM64] Try low allocation in DMA zone and fall back
+			to high allocation if it fails when '@offset' hasn't been
+			specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -808,6 +811,8 @@
 			Otherwise memory region will be allocated below 4G, if
 			available.
 			It will be ignored if crashkernel=X is specified.
+			[KNL, ARM64] range in high memory.
+			Allow kernel to allocate physical memory region from top.
 	crashkernel=size[KMG],low
 			[KNL, X86-64] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
@@ -816,13 +821,15 @@
 			requires at least 64M+32K low memory, also enough extra
 			low memory is needed to make sure DMA buffers for 32-bit
 			devices won't run out. Kernel would try to allocate at
-			at least 256M below 4G automatically.
+			least 256M below 4G automatically.
 			This one let user to specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
 			It will be ignored when crashkernel=X,high is not used
 			or memory reserved is below 4G.
-
+			[KNL, ARM64] range in low memory.
+			This one let user to specify a low range in DMA zone for
+			crash dump kernel.
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
-- 
2.25.1


