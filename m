Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F87CDB476
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PlfIM1WXChynIzNndVv7V2faxxZlWxR863esbkfsUdo=; b=w3nh6mfo6hyFmZxQkbC0uUq08P
	pLI0zL2CUUCCHslPfOGlwePsQZMLqbv1xSjxN4kkU4lQu1h7IzY6rA8MdJUkWFo5/13/Fof7lpDCx
	3pIpruG2eaYIWF7SPaKR2HAIUpUyg/F+s4HrgTxv7VyhLw+rFK3ajFWg4XebRgURJA4hjGFIveQaD
	CwV56ZGKDX+inbstJO9kduo1jzJaFvPeFoZaTJD7g51LtAOogJhY03QgBtDZt25ZG4Wn8uma9pu8p
	doAsZmNZQ5TxiLjrx13lgsCTB0Z2MKJ5CT3shGNww0sRWe/17/77dd/Jt+hUgQgWhfXig3nEDp+Tq
	yQBV557w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgr-00000005Nu8-2bl8;
	Mon, 22 Jun 2026 20:56:21 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgp-00000005Nnt-1B3k
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161779; x=1813697779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XpOBrcopnmibtWd/z94Ied82FyCUSNgq6OxIIjj++/Q=;
  b=bhPZ6OB3kJ8cFRCF9rAZWByOlBzdTcRNyvz202bc3MNHn7bJfx9GdubP
   V90SlYuUltjVfw4dkxlT+AvX/4ZxK3Fahs6QaX/ii+Z5ZlAFk6TjshSWT
   RE+azXwooE//oe0OU9V1KmevetcQwssJ345YhG87ttuZp4xAr9jJ1u4nK
   eylSv5lEk+8PXTtjwHt8jq2QRLVW8Pdhr9MTuZepU7PSnaExJv/BbDj8Q
   2g0c35p0X6sNXixFQOzvOvy27Kw4lxEoZO9lO27M4RTvpEVDIzIYfBV6+
   Sy5giSAr/oJpIGKgvBjT14lcNBPosS97PAJZ5AM6zPo4aviwr/OOaPTGR
   Q==;
X-CSE-ConnectionGUID: 3t45fHP1Qau4k0NGzma8vA==
X-CSE-MsgGUID: dnVSXirzQGyJn0saFCMeTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces04_data.me-crop.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:18 +0300
X-CSE-ConnectionGUID: R+6EaiPIQqKzcU8NpWVLXQ==
X-CSE-MsgGUID: zusUc9P3RW+LcjIrahLsig==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces04_data.me-crop.lan with SMTP; 23 Jun 2026 00:01:25 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:17 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 10/10] vmcore_tasks: Add README with project documentation
Date: Mon, 22 Jun 2026 23:54:48 +0300
Message-ID: <20260622205550.1087163-11-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135619_739999_D0095524 
X-CRM114-Status: GOOD (  17.51  )
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

Add comprehensive README covering:
- Project overview and motivation
- Code structure and runtime flow
- Vmcoreinfo requirements for common subsystems (tasks, VMA,
  memory, signal frames) and per-architecture (RISC-V 64, MIPS64)
- Key design decisions
- Build and usage instructions
- Testing methodology and platform coverage
- Known limitations

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/README.md | 331 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 vmcore_tasks/README.md

