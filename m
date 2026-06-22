Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15125CDB476
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R21NcL1N2IUfcEZkL7aNZ8F3UlS4EKguIqeOtacmBo8=; b=FangX+q5/VCIFOfdGPWTpemhSO
	oGW760mjB9r9z7fN9GPo9EUoT+eE2e9b1v3ZNnMk43d1azsQd0mSDt4FFdniJ7fumLQ4cxgSTSFXb
	qGZlE52IzydPSjvDG2xdPOGGde5zn+8B3KxGMyJ83T3kwAlR1Gfpbrvn52kDgVbCMnmp9t4BoVHmQ
	iixF4pdiql+8svqi52uKOkGEMnKEmHs354y0VkXy8De9N0RBn/l5/0x70TmNsZmDa/F2Nm5gx/r/7
	qFqohNXKY9jzsDxQDaVEwhB9z8dfcPSZqbmpptvK/U7sX9+CZ9yqtB6WjfrXK9eXg89CdU/B5vWea
	5cetPdjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgb-00000005Ngo-30qX;
	Mon, 22 Jun 2026 20:56:05 +0000
Received: from esa1.hc555-34.eu.iphmx.com ([23.90.104.144])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgX-00000005Nfh-3Rbu
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161761; x=1813697761;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ilH1gfJs8IsKJ34IQXpyF/1kpVxZt37qhlMqKUylaJE=;
  b=OJlrtpr2VD8AnidsnQ7HLRop9aFTq5uN1+BtrWm2gTvrTSAU7PNiI0tc
   +Hm1mg9KN7YINK5W/FcnhliEUi0lO5Iznh5vQLEenx3+JwIKsXQz9QFin
   5yitsLIBFL85Y071UxhmEezBdX5ytpSHwZKsB2fyftL8v0vsCWwZ7LFIt
   kOjqyryqVk5IjvRJQlSFp+vgpE0MgcEHkQRT7QUEKZVAZumSfcTbD8dSi
   awANHKPNbQprBNq+QVe9FKKcaqqcmdvlVjirpcadA7dQx5Ek2hFsv4f2X
   DZtKuxMfss4vuCiRyuzQ9ZXloghhHE3fx1B75Go1S0cSKk4vd0irxr/zQ
   A==;
X-CSE-ConnectionGUID: 25uvBqGFQ8maQWbClrd9hw==
X-CSE-MsgGUID: NPrlaMQZRX6C77F03kglcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa1.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:55:56 +0300
X-CSE-ConnectionGUID: HDLzdxuBRxexysv7YUCBhg==
X-CSE-MsgGUID: qRTFL5GoSX+6zR54tiV/gA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:03 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:55:55 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 00/10] vmcore-tasks: lightweight task and backtrace extractor for vmcore files
Date: Mon, 22 Jun 2026 23:54:38 +0300
Message-ID: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135602_392357_C65E9671 
X-CRM114-Status: GOOD (  15.91  )
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

This series adds vmcore-tasks, a new userspace tool for extracting
per-task debugging information from Linux vmcore (kdump) files. It is
designed as a lightweight tool, targeting embedded
systems where crash-utility may not be available.

Motivation
----------

After a kernel panic, kdump produces a vmcore containing a full memory
snapshot. Existing post-mortem tools like crash-utility are
powerful but heavyweight — they require vmlinux with DWARF debug info
and a matching kernel symbol table. On embedded targets with limited
storage, stripped kernels, or unsupported architectures, this is often
not practical.

vmcore-tasks takes a different approach: it requires no vmlinux or
DWARF data. Instead, a kernel-side component exports the necessary
struct offsets, sizes, and symbol addresses into the standard
vmcoreinfo note section. This data, already embedded in the vmcore
by kdump, is sufficient to navigate kernel data structures,
allowing it to run directly from crash-kernel, and only solving
bt addresses later with tools like addr2line.

vmcore-tasks extract:

  - Per-task register state (pt_regs) and user-space backtraces
  - VMA memory maps with filename resolution via dentry walk
  - Per-thread state for multi-threaded processes
  - Kernel dmesg log (reuses existing vmcore-dmesg infrastructure)

Architecture
------------

The tool is structured in layers:

  util_lib/          Foundation: vmcoreinfo parser, memory reader,
                     maple tree walker (reuses existing elf_info.c
                     and adds new shared utilities)

  vmcore_tasks/      Core logic: task enumeration, VMA collection,
                     generic stack unwinder with arch callbacks

  vmcore_tasks/arch/ Architecture backends: page table translation
                     and instruction decode (RISC-V 64, MIPS64)

The generic unwinder in unwind.c drives frame recovery using
arch-provided callbacks (detect SP adjustment, RA save, signal
trampolines), so adding a new architecture requires only implementing
the instruction decode — not the unwinding state machine.

