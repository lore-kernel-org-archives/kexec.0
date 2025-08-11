Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F3EC87FD2
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 09:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mn6yGCgIfkqUqRIzMPkZRCyDdMUzEhApvE49oVqcvo0=; b=piRBhwQMW2GapuCU7dD2gRpUyH
	rUTq3jxbfAKMCQr6kpC7fZvRETSU3wKn6YidbSVXRu6kgPIg7rn/ObTnwiCTv0rPtFF/NY5clxaBk
	A6shRvPGw1FAh7034MhJ0QCl5rHpVIkQzW3MdT/wdvjEZlreLVK855yQ3gxsPjIcdWM5JZ6MzrRAC
	7BBb/EF9wc3LqeD/lY67ziQ2sMUJooAEJzn/G5M/YuPw0MDtfNoGN7KGzWrwOTntO11jPA+dd0Ogl
	kR7ehIMZQ6ejkIR7FwBT2AH6s9cySjaZxFCFaJqyqRFn4J3EH36PyBCDYtTQn0uuj/O7g8ErHnIkD
	GOdhqlTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpQ-000000076wa-3jkL;
	Mon, 11 Aug 2025 09:28:28 +0000
Received: from out-183.mta1.migadu.com ([95.215.58.183])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulOpO-000000076lZ-11F5
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 09:28:27 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mn6yGCgIfkqUqRIzMPkZRCyDdMUzEhApvE49oVqcvo0=;
	b=FBkchM+oKFunptI/GonLa8A971t0vOUJRpSTuUu1uo3GD5p/4CJaRBj3DOaSI+upBgQjI1
	0kRrxqpEG1a1PyQwR3GxtXFAroLuvQyOAsNJUexLT72W2BwtQL3kb3raTMXH8nWm8/btDR
	OeW3oQyHT9ieBvmxlunj/quxeNvbQVw=
From: Youling Tang <youling.tang@linux.dev>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 0/6] Add kexec_file support for LoongArch
Date: Mon, 11 Aug 2025 17:26:53 +0800
Message-Id: <20250811092659.14903-1-youling.tang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_022826_468581_346012DF 
X-CRM114-Status: UNSURE (   9.67  )
X-CRM114-Notice: Please train this message.
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

This patch series enables us to load the LoongArch vmlinuz.efi or
vmlinux.efi by specifying its file decriptor, instead of user-filled
buffer via kexec_load() syscall.

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

Youling Tang (6):
  LoongArch: Add struct loongarch_image_header for kernel image
  LoongArch: Add kexec_file support
  LoongArch/kexec_file: Add initrd loading
  LoongArch/kexec_file: Add crash dump support
  LoongArch/kexec_file: Add "mem" parameter to limit memory usage of
    kdump kernel
  LoongArch: Enable CONFIG_KEXEC_FILE

 arch/loongarch/Kconfig                     |   8 +
 arch/loongarch/configs/loongson3_defconfig |   1 +
 arch/loongarch/include/asm/image.h         |  58 +++++
 arch/loongarch/include/asm/kexec.h         |  12 ++
 arch/loongarch/kernel/Makefile             |   1 +
 arch/loongarch/kernel/kexec_image.c        | 112 ++++++++++
 arch/loongarch/kernel/machine_kexec.c      |  33 ++-
 arch/loongarch/kernel/machine_kexec_file.c | 234 +++++++++++++++++++++
 8 files changed, 448 insertions(+), 11 deletions(-)
 create mode 100644 arch/loongarch/include/asm/image.h
 create mode 100644 arch/loongarch/kernel/kexec_image.c
 create mode 100644 arch/loongarch/kernel/machine_kexec_file.c

-- 
2.34.1


