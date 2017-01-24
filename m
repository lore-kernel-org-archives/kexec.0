Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cVwpY-0000ZV-TW
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 08:51:58 +0000
Received: by mail-pg0-f44.google.com with SMTP id t6so53340372pgt.3
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 00:51:36 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v30 10/11] Documentation: kdump: describe arm64 port
Date: Tue, 24 Jan 2017 17:50:04 +0900
Message-Id: <20170124085004.3892-9-takahiro.akashi@linaro.org>
In-Reply-To: <20170124084638.3770-1-takahiro.akashi@linaro.org>
References: <20170124084638.3770-1-takahiro.akashi@linaro.org>
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
To: catalin.marinas@arm.com, will.deacon@arm.com
Cc: mark.rutland@arm.com, geoff@infradead.org, kexec@lists.infradead.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, linux-arm-kernel@lists.infradead.org

Add arch specific descriptions about kdump usage on arm64 to kdump.txt.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Reviewed-by: Baoquan He <bhe@redhat.com>
Acked-by: Dave Young <dyoung@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/kdump/kdump.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
index b0eb27b956d9..615434d81108 100644
--- a/Documentation/kdump/kdump.txt
+++ b/Documentation/kdump/kdump.txt
@@ -18,7 +18,7 @@ memory image to a dump file on the local disk, or across the network to
 a remote system.
 
 Kdump and kexec are currently supported on the x86, x86_64, ppc64, ia64,
-s390x and arm architectures.
+s390x, arm and arm64 architectures.
 
 When the system kernel boots, it reserves a small section of memory for
 the dump-capture kernel. This ensures that ongoing Direct Memory Access
@@ -249,6 +249,13 @@ Dump-capture kernel config options (Arch Dependent, arm)
 
     AUTO_ZRELADDR=y
 
+Dump-capture kernel config options (Arch Dependent, arm64)
+----------------------------------------------------------
+
+- Please note that kvm of the dump-capture kernel will not be enabled
+  on non-VHE systems even if it is configured. This is because the CPU
+  will not be reset to EL2 on panic.
+
 Extended crashkernel syntax
 ===========================
 
@@ -305,6 +312,8 @@ Boot into System Kernel
    kernel will automatically locate the crash kernel image within the
    first 512MB of RAM if X is not given.
 
+   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
+   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
 
 Load the Dump-capture Kernel
 ============================
@@ -327,6 +336,8 @@ For s390x:
 	- Use image or bzImage
 For arm:
 	- Use zImage
+For arm64:
+	- Use vmlinux or Image
 
 If you are using a uncompressed vmlinux image then use following command
 to load dump-capture kernel.
@@ -370,6 +381,9 @@ For s390x:
 For arm:
 	"1 maxcpus=1 reset_devices"
 
+For arm64:
+	"1 maxcpus=1 reset_devices"
+
 Notes on loading the dump-capture kernel:
 
 * By default, the ELF headers are stored in ELF64 format to support
-- 
2.11.0


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
