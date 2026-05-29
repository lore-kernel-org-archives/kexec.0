Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7439BCD6E4A
	for <kexec@archiver.kernel.org>; Fri, 29 May 2026 14:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eyl+ehBlxBHsDx62eFKFPSNCgRZqAc+bGbUbiW2nOz8=; b=sa+2Ple5beoUYYh7AwMCulQe5a
	bvVq1NN8caoKCOB8uDcLjv/nVr8PMou8akjuK7QSRHY/Tk7UTUtTUgXUT4usleh2Jk7kKwo9NoQEr
	bGgBCxJinaMVY5yh3GDU1ywkUSAJMVmpJA8QOgV3TZBa4vv8b48Gju9clFKZfgKsBa44L03XU3fv+
	usW2qgm/cdXsPz9nRU5aIbzIcZ17uKi8ASaBHF4g95i71nYy3/NAJvVRJYWCG8Mg+INoElA+qRUJo
	AyWgtbrKOsW6CS1lX7CBw5zIBfAc4F84lIkPOnf1f6wB/h1/i7lXzNh0uQpZ98jzdchXwK/kBGZQ1
	QKGT4Amw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyH9-00000007WjR-1n30;
	Fri, 29 May 2026 14:33:27 +0000
Received: from out-188.mta0.migadu.com ([2001:41d0:1004:224b::bc])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSyH6-00000007Wi2-3lsR
	for kexec@lists.infradead.org;
	Fri, 29 May 2026 14:33:26 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780065197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eyl+ehBlxBHsDx62eFKFPSNCgRZqAc+bGbUbiW2nOz8=;
	b=DZjSulJ961TsPjzS3b+q4BFKgAd2C05gQOdDZlFa763xRuqKnpXByoSAiGELafch2Gl9Kv
	a95Tb6wB1z6MyzZmazv2suEs0dzCNZXvCgB+d6bqsw3Q1BKGdhe+v4YwAwSUKtgWfvVjVU
	ZohlUO6R3CXU3BR5GBu46ZASDoyT5Zo=
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
	George Guo <guodongtai@kylinos.cn>
Subject: 
Date: Fri, 29 May 2026 22:32:34 +0800
Message-Id: <20260529143238.169169-1-dongtai.guo@linux.dev>
MIME-Version: 1.0
ERROR: Invalid commit separator - some tools may have problems applying this
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_073325_082095_7BAB384B 
X-CRM114-Status: GOOD (  13.92  )
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

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#26: 
containing only /chosen with the two KHO properties.  Since DEVICE_TREE_GUID

ERROR: Invalid commit separator - some tools may have problems applying this
#34: 
-------------------------------

total: 2 errors, 1 warnings, 0 lines checked
>
Date: Fri, 29 May 2026 21:54:01 +0800
Subject: [PATCH v2 0/4] LoongArch: add KHO support and selftests

This series adds Kexec Handover (KHO) support for LoongArch and extends
the KHO selftest infrastructure to run on LoongArch under QEMU.

KHO passes metadata (the KHO state FDT and scratch area addresses) to the
second kernel via the FDT /chosen node, using the linux,kho-fdt and
linux,kho-scratch properties that drivers/of/kexec.c:kho_add_chosen()
writes and drivers/of/fdt.c:early_init_dt_check_kho() reads.

KHO support (patches 1-2):

Patch 1 adds KHO support for FDT-based systems (initial_boot_params !=
NULL, e.g. QEMU virt without OVMF).  kho_load_fdt() copies the running
kernel's FDT, appends linux,kho-fdt and linux,kho-scratch to /chosen,
and loads the result as a kexec segment.  machine_kexec() updates the
DEVICE_TREE_GUID entry in the EFI config table to point to this segment
so the second kernel's fdt_setup() can find and parse it.

Patch 2 adds KHO support for ACPI-only systems (initial_boot_params ==
NULL, e.g. LoongArch servers with UEFI or QEMU with OVMF).  Because no
system FDT is available, kho_load_fdt() builds a minimal FDT from
scratch containing only /chosen with the two KHO properties.  Since
DEVICE_TREE_GUID is absent from the EFI config table on ACPI-only
systems, a new extended config table is built with the entry appended
and loaded as a kexec segment; machine_kexec() switches st->tables to
point to it before jumping.  The second kernel's fdt_setup() calls
efi_fdt_pointer() to detect the KHO FDT and passes it to
early_init_dt_check_kho().

Selftest support (patches 3-4):

Patch 3 adds loongarch.conf and extends vmtest.sh to recognise loongarch64
as a build target.  The LoongArch virt machine is FDT-only (no ACPI), so
'earlycon' must appear on the kernel cmdline or the console UART is never
discovered.  PS/2 input devices are also disabled since QEMU's LoongArch
virt machine has no i8042 controller; the fallback port probe hits a page
fault and panics before reaching userspace.

Patch 4 handles QEMU not exiting after kexec on LoongArch.  QEMU provides
no EFI runtime services, so machine_restart() falls through to an infinite
idle loop.  QEMU_NEEDS_KILL=1 in loongarch.conf signals vmtest.sh to run
QEMU in the background, poll the serial output for the test verdict, and
kill QEMU once it appears, so the test completes unattended.

George Guo (4):
  LoongArch: kexec: add KHO support for FDT-based systems
  LoongArch: kexec: add KHO support for ACPI-only systems
  selftests/kho: add LoongArch vmtest support
  selftests/kho: handle QEMU not exiting after kexec on LoongArch

 arch/loongarch/Kconfig                     |   3 +
 arch/loongarch/include/asm/kexec.h         |   7 +
 arch/loongarch/kernel/machine_kexec.c      |  38 +++
 arch/loongarch/kernel/machine_kexec_file.c | 256 +++++++++++++++++++++
 arch/loongarch/kernel/setup.c              |  21 +-
 tools/testing/selftests/kho/loongarch.conf |  13 ++
 tools/testing/selftests/kho/vmtest.sh      |  35 ++-
 7 files changed, 365 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/kho/loongarch.conf

-- 
2.25.1


