Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2634FCDB46F
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rK+wdpTKwtUqqQbnzbovNKE4a949rchqs+3YgpItl4U=; b=YA7oQd2F5aa2MBPT5QbfBD9skr
	hIdMf4qjaYdMJdflG/yy2fH/IV6Wil4Pzqi2ofZCemZipiMkRR04Fq4oVqnl1Ew/hc7xSRB+UYgjr
	QdnUjXKQCW2FHb7pwKN5QS70i1RjPUbxy+DWATkIc0ZIzD72pU71teYMzvjjAqo54fU5DVKZD09mv
	Wk+LeATnul8FlsYaxtttvosbWKUW7Tflulu3gFVysSJgoXSaOEfnK2L3P7JcP4KISxq03pGyN4gtr
	HgBRMowDjjzeooYKPNJ27E4H2nF5rxZsesdNoUq/FF3RViNg24hYg3UVcHVvfixFwlH4PtOy3juIu
	n81LlJaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyb-00000005OKz-166t;
	Mon, 22 Jun 2026 21:14:41 +0000
Received: from esa3.hc555-34.eu.iphmx.com ([207.54.77.50])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyY-00000005OKU-2011;
	Mon, 22 Jun 2026 21:14:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782162878; x=1813698878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D3y8PBJx5rtb8CmEmDXgcyrYvH9ZgsAHrPcIa59UTq4=;
  b=QOtJGwOcwDOtcQuxX9CcU1zqcauPlZRqUAvCTT4zaACEw0LbUVYC0/52
   +9O2Eq+CrnGbg3ew1Huu6HY83/4zZkkSt4t8D08JgW+PoUxmOe2+cNPlZ
   ALDhvqKDbaQRYzAq8cFRid2BkFji+tz2rzB2WG0gLEVw1SEzERG09Z1S/
   1gRCGAS5JSwWAQOdQTWnUhS1qOxl+f4D7RUflKcA6cMo2KtkdvgdsOtuV
   ouvESiu17V/vsOUAHZIJIWswWO9zILrIMyzZOiMsBr/euUTt2XDu0zVJz
   hNrhZmwNj0zE/HOv7Rvjxsc2TqRgm9CTnVqbcSRVvR7g4cwgcJCctKnOr
   Q==;
X-CSE-ConnectionGUID: oT3kSS77Tyq+c7aft27FLg==
X-CSE-MsgGUID: M7T8Y9deSDeaWl9YgpU/sw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:14:36 +0300
X-CSE-ConnectionGUID: IJ4IgnLqQFWzySBMiwjKVQ==
X-CSE-MsgGUID: aQq98ZxbQ3KVyRPomf/Zzg==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:19:42 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:14:34 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Dave Young <ruirui.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ghiti <alex@ghiti.fr>,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 0/4] vmcore-tasks: export per-task metadata to vmcoreinfo
Date: Tue, 23 Jun 2026 00:14:26 +0300
Message-ID: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_141438_816354_49484DA7 
X-CRM114-Status: GOOD (  11.60  )
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

This series extends vmcoreinfo with struct offsets and sizes needed by
the vmcore-tasks userspace tool to extract per-task state from a vmcore
dump without requiring kernel debug symbols (DWARF/BTF).

The vmcore-tasks tool reads /proc/vmcore (or a saved vmcore file) and
reconstructs, for each task:
  - task name, pid, state, flags
  - VMA list (start, end, flags, backing file)
  - user register state (saved on the kernel stack at kernel entry)
  - user-space backtrace with VMA/filename mapping
  - kernel dmesg buffer

This provides a lightweight post-mortem crash analysis capability for
production environments where full debug info (DWARF/BTF) is not
available.

The companion userspace tool is submitted to kexec-tools:
  https://lore.kernel.org/all/20260622205550.1087163-1-pnina.feder@mobileye.com/

The series is structured as follows:

  Patch 1: Increase vmcoreinfo buffer from PAGE_SIZE to a fixed SZ_8K,
           decoupled from page size to avoid waste on large-page
           architectures (MIPS 16KB, arm64 64KB).

  Patch 2: Export generic struct offsets (task_struct, mm_struct,
           vm_area_struct, maple_tree, file/dentry/path, pt_regs,
           signal_struct) needed to walk task lists and VMAs.

  Patch 3: Export RISC-V arch-specific offsets (signal frame layouts,
           register context structures) for user register extraction.

  Patch 4: Export MIPS arch-specific offsets (signal frame layouts,
           register context structures) for user register extraction.

Additional architecture support (arm64, x86, etc.) can follow the
same pattern established by patches 3 and 4.

Tested on MIPS64 (QEMU Malta) and RISC-V with full kdump pipeline:
primary kernel -> kexec panic -> crash kernel -> vmcore-tasks analysis.

Pnina Feder (4):
  vmcoreinfo: increase vmcoreinfo buffer to 8KB
  vmcoreinfo: export task and mm struct offsets to vmcoreinfo
  riscv: vmcore_info: export riscv arch-specific struct offsets to
    vmcoreinfo
  mips: vmcore_info: export mips arch-specific struct offsets to
    vmcoreinfo

 .../admin-guide/kdump/vmcoreinfo.rst          | 137 ++++++++++++++++++
 arch/mips/kernel/Makefile                     |   1 +
 arch/mips/kernel/signal.c                     |   8 +
 arch/mips/kernel/vmcore_info.c                |  22 +++
 arch/riscv/kernel/signal.c                    |   8 +
 arch/riscv/kernel/vmcore_info.c               |  11 ++
 include/linux/vmcore_info.h                   |   3 +-
 kernel/vmcore_info.c                          |  60 ++++++++
 8 files changed, 249 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kernel/vmcore_info.c

-- 
2.43.0


