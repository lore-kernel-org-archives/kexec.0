Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-Id: <64d9638238d079d89de959373a8a1290d6ea6801.1445297709.git.geoff@infradead.org>
In-Reply-To: <cover.1445297709.git.geoff@infradead.org>
References: <cover.1445297709.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 14/16] arm64: kdump: update a kernel doc
Date: Mon, 19 Oct 2015 23:38:54 +0000
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
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, kexec@lists.infradead.org, Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, christoffer.dall@linaro.org

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This patch adds arch specific descriptions about kdump usage on arm64
to kdump.txt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 Documentation/kdump/kdump.txt | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index bc4bd5a..35f4fa7 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,26 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+1) Disable symmetric multi-processing support under "Processor type and
+   features":
+
+   CONFIG_SMP=n
+
+   (If CONFIG_SMP=y, then specify maxcpus=1 on the kernel command line
+   when loading the dump-capture kernel, see section "Load the Dump-capture
+   Kernel".)
+
+2) The maximum memory size on the dump-capture kernel must be limited by
+   specifying:
+
+   mem=X[MG]
+
+   where X should be less than or equal to the size in "crashkernel="
+   boot parameter. Kexec-tools will automatically add this.
+
 Extended crashkernel syntax
 ===========================
 
@@ -312,6 +332,8 @@ Boot into System Kernel
    any space below the alignment point may be overwritten by the dump-capture kernel,
    which means it is possible that the vmcore is not that precise as expected.
 
+   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
+   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
@@ -334,6 +356,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -377,6 +401,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 mem=X[MG] maxcpus=1 reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-- 
2.5.0



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
