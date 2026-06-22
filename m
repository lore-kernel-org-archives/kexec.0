Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFACCD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8GWlyM8CpMrVXEKuV/nRi01uwx3voyhRm1DG3OkC58=; b=rBzcYwDiS8T/Fi5LZfq+XDbQxA
	aXorw+XjKBI3wawYqem9aYRfmn/yX1X0lkP2SwcE/hDZjSm6Npd0yjaTcFtZPgYr5xr6hg9YuZ1g3
	03L9NM6Xn5/3xd1tFwi1ydTq0y1jQGngrsXnDixItOoXoEiwQnTTZIfkh3Qkowq/7qIZzyZDMt4TJ
	9fH5dFAP8XoDArozcqMdojvuts+vRhb2W/kdw/G81+WpGojjSKzoambzr1LI07FCPl/Z7JBIxNPeQ
	FoLxqPdYlqvXqfIrwlpv+gVSZgYHZQWGQXiXzrGZRx2Ksh0/e+llLhJqpCrdpBtkHtWYJ9mbPsC11
	Nzq6wrEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyj-00000005OOq-2srs;
	Mon, 22 Jun 2026 21:14:49 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblyg-00000005OMj-3HqB;
	Mon, 22 Jun 2026 21:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782162886; x=1813698886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6BSSkCU+NkPV6pTJggNtiu9r13kyn8sWkrRXlCMT02U=;
  b=lsxb+4W4OUSMninH9Y9VSzpsblFhW8Wt3A9Cw6zDZQLHqC0g2JRaD5nI
   0VCXOg0VfvX0n84B6dxOXG25IAhibdGvVBL/uh5Osa4M8XpKtrNUIl09H
   1xKXcr/LB27jMj/RtPRvNg1U6kDhHW3sr0uspT9Rn74Btf6ps2MsDkCLE
   teyRWMhMXcGiChmuzBg7s4reG5RP7ABknXGego4xL8ExdyrLHTDbG2yNp
   N7pCC3l9y3zfmmogPs4rq9uwWgXUZVLYTFGrssc06cM9uFSUlEDcw8rh7
   P9GTjwxXKvOQkY2O8n7wx6KCguOzb50lS0REZHb0sdM5Dhg541dQZaUOG
   A==;
X-CSE-ConnectionGUID: j/nDttYOQW6mhdG90JckSA==
X-CSE-MsgGUID: LOmp3uNiSYmgHAVdBPuRzg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces02_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 00:14:44 +0300
X-CSE-ConnectionGUID: +BChgPoUTmWAZnmRsk2pqw==
X-CSE-MsgGUID: usVcw5RxR/2NhQhyF0UC9A==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.3])
  by ces02_data.me-corp.lan with SMTP; 23 Jun 2026 00:19:53 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Tue, 23 Jun 2026 00:14:43 +0300
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
Subject: [PATCH 2/4] vmcoreinfo: export task and mm struct offsets to vmcoreinfo
Date: Tue, 23 Jun 2026 00:14:28 +0300
Message-ID: <20260622211430.4008899-3-pnina.feder@mobileye.com>
In-Reply-To: <20260622211430.4008899-1-pnina.feder@mobileye.com>
References: <20260622211430.4008899-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_141447_104492_FCB3C313 
X-CRM114-Status: GOOD (  14.75  )
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

Export the struct offsets and sizes needed by the vmcore-tasks tool
to walk task lists, extract register state, and enumerate VMAs from
a vmcore dump. This includes offsets into task_struct, mm_struct,
vm_area_struct, and related structures that are not already covered
by existing vmcoreinfo exports.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 .../admin-guide/kdump/vmcoreinfo.rst          | 77 +++++++++++++++++++
 kernel/vmcore_info.c                          | 60 +++++++++++++++
 2 files changed, 137 insertions(+)

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 7663c610fe90..36103b3cdc05 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -594,3 +594,80 @@ va_kernel_pa_offset
 
 Indicates the offset between the kernel virtual and physical mappings.
 Used to translate virtual to physical addresses.