VMA enumeration auto-selects between the legacy mm_struct->mmap
linked list (kernels < 6.1) and maple tree walk (kernels >= 6.1)
based on vmcoreinfo content.

Integration with kexec-tools
----------------------------

The new files are placed in vmcore_tasks/ and util_lib/.
The util_lib additions (vmcore_info.c, memory.c, maple_tree.c)
are currently built only by the vmcore_tasks Makefile.
Integration into the main kexec-tools build system can follow once
the tool matures.

The tool reuses elf_info.c from util_lib for ELF parsing and
paddr_to_offset() for physical-to-file-offset mapping, and reuses
dump_dmesg() from vmcore-dmesg for kernel log extraction.

Depends on kernel-side patch to export the needed vmcoreinfo values.
Will update with a link to this patch later.

Testing
-------

Validated against vmcore files from controlled kernel panic scenarios
on RISC-V 64-bit (SV39) and MIPS64 platforms, covering multi-frame
backtraces, leaf functions, and signal frame unwinding. Tested both
natively and cross-architecture (x86_64 host processing RISC-V/MIPS64
vmcores).

Pnina Feder (10):
  util_lib: add paddr_to_offset function and expose raw vmcoreinfo data
  util_lib: Add vmcoreinfo parser and memory reader
  util_lib: Add maple tree walker for VMA enumeration
  vmcore_tasks: Add common definitions and project infrastructure
  vmcore_tasks: arch: Add RISC-V 64-bit architecture support
  vmcore_tasks: arch: Add MIPS64 architecture support
  vmcore_tasks: Add generic user-space stack unwinder
  vmcore_tasks: Add VMA utilities and task enumeration
  vmcore_tasks: Add main entry point and backtrace parser
  vmcore_tasks: Add README with project documentation

 util_lib/elf_info.c                           |  53 +-
 util_lib/include/elf_info.h                   |  11 +-
 util_lib/include/maple_tree.h                 | 137 ++++
 util_lib/include/memory.h                     |  37 +
 util_lib/include/vmcore_info.h                |  72 ++
 util_lib/include/vmcore_tasks_util.h          |  62 ++
 util_lib/maple_tree.c                         | 715 ++++++++++++++++++
 util_lib/memory.c                             | 327 ++++++++
 util_lib/vmcore_info.c                        | 382 ++++++++++
 vmcore_tasks/Makefile                         | 103 +++
 vmcore_tasks/README.md                        | 331 ++++++++
 vmcore_tasks/arch/mips64/mips64.c             | 648 ++++++++++++++++
 vmcore_tasks/arch/mips64/mips64_defs.h        |  78 ++
 vmcore_tasks/arch/riscv64/riscv64.c           | 327 ++++++++
 vmcore_tasks/arch/riscv64/riscv64_defs.h      | 127 ++++
 vmcore_tasks/tasks.c                          | 540 +++++++++++++
 vmcore_tasks/tasks.h                          |  53 ++
 vmcore_tasks/unwind.c                         | 267 +++++++
 vmcore_tasks/vma_util.c                       | 429 +++++++++++
 vmcore_tasks/vma_util.h                       |  16 +
 vmcore_tasks/vmcore_tasks.c                   | 182 +++++
 vmcore_tasks/vmcore_tasks_backtrace_parser.py | 393 ++++++++++
 vmcore_tasks/vmcore_tasks_defs.h              | 124 +++
 23 files changed, 5402 insertions(+), 12 deletions(-)
 create mode 100644 util_lib/include/maple_tree.h
 create mode 100644 util_lib/include/memory.h
 create mode 100644 util_lib/include/vmcore_info.h
 create mode 100644 util_lib/include/vmcore_tasks_util.h
 create mode 100644 util_lib/maple_tree.c
 create mode 100644 util_lib/memory.c
 create mode 100644 util_lib/vmcore_info.c
 create mode 100644 vmcore_tasks/Makefile
 create mode 100644 vmcore_tasks/README.md
 create mode 100644 vmcore_tasks/arch/mips64/mips64.c
 create mode 100644 vmcore_tasks/arch/mips64/mips64_defs.h
 create mode 100644 vmcore_tasks/arch/riscv64/riscv64.c
 create mode 100644 vmcore_tasks/arch/riscv64/riscv64_defs.h
 create mode 100644 vmcore_tasks/tasks.c
 create mode 100644 vmcore_tasks/tasks.h
 create mode 100644 vmcore_tasks/unwind.c
 create mode 100644 vmcore_tasks/vma_util.c
 create mode 100644 vmcore_tasks/vma_util.h
 create mode 100644 vmcore_tasks/vmcore_tasks.c
 create mode 100644 vmcore_tasks/vmcore_tasks_backtrace_parser.py
 create mode 100644 vmcore_tasks/vmcore_tasks_defs.h

-- 
2.43.0


