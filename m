Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E78C79F85
	for <kexec@archiver.kernel.org>; Fri,  4 Sep 2026 10:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uI5FL0ACsU1gI6Es6Isjml7bm4xOo67fJ+SLBa3OHw0=; b=hOjieHUoE2rKJes/SMw1u7K1vX
	Qr55WR2oU4L/7xoYGcjvPAddd9QpsOSFuPoueNPL2Nx3KswxmuW1yrdfa/44tMDG/+2+A4C2i8RzC
	moQubczod8rvPWGFifc4AlYtuFfVIOA1VBb3pCaHUfmME8QwWpMnWLJPebEAV3oheOt2lZ+l/N2B/
	SF2E5B3a4yAX9u9yhZSHpKZk/0tEWgWWoz4GoXtD3JTTUZHjZYnSvB0KWjtTRL+INLzMdpq9JJIP4
	BzH9dRPxaJt19WB/vPv5b4oimviw/xLhxTlWHylVtEggrXFIKRFYOLNtalqgWStBUNlctjFdHS2tI
	dAlfJjxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2Qsc-00000001coq-0G3a;
	Fri, 04 Sep 2026 10:10:42 +0000
Received: from out-127.mta1.migadu.com ([95.215.58.127] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2QsZ-00000001clz-43yb
	for kexec@lists.infradead.org;
	Fri, 04 Sep 2026 10:10:41 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=/oiDxHrVDKa7VGrXp6hL5mHL7wu/IJpMsp5HWkvasdU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788516638; v=1; x=1789121438;
 b=dg/D2y03QKFwv7tqBdzyogXQtKWJ6QyG1AcV3TJ7bsMddVZASTcVwj62I/0/wfZEFineU+UJ
 CnMSS7E65A4K0nrZe9VxlTxW2cOeDVyg0D8ncWkhy27GLqaMZuMNHGYTvO2pwJF8dwi1WXA3wLh
 UgCdLH577lFDOfuakyd6prj0=
X-Envelope-To: kexec@lists.infradead.org
Received: by smtp.migadu.com with ESMTPS id 6e5c0a65e25e0cdf;
	Fri, 04 Sep 2026 10:10:37 +0000
X-Mizu-Trace-ID: 6e5c0a65e25e0cdf
X-Migadu-Flow: FLOW_OUT
From: George Guo <dongtai.guo@linux.dev>
To: rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	chenhuacai@kernel.org,
	ardb@kernel.org,
	shuah@kernel.org
Cc: ilias.apalodimas@linaro.org,
	akpm@linux-foundation.org,
	baoquan.he@linux.dev,
	ruirui.yang@linux.dev,
	guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	liukexin@kylinos.cn,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: [PATCH v5 5/5] selftests/kho: add LoongArch vmtest support
Date: Fri,  4 Sep 2026 18:08:52 +0800
Message-ID: <20260904100852.26006-6-dongtai.guo@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904100852.26006-1-dongtai.guo@linux.dev>
References: <20260904100852.26006-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260904_031040_151770_D22FD1DB 
X-CRM114-Status: GOOD (  13.62  )
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

From: George Guo <guodongtai@kylinos.cn>

Add loongarch.conf to configure QEMU's LoongArch virtual machine with a
la464 CPU, an 8250 serial console, and the generic PCI host controller.
Extend vmtest.sh to recognize loongarch64 as a supported target and map
it to the loongarch kernel architecture name.

Boot vmlinux.efi through EFI firmware.  The KHO configuration table
channel is installed by the EFI stub during the initial boot, so direct
kernel boot bypasses the path that this test needs to exercise.  QEMU_EFI
defaults to the firmware shipped under /usr/share/edk2/loongarch64/ and
can be overridden for distributions that install it under a different
path, such as Debian's qemu-efi-loongarch64 package.

QEMU's LoongArch virt machine has no i8042 controller.  Enable the generic
PCI host so its I/O space is mapped before the i8042 fallback probe
accesses the legacy ports.  This avoids disabling the i8042 options and
allows the same kernel configuration to remain usable on physical hosts.

Enable ACPI_SPCR_TABLE so the bare earlycon parameter can obtain the UART
type, MMIO address and baud rate from the SPCR table installed by EDK2.
Unlike on x86, ACPI_SPCR_TABLE does not default to enabled on LoongArch.
Without it, no early console is registered for the EFI firmware boot path,
and vmtest cannot observe the early kernel output in its serial log.

The KHO vmtest requires CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, which
depends on SPARSEMEM.  Select CONFIG_SPARSEMEM_MANUAL=y to satisfy the
dependency on LoongArch.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 11 +++++++++++
 tools/testing/selftests/kho/vmtest.sh      |  3 ++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
new file mode 100644
index 000000000000..36153b03c4ef
--- /dev/null
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -0,0 +1,11 @@
+QEMU_EFI="${QEMU_EFI:-/usr/share/edk2/loongarch64/QEMU_EFI.fd}"
+QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464 -bios $QEMU_EFI"
+QEMU_KCONFIG="
+CONFIG_ACPI_SPCR_TABLE=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SPARSEMEM_MANUAL=y
+"
+KERNEL_IMAGE="vmlinux.efi"
+KERNEL_CMDLINE="console=ttyS0 earlycon"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 0014bd76e88d..d05ba0734b25 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -21,7 +21,7 @@ Options:
 	-d)	path to the kernel build directory
 	-j)	number of jobs for compilation, similar to -j in make
 	-t)	run test for target_arch, requires CROSS_COMPILE set
-		supported targets: aarch64, x86_64
+		supported targets: aarch64, loongarch64, x86_64
 	-h)	display this help
 EOF
 }
@@ -126,6 +126,7 @@ function target_to_arch() {
 
 	case $target in
 	     aarch64) echo "arm64" ;;
+	     loongarch64) echo "loongarch" ;;
 	     x86_64) echo "x86" ;;
 	     *) skip "architecture $target is not supported"
 	esac
-- 
2.53.0


