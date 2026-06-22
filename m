Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F431CDB475
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2SMDvIKKzAdjggRrwAB3KxyAMJ1I2iAj2cpAG3VBRbI=; b=H4otqV2Z2+fVZU9eBW1fI9lEnk
	blxmfAWj3QstpQbQeuMf4rO59nJYW8IPWNWAzfhwUAuiPjjrvawxjCyQMutDI3qi8LC1N1ZIVoNsg
	0ffiRfF8NICRK424jE9t+JIYkApPKz11YWtPGpKx1h52QV0ydXFbRRVkoNZb+WY6A6X4cV+5qeEHi
	WDmGOgz2fxRAnMn3CASpbYk9HzbhlpcmseRamFIo6lTmUDHHLo+LH040lSYiZIGzBuq0W2qmbgeud
	ADiHwuCTtfbpKF1gxYiAfQUWbEwcs1DxuBy4ATqccY5yOHqHH//Cp+KJn7EgFZFq/2XbC1Wx08Urn
	geg4gzRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgq-00000005NsS-1qLw;
	Mon, 22 Jun 2026 20:56:20 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgl-00000005Nnt-2tFq
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161775; x=1813697775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCoYuohZariNVxu7prDIe43uoAALreygvmwHnoqNfgM=;
  b=QterDC2sE3WAgLuUtpqydNb6YwSUssrvGfma6NPVMIBSBpTsz3qDQwkK
   nXrQLycI3Qw1w5DHZWoZpPgXfMWbB1dzeUeLcVXl7of63WqeoGhepRg/5
   8jGsqzFeYIvsulzi1nNKmbQpgH++Q5vxdMEC2LjNZNjxuTFw8LhCrhq2b
   wFnBtWl3UblhmeejJ6QUBjfoOD7+SsXeOJey0OxqAhbxixeG9BH/LG4yN
   W+y90J8RTQLeWzyD769P1tEifaTibJzkJwxggfKhI+J1nObDywT/NHXPl
   /9Uk7eil7GhlLjV/X47qh+uuNNOAf3FJkzwP+No0vZVyENxz6YnH7PJQc
   g==;
X-CSE-ConnectionGUID: rQD5raQuQjS7Rxwb562Qrw==
X-CSE-MsgGUID: LNr2TDGTQ16aFCrZEHA55Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:14 +0300
X-CSE-ConnectionGUID: WNJt6uKLRtuImAeXd479Kg==
X-CSE-MsgGUID: WxzL5f9CQC+gVwxzwVeI3A==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 00:01:13 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:12 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 08/10] vmcore_tasks: Add VMA utilities and task enumeration
Date: Mon, 22 Jun 2026 23:54:46 +0300
Message-ID: <20260622205550.1087163-9-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135616_296741_EEF49EFC 
X-CRM114-Status: GOOD (  26.63  )
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

Add VMA handling and task walking infrastructure:

- vma_util: VMA metadata extraction from kernel structures.
  Supports two enumeration strategies selected at runtime based
  on vmcoreinfo availability:
  1. Legacy mmap linked list (kernels < ~6.1): walks
     mm_struct->mmap -> vm_area_struct->vm_next chain with
     map_count hint, self-loop and max-walk guards.
  2. Maple tree (kernels >= ~6.1): walks mm_struct->mm_mt via
     do_maple_tree() when mm_struct.mmap offset is absent.
  For each VMA, extracts addresses, flags, resolves backing
  filename via dentry->d_name chain walk, and classifies type
  (stack, heap, text) using mm_struct fields.

- tasks: Walks the kernel task_struct linked list from init_task.
  For each user task, collects PID, comm, flags, task state,
  mm_struct page table base, and per-task VMA snapshot. Enumerates
  threads via signal_struct->thread_head list, reads pt_regs from
  each thread's kernel stack, and invokes the user-space unwinder
  with leaf-function fallback for backtrace capture. Outputs
  formatted text with VMA map, register state, and backtrace
  per thread.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/tasks.c    | 540 ++++++++++++++++++++++++++++++++++++++++
 vmcore_tasks/tasks.h    |  53 ++++
 vmcore_tasks/vma_util.c | 429 +++++++++++++++++++++++++++++++
 vmcore_tasks/vma_util.h |  16 ++
 4 files changed, 1038 insertions(+)
 create mode 100644 vmcore_tasks/tasks.c
 create mode 100644 vmcore_tasks/tasks.h
 create mode 100644 vmcore_tasks/vma_util.c
 create mode 100644 vmcore_tasks/vma_util.h

