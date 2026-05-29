Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1E5CD6E52
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2pmFg0ye5kd/wVZc0l7oWo0it3EFeUIanJ2wGfN6Hps=; b=iYVFep6IudmKYR7pM/jYhFYt+i
	4vc7FbjjlIjdmTq9hWhV5/GalnL6AWDemBkTqcJCItJID+MwzbItTrfjt6aNNksIgCcRx3WCReMJ7
	jHTla8TZdeCmEf5a6BWrKKOO5eKwOyu63KFYAzDSRCsu/9LgGjvMs1GuVu1lHhw+5csk68OHZobRb
	Sy+kYxXNdQJ7YVvkU/KisRjA/H2MIvoUF5xjIAyd0W5iBLf9HiZor4T1ibYDMyCeyspwjoMwceuS9
	itcutSZljuPs4asBoxMD0B8HI8fe/CLyXNllcuYMIjlnx+i88wJFXzRZYcYDpNuw5ZXtyeF5ZqwjI
	mgVJ96fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyHD-00000007Wlz-2q13;
	Fri, 29 May 2026 14:33:31 +0000
Received: from out-178.mta0.migadu.com ([91.218.175.178])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyHB-00000007WjM-0YIk
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 14:33:30 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780065206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2pmFg0ye5kd/wVZc0l7oWo0it3EFeUIanJ2wGfN6Hps=;
	b=trmWex9plGSmdvJZunorsxrk9A0B2CC66Xq5oDxgPLcra8WcWhAj+yrSNtWCGyJf3kmJUB
	OvAuB90ejBL3rRZNg2vI3fJmInKADuvJEKE9i+aIfK2LrZiw/E/vZ1B+b9g/+1YrF7T5nE
	RMSbjPyQza44x3A7soqYrdkbpo28Eq0=
From: George Guo <dongtai.guo@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Alexander Graf <graf@amazon.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH v2 3/4] selftests/kho: add LoongArch vmtest support
Date: Fri, 29 May 2026 22:32:37 +0800
Message-Id: <20260529143238.169169-4-dongtai.guo@linux.dev>
In-Reply-To: <20260529143238.169169-1-dongtai.guo@linux.dev>
References: <20260529143238.169169-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_073329_341240_232F5683 
X-CRM114-Status: GOOD (  16.72  )
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

Add loongarch.conf to configure QEMU's LoongArch virt machine with a
la464 CPU, enable the 8250 serial console, and set the kernel image
to vmlinux.efi. Extend vmtest.sh to recognize loongarch64 as a
supported target and map it to the 'loongarch' kernel arch name.

QEMU's LoongArch virt machine provides no ACPI tables and relies on
FDT to describe hardware. Without 'earlycon' on the kernel command
line, the FDT is not scanned for a console UART, no output reaches
the console, and vmtest.sh's console log stays empty causing the test
to always fail. Add 'earlycon' to KERNEL_CMDLINE in loongarch.conf
to fix this.

QEMU's LoongArch virt machine has no i8042 PS/2 controller.  When PNP
detection finds nothing, i8042_init() falls back to probing the ports
directly.  On LoongArch the I/O ports are memory-mapped, and the i8042
port addresses are not backed by any device on the virt machine, so
i8042_flush() takes a page fault and the kernel panics:

  i8042: PNP: No PS/2 controller found.
  i8042: Probing ports directly.
  CPU 0 Unable to handle kernel paging request at virtual address ffff800000008064
  ERA: i8042_flush+0x50/0x198
   RA: i8042_init+0x2a8/0x35c
  Kernel panic - not syncing: Attempted to kill init!

Disable SERIO_I8042 and its dependents (KEYBOARD_ATKBD, MOUSE_PS2) in
the QEMU_KCONFIG fragment to prevent the driver from being built.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 10 ++++++++++
 tools/testing/selftests/kho/vmtest.sh      |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
new file mode 100644
index 000000000000..0145cb49e5b2
--- /dev/null
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -0,0 +1,10 @@
+QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464"
+QEMU_KCONFIG="
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_SERIO_I8042 is not set
+"
+KERNEL_IMAGE="vmlinux.efi"
+KERNEL_CMDLINE="console=ttyS0 earlycon"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 49fdac8e8b15..a6ae9ac09595 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -21,7 +21,7 @@ Options:
 	-d)	path to the kernel build directory
 	-j)	number of jobs for compilation, similar to -j in make
 	-t)	run test for target_arch, requires CROSS_COMPILE set
-		supported targets: aarch64, x86_64
+		supported targets: aarch64, x86_64, loongarch64
 	-h)	display this help
 EOF
 }
@@ -123,6 +123,7 @@ function target_to_arch() {
 	case $target in
 	     aarch64) echo "arm64" ;;
 	     x86_64) echo "x86" ;;
+	     loongarch64) echo "loongarch" ;;
 	     *) skip "architecture $target is not supported"
 	esac
 }
-- 
2.25.1