+
+Task and VMA metadata
+=====================
+
+The following vmcoreinfo entries export struct offsets and sizes needed
+to walk task lists, extract register state, and enumerate VMAs from a
+vmcore dump without requiring kernel debug symbols (DWARF/BTF). Used by
+the vmcore-tasks userspace tool for lightweight post-mortem crash
+analysis.
+
+init_task
+---------
+
+The address of the initial task (swapper). Used as the starting point
+to walk the circular task list via the tasks member.
+
+(task_struct, tasks)|(task_struct, pid)|(task_struct, tgid)|(task_struct, comm)|(task_struct, mm)|(task_struct, stack)|(task_struct, signal)|(task_struct, flags)|(task_struct, __state)|(task_struct, exit_state)|(task_struct, thread_node)
+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
+
+Offsets into task_struct needed to extract per-task metadata: process
+name, PID/TGID, task state, kernel stack pointer, mm_struct pointer,
+signal_struct pointer, and thread group linkage.
+
+(signal_struct, thread_head)|(signal_struct, nr_threads)
+--------------------------------------------------------
+
+Offsets into signal_struct for walking the thread group list and
+determining the number of threads.
+
+(mm_struct, mm_mt)|(mm_struct, pgd)|(mm_struct, start_brk)|(mm_struct, brk)|(mm_struct, start_stack)
+----------------------------------------------------------------------------------------------------
+
+Offsets into mm_struct for accessing the VMA maple tree, page global
+directory, and memory layout boundaries.
+
+Maple tree internals
+--------------------
+
+Offsets for maple_tree, maple_node, maple_range_64, maple_arange_64,
+and maple_metadata structures. These are needed to walk the maple tree
+that stores VMAs (mm_struct.mm_mt) from a vmcore dump.
+
+(vm_area_struct, vm_start)|(vm_area_struct, vm_end)|(vm_area_struct, vm_flags)|(vm_area_struct, vm_file)|(vm_area_struct, vm_mm)
+-------------------------------------------------------------------------------------------------------------------------------
+
+Offsets into vm_area_struct for extracting VMA boundaries, permissions,
+backing file, and owning mm_struct.
+
+(file, f_path)|(path, dentry)|(dentry, d_name)|(dentry, d_parent)|(qstr, hash_len)|(qstr, name)
+------------------------------------------------------------------------------------------------
+
+Offsets for traversing file -> path -> dentry -> name to reconstruct
+the filename backing a VMA.
+
+THREAD_SIZE
+-----------
+
+The size of the kernel stack. Used to locate the pt_regs saved at the
+top of the kernel stack for each task.
+
+(ucontext, uc_mcontext)
+-----------------------
+
+Offset of the machine context within struct ucontext. Used to locate
+saved registers within a signal frame.
+
+__NR_rt_sigreturn
+-----------------
+
+The rt_sigreturn syscall number. Used to identify signal frame return
+trampolines on the user stack during backtrace reconstruction.
+
+CONFIG_PGTABLE_LEVELS|PMD_SHIFT|PGDIR_SHIFT
+--------------------------------------------
+
+Page table geometry constants. Used for walking page tables to translate
+user virtual addresses to physical addresses in a vmcore dump.
diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index 8614430ca212..f963274ab1a2 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -17,6 +17,7 @@
 
 #include <asm/page.h>
 #include <asm/sections.h>
+#include <asm/ucontext.h>
 
 #include "kallsyms_internal.h"
 #include "kexec_internal.h"
@@ -244,6 +245,65 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL(kallsyms_offsets);
 #endif /* CONFIG_KALLSYMS */
 
