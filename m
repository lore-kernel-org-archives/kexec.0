Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CDECD5BBF
	for <kexec@archiver.kernel.org>; Mon, 25 May 2026 06:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hIRi3HO9e8xA8aknZ+Hmyg9qLaGWZHy9zhx8wJx1Ids=; b=T3oGVAGlsR2kxqQt+0TPIIfj8m
	uML3DGyf6teNf2sxmuk2kAgjYUzSWehmdCz7+R+uxefzBm7NqIFTw9/zDFZ8oZjjA4J9sk5z2Ac/f
	aXjECtV4DnwibNc+NX4sEBm9PGV4gBT97gt4iOzvjCvSeC8zXXyMZYWgk3OUJOeaSQtS+rv//x8Be
	By8os3NpyjbfStP7dFfd6JL2W2tQcq5H0fr5ONUWBRf1i08u7fQN9hJbfp5Ik+JNNyT3iSwsswsX5
	M3e+X1ovc5+YxFcrvigBizYRBomLbupqSMUowSMzyYrh/96MEWNTfDcn8pQ3Xq6Iwjc5UnhztTlzW
	VS2tgZpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnl-0000000GQ5z-0Pxb;
	Mon, 25 May 2026 06:28:37 +0000
Received: from out-187.mta1.migadu.com ([95.215.58.187])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROnh-0000000GQ0F-2UTA
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 06:28:34 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779690497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hIRi3HO9e8xA8aknZ+Hmyg9qLaGWZHy9zhx8wJx1Ids=;
	b=IIr3jMS+wd34Awp2PESkNwbtIVAd+PlWxSlG7OC5DEjyjpcqSEGLbiw8523AvvMPLjdbqo
	CjeS0Nnk6q1Kaqdn0L0rv13USlnXLplGl//9Cqz6+d65uyv5Ei7w9OvQVTRHFhvZmhqxdS
	/ykMAAqLGv18mjCxo0qCjhE5lwvUY4M=
From: George Guo <dongtai.guo@linux.dev>
To: chenhuacai@kernel.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org
Cc: kernel@xen0n.name,
	graf@amazon.com,
	shuah@kernel.org,
	loongarch@lists.linux.dev,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 0/7] LoongArch: add KHO support and selftests
Date: Mon, 25 May 2026 14:28:03 +0800
Message-Id: <20260525062810.103367-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_232833_776158_A973C447 
X-CRM114-Status: GOOD (  13.25  )
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

From: George Guo <guodongtai@kylinos.cn>>

This series adds Kexec Handover (KHO) support for LoongArch64 and
extends the KHO selftest infrastructure to run on LoongArch under QEMU.

KHO support (patches 1-2)
--------------------------
Patch 1 wires up the three pieces needed for KHO on LoongArch:
 - Kconfig: select ARCH_SUPPORTS_KEXEC_HANDOVER for 64BIT
 - machine_kexec_file: call cmdline_add_kho() to pass the KHO FDT and
   scratch buffer addresses via "kho_handover=" on the kernel cmdline
 - setup: parse "kho_handover=" early and call kho_populate()

Patch 2 fixes a duplicate-parameter bug when kexec is invoked with
--reuse-cmdline: the running kernel's cmdline already contains a stale
kho_handover= from the previous load.  load_other_segments() prepends a
fresh entry but appends the original cmdline verbatim, so early_param()
calls kho_populate() twice and the second call overwrites the first with
a stale FDT pointer, panicking early in mm_core_init().

Bug fixes (patches 3-4)
------------------------
Patch 3 fixes a build failure with CONFIG_KFENCE=y: virt_to_phys() and
phys_to_virt() in asm/io.h expand to use offset_in_page() and
page_address(), which require <linux/mm.h> that was not included.

Patch 4 moves KEXEC_CONTROL_CODE from 0x100000 to 0x180000.  QEMU
places its machine FDT at 0x100000 when booting with '-kernel'; the
previous placement silently overwrote the FDT with the relocation
trampoline, breaking earlycon in the kexec'd kernel.

Selftest support (patches 5-7)
-------------------------------
Patch 5 adds loongarch.conf and extends vmtest.sh to recognise
loongarch64 as a build target.  QEMU's LoongArch virt machine is
FDT-only (no ACPI), so 'earlycon' must appear on the kernel cmdline or
the console UART is never discovered and the test log stays empty.

Patch 6 disables SERIO_I8042 and its dependents in the QEMU_KCONFIG
fragment.  QEMU's LoongArch virt machine has no i8042 controller; the
fallback port probe hits a page fault on the memory-mapped I/O range and
panics before reaching userspace.

Patch 7 polls the serial output for the test verdict and kills QEMU once
it appears.  QEMU provides no EFI runtime services on LoongArch, so
machine_restart() falls through to an infinite idle loop and QEMU never
exits after kexec.


George Guo (7):
  LoongArch: Add KHO basic support
  LoongArch: kho: strip stale kho_handover= from reused cmdline
  LoongArch: Add missing linux/mm.h include in asm/io.h
  LoongArch: kexec: avoid overwriting QEMU's machine FDT at 0x100000
  selftests/kho: add LoongArch vmtest support
  selftests/kho: LoongArch: disable PS/2 input devices for QEMU virt
  selftests/kho: handle QEMU not exiting after kexec on LoongArch

 arch/loongarch/Kconfig                     |  3 ++
 arch/loongarch/include/asm/io.h            |  1 +
 arch/loongarch/kernel/machine_kexec.c      |  9 +++-
 arch/loongarch/kernel/machine_kexec_file.c | 57 ++++++++++++++++++++++
 arch/loongarch/kernel/setup.c              | 27 ++++++++++
 tools/testing/selftests/kho/loongarch.conf | 10 ++++
 tools/testing/selftests/kho/vmtest.sh      | 38 ++++++++++++---
 7 files changed, 135 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

-- 
2.25.1


