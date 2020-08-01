Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: Chen Zhou <chenzhou10@huawei.com>
Subject: [PATCH v11 5/5] kdump: update Documentation about crashkernel
Date: Sat, 1 Aug 2020 21:08:56 +0800
Message-ID: <20200801130856.86625-6-chenzhou10@huawei.com>
In-Reply-To: <20200801130856.86625-1-chenzhou10@huawei.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, dyoung@redhat.com, bhe@redhat.com, corbet@lwn.net, John.P.donnelly@oracle.com, prabhakar.pkin@gmail.com, bhsharma@redhat.com
Cc: wangkefeng.wang@huawei.com, arnd@arndb.de, linux-doc@vger.kernel.org, chenzhou10@huawei.com, xiexiuqi@huawei.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, horms@verge.net.au, nsaenzjulienne@suse.de, huawei.libin@huawei.com, guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org

Now the behavior of crashkernel=X has been changed, which tries low
allocation in ZONE_DMA, and fall back to high allocation if it fails.

If requized size X is too large and leads to very little free memory
in ZONE_DMA after low allocation, the system may not work well.
So add a threshold and go for high allocation directly if the required
size is too large. The threshold is set as the half of low memory.

If crash_base is outside ZONE_DMA, try to allocate at least 256M in
ZONE_DMA automatically. "crashkernel=Y,low" can be used to allocate
specified size low memory. For non-RPi4 platforms, change ZONE_DMA
memtioned above to ZONE_DMA32.

So update the Documentation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 Documentation/admin-guide/kdump/kdump.rst     | 21 ++++++++++++++++---
 .../admin-guide/kernel-parameters.txt         | 11 ++++++++--
 2 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
index 2da65fef2a1c..4b58f97351d5 100644
--- a/Documentation/admin-guide/kdump/kdump.rst
+++ b/Documentation/admin-guide/kdump/kdump.rst
@@ -299,7 +299,15 @@ Boot into System Kernel
    "crashkernel=64M@16M" tells the system kernel to reserve 64 MB of memory
    starting at physical address 0x01000000 (16MB) for the dump-capture kernel.
 
-   On x86 and x86_64, use "crashkernel=64M@16M".
+   On x86 use "crashkernel=64M@16M".
+
+   On x86_64, use "crashkernel=X" to select a region under 4G first, and
+   fall back to reserve region above 4G.
+   We can also use "crashkernel=X,high" to select a region above 4G, which
+   also tries to allocate at least 256M below 4G automatically and
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   Use "crashkernel=Y@X" if you really have to reserve memory from specified
+   start address X.
 
    On ppc64, use "crashkernel=128M@32M".
 
@@ -316,8 +324,15 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
-   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
-   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
+   On arm64, use "crashkernel=X" to try low allocation in ZONE_DMA, and
+   fall back to high allocation if it fails. And go for high allocation
+   directly if the required size is too large. If crash_base is outside
+   ZONE_DMA, try to allocate at least 256M in ZONE_DMA automatically.
+   "crashkernel=Y,low" can be used to allocate specified size low memory.
+   For non-RPi4 platforms, change ZONE_DMA memtioned above to ZONE_DMA32.
+   Use "crashkernel=Y@X" if you really have to reserve memory from
+   specified start address X. Note that the start address of the kernel,
+   X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad81c79..d1b6016850d6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -722,6 +722,10 @@
 			[KNL, x86_64] select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
+			[KNL, arm64] Try low allocation in ZONE_DMA, fall back
+			to high allocation if it fails when '@offset' hasn't been
+			specified. For non-RPi4 platforms, change ZONE_DMA to
+			ZONE_DMA32.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
 
 	crashkernel=range1:size1[,range2:size2,...][@offset]
@@ -746,13 +750,16 @@
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
+			[KNL, arm64] range under 4G.
+			This one let user to specify a low range in ZONE_DMA for
+			crash dump kernel. For non-RPi4 platforms, change ZONE_DMA
+			to ZONE_DMA32.
 	cryptomgr.notests
 			[KNL] Disable crypto self-tests
 
-- 
2.20.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