diff --git a/vmcore_tasks/tasks.c b/vmcore_tasks/tasks.c
new file mode 100644
index 00000000..1bcd2e91
--- /dev/null
+++ b/vmcore_tasks/tasks.c
@@ -0,0 +1,540 @@
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#include "vmcore_info.h"
+#include "memory.h"
+
+#include "tasks.h"
+#include "vma_util.h"
+
+#define DEF_MAX_INSTR_CHECK (1024 * 10)
+
+/* Find last (most significant) bit set - same as Linux fls() */
+static inline int mcd_fls(unsigned int x)
+{
+	if (x == 0)
+		return 0;
+	return 32 - __builtin_clz(x);
+}
+
+static unsigned int read_task_state(const char *task_buf)
+{
+	if (OFFSET_EXISTS("task_struct.__state"))
+		return UINT(task_buf + OFFSET("task_struct.__state"));
+	return UINT(task_buf + OFFSET("task_struct.state"));
+}
+
+/* Compute task state index - mirrors kernel's __task_state_index() */
+static unsigned int get_task_state_index(unsigned int tsk_state, unsigned int tsk_exit_state)
+{
+	unsigned int state = (tsk_state | tsk_exit_state) & TASK_REPORT;
+
+	if ((tsk_state & TASK_IDLE) == TASK_IDLE)
+		return TASK_STATE_IDLE;
+
+	/* Report RTLOCK_WAIT and FROZEN as uninterruptible */
+	if ((tsk_state & TASK_RTLOCK_WAIT) || (tsk_state & TASK_FROZEN))
+		state = TASK_UNINTERRUPTIBLE;
+
+	return mcd_fls(state);
+}
+
+/* Convert state index to string for display */
+static const char *task_state_to_str(unsigned int state_idx)
+{
+	static const char * const state_names[] = {
+	[TASK_STATE_RUNNING]    = "R (running)",
+	[TASK_STATE_SLEEPING]   = "S (sleeping)",
+	[TASK_STATE_DISK_SLEEP] = "D (disk sleep)",
+	[TASK_STATE_STOPPED]    = "T (stopped)",
+	[TASK_STATE_TRACED]     = "t (tracing stop)",
+	[TASK_STATE_DEAD]       = "X (dead)",
+	[TASK_STATE_ZOMBIE]     = "Z (zombie)",
+	[TASK_STATE_PARKED]     = "P (parked)",
+	[TASK_STATE_IDLE]       = "I (idle)",
+	};
+
+	if (state_idx < sizeof(state_names) / sizeof(state_names[0]) && state_names[state_idx])
+		return state_names[state_idx];
+	return "? (unknown)";
+}
+
+/*
+ * Check whether addr is in a valid executable VMA and fill vma_out.
+ * Returns true if valid.
+ */
+static bool is_valid_text_addr(unsigned long addr, struct task_data *task,
+			       struct vma_metadata *vma_out)
+{
+	return get_vma_from_user_addr(addr, task, vma_out) &&
+	       (vma_out->flags & VM_EXEC);
+}
+
+static void record_bt_entry(struct thread_data *thread, int slot,
+			    unsigned long addr, struct vma_metadata *vma)
+{
+	thread->bt_entry[slot].abs_addr = addr;
+	thread->bt_entry[slot].vm_start = vma->start;
+	thread->bt_entry[slot].vm_end   = vma->end;
+	snprintf(thread->bt_entry[slot].filename,
+		 sizeof(thread->bt_entry[slot].filename),
+		 "%s", vma->filename);
+}
+
+/*
+ * Attempt leaf-function fallback: use the original RA from registers
+ * as the caller PC.  Only valid for the very first frame.
+ *
+ * Resets SP to the original value (the failed unwind may have corrupted it)
+ * and clears RA so the next unwind iteration won't reuse stale state.
+ *
+ * Returns true if fallback was applied and a bt_entry was recorded.
+ */
+static bool try_leaf_fallback(struct stackframe *frame, struct task_data *task,
+			      struct thread_data *thread, int *slot,
+			      unsigned long orig_ra, unsigned long orig_sp)
+{
+	struct vma_metadata text_vma;
+
+	if (orig_ra == 0)
+		return false;
+
+	if (!is_valid_text_addr(orig_ra, task, &text_vma))
+		return false;
+
+	pr_verbose("Backtrace: leaf fallback: using RA from regs 0x%lx\n", orig_ra);
+	frame->pc = orig_ra;
+	frame->sp = orig_sp;
+	frame->ra = 0;
+
+	(*slot)--;
+	record_bt_entry(thread, *slot, orig_ra, &text_vma);
+	return true;
+}
+
+void do_user_backtrace(struct task_data *task, struct thread_data *thread)
+{
+	struct vma_metadata stack_vma = {};
+	struct vma_metadata text_vma = {};
+	struct stackframe frame;
+	int slot = BACKTRACE_DEPTH;
+	unsigned long max_search;
+
+	frame.pc = PT_REGS_PC(thread->regs);
+	frame.sp = PT_REGS_SP(thread->regs);
+	frame.ra = PT_REGS_RA(thread->regs);
+
+	unsigned long orig_ra = frame.ra;
+	unsigned long orig_sp = frame.sp;
+
+	pr_trace("init regs: pc=0x%016llx ra=0x%016llx sp=0x%016llx\n",
+		 (unsigned long long)frame.pc,
+		 (unsigned long long)frame.ra,
+		 (unsigned long long)frame.sp);
+
+	/* Validate initial SP is in a known VMA (used for bounds checking later) */
+	if (!get_vma_from_user_addr(frame.sp, task, &stack_vma)) {
+		fprintf(stderr, "error: invalid initial SP, cannot backtrace\n");
+		if (is_verbose()) print_vma_map_for_task(task);
+		return;
+	}
+
+	/* Record initial PC as first backtrace entry */
+	if (slot > 0) {
+		if (!is_valid_text_addr(frame.pc, task, &text_vma)) {
+			fprintf(stderr, "error: initial PC 0x%016llx not in executable VMA\n",
+				(unsigned long long)frame.pc);
+			if (is_verbose()) print_vma_map_for_task(task);
+			return;
+		}
+		slot--;
+		record_bt_entry(thread, slot, frame.pc, &text_vma);
+	}
+
+	bool is_first_frame = true;
+
+	while (slot > 0) {
+		/* Validate current PC is in an executable VMA to determine scan range */
+		if (!is_valid_text_addr(frame.pc, task, &text_vma)) {
+			pr_trace("Backtrace: PC 0x%lx not in executable VMA, stopping\n", frame.pc);
+			break;
+		}
+
+		max_search = (frame.pc - text_vma.start > DEF_MAX_INSTR_CHECK)
+			     ? DEF_MAX_INSTR_CHECK
+			     : frame.pc - text_vma.start;
+
+		if (unwind_user_frame(&frame, max_search) != 0) {
+			/*
+			 * On the first frame this may be a leaf function —
+			 * try falling back to the RA from the original registers.
+			 */
+			if (is_first_frame &&
+			    try_leaf_fallback(&frame, task, thread, &slot, orig_ra, orig_sp)) {
+				is_first_frame = false;
+				continue;
+			}
+			break;
+		}
+
+		if (frame.ra == 0 || !is_valid_text_addr(frame.ra, task, &text_vma)){
+			/*
+			 * RA is zero, unmapped, or not in a text section.
+			 * This is likely a false-positive prologue match.
+			 * On the first frame, try the leaf fallback.
+			 */
+			if (is_first_frame &&
+				try_leaf_fallback(&frame, task, thread, &slot, orig_ra, orig_sp)) {
+				is_first_frame = false;
+				continue;
+			}
+			pr_trace("Backtrace: RA 0x%lx invalid after unwind, stopping\n", frame.ra);
+			break;
+		}
+
+		is_first_frame = false;
+
+		/* Check SP stays within the original stack VMA */
+		if (frame.sp > stack_vma.end || frame.sp < stack_vma.start) {
+			pr_trace("Backtrace: SP 0x%lx out of stack bounds [0x%lx-0x%lx]\n",
+				 frame.sp, stack_vma.start, stack_vma.end);
+			break;
+		}
+
+		/* Detect infinite loops (RA same as previous entry) */
+		if (frame.ra == thread->bt_entry[slot].abs_addr) {
+			pr_trace("Backtrace: RA 0x%lx same as previous entry, stopping\n", frame.ra);
+			break;
+		}
+
+		slot--;
+		record_bt_entry(thread, slot, frame.ra, &text_vma);
+
+		pr_verbose("Backtrace: frame #%d: addr=0x%016llx, filename=%s, offset=0x%016llx\n",
+			   BACKTRACE_DEPTH - 1 - slot,
+			   (unsigned long long)frame.ra,
+			   text_vma.filename,
+			   (unsigned long long)(frame.ra - text_vma.start));
+	}
+}
+
+__weak bool read_task_registers(uint64_t stack_ptr, struct pt_regs *regs)
+{
+	uint64_t regs_addr;
+	size_t pt_regs_size = SIZE("pt_regs");
+	size_t stack_align = NUMBER("STACK_ALIGN");
+	size_t thread_size = NUMBER("THREAD_SIZE");
+
+	if (!stack_ptr) {
+		fprintf(stderr, "Invalid stack pointer\n");
+		return false;
+	}
+    
+	// Calculate pt_regs location: stack + THREAD_SIZE - ALIGN(sizeof(pt_regs), STACK_ALIGN)
+	// ALIGN(x, a) = (((x) + (a) - 1) & ~((a) - 1))
+	size_t aligned_size = ((pt_regs_size + stack_align - 1) & ~(stack_align - 1));
+	regs_addr = stack_ptr + thread_size - aligned_size;
+
+	// Read pt_regs structure
+	if (readmem(regs_addr, regs, pt_regs_size, "read pt_regs", KVADDR) < 0) {
+		fprintf(stderr, "Failed to read pt_regs from 0x%016llx\n",
+			(unsigned long long)regs_addr);
+		return false;
+	}
+
+	return true;
+}
+
+int fill_task_data(char *task_buf, struct task_data *task){
+	uint64_t mm_addr, next_list_head, stack_addr;
+	uint64_t signal_addr, thread_head_addr, thread_task_addr, next_val;
+	unsigned int task_state, exit_state;
+	size_t task_struct_sz = SIZE("task_struct");
+
+	task->pid = UINT(task_buf + OFFSET("task_struct.pid"));
+	memcpy(task->comm, task_buf + OFFSET("task_struct.comm"), MAX_TASK_NAME - 1);
+	task->comm[MAX_TASK_NAME - 1] = '\0';	
+
+	pr_trace("Task name: %s [PID %d]\n", task->comm, task->pid);
+
+	mm_addr = UINT64(task_buf + OFFSET("task_struct.mm"));	
+	if (!mm_addr) {
+		task->is_user_task = 0;
+		task->vmas.vma_count = 0;
+		task->vmas.vma_meta = NULL;
+		task->flags = UINT(task_buf + OFFSET("task_struct.flags"));
+		task->num_threads = 1;
+		task->threads = NULL;
+
+		task_state = read_task_state(task_buf);
+		exit_state = UINT(task_buf + OFFSET("task_struct.exit_state"));
+		task->state_idx = get_task_state_index(task_state, exit_state);
+		task->state = task_state;
+		return 0;
+	}
+	// user task - collect VMAs (shared by all threads)
+	task->is_user_task = 1;	
+	if (readmem(mm_addr + OFFSET("mm_struct.pgd"), &task->mm_pgd, sizeof(uint64_t), "read mm_pgd", KVADDR) < 0) {
+		fprintf(stderr, "Failed to read mm_pgd for task %s [PID %d]\n", task->comm, task->pid);
+		return -1;
+	}
+	set_context(task->mm_pgd);  // Set once at start
+
+	pr_verbose("Task name: %s [PID %d]\n", task->comm, task->pid);
+		
+	// fill VMAs
+	if (!dump_vma_snapshot(&task->vmas, mm_addr)){
+		fprintf(stderr, "Failed to collect vma list.\n");
+		task->vmas.vma_count = 0;
+		task->vmas.vma_meta = NULL;
+		return -1;
+	}else{
+		if (is_verbose()) print_vma_map_for_task(task);
+	}
+
+	// Collect threads
+	signal_addr = UINT64(task_buf + OFFSET("task_struct.signal"));
+	thread_head_addr = signal_addr + OFFSET("signal_struct.thread_head");
+	if (readmem(signal_addr + OFFSET("signal_struct.nr_threads"), &task->num_threads, sizeof(int),
+		    "read threads num from signal", KVADDR) < 0) {
+		fprintf(stderr, "Failed to read number of threads for task %s [PID %d]\n", task->comm, task->pid);
+		return -1;
+	}
+	if (task->num_threads <= 0 || task->num_threads > 10000) {
+		fprintf(stderr, "Suspicious nr_threads=%d for task %s [PID %d]\n",
+			task->num_threads, task->comm, task->pid);
+		return -1;
+	}
+	pr_trace("Total threads found for PID=%d: %d\n", task->pid,  task->num_threads);
+
+	task->threads = calloc(task->num_threads, sizeof(struct thread_data));
+	if (!task->threads) {
+		fprintf(stderr, "Failed to allocate threads array\n");
+		return -1;
+	}
+
+	pr_verbose("Generating backtrace\n");
+	// Walk the thread list
+	// Start reading from the .next pointer inside it
+	next_list_head = thread_head_addr + OFFSET("list_head.next");
+	for (int i = 0; i < task->num_threads; i++) {
+		// Read next thread pointer from current thread's list_head .next
+		if (readmem(next_list_head, &next_val, sizeof(next_val),
+			    "read next thread pointer", KVADDR) < 0) {
+			fprintf(stderr, "Failed to read next thread pointer from 0x%llx\n",
+				(unsigned long long)next_list_head);
+			break;
+		}
+		if (next_val == thread_head_addr) {
+			// Reached back to head
+			fprintf(stderr, "Reached back to thread list head prematurely\n");
+			break;
+		}
+		// next_val points to thread_node (the list_head struct)
+		thread_task_addr = next_val - OFFSET("task_struct.thread_node");
+
+		// For next iteration, read from next_val + OFFSET("list_head.next")
+		next_list_head = next_val + OFFSET("list_head.next");
+
+		// Read thread task_struct
+		char *thread_task_buf = calloc(1, task_struct_sz);
+		if (!thread_task_buf) {
+			fprintf(stderr, "Failed to allocate thread task buffer\n");
+			return -1;
+		}
+
+		if (readmem(thread_task_addr, thread_task_buf, task_struct_sz,
+			    "read thread task_struct", KVADDR) < 0) {
+			fprintf(stderr, "Failed to read thread task_struct @ 0x%llx size = %zu\n",
+				(unsigned long long)thread_task_addr, task_struct_sz);
+			free(thread_task_buf);
+			thread_task_buf = NULL;
+			return -1;
+		}
+		task->threads[i].tid = UINT(thread_task_buf + OFFSET("task_struct.pid"));
+		task->threads[i].flags = UINT(thread_task_buf + OFFSET("task_struct.flags"));
+		memcpy(task->threads[i].comm, thread_task_buf + OFFSET("task_struct.comm"), MAX_TASK_NAME - 1);
+		task->threads[i].comm[MAX_TASK_NAME - 1] = '\0';
+
+		task_state = read_task_state(thread_task_buf);
+		exit_state = UINT(thread_task_buf + OFFSET("task_struct.exit_state"));
+		task->threads[i].state_idx = get_task_state_index(task_state, exit_state);
+		task->threads[i].state = task_state;
+
+		stack_addr = UINT64(thread_task_buf + OFFSET("task_struct.stack"));
+		if (!read_task_registers(stack_addr, &task->threads[i].regs)) {
+			fprintf(stderr, "Failed to read registers for TID=%d\n", task->threads[i].tid);
+			free(thread_task_buf);
+			thread_task_buf = NULL;
+			return -1;
+		}
+		pr_trace("===== Thread PID=[%d], NAME= %s, STATE=%s, is_user_task: %d, thread_num: %d/%d, FLAGS=0x%x =====\n",
+			task->threads[i].tid, task->threads[i].comm, task_state_to_str(task->threads[i].state_idx), task->is_user_task, i+1, task->num_threads, task->threads[i].flags);
+		do_user_backtrace(task, &task->threads[i]);
+
+		free(thread_task_buf);
+		thread_task_buf = NULL;	
+	}
+	return 0;
+}
+
+int collect_tasks(struct system_minicore *sys_mc)
+{
+	uint64_t list_head_vaddr, task_vaddr, list_next_task;
+	char *task_buf = NULL;
+	const int max_tasks = 10000;
+	size_t task_struct_sz = SIZE("task_struct");
+
+	list_head_vaddr = SYMBOL("init_task") + OFFSET("task_struct.tasks") + OFFSET("list_head.next");
+	task_vaddr = SYMBOL("init_task");
+	
+	// First pass: count tasks
+	list_next_task = list_head_vaddr;
+	do {
+		sys_mc->task_count++;
+		// Read next task pointer from current task's tasks list_head
+		if (readmem(list_next_task, &list_next_task, sizeof(list_next_task),
+			    "read next task pointer", KVADDR) < 0) {
+			fprintf(stderr, "Failed to read next task pointer from 0x%llx\n",
+				(unsigned long long)list_head_vaddr);
+			//break;
+			return -1;
+		}
+	} while (list_next_task != list_head_vaddr && sys_mc->task_count < max_tasks);
+	
+	// Allocate tasks array
+	sys_mc->tasks = calloc(sys_mc->task_count, sizeof(struct task_data));
+	if (!sys_mc->tasks) {
+		fprintf(stderr, "Failed to allocate tasks array\n");
+		return -1;
+	}
+	
+	if (OFFSET_EXISTS("mm_struct.mmap"))
+		pr_info("Using mm_struct->mmap linked list for VMA walk\n");
+	else
+		pr_info("mm_struct->mmap not found, using maple tree for VMA walk\n");
+
+	// Second pass: read each task and collect info
+	for (int i = 0; i < sys_mc->task_count; i++) {
+		task_buf = calloc(1, task_struct_sz);
+		if (!task_buf) {
+			fprintf(stderr, "Failed to allocate task buffer\n");
+			return -1;
+		}
+		// Read task buffer
+		if (readmem(task_vaddr, task_buf, task_struct_sz, "read task struct", KVADDR) < 0) {
+			fprintf(stderr, "Failed to read task_struct @ 0x%llx size = %zu\n",
+				(unsigned long long)task_vaddr, task_struct_sz);
+			free(task_buf);
+			return -1;
+		}
+		if (fill_task_data(task_buf, &sys_mc->tasks[i]) < 0) {
+			fprintf(stderr, "Failed to fill task data for task %d\n", i);
+			// Continue to next task — partial data is better than abort
+		}
+
+		list_next_task = UINT64(task_buf + OFFSET("task_struct.tasks") + OFFSET("list_head.next"));
+		
+		free(task_buf);
+		task_buf = NULL;	
+
+		task_vaddr = list_next_task - OFFSET("task_struct.tasks");
+	}
+	pr_info("Total tasks collected: %d\n", sys_mc->task_count);
+	return 0;
+}
+
+/* Write formatted output mimicking mini_coredump_buffer_asserter.txt format */
+static void write_vma_table(FILE *fp, struct task_data *task)
+{
+	fprintf(fp, "vm_nr [          vm_start-            vm_end] filename                                         name             flags      \n");
+	for (int i = 0; i < task->vmas.vma_count; i++) {
+		struct vma_metadata *vma = &task->vmas.vma_meta[i];
+
+		fprintf(fp, "%-5d [0x%016llx-0x%016llx] %-48s %-16s 0x%08llx\n",
+			i,
+			(unsigned long long)vma->start,
+			(unsigned long long)vma->end,
+			vma->filename[0] ? vma->filename : "",
+			vma->type,
+			(unsigned long long)vma->flags);
+	}
+}
+
+__weak void write_user_registers_formatted(FILE *fp, struct pt_regs *regs)
+{
+	(void)fp;
+	(void)regs;
+}
+
+static void write_user_backtrace_formatted(FILE *fp, struct thread_data *thread)
+{
+	int bt_idx = 0;
+	fprintf(fp, "user backtrace:\n");
+	/* Iterate from end to start to print in correct order (highest index = first entry) */
+	for (int i = BACKTRACE_DEPTH - 1; i >= 0; i--) {
+		if (thread->bt_entry[i].abs_addr == 0)
+			continue;
+		fprintf(fp, "#%-2d addr=0x%016llx, vm_start=0x%016llx, vm_end=0x%016llx, filename=%-60s\n",
+			bt_idx++,
+			(unsigned long long)thread->bt_entry[i].abs_addr,
+			(unsigned long long)thread->bt_entry[i].vm_start,
+			(unsigned long long)thread->bt_entry[i].vm_end,
+			thread->bt_entry[i].filename);
+	}
+}
+
+void save_minicore_formatted(FILE *fp, struct system_minicore *sys_mc)
+{
+	for (int i = 0; i < sys_mc->task_count; i++) {
+		struct task_data *task = &sys_mc->tasks[i];
+
+		if (!task->is_user_task)
+			continue;
+
+		if (!task->threads)
+			continue;
+
+		for (int t = 0; t < task->num_threads; t++) {
+			struct thread_data *thread = &task->threads[t];
+	
+			/* Write task/thread header */
+			fprintf(fp, "name: %s, pid: [%d], state: %d, is_user_task: %c, thread_nr: %d/%d, flags: 0x%x\n",
+				thread->comm,
+				thread->tid,
+				thread->state,
+				task->is_user_task ? 'Y' : 'N',
+				t + 1,
+				task->num_threads,
+				thread->flags);
+
+			/* Write VMA table only for first thread (VMAs are shared by all threads) */
+			if (t == 0 && task->vmas.vma_count > 0) {
+				write_vma_table(fp, task);
+			}
+
+			/* Write registers */
+			write_user_registers_formatted(fp, &thread->regs);
+
+			/* Write backtrace */
+			write_user_backtrace_formatted(fp, thread);
+		}
+	}
+
+	for (int i = 0; i < sys_mc->task_count; i++) {
+		struct task_data *task = &sys_mc->tasks[i];
+
+		if (task->is_user_task)
+			continue;
+
+		fprintf(fp, "name: %s, pid: [%d], state: %d, is_user_task: %c, flags: 0x%x\n",
+			task->comm,
+			task->pid,
+			task->state,
+			task->is_user_task ? 'Y' : 'N',
+			task->flags);
+	}
+}
\ No newline at end of file
diff --git a/vmcore_tasks/tasks.h b/vmcore_tasks/tasks.h
new file mode 100644
index 00000000..d01a7a24
--- /dev/null
+++ b/vmcore_tasks/tasks.h
@@ -0,0 +1,53 @@
+#ifndef TASKS_H
+#define TASKS_H
+
+#include <stdint.h>
+
+#include "vmcore_tasks_defs.h"
+
+/* Task state flags - from include/linux/sched.h */
+#define TASK_RUNNING		0x00000000
+#define TASK_INTERRUPTIBLE	0x00000001
+#define TASK_UNINTERRUPTIBLE	0x00000002
+#define __TASK_STOPPED		0x00000004
+#define __TASK_TRACED		0x00000008
+#define EXIT_DEAD		0x00000010
+#define EXIT_ZOMBIE		0x00000020
+#define TASK_PARKED		0x00000040
+#define TASK_DEAD		0x00000080
+#define TASK_WAKEKILL		0x00000100
+#define TASK_WAKING		0x00000200
+#define TASK_NOLOAD		0x00000400
+#define TASK_NEW		0x00000800
+#define TASK_RTLOCK_WAIT	0x00001000
+#define TASK_FROZEN		0x00002000
+#define TASK_IDLE		(TASK_UNINTERRUPTIBLE | TASK_NOLOAD)
+
+#define TASK_REPORT		(TASK_RUNNING | TASK_INTERRUPTIBLE | \
+                 TASK_UNINTERRUPTIBLE | __TASK_STOPPED | \
+                 __TASK_TRACED | EXIT_DEAD | EXIT_ZOMBIE | \
+                 TASK_PARKED)
+
+/* Task state index values (result of fls) */
+#define TASK_STATE_RUNNING	0
+#define TASK_STATE_SLEEPING	1  /* TASK_INTERRUPTIBLE */
+#define TASK_STATE_DISK_SLEEP	2  /* TASK_UNINTERRUPTIBLE */
+#define TASK_STATE_STOPPED	3
+#define TASK_STATE_TRACED	4
+#define TASK_STATE_DEAD		5  /* EXIT_DEAD */
+#define TASK_STATE_ZOMBIE	6  /* EXIT_ZOMBIE */
+#define TASK_STATE_PARKED	7
+#define TASK_STATE_IDLE		8  /* special case */
+
+/* Fills out with parsed VMCOREINFO values.
+ * Returns 0 on success, -1 if required base fields missing.
+ */
+int collect_tasks(struct system_minicore *sys_mc);
+
+/* Write tasks formatted output to file */
+void save_minicore_formatted(FILE *fp, struct system_minicore *sys_mc);
+
+/* Arch-overridable: read pt_regs from kernel stack (weak in tasks.c) */
+bool read_task_registers(uint64_t stack_ptr, struct pt_regs *regs);
+
+#endif /* TASKS_H */
\ No newline at end of file
diff --git a/vmcore_tasks/vma_util.c b/vmcore_tasks/vma_util.c
new file mode 100644
index 00000000..25e30fd4
--- /dev/null
+++ b/vmcore_tasks/vma_util.c
@@ -0,0 +1,429 @@
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <sys/param.h>
+#include <stdlib.h>
+
+#include "memory.h"
+#include "maple_tree.h"
+#include "vmcore_info.h"
+
+#include "vma_util.h"
+#include "vmcore_tasks_defs.h"
+
+
+bool get_vma_from_user_addr(unsigned long in_addr,
+			    struct task_data *task,
+			    struct vma_metadata *out_vma)
+{
+	struct task_vmas task_vmas = task->vmas;
+	int i;
+
+	for (i = 0; i < task_vmas.vma_count; i++) {
+		struct vma_metadata *vma_meta = &task_vmas.vma_meta[i];
+
+		if (in_addr >= vma_meta->start && in_addr < vma_meta->end) {
+			pr_trace("found vma mapping : [0x%016lx-0x%016lx]\n", vma_meta->start, vma_meta->end);
+
+			/* Copy only fields we use elsewhere */
+			out_vma->start = vma_meta->start;
+			out_vma->end   = vma_meta->end;
+			out_vma->file  = vma_meta->file;
+			out_vma->flags = vma_meta->flags;
+			snprintf(out_vma->filename, sizeof(out_vma->filename), "%s", vma_meta->filename);
+			snprintf(out_vma->type, sizeof(out_vma->type), "%s", vma_meta->type);
+			return true;
+		}
+	}
+	return false;
+}
+
+void print_vma_map_for_task(struct task_data *task)
+{
+	pr_verbose("  VMAs: %d regions\n", task->vmas.vma_count);
+	for (int i = 0; i < task->vmas.vma_count; i++) {
+		pr_verbose("    [%d] 0x%llx-0x%llx flags=0x%llx file=0x%llx type=%s filename=%s\n",
+		       i,
+		       (unsigned long long)task->vmas.vma_meta[i].start,
+		       (unsigned long long)task->vmas.vma_meta[i].end,
+		       (unsigned long long)task->vmas.vma_meta[i].flags,
+		       (unsigned long long)task->vmas.vma_meta[i].file,
+		       task->vmas.vma_meta[i].type,
+		       task->vmas.vma_meta[i].filename);
+	}
+}
+
+static bool get_file_path(uint64_t file_ptr, char *path_buf, size_t buf_size)
+{
+	uint64_t f_path_dentry;
+	uint64_t d_name_ptr, d_parent;
+	uint64_t hash_len;
+	uint32_t d_name_len;
+	char *file_buf = NULL;
+	char *dentry_buf = NULL;
+	bool ret = false;
+	size_t file_sz = SIZE("file");
+	size_t dentry_sz = SIZE("dentry");
+
+	/* Stack of path components (max depth 32 should be plenty) */
+	#define MAX_PATH_DEPTH 32
+	char components[MAX_PATH_DEPTH][256];
+	int depth = 0;
+
+	if (!file_ptr) {
+		path_buf[0] = '\0';
+		return true;
+	}
+
+	file_buf = malloc(file_sz);
+	dentry_buf = malloc(dentry_sz);
+	if (!file_buf || !dentry_buf) {
+		fprintf(stderr, "get_file_path: allocation failed\n");
+		snprintf(path_buf, buf_size, "[error]");
+		goto out;
+	}
+
+	// Read struct file
+	if (readmem(file_ptr, file_buf, file_sz, "read file struct", KVADDR) < 0) {
+		snprintf(path_buf, buf_size, "[error]");
+		goto out;
+	}
+
+	// Get f_path.dentry pointer
+	f_path_dentry = UINT64(file_buf + OFFSET("file.f_path") + OFFSET("path.dentry"));
+	if (!f_path_dentry) {
+		snprintf(path_buf, buf_size, "[no dentry]");
+		goto out;
+	}
+
+	/* Walk dentry chain up to root (d_parent == self) */
+	uint64_t cur_dentry = f_path_dentry;
+	while (depth < MAX_PATH_DEPTH) {
+		if (readmem(cur_dentry, dentry_buf, dentry_sz, "read dentry", KVADDR) < 0) {
+			snprintf(path_buf, buf_size, "[error]");
+			goto out;
+		}
+
+		hash_len = UINT64(dentry_buf + OFFSET("dentry.d_name") + OFFSET("qstr.hash_len"));
+		d_name_ptr = UINT64(dentry_buf + OFFSET("dentry.d_name") + OFFSET("qstr.name"));
+		d_name_len = (uint32_t)(hash_len >> 32);
+
+		if (!d_name_ptr || d_name_len == 0 || d_name_len > 255)
+			break;
+
+		if (d_name_len >= sizeof(components[0]))
+			d_name_len = sizeof(components[0]) - 1;
+
+		if (readmem(d_name_ptr, components[depth], d_name_len, "read filename", KVADDR) < 0)
+			break;
+		components[depth][d_name_len] = '\0';
+
+		/* Skip root dentry name "/" */
+		if (d_name_len == 1 && components[depth][0] == '/')
+			break;
+
+		depth++;
+
+		d_parent = UINT64(dentry_buf + OFFSET("dentry.d_parent"));
+		if (d_parent == cur_dentry || d_parent == 0)
+			break;
+		cur_dentry = d_parent;
+	}
+
+	/* Build full path from components (reverse order) */
+	if (depth == 0) {
+		snprintf(path_buf, buf_size, "[unknown]");
+		goto out;
+	}
+
+    	path_buf[0] = '\0';
+	for (int i = depth - 1; i >= 0; i--) {
+		size_t cur_len = strlen(path_buf);
+		snprintf(path_buf + cur_len, buf_size - cur_len, "/%s", components[i]);
+	}
+
+	ret = true;
+out:
+	if (file_buf)
+		free(file_buf);
+	if (dentry_buf)
+		free(dentry_buf);
+	return ret;
+	#undef MAX_PATH_DEPTH
+}
+
+static void get_vma_type(struct vma_metadata *vma_meta, unsigned long start_stack,
+				unsigned long start_brk, unsigned long brk)
+{
+
+	/* Check if this is the stack region */
+	if (vma_meta->start <= start_stack && vma_meta->end >= start_stack) {
+		snprintf(vma_meta->type, sizeof(vma_meta->type), "[stack]");
+		return;
+	}
+
+	/* Check if this is the heap region */
+	if (vma_meta->start <= brk && vma_meta->end >= start_brk) {
+		snprintf(vma_meta->type, sizeof(vma_meta->type), "[heap]");
+		return;
+	}
+
+	/* Check if this is a text (code) region: readable + executable but not writable */
+	if ((vma_meta->flags & (VM_READ | VM_EXEC | VM_WRITE)) == (VM_READ | VM_EXEC)) {
+		snprintf(vma_meta->type, sizeof(vma_meta->type), "[text]");
+		return;
+	}
+
+	/* Default: data or other */
+	snprintf(vma_meta->type, sizeof(vma_meta->type), "[---]");
+}
+
+/*
+ * Walk VMAs via the legacy mm_struct->mmap linked list.
+ * Works on kernels before the maple tree migration (< ~6.1).
+ */
+static bool collect_vmas_mmap(struct task_vmas *vmas, uint64_t mm_addr,
+			      unsigned long start_stack, unsigned long start_brk,
+			      unsigned long brk)
+{
+	uint64_t vma_addr;
+	unsigned long map_count = 0;
+	int count = 0, capacity = 64;
+	int max_walk = 0;
+	size_t vma_struct_sz = SIZE("vm_area_struct");
+	char *vma_struct_tmp = NULL;
+	struct vma_metadata *vma_meta = NULL;
+
+	/* Read the mmap head pointer */
+	if (readmem(mm_addr + OFFSET("mm_struct.mmap"), &vma_addr,
+		    sizeof(vma_addr), "read mm->mmap", KVADDR) < 0) {
+		fprintf(stderr, "collect_vmas_mmap: failed to read mmap pointer\n");
+		return false;
+	}
+
+	if (vma_addr == 0) {
+		vmas->vma_count = 0;
+		vmas->vma_meta = NULL;
+		return true;
+	}
+
+	/* Use map_count as an allocation hint when available. */
+	if (OFFSET_EXISTS("mm_struct.map_count") &&
+	    readmem(mm_addr + OFFSET("mm_struct.map_count"), &map_count,
+		    sizeof(map_count), "read mm->map_count", KVADDR) >= 0) {
+		if (map_count > 0 && map_count < 100000)
+			capacity = (int)map_count;
+	}
+
+	if (capacity < 32)
+		capacity = 32;
+
+	/* Hard walk cap for corrupted lists: 4x expected + slack. */
+	max_walk = (capacity * 4) + 1024;
+
+	vma_struct_tmp = malloc(vma_struct_sz);
+	if (!vma_struct_tmp)
+		return false;
+
+	vma_meta = calloc(capacity, sizeof(struct vma_metadata));
+	if (!vma_meta) {
+		free(vma_struct_tmp);
+		return false;
+	}
+
+	while (vma_addr != 0) {
+		if (count >= max_walk) {
+			fprintf(stderr,
+				"collect_vmas_mmap: aborting VMA walk after %d entries (map_count hint=%lu)\n",
+				count, map_count);
+			break;
+		}
+
+		if (readmem(vma_addr, vma_struct_tmp, vma_struct_sz,
+			    "read vm_area_struct", KVADDR) < 0) {
+			fprintf(stderr, "collect_vmas_mmap: failed to read VMA at 0x%lx\n",
+				(unsigned long)vma_addr);
+			break;
+		}
+
+		/* Grow array if needed */
+		if (count >= capacity) {
+			capacity *= 2;
+			struct vma_metadata *tmp = realloc(vma_meta,
+				capacity * sizeof(struct vma_metadata));
+			if (!tmp) {
+				fprintf(stderr, "collect_vmas_mmap: realloc failed\n");
+				free(vma_meta);
+				free(vma_struct_tmp);
+				return false;
+			}
+			vma_meta = tmp;
+			memset(&vma_meta[count], 0,
+			       (capacity - count) * sizeof(struct vma_metadata));
+		}
+
+		vma_meta[count].start = ULONG(vma_struct_tmp +
+					      OFFSET("vm_area_struct.vm_start"));
+		vma_meta[count].end = ULONG(vma_struct_tmp +
+					    OFFSET("vm_area_struct.vm_end"));
+		vma_meta[count].flags = ULONG(vma_struct_tmp +
+					      OFFSET("vm_area_struct.vm_flags"));
+		vma_meta[count].file = ULONG(vma_struct_tmp +
+					     OFFSET("vm_area_struct.vm_file"));
+
+		get_file_path(vma_meta[count].file,
+			      vma_meta[count].filename,
+			      sizeof(vma_meta[count].filename));
+
+		get_vma_type(&vma_meta[count], start_stack, start_brk, brk);
+
+		count++;
+
+		/* Follow vm_next pointer */
+		if (OFFSET_EXISTS("vm_area_struct.vm_next"))
+			vma_addr = ULONG(vma_struct_tmp +
+					 OFFSET("vm_area_struct.vm_next"));
+		else
+			/* vm_next is right after vm_end (offset 16 on 64-bit) */
+			vma_addr = ULONG(vma_struct_tmp + sizeof(unsigned long) * 2);
+
+		/* Guard self-loop on corrupted vm_next. */
+		if (count > 0 && vma_addr == vma_meta[count - 1].start) {
+			fprintf(stderr, "collect_vmas_mmap: detected self-loop at 0x%lx\n",
+				(unsigned long)vma_addr);
+			break;
+		}
+	}
+
+	vmas->vma_count = count;
+	vmas->vma_meta = vma_meta;
+
+	free(vma_struct_tmp);
+	return true;
+}
+
+/* Walk VMAs via maple tree (kernels >= ~6.1). */
+static bool collect_vmas_mapletree(struct task_vmas *vmas, uint64_t mm_addr,
+				   unsigned long start_stack, unsigned long start_brk,
+				   unsigned long brk)
+{
+	ulong vma;
+	int count, i, j, entry_num;
+	size_t vma_struct_sz = SIZE("vm_area_struct");
+	char *vma_struct_tmp = NULL;
+	struct vma_metadata *vma_meta = NULL;
+	struct list_pair *entry_list = NULL;
+
+	vma_struct_tmp = malloc(vma_struct_sz);
+	if (!vma_struct_tmp) {
+		fprintf(stderr, "dump_vma_snapshot: allocation failed\n");
+		return false;
+	}
+
+	uint64_t mt_addr = mm_addr + OFFSET("mm_struct.mm_mt");
+
+	/* This code was copied from gcore_coredump.c */
+
+	entry_num = do_maple_tree(mt_addr, MAPLE_TREE_COUNT, NULL);
+	if (entry_num <= 0) {
+		vmas->vma_count = 0;
+		vmas->vma_meta = NULL;
+		free(vma_struct_tmp);
+		return true;  // Empty VMA list is valid (kernel threads)
+	}
+
+	entry_list = (struct list_pair *)calloc(entry_num, sizeof(struct list_pair));
+	if (!entry_list) {
+		fprintf(stderr, "dump_vma_snapshot: failed to allocate entry_list\n");
+		free(vma_struct_tmp);
+		return false;
+	}
+	entry_list[0].index = entry_num;  /* limit gather to allocated size */
+	do_maple_tree(mt_addr, MAPLE_TREE_GATHER, entry_list);
+	
+	/* Calculate the actual number of vmas since each
+	 * entry could be empty. */
+	count = 0;
+	for (i = 0; i < entry_num; ++i)
+		if (entry_list[i].value)
+			count++;
+
+	vma_meta = (struct vma_metadata *)calloc(count, sizeof(struct vma_metadata));
+	if (!vma_meta) {
+		fprintf(stderr, "Failed to allocate vma_meta\n");
+		free(entry_list);
+		free(vma_struct_tmp);
+		return false;
+	}
+
+	for (i = 0, j = 0; i < entry_num; ++i) {
+		if (!entry_list[i].value)
+			continue;
+		
+		vma = (ulong)entry_list[i].value;
+		
+		if (readmem(vma, vma_struct_tmp,
+				SIZE("vm_area_struct"),  "read vm_area_struct", KVADDR) < 0 ) {
+			fprintf(stderr, "dump_vma_snapshot: read vm_area_struct failed\n");
+			free(vma_meta);
+			free(entry_list);
+			free(vma_struct_tmp);
+			return false;
+		}
+		vma_meta[j].start = ULONG(vma_struct_tmp + OFFSET("vm_area_struct.vm_start"));
+		vma_meta[j].end   = ULONG(vma_struct_tmp + OFFSET("vm_area_struct.vm_end"));
+		vma_meta[j].flags = ULONG(vma_struct_tmp + OFFSET("vm_area_struct.vm_flags"));
+		vma_meta[j].file  = ULONG(vma_struct_tmp + OFFSET("vm_area_struct.vm_file"));
+
+		// Get filename if available
+		get_file_path(vma_meta[j].file,
+			      vma_meta[j].filename, sizeof(vma_meta[j].filename));
+
+		// Determine VMA type (stack, heap, text, data)
+		get_vma_type(&vma_meta[j], start_stack, start_brk, brk);
+
+		j++;
+	}
+
+	free(entry_list);
+	entry_list = NULL;
+
+	vmas->vma_count = count;
+	vmas->vma_meta = vma_meta;
+
+	free(vma_struct_tmp);
+	return true;	
+}
+
+bool dump_vma_snapshot(struct task_vmas *vmas, uint64_t mm_addr)
+{
+	unsigned long start_stack = 0, start_brk = 0, brk = 0;
+
+	/* Read mm_struct fields for VMA type detection */
+	if (readmem(mm_addr + OFFSET("mm_struct.start_stack"), &start_stack,
+		sizeof(start_stack), "read start_stack", KVADDR) < 0) {
+		fprintf(stderr, "dump_vma_snapshot: read start_stack failed\n");
+	}
+	if (readmem(mm_addr + OFFSET("mm_struct.start_brk"), &start_brk,
+		sizeof(start_brk), "read start_brk", KVADDR) < 0) {
+		fprintf(stderr, "dump_vma_snapshot: read start_brk failed\n");
+	}
+	if (readmem(mm_addr + OFFSET("mm_struct.brk"), &brk,
+		sizeof(brk), "read brk", KVADDR) < 0) {
+		fprintf(stderr, "dump_vma_snapshot: read brk failed\n");
+	}
+ 	/*
+	 * Try legacy mmap linked list first (older kernels).
+	 * Fall back to maple tree if mmap doesn't exist (kernels >= ~6.1).
+	 */
+	if (OFFSET_EXISTS("mm_struct.mmap")) {
+		pr_trace("Using mm_struct->mmap linked list for VMA walk\n");
+		return collect_vmas_mmap(vmas, mm_addr, start_stack, start_brk, brk);
+	}
+
+	pr_trace("mm_struct->mmap not found, using maple tree for VMA walk\n");
+	return collect_vmas_mapletree(vmas, mm_addr, start_stack, start_brk, brk);
+}
diff --git a/vmcore_tasks/vma_util.h b/vmcore_tasks/vma_util.h
new file mode 100644
index 00000000..5030561d
--- /dev/null
+++ b/vmcore_tasks/vma_util.h
@@ -0,0 +1,16 @@
+#ifndef VMA_UTIL_H
+#define VMA_UTIL_H
+
+#include <stdint.h>
+#include <stdio.h>
+#include <stdbool.h>
+
+#include "vmcore_tasks_defs.h" 
+
+bool get_vma_from_user_addr(unsigned long in_addr,
+			    struct task_data *task,
+			    struct vma_metadata *out_vma);
+void print_vma_map_for_task(struct task_data *task);
+bool dump_vma_snapshot(struct task_vmas *vmas, uint64_t mm_addr);
+
+#endif /* VMA_UTIL_H */
\ No newline at end of file
-- 
2.43.0


