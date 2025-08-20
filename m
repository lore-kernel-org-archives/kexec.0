Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C95ACA0EDC
	for <kexec@archiver.kernel.org>; Wed, 20 Aug 2025 05:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IX26plY5Uf29k5UnA4HhqtwDMo5fxBKoNIkZeiD/EKE=; b=wH2NZ/RIxl5wuub2A8z10DNbZe
	Bn0/KCZNAYZDmPDiuR3j0NlYrvQAj2bUiXma0aYbFO7/s1+pCkUmhXWr3nQQ4EqyEPseW/CAKYFbi
	j4z1J3L6NVa8/xeFJE+FKvLPFVJyzAS/CMjsM3OJpsnFegmU4Gwg2ym+20MsWm0vh306MxUHBC/vV
	9vcjuuBaJ7D7SJwNKrrQ0tpaRon3g3C+id8yhtdjsVpzLdVs9otJOysuzAob3t03OF4scsu0fsc5m
	7Qr4cp+KWwO9I8C866y+rO+QR8epQxP3FXNEG/w9D8j8kDsbkdNX08hFBjTG4Bghy13d+xUrSclA4
	7cr8D5aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobrE-0000000CSwb-3eRU;
	Wed, 20 Aug 2025 05:59:36 +0000
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uobrB-0000000CSWa-3XlA
	for kexec@lists.infradead.org;
	Wed, 20 Aug 2025 05:59:35 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755669447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IX26plY5Uf29k5UnA4HhqtwDMo5fxBKoNIkZeiD/EKE=;
	b=AEh2Np3Oz59nRp6/JITqRY8s8f8om5cxv0JtivD/ElFl6AgojeMV5ozdg6pMHUmeDwofC8
	FvnqQpIgkN+EPUWW0LVcjaWFrKzos/SchN+hfv+yGxZzXh2Jbiuvc+VZHIYS0wY4OWFzZJ
	TAOaUH+mBqNs72xkVDJkKoCJ1agSHx0=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH v2 0/5] Add kexec_file support for LoongArch
Date: Wed, 20 Aug 2025 13:56:55 +0800
Message-Id: <20250820055700.24344-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_225934_013365_113E6F08 
X-CRM114-Status: GOOD (  10.64  )
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

From: Youling Tang <tangyouling@kylinos.cn>

This patchset implement kexec_file_load() support on LoongArch.

This patch series enables us to load the LoongArch vmlinuz.efi(pez) or
vmlinux.efi(pei) or vmlinux(elf) by specifying its file decriptor,
instead of user-filled buffer via kexec_load() syscall.

To use kexec_file_load() system call, instead of kexec_load(), at kexec
command, '-s' options must be specified. kexec-tools needs to apply the
corresponding patches. These patches can be found in repository [1] and
will be submitted to the kexec-tools community later.

The basic usage of kexec_file is:
1) Load second kernel image:
 # kexec -s -l vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Startup second kernel:
 # kexec -e

For kdump:
1) Load capture kernel image:
 # kexec -s -p vmlinuz.efi --initrd=initrd.img --reuse-cmdline

2) Do something to crash, like:
 # echo c > /proc/sysrq-trigger

Link:
[1] https://github.com/tangyouling/kexec-tools/commits/main/

Changelog:
 v2:
 * Merge some patches.
 * Add support for ELF format images.
 * Rename kexec_image.c to kexec_efi.c .
 * When KEXEC_FILE is enabled, RELOCATABLE is selected by default.
 * Some minor modifications.

Youling Tang (5):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add kexec_file support
  LoongArch/kexec_file: Support loading ELF binary file
  LoongArch/kexec_file: Add crash dump support
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |  10 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  57 +++++
 arch/loongarch/include/asm/kexec.h         |  13 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_efi.c          | 111 ++++++++++
 arch/loongarch/kernel/kexec_elf.c          | 105 +++++++++
 arch/loongarch/kernel/machine_kexec.c      |  33 ++-
 arch/loongarch/kernel/machine_kexec_file.c | 235 +++++++++++++++++++++
 9 files changed, 555 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_efi.c
 create mode 100644 arch/loongarch/kernel/kexec_elf.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.43.0