diff --git a/vmcore_tasks/README.md b/vmcore_tasks/README.md
new file mode 100644
index 00000000..7abbc3ce
--- /dev/null
+++ b/vmcore_tasks/README.md
@@ -0,0 +1,331 @@
+# vmcore-tasks
+
+## Overview
+
+vmcore-tasks is a userspace tool that extracts per-task mini coredumps with register state and user-space backtraces and dmesg from Linux vmcore (kdump) files. It is designed for post-mortem
+debugging of kernel crashes on embedded targets where full crash-utility support
+may not be available.
+
+Unlike crash-utility, vmcore-tasks does **not** require vmlinux, DWARF data, or
+symbol tables. Instead, it relies on a **kernel-side component** that exports
+the required struct offsets, sizes, and symbol addresses into the standard
+vmcoreinfo note section. This data is embedded in the vmcore by kdump and is
+sufficient to navigate kernel data structures at runtime.
+
+Currently supports RISC-V 64-bit and MIPS64 architectures.
+
+## Motivation
+
+After a kernel panic, the kdump mechanism produces a vmcore file containing a
+snapshot of system memory. Existing tools (crash-utility, makedumpfile) are
+heavyweight. vmcore-tasks provides a lightweight alternative that extracts the most useful debugging artifacts:
+
+- Per-task mini coredumps with register state and user-space backtraces
+- Kernel dmesg log (all ringbuffer formats: legacy, structured, lockless)
+
+## Code Structure
+
+```
+vmcore_tasks.c              Main entry point, orchestration
+  |
+  +-- tasks.c             Task list walking, per-task data collection,
+  |                       mini coredump output
+  |
+  +-- vma_util.c          VMA enumeration (maple tree or mmap linked list)
+  |
+  +-- unwind.c            Generic user-space frame unwinder
+  |
+  +-- vmcore_tasks_defs.h  Common types, accessor macros, arch dispatch
+  |
+  +-- arch/
+  |   +-- riscv64/        RISC-V 64: SV39 page table walk, instruction decode
+  |   |   +-- riscv64.c
+  |   |   +-- riscv64_defs.h
+  |   +-- mips64/         MIPS64: 3-level page table walk, instruction decode
+  |       +-- mips64.c
+  |       +-- mips64_defs.h
+  |
+  +-- util_lib/           Foundation libraries
+      +-- vmcore_info.c   Vmcoreinfo parser (SYMBOL/OFFSET/SIZE/NUMBER/LENGTH)
+      +-- memory.c        readmem(), virtual-to-physical dispatch
+      +-- maple_tree.c    Maple tree walker (from crash-utility)
+      +-- include/
+          +-- vmcore_tasks_util.h  Shared macros, typedefs, debug helpers
+          +-- vmcore_info.h        Vmcoreinfo API declarations
+          +-- memory.h             Memory API declarations
+          +-- maple_tree.h         Maple tree API declarations
+```
+
+## Runtime Flow
+
+1. **ELF parsing**: Open vmcore, parse ELF headers, locate PT_LOAD
+   segments and vmcoreinfo note.
+
+2. **Vmcoreinfo init**: Parse all SYMBOL/OFFSET/SIZE/NUMBER/LENGTH
+   entries and plain KEY=VALUE pairs (PAGESIZE, OSRELEASE) into
+   lookup tables.
+
+3. **Architecture init**: Based on compile-time target (RISCV64/MIPS64),
+   register vtop function, unwind callbacks, and read arch-specific
+   parameters from vmcoreinfo.
+
+4. **Memory init**: Read PAGE_OFFSET, PHYS_OFFSET, VMALLOC range from
+   vmcoreinfo. `readmem()` translates virtual addresses to physical via
+   arch vtop, then maps to file offsets via PT_LOAD segments.
+
+5. **Task enumeration**: Walk `init_task` -> `task_struct` linked list.
+   For each task:
+   - Read PID, comm, mm_struct, register state (pt_regs from stack)
+   - Enumerate VMAs via maple tree (kernel >= 6.1) or mmap linked
+     list (older kernels), auto-selected based on vmcoreinfo
+   - Run user-space stack unwinder using arch instruction callbacks
+   - Output mini coredump with NT_PRSTATUS, NT_PRPSINFO, VMA map,
+     and backtrace
+
+6. **Dmesg extraction**: Extract kernel log from the vmcore using the
+   appropriate ringbuffer format (auto-detected from vmcoreinfo symbols).
+
+## Vmcoreinfo Requirements
+
+The kernel-side component must export the following entries into vmcoreinfo.
+Standard kdump entries (marked with \*) are already present in mainline Linux.
+
+### Common (all architectures)
+
+**Plain key=value:**
+
+| Entry | Notes |
+|-------|-------|
+| `PAGESIZE` \* | Runtime page size |
+| `OSRELEASE` \* | Kernel version string |
+
+**Symbols:**
+
+| Entry | Used by |
+|-------|---------|
+| `SYMBOL(swapper_pg_dir)` | Kernel page table base |
+| `SYMBOL(init_task)` | Task list head |
+
+**Numbers:**
+
+| Entry | Notes |
+|-------|-------|
+| `NUMBER(PAGE_OFFSET)` \* | Kernel direct-map base |
+| `NUMBER(phys_ram_base)` | Physical RAM base (fallback: `PHYS_OFFSET`) |
+| `NUMBER(VMALLOC_START)` | Optional - vmalloc range |
+| `NUMBER(VMALLOC_END)` | Optional - vmalloc range |
+| `NUMBER(VMEMMAP_START)` | Optional - vmemmap range |
+| `NUMBER(VMEMMAP_END)` | Optional - vmemmap range |
+| `NUMBER(MODULES_VADDR)` | Optional - module range |
+| `NUMBER(MODULES_END)` | Optional - module range |
+| `NUMBER(KERNEL_LINK_ADDR)` | Optional - kernel link address |
+| `NUMBER(va_kernel_pa_offset)` | Optional - kernel VA-PA offset |
+| `NUMBER(STACK_ALIGN)` | Stack alignment for pt_regs location |
+| `NUMBER(THREAD_SIZE)` | Kernel thread stack size |
+
+**Sizes:**
+
+| Entry | Used by |
+|-------|---------|
+| `SIZE(task_struct)` | Task walking |
+| `SIZE(pt_regs)` | Register extraction |
+| `SIZE(vm_area_struct)` | VMA reading |
+| `SIZE(file)` | File path resolution |
+| `SIZE(dentry)` | File path resolution |
+| `SIZE(maple_tree)` | Maple tree support (optional) |
+| `SIZE(maple_node)` | Maple tree support (optional) |
+
+**Offsets - task_struct:**
+
+| Entry |
+|-------|
+| `OFFSET(task_struct.__state)` (or `.state` for older kernels) |
+| `OFFSET(task_struct.pid)` |
+| `OFFSET(task_struct.comm)` |
+| `OFFSET(task_struct.mm)` |
+| `OFFSET(task_struct.flags)` |
+| `OFFSET(task_struct.exit_state)` |
+| `OFFSET(task_struct.stack)` |
+| `OFFSET(task_struct.tasks)` |
+| `OFFSET(task_struct.signal)` |
+| `OFFSET(task_struct.thread_node)` |
+
+**Offsets - signal_struct:**
+
+| Entry |
+|-------|
+| `OFFSET(signal_struct.thread_head)` |
+| `OFFSET(signal_struct.nr_threads)` |
+
+**Offsets - mm_struct:**
+
+| Entry | Notes |
+|-------|-------|
+| `OFFSET(mm_struct.mmap)` | Legacy VMA path (optional if maple tree used) |
+| `OFFSET(mm_struct.mm_mt)` | Maple tree VMA path (kernel >= 6.1) |
+| `OFFSET(mm_struct.map_count)` | Optional |
+| `OFFSET(mm_struct.pgd)` | User page table base |
+| `OFFSET(mm_struct.start_stack)` | VMA type classification |
+| `OFFSET(mm_struct.start_brk)` | VMA type classification |
+| `OFFSET(mm_struct.brk)` | VMA type classification |
+
+**Offsets - vm_area_struct:**
+
+| Entry | Notes |
+|-------|-------|
+| `OFFSET(vm_area_struct.vm_start)` | |
+| `OFFSET(vm_area_struct.vm_end)` | |
+| `OFFSET(vm_area_struct.vm_flags)` | |
+| `OFFSET(vm_area_struct.vm_file)` | |
+| `OFFSET(vm_area_struct.vm_next)` | Legacy path only |
+
+**Offsets - file/dentry (filename resolution):**
+
+| Entry |
+|-------|
+| `OFFSET(file.f_path)` |
+| `OFFSET(path.dentry)` |
+| `OFFSET(dentry.d_name)` |
+| `OFFSET(dentry.d_parent)` |
+| `OFFSET(qstr.hash_len)` |
+| `OFFSET(qstr.name)` |
+
+**Offsets - list_head:**
+
+| Entry |
+|-------|
+| `OFFSET(list_head.next)` |
+
+**Offsets - maple tree (optional, needed for kernel >= 6.1):**
+
+| Entry |
+|-------|
+| `OFFSET(maple_tree.ma_root)` |
+| `OFFSET(maple_tree.ma_flags)` |
+| `OFFSET(maple_node.parent)` |
+| `OFFSET(maple_node.ma64)` |
+| `OFFSET(maple_node.mr64)` |
+| `OFFSET(maple_node.slot)` |
+| `OFFSET(maple_arange_64.pivot)` |
+| `OFFSET(maple_arange_64.slot)` |
+| `OFFSET(maple_arange_64.gap)` |
+| `OFFSET(maple_arange_64.meta)` |
+| `OFFSET(maple_range_64.pivot)` |
+| `OFFSET(maple_range_64.slot)` |
+| `OFFSET(maple_metadata.end)` |
+| `OFFSET(maple_metadata.gap)` |
+
+### RISC-V 64-bit
+
+RISC-V uses SV39 virtual address translation (3-level page table).
+The unwinder decodes RISC-V standard (32-bit) instructions to trace stack frames and detect signal trampolines.
+
+| Entry | Type | Notes |
+|-------|------|-------|
+| `NUMBER(VA_BITS)` | NUMBER | Selects SV39/SV48/SV57 |
+| `NUMBER(__NR_rt_sigreturn)` | NUMBER | Signal frame detection (optional) |
+| `OFFSET(rt_sigframe.uc)` | OFFSET | Signal frame unwinding |
+| `OFFSET(ucontext.uc_mcontext)` | OFFSET | Signal frame unwinding |
+| `OFFSET(sigcontext.sc_regs)` | OFFSET | Signal frame unwinding |
+
+### MIPS64
+
+MIPS64 uses a 3-level page table (PGD -> PMD -> PTE). Page table bit
+layouts vary between kernel configurations, so the tool reads them from
+vmcoreinfo rather than hardcoding. Address space regions (XKPHYS, KSEG0,
+KSEG1, XKSEG) are identified by fixed address ranges.
+
+| Entry | Type | Notes |
+|-------|------|-------|
+| `NUMBER(_PAGE_PRESENT)` | NUMBER | Page table flags (optional, has defaults) |
+| `NUMBER(_PAGE_VALID)` | NUMBER | Page table flags (optional, has defaults) |
+| `NUMBER(_PFN_SHIFT)` | NUMBER | PTE to PFN extraction |
+| `NUMBER(_PFN_MASK)` | NUMBER | PTE to PFN extraction |
+| `NUMBER(PMD_SHIFT)` | NUMBER | Page table geometry |
+| `NUMBER(PGDIR_SHIFT)` | NUMBER | Page table geometry |
+| `NUMBER(PTRS_PER_PGD)` | NUMBER | Page table geometry |
+| `NUMBER(PTRS_PER_PMD)` | NUMBER | Page table geometry |
+| `NUMBER(PTRS_PER_PTE)` | NUMBER | Page table geometry |
+| `NUMBER(_MAX_PHYSMEM_BITS)` | NUMBER | Physical address width (optional) |
+| `OFFSET(rt_sigframe.rs_uc)` | OFFSET | Signal frame unwinding |
+| `OFFSET(ucontext.uc_mcontext)` | OFFSET | Signal frame unwinding |
+| `OFFSET(sigcontext.sc_regs)` | OFFSET | Signal frame unwinding |
+| `OFFSET(sigcontext.sc_pc)` | OFFSET | Signal frame unwinding |
+
+## Key Design Decisions
+
+- **No vmlinux/DWARF required**: All struct layout information is provided
+  by the kernel-side vmcoreinfo additions. The tool is self-contained.
+
+- **Page size at runtime**: Not hardcoded. Read from vmcoreinfo PAGESIZE
+  entry via cached `get_page_size()`/`get_page_shift()` accessors.
+
+- **VMA enumeration strategy**: Auto-selected based on vmcoreinfo.
+  If `mm_struct.mmap` offset exists, uses legacy linked list walk.
+  Otherwise uses maple tree (kernel >= 6.1).
+
+- **Unwinder separation**: Generic unwinding logic in `unwind.c`,
+  arch-specific instruction decode in `arch/*/`. Adding a new
+  architecture requires only implementing the instruction callbacks
+  (`is_sp_move_ins`, `is_ra_save_ins`, etc.), not the unwinding state
+  machine.
+
+- **elf_info.c and maple_tree.c**: Ported from kexec-tools and
+  crash-utility respectively. Kept close to upstream to ease future
+  syncs, with minimal modifications.
+
+## Build
+
+```bash
+# Auto-detect architecture from cross-compiler:
+make CC=riscv64-linux-gnu-gcc
+
+# Or specify explicitly:
+make CC=mips-linux-gnu-gcc TARGET=MIPS64
+
+# Native build (for development/testing on x86_64):
+make TARGET=RISCV64
+```
+
+## Usage
+
+```bash
+# Extract all artifacts from vmcore:
+vmcore-tasks <vmcore_file>
+
+# With debug output (levels 1-4):
+vmcore-tasks -d1 <vmcore_file>
+
+# Full trace to file:
+vmcore-tasks -d4 <vmcore_file> 2>log.txt
+
+# Parse backtrace output with addr2line:
+python3 vmcore_tasks_backtrace_parser.py -b tasks_buffer.txt -s <symbols_path> -t <toolchain_path>
+```
+
+## Testing
+
+Validated against vmcore files generated from controlled kernel panic
+scenarios on the following platforms:
+
+| Platform | Page Table | Test Scenarios |
+|----------|-----------|----------------|
+| RISC-V 64-bit (SV39) | 3-level | Assert handler, leaf application, signal frame |
+| MIPS64 | 3-level | Assert handler, leaf application, signal frame |
+
+Each test scenario exercises a different unwinding path:
+
+- **Assert handler**: Multi-frame user-space backtrace through libc `abort()`.
+- **Leaf application**: Function without stack frame setup (leaf function at
+  top of stack).
+- **Signal frame**: User-space signal handler active at time of crash,
+  validates `rt_sigframe` unwinding.
+
+Tested with vmcore-tasks running on:
+- Native RISC-V 64-bit and MIPS64 targets
+- Cross-architecture: x86_64 host processing RISC-V/MIPS64 vmcores
+
+## TODO / Known Limitations
+
+- SV48/SV57 page table translation not yet implemented for RISC-V
+- Compressed instruction support (16 bit) for RISCV not yet implemented
\ No newline at end of file
-- 
2.43.0


