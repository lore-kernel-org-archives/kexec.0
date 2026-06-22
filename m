Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7EFCDB476
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 20:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WZ+kFzS8lQYRwGg4haopF5XpEAXM1jeY97eMjJ0SZkA=; b=WKvmQM6iyiB8mtzghwIkkS9MMI
	8INBqg8A60gGKRSyJ2eSDvT32ROv97WE9wFndjuSA7Bivm95HmVLoZAGGKH3j3c/N6sv5eZAAoSng
	1bXs7pF6tFY9qmDKj8AM7sfk24Ahya1GJFsB3Q390E41zXnqNUARPXXMzITM726KmTnR20HdySu4d
	4MSL1yK87oM0tT+5YTQkMLhQCXkxUfnRtP3itDHGoDDRaSTiC6gxWUzKdClwRGDE6bg9T+MMz2Erm
	V6mkDAm/E/A8IsxPrXdm1psW8LFOiKkuBy8RzR7P2Q13mfc2QHB6EtCCneU2Q4XZ/akccFVczEJGw
	76+k/q7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblgh-00000005NkX-0zbO;
	Mon, 22 Jun 2026 20:56:11 +0000
Received: from esa4.hc555-34.eu.iphmx.com ([207.54.77.171])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wblge-00000005NhR-44s3
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 20:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1782161769; x=1813697769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DIl6UytUdMI1Nz7qlrt+XSA+cfohfs/aHPpkMtSzosE=;
  b=gaWtrBhh4V4wsZV8VAdOT66arK9Lcc3BwXPZv1WcuNO4dk6YAZ3Xb3gI
   d8vEAZ9LlyW0hAUuAeP46z88WJcBONn887SyJm5r5CKAQIp0kF+fFLatt
   HRD16PkjHhQ6OqCxD6DEoDwrnCCx8x1rVadUIbC/hN83gAzzWtbaXCeoe
   I4Qc+orJwaK0fAI/5BmEn5UATJ7z7Nj4FthF603bJsNd2qRZ8Ze00Ra7v
   PtnXrGTZdwgBqKNsUYwCuUW/SLaIzCnTWnjCBNLNha8eDOHBHTSvOo+Js
   uES5rpvpMz56G1z9nJQrgjE2lsPsLx6cIk1PIcYEx8vGoOaTUPIQI7sOG
   A==;