+	VMCOREINFO_SYMBOL(init_task);
+	VMCOREINFO_STRUCT_SIZE(task_struct);
+	VMCOREINFO_OFFSET(task_struct, tasks);
+	VMCOREINFO_OFFSET(task_struct, thread_node);
+	VMCOREINFO_OFFSET(task_struct, pid);
+	VMCOREINFO_OFFSET(task_struct, tgid);
+	VMCOREINFO_OFFSET(task_struct, exit_state);
+	VMCOREINFO_OFFSET(task_struct, __state);
+	VMCOREINFO_OFFSET(task_struct, flags);
+	VMCOREINFO_OFFSET(task_struct, comm);
+	VMCOREINFO_OFFSET(task_struct, stack);
+	VMCOREINFO_OFFSET(task_struct, signal);
+	VMCOREINFO_OFFSET(signal_struct, thread_head);
+	VMCOREINFO_OFFSET(signal_struct, nr_threads);
+	VMCOREINFO_OFFSET(task_struct, mm);
+	VMCOREINFO_STRUCT_SIZE(mm_struct);
+	VMCOREINFO_OFFSET(mm_struct, mm_mt);
+	VMCOREINFO_OFFSET(mm_struct, pgd);
+	VMCOREINFO_OFFSET(mm_struct, start_brk);
+	VMCOREINFO_OFFSET(mm_struct, brk);
+	VMCOREINFO_OFFSET(mm_struct, start_stack);
+	VMCOREINFO_STRUCT_SIZE(maple_tree);
+	VMCOREINFO_OFFSET(maple_tree, ma_root);
+	VMCOREINFO_OFFSET(maple_tree, ma_flags);
+	VMCOREINFO_STRUCT_SIZE(maple_node);
+	VMCOREINFO_OFFSET(maple_node, slot);
+	VMCOREINFO_OFFSET(maple_node, parent);
+	VMCOREINFO_OFFSET(maple_node, ma64);
+	VMCOREINFO_OFFSET(maple_node, mr64);
+	VMCOREINFO_OFFSET(maple_range_64, pivot);
+	VMCOREINFO_OFFSET(maple_range_64, slot);
+	VMCOREINFO_OFFSET(maple_metadata, end);
+	VMCOREINFO_OFFSET(maple_metadata, gap);
+	VMCOREINFO_OFFSET(maple_arange_64, pivot);
+	VMCOREINFO_OFFSET(maple_arange_64, slot);
+	VMCOREINFO_OFFSET(maple_arange_64, gap);
+	VMCOREINFO_OFFSET(maple_arange_64, meta);
+	VMCOREINFO_STRUCT_SIZE(vm_area_struct);
+	VMCOREINFO_OFFSET(vm_area_struct, vm_start);
+	VMCOREINFO_OFFSET(vm_area_struct, vm_end);
+	VMCOREINFO_OFFSET(vm_area_struct, vm_flags);
+	VMCOREINFO_OFFSET(vm_area_struct, vm_file);
+	VMCOREINFO_OFFSET(vm_area_struct, vm_mm);
+	VMCOREINFO_STRUCT_SIZE(file);
+	VMCOREINFO_OFFSET(file, f_path);
+	VMCOREINFO_OFFSET(path, dentry);
+	VMCOREINFO_STRUCT_SIZE(dentry);
+	VMCOREINFO_OFFSET(dentry, d_name);
+	VMCOREINFO_OFFSET(dentry, d_parent);
+	VMCOREINFO_OFFSET(qstr, hash_len);
+	VMCOREINFO_OFFSET(qstr, name);
+	VMCOREINFO_NUMBER(THREAD_SIZE);
+	VMCOREINFO_STRUCT_SIZE(pt_regs);
+	VMCOREINFO_OFFSET(ucontext, uc_mcontext);
+	VMCOREINFO_NUMBER(__NR_rt_sigreturn);
+	VMCOREINFO_NUMBER(CONFIG_PGTABLE_LEVELS);
+	VMCOREINFO_NUMBER(PMD_SHIFT);
+	VMCOREINFO_NUMBER(PGDIR_SHIFT);
+
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
-- 
2.43.0


