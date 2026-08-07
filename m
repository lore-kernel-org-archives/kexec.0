Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24A49C5AC7A
	for <kexec@archiver.kernel.org>; Fri,  7 Aug 2026 10:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cRL3uotexgsAYtLUosWyuQdevxVlf8Hhe38VeOp48k=; b=xfNiRLRH1R1hnxphFtmF4TJUvZ
	g2sHEzQERtbCOAqUOAnVX32UnZrVWGPRR3F0/HzO8vzhttS5yannpVnnsQ4zNH+IFy5dhVeKYVVcB
	wHMB/IK6COc+WewnIdKfbGaz2SkXAslnSZuvNlR8cbRxEfmCsWnTiy9WxwpwMcrKgLUDXzosnX8Bi
	iUVUBdsC9J+iu29hIlLRc5e0rQH6NUvgPL13/7U2PTYoLZYhHBHDEr6VsJxfhSxnhInrJXmiRh/ZH
	yRVNMXGFt9G+thSyzUMk2j34onrClXIxHHnMILYxllmapq766Mhs2xtUMLmqPc7dYQFd+sBtWm5s8
	GVdkvhdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHyr-00000007h7V-3sfe;
	Fri, 07 Aug 2026 10:39:13 +0000
Received: from out-170.mta0.migadu.com ([2001:41d0:1004:224b::aa])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHyp-00000007h6V-0EjQ
	for kexec@lists.infradead.org;
	Fri, 07 Aug 2026 10:39:12 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786099147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+cRL3uotexgsAYtLUosWyuQdevxVlf8Hhe38VeOp48k=;
	b=leFCf1q7bWexhIlRym5mgLf1EOisTxXGgyEu7WyO9nLs6AFFzBa5eAN4zwjxXwdcx9Zca0
	omPlm5ULbkJc4DAoXhz5sJcehdTr4IdR3WIHmsRnRF4G7Y5VNtpBLF9EzxE+TcLqPLTWwa
	oHj3Bgs1ou/YKoTNmTnBdncag6GUT54=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	shuah@kernel.org,
	ardb@kernel.org
Cc: guodongtai@kylinos.cn,
	kernel@xen0n.name,
	graf@amazon.com,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-efi@vger.kernel.org,
	Kexin Liu <liukexin@kylinos.cn>
Subject: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
Date: Fri,  7 Aug 2026 18:37:14 +0800
Message-ID: <20260807103714.33074-5-dongtai.guo@linux.dev>
In-Reply-To: <20260807103714.33074-1-dongtai.guo@linux.dev>
References: <20260807103714.33074-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_033911_371766_3F930B6C 
X-CRM114-Status: GOOD (  17.29  )
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

Add loongarch.conf to configure QEMU's LoongArch virtual machine (VM)
with a la464 CPU, enable the 8250 serial console, and set the kernel
image to vmlinux.efi.  Extend vmtest.sh to recognise loongarch64 as a
supported target and map it to the 'loongarch' kernel arch name.

QEMU's LoongArch VM provides no ACPI tables and relies on FDT to
describe hardware.  Without 'earlycon' on the kernel command line, the
FDT is not scanned for a console UART, no output reaches the console,
and vmtest.sh's console log stays empty causing the test to always
fail.  Add 'earlycon' to KERNEL_CMDLINE in loongarch.conf.

QEMU's LoongArch VM has no i8042 PS/2 controller.  When PNP detection
finds nothing, i8042_init() falls back to probing the ports directly.
On LoongArch the I/O ports are memory-mapped, and the i8042 port
addresses are not backed by any device on the VM, so i8042_flush() takes
a page fault and the kernel panics:

  i8042: PNP: No PS/2 controller found.
  i8042: Probing ports directly.
  CPU 0 Unable to handle kernel paging request at virtual address ffff800000008064
  ERA: i8042_flush+0x50/0x198
   RA: i8042_init+0x2a8/0x35c
  Kernel panic - not syncing: Attempted to kill init!

Disable SERIO_I8042 and its dependents (KEYBOARD_ATKBD, MOUSE_PS2) in
the QEMU_KCONFIG fragment to prevent the driver from being built.
All three options are scoped to loongarch.conf; no other architecture
is affected.

Wrap the QEMU invocation in run_qemu() with timeout(1) using a local
time limit so the test always terminates, even when QEMU does not exit
on its own.  This is useful for every architecture; on LoongArch, for
example, QEMU provides no EFI runtime services and machine_restart()
falls through to an idle loop after kexec, so QEMU would never exit
otherwise.

Co-developed-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: Kexin Liu <liukexin@kylinos.cn>
Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 tools/testing/selftests/kho/loongarch.conf | 11 +++++++++++
 tools/testing/selftests/kho/vmtest.sh      | 22 +++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

diff --git a/tools/testing/selftests/kho/loongarch.conf b/tools/testing/selftests/kho/loongarch.conf
new file mode 100644
index 000000000000..e45fe1014cf3
--- /dev/null
+++ b/tools/testing/selftests/kho/loongarch.conf
@@ -0,0 +1,11 @@
+QEMU_CMD="qemu-system-loongarch64 -M virt -cpu la464"
+QEMU_KCONFIG="
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SPARSEMEM_MANUAL=y
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_MOUSE_PS2 is not set
+# CONFIG_SERIO_I8042 is not set
+"
+KERNEL_IMAGE="vmlinux.efi"
+KERNEL_CMDLINE="console=ttyS0 earlycon kho_scratch=16M,16M,16M"
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index 0014bd76e88d..de6aa59cf5a0 100755
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
@@ -111,12 +111,19 @@ function run_qemu() {
 
 	cmdline="$cmdline kho=on panic=-1"
 
-	$qemu_cmd -m 1G -smp 2 -no-reboot -nographic -nodefaults \
-		  -accel kvm -accel hvf -accel tcg  \
-		  -serial file:"$serial" \
-		  -append "$cmdline" \
-		  -kernel "$kernel" \
-		  -initrd "$initrd"
+	local qemu_args=(
+		-m 1G -smp 2 -no-reboot -nographic -nodefaults
+		-accel kvm -accel hvf -accel tcg
+		-serial file:"$serial"
+		-append "$cmdline"
+		-kernel "$kernel"
+		-initrd "$initrd"
+	)
+
+	# Bound the QEMU run so the test always terminates, even when QEMU
+	# does not exit on its own (e.g. no EFI runtime services after kexec).
+	local qemu_timeout=60
+	timeout "$qemu_timeout" $qemu_cmd "${qemu_args[@]}" || true
 
 	grep "KHO restore succeeded" "$serial" &> /dev/null || fail "KHO failed"
 }
@@ -127,6 +134,7 @@ function target_to_arch() {
 	case $target in
 	     aarch64) echo "arm64" ;;
 	     x86_64) echo "x86" ;;
+	     loongarch64) echo "loongarch" ;;
 	     *) skip "architecture $target is not supported"
 	esac
 }
-- 
2.53.0