X-CSE-ConnectionGUID: rQD5raQuQjS7Rxwb562Qrw==
X-CSE-MsgGUID: 342qZfmcSeW9bMhYYk+jLg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2026 23:56:06 +0300
X-CSE-ConnectionGUID: WAPxHxybQam9e6qDG4M19w==
X-CSE-MsgGUID: SgfXgDS+QJyFhNKbEnQNeA==
Received: from unknown (HELO epgd034.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 23 Jun 2026 00:01:05 +0300
Received: by epgd034.me-corp.lan (sSMTP sendmail emulation); Mon, 22 Jun 2026 23:56:05 +0300
From: Pnina Feder <pnina.feder@mobileye.com>
To: kexec@lists.infradead.org
Cc: horms@kernel.org,
	Pnina Feder <pnina.feder@mobileye.com>
Subject: [PATCH 04/10] vmcore_tasks: Add common definitions and project infrastructure
Date: Mon, 22 Jun 2026 23:54:42 +0300
Message-ID: <20260622205550.1087163-5-pnina.feder@mobileye.com>
In-Reply-To: <20260622205550.1087163-1-pnina.feder@mobileye.com>
References: <20260622205550.1087163-1-pnina.feder@mobileye.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_135609_153188_B0034DA6 
X-CRM114-Status: GOOD (  16.61  )
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

Add the shared header and build system for the vmcore-tasks tool:

- vmcore_tasks_defs.h: Core data structures for task extraction
  (task_data, thread_data, vma_metadata, stackframe, system_minicore),
  architecture dispatch via compile-time RISCV64/MIPS64 selection,
  unwind_arch_ops callbacks for arch-specific instruction decode,
  and VM flag constants.

- Makefile: Standalone build system with auto-detection of target
  architecture from cross-compiler triplet, or explicit TARGET=
  selection. Supports out-of-tree builds via O= parameter.
  Compiles sources from both vmcore_tasks/ and util_lib/.

Signed-off-by: Pnina Feder <pnina.feder@mobileye.com>
---
 vmcore_tasks/Makefile            | 103 +++++++++++++++++++++++++
 vmcore_tasks/vmcore_tasks_defs.h | 124 +++++++++++++++++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 vmcore_tasks/Makefile
 create mode 100644 vmcore_tasks/vmcore_tasks_defs.h

diff --git a/vmcore_tasks/Makefile b/vmcore_tasks/Makefile
new file mode 100644
index 00000000..0219c6d4
--- /dev/null
+++ b/vmcore_tasks/Makefile
@@ -0,0 +1,103 @@
+# Simple Makefile to build vmcore-tasks: task lister similar to vmcore-dmesg
+# Produces binary: vmcore-tasks
+
+CC ?= gcc
+CFLAGS ?= -O2 -g
+CFLAGS += -Wall -Wextra
+CFLAGS += -I$(SRC_DIR) -I$(SRC_DIR)/../util_lib/include
+
+# Support out-of-tree builds via O= parameter
+# Usage: make O=/path/to/build/dir
+SRC_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
+ifdef O
+	BUILD_DIR := $(O)
+else
+	BUILD_DIR := $(SRC_DIR)
+endif
+
+# Auto-detect target architecture from compiler, unless TARGET is specified
+# Usage: make                # auto-detect from gcc
+#        make TARGET=RISCV64 # force specific target
+#        make TARGET=MIPS64  # force specific target
+
+ifndef TARGET
+	# Get compiler's target triplet (e.g., riscv64-unknown-linux-gnu, x86_64-linux-gnu)
+	CC_TARGET := $(shell $(CC) -dumpmachine)
+
+	ifneq (,$(findstring riscv64,$(CC_TARGET)))
+		TARGET := RISCV64
+	else ifneq (,$(findstring riscv32,$(CC_TARGET)))
+		TARGET := RISCV32
+	else ifneq (,$(findstring mips,$(CC_TARGET)))
+		TARGET := MIPS64
+	else ifneq (,$(findstring mips32,$(CC_TARGET)))
+		TARGET := MIPS32
+	else ifneq (,$(findstring aarch64,$(CC_TARGET)))
+		TARGET := ARM64
+	else ifneq (,$(findstring x86_64,$(CC_TARGET)))
+		TARGET := X86_64
+	else
+		$(error Unsupported architecture: $(CC_TARGET). Use TARGET=<arch> to specify.)
+	endif
+endif
+
+# Add architecture define
+CFLAGS += -D$(TARGET)
+
+# Arch-specific sources based on target
+ifeq ($(TARGET),RISCV64)
+	CFLAGS += -I$(SRC_DIR)/arch/riscv64
+	ARCH_SRC = $(wildcard $(SRC_DIR)/arch/riscv64/*.c)
+else ifeq ($(TARGET),MIPS64)
+	CFLAGS += -I$(SRC_DIR)/arch/mips64
+	# MIPS ABI/endian flags only when using a MIPS cross-compiler
+	ifneq (,$(findstring mips,$(shell $(CC) -dumpmachine)))
+		CFLAGS += -EL -mabi=64 -march=mips64r6 -fPIC
+		LDFLAGS += -static
+	endif
+	ARCH_SRC = $(wildcard $(SRC_DIR)/arch/mips64/*.c)
+else
+	ARCH_SRC =
+endif
+
+$(info Building for target: $(TARGET) (compiler: $(CC)))
+
+# Sources (relative to SRC_DIR)
+MAIN_SRC = $(wildcard $(SRC_DIR)/*.c)
+UTIL_SRC = $(addprefix $(SRC_DIR)/../,util_lib/elf_info.c util_lib/maple_tree.c util_lib/memory.c util_lib/vmcore_info.c)
+
+# Headers (for dependency tracking)
+HEADERS = $(wildcard $(SRC_DIR)/*.h) $(wildcard $(SRC_DIR)/../util_lib/include/*.h) $(wildcard $(SRC_DIR)/arch/$(TARGET)/*.h)
+
+# Objects (placed in BUILD_DIR, mirroring source structure)
+MAIN_OBJ = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(MAIN_SRC))
+ARCH_OBJ = $(patsubst $(SRC_DIR)/%.c,$(BUILD_DIR)/%.o,$(ARCH_SRC))
+UTIL_OBJ = $(patsubst $(SRC_DIR)/../%.c,$(BUILD_DIR)/%.o,$(UTIL_SRC))
+ALL_OBJ = $(MAIN_OBJ) $(ARCH_OBJ) $(UTIL_OBJ)
+
+BIN = $(BUILD_DIR)/vmcore-tasks
+
+.PHONY: all clean
+
+all: $(BIN)
+
+$(BIN): $(ALL_OBJ)
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^
+
+# All objects depend on all headers
+$(ALL_OBJ) : $(HEADERS)
+
+.SECONDEXPANSION:
+
+# Create build subdirectories as needed
+$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c | $$(dir $$@)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+$(BUILD_DIR)/%.o: $(SRC_DIR)/../%.c | $$(dir $$@)
+	$(CC) $(CFLAGS) -c $< -o $@
+
+%/:
+	mkdir -p $@
+
+clean:
+	rm -f $(ALL_OBJ) $(BIN)
diff --git a/vmcore_tasks/vmcore_tasks_defs.h b/vmcore_tasks/vmcore_tasks_defs.h
new file mode 100644
index 00000000..cfc5864d
--- /dev/null
+++ b/vmcore_tasks/vmcore_tasks_defs.h
@@ -0,0 +1,124 @@
+#ifndef VMCORE_TASKS_DEFS_H
+#define VMCORE_TASKS_DEFS_H
+
+#include <stdbool.h>
+#include "vmcore_tasks_util.h"
+
+#ifdef MIPS64
+#include "arch/mips64/mips64_defs.h"
+#elif defined(RISCV64)
+#include "arch/riscv64/riscv64_defs.h"
+#else
+#error "No architecture defined."
+#endif
+
+#define CODE_BUF_SIZE 4096
+#define MAX_TASK_NAME 16
+#define MAX_MAPPING_FILENAME 48
+#define MAX_MAPPING_TYPE 16
+#define BACKTRACE_DEPTH 30
+
+/* VM flags from linux/mm.h */
+#define VM_READ         0x00000001
+#define VM_WRITE        0x00000002
+#define VM_EXEC         0x00000004
+
+
+struct stackframe {
+	unsigned long pc;
+	unsigned long sp;
+	unsigned long ra;
+};
+
+struct signal_unwind_layout {
+	const char *rt_sigframe_uc_key;
+	const char *ucontext_mcontext_key;
+	const char *sigcontext_regs_key;
+	const char *sigcontext_pc_key;
+	unsigned int reg_width;
+	int sp_reg_index;
+	int ra_reg_index;
+	int pc_reg_index;
+	int pc_reg_alt_index;
+};
+
+struct backtrace_entries {
+	unsigned long abs_addr;
+	unsigned long vm_start;
+	unsigned long vm_end;
+	char filename[MAX_MAPPING_FILENAME];
+};
+
+struct vma_metadata {
+	unsigned long start;
+	unsigned long end;
+	unsigned long flags;
+	unsigned long file;
+	char filename[MAX_MAPPING_FILENAME];
+	char type[MAX_MAPPING_TYPE];
+};
+
+struct task_vmas {
+	int vma_count;
+	struct vma_metadata *vma_meta;
+};
+
+struct thread_data {
+	char comm[MAX_TASK_NAME];
+	pid_t tid;
+	int state;
+	int state_idx;
+	uint32_t flags;
+	struct pt_regs regs;
+	struct backtrace_entries bt_entry[BACKTRACE_DEPTH];
+};
+
+struct task_data{
+	char comm[MAX_TASK_NAME];
+	pid_t pid;
+	uint8_t is_user_task;
+	uint64_t mm_pgd;
+	struct task_vmas vmas;
+	int num_threads;
+	uint32_t flags;
+	int state;
+	int state_idx;
+	struct thread_data *threads;
+};
+
+struct system_minicore {
+	int task_count;
+	struct task_data *tasks;
+};
+
+struct unwind_arch_ops {
+	unsigned int insn_size;
+	unsigned int ra_width;
+	bool (*is_sp_move_ins)(uint32_t insn, int *stack_adj);
+	bool (*is_ra_save_ins)(uint32_t insn, unsigned long *ra_offset);
+	bool (*is_end_of_backtrace)(uint32_t insn);	/* NULL = not used */
+	int (*post_unwind_fixup)(struct stackframe *frame, unsigned int max_check);	/* NULL = not used */
+	bool (*likely_signal_pc)(uint64_t pc);
+	const struct signal_unwind_layout *signal_layout;
+};
+
+int unwind_user_frame(struct stackframe *old_frame,
+		      const unsigned int max_check);
+
+struct arch_deps {
+	bool (*vtop)(uint64_t, uint64_t, uint64_t *);
+	struct unwind_arch_ops unwind_ops;
+};
+extern struct arch_deps arch;
+
+#ifdef MIPS64
+void mips64_init();
+#define arch_init() mips64_init()
+#elif defined(RISCV64)
+void riscv64_init();
+#define arch_init() riscv64_init()
+#else
+#error "No architecture defined."
+#endif
+
+#endif /* VMCORE_TASKS_DEFS_H */
\ No newline at end of file
-- 
2.43.0


