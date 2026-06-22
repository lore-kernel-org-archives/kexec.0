Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A86CDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xPJYW9yyEh5zSHVb+w9eMw3NvjLrmM4On0OVVA4PIM4=; b=RkDYuyI6shPTGh0pc7JjLjzsYG
	V8tQ1qmgPuWeFxE7IQOtFXYCHiTX5GVwl95JvtSPTYj+YoSc00YTuV+xoLWbfz53lTfWfAnIwyySS
	FUn1lskupjHQdWbfp2/teTfq4MjqWEooJnrCTSYs4VoxWY7QWIEtJKVlAt9GFkXbe7tVgt+o5v7gO
	rF7qlnPZPYYyWupeVIL151lxMn98/dfhxWzvAdh8IgPJTGjb9UwSNMvOVfEZb4n4CVQ0QAYXxhguY
	+oZ5mOg61Wez+CADutugxqWIqVug9QSe0PRgIElp1vu5AjbIM7Ma1dNHv5mvmhThIzKnM2C35kKZz
	K/kDmLgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhu-00000005JSh-3JjZ;
	Mon, 22 Jun 2026 18:49:18 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhp-00000005JLw-2nNM
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:15 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-69557a7f1a5so4896085a12.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154152; x=1782758952; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPJYW9yyEh5zSHVb+w9eMw3NvjLrmM4On0OVVA4PIM4=;
        b=pqNZE2ph2eKNcGWcatu+ZNMZESXe8y94Mz/1onb9w2f/YcgnXQ8D3HarD2X9oxZ0UA
         sGU6sSi+CaXtTf3clxR8oE7KFwkeUTMmBqhVe9cjqfsur3RyX+ZtM38htQznMMzTa9Rn
         lpVGpE+5JyBPW/bQyclavctVNTWfnVQ3lnTA1KW4oynB2i/Gqqj+hnJmR4vRTnQU3A2z
         9aW3AY7bA/vE/o3rOLCIcDg5KW7Ht+PC69V6oBn2SgUgzu+llUv3SIGdqOww6iz14g/m
         wJP78eIslHLyMMi9UCF9WHHPUgk9llgioU4eeD5e8eo81hmw1KbUWTHqtq03rEp3l2EY
         A4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154152; x=1782758952;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPJYW9yyEh5zSHVb+w9eMw3NvjLrmM4On0OVVA4PIM4=;
        b=FELhMdXdVM3XqnaNoQBkmvVJD/zvJitlOD0oGBMZNS1lGHXCTBVBr0P3RIXrbp879i
         m0zBwIBpM5rAzEoDWY1zT7r5mm93APWRAUuoUmAAeYbKHWQrMCoB/ChD8pd08Egm2Q8h
         EYoaTLjnDq0cVRd394xd53BhWMDzzepX2FQrMpowB3skuTqphZ9VlXTLEaGUg6etR94P
         /E73QR61jaJq1ofSnrEON9cOpxDGc62x7PLANO9oILsk5wkaCR/c2Bs89KBrpiFO0MzR
         quG9m4brYYeMjN4e7PW1IQkABcajFwLqa7LBy+UZ8kU0SbMNejNEHfsysyAFI/vSQu1T
         ts5g==
X-Forwarded-Encrypted: i=1; AFNElJ8AvMuZy8pWbzHJWwg+odKZffLg7yYejnt82hPR5UVLsIur1aqxpYSS+gEM4mUfx1n9Bvaakg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyyhkrvNfUT+Y1FRMEmwVgEvZhAdxvX1/N+W3bZ9HWKM0jcqQCO
	gc6E6wKAwhSaEVWgjNhMkbqfiD73Z/QSOP1Vc6ESdpmTQutFFzf7JErWR3wCrfDKBehyGydlRyh
	B6rrlWRF7RqnB5WqQrA==
X-Received: from edl4-n1.prod.google.com ([2002:a05:6402:4244:10b0:697:7e74:f769])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:51cd:b0:697:b75d:fa13 with SMTP id 4fb4d7f45d1cf-697b75e01d3mr2901786a12.6.1782154151321;
 Mon, 22 Jun 2026 11:49:11 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:51 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-10-tarunsahu@google.com>
Subject: [PATCH v3 9/9] selftests: kvm: Add guest_memfd_preservation_test
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Tarun Sahu <tarunsahu@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_114913_760055_133DD0FD 
X-CRM114-Status: GOOD (  25.12  )
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

Add a new KVM selftest `guest_memfd_preservation_test` to verify that
guest memory backed by guest_memfd is preserved properly.

Here, I have used the kvm selftests framework by creating a new
vm and mapping two memory slots to it. One is the code that is executed
inside the vm and other is the guest_memfd whose memory is being
written by the guest code.

In Stage 1: Once data is written the vm exits and wait for the user
to trigger the kexec.

In Stage 2: A new vm is created with retrieved kvm and again two
memory slots are assigned. Once for guest code, and another is for
retrieved guest_memfd where guest_memfd memory is verified by the
executed guest code. If verification succeeds, The test passes.

// Kernel is compiled with CONFIG_LIVEUPDATE_GUEST_MEMFD and booted
// with kho=on liveupdate=on command line parameter.

$ ./selftests/kvm/guest_memfd_preservation_test --stage 1
$ <kexec>
$ ./selftests/kvm/guest_memfd_preservation_test --stage 2

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
 .../kvm/guest_memfd_preservation_test.c       | 236 ++++++++++++++++++
 3 files changed, 242 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e27b677..d0033a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14421,6 +14421,7 @@ L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
 F:	Documentation/liveupdate/vmm.rst
+F:	tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index d28a057..d5bc8be2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -164,6 +164,8 @@ TEST_GEN_PROGS_x86 += pre_fault_memory_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
+# Manual test that forks a persistent background daemon; skip auto CI run
+TEST_GEN_PROGS_EXTENDED_x86 += guest_memfd_preservation_test
 
 TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
@@ -258,6 +260,7 @@ OVERRIDE_TARGETS = 1
 # which causes the environment variable to override the makefile).
 include ../lib.mk
 include ../cgroup/lib/libcgroup.mk
+include ../liveupdate/lib/libliveupdate.mk
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
@@ -312,7 +315,8 @@ LIBKVM_S := $(filter %.S,$(LIBKVM))
 LIBKVM_C_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_C))
 LIBKVM_S_OBJ := $(patsubst %.S, $(OUTPUT)/%.o, $(LIBKVM_S))
 LIBKVM_STRING_OBJ := $(patsubst %.c, $(OUTPUT)/%.o, $(LIBKVM_STRING))
-LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) $(LIBCGROUP_O)
+LIBKVM_OBJS = $(LIBKVM_C_OBJ) $(LIBKVM_S_OBJ) $(LIBKVM_STRING_OBJ) \
+						$(LIBCGROUP_O) $(LIBLIVEUPDATE_O)
 SPLIT_TEST_GEN_PROGS := $(patsubst %, $(OUTPUT)/%, $(SPLIT_TESTS))
 SPLIT_TEST_GEN_OBJ := $(patsubst %, $(OUTPUT)/$(ARCH)/%.o, $(SPLIT_TESTS))
 
diff --git a/tools/testing/selftests/kvm/guest_memfd_preservation_test.c b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
new file mode 100644
index 0000000..c0a20e7
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Author: Tarun Sahu <tarunsahu@google.com>
+ *
+ * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
+ *
+ * NOTE: This is a MANUAL test and is excluded from automated CI/testing
+ * frameworks because Stage 1 daemonizes into the background to pin resources
+ * and requires a human operator to manually trigger kexec before Stage 2
+ * is executed. Running Stage 1 automatically would leak the background daemon
+ * and cause CI runners to falsely interpret it as a passed test.
+ *
+ * Usage:
+ * Stage 1: ./guest_memfd_preservation_test --stage 1
+ * Stage 2: ./guest_memfd_preservation_test --stage 2
+ */
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <linux/sizes.h>
+#include <linux/falloc.h>
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall_common.h"
+#include "../kselftest.h"
+#include "../kselftest_harness.h"
+
+#include <libliveupdate.h>
+
+#define SESSION_NAME "gmem_vm_preservation_session"
+#define VM_TOKEN 0x1001
+#define GMEM_TOKEN 0x1002
+
+#define STATE_SESSION_NAME "gmem_preservation_state"
+#define STATE_TOKEN 0x999
+
+#define GMEM_SIZE (16ULL * 1024 * 1024)
+#define DATA_SIZE (5ULL * 1024 * 1024)
+
+static size_t page_size;
+
+/* Deterministic byte pattern generation based on offset */
+static inline uint8_t get_pattern_byte(size_t offset)
+{
+	return (uint8_t)(offset ^ 0x5A);
+}
+
+static void guest_code_phase1(uint64_t gpa, uint64_t size, uint64_t data_size)
+{
+	uint8_t *mem = (uint8_t *)gpa;
+	size_t i;
+
+	for (i = 0; i < data_size; i++)
+		mem[i] = get_pattern_byte(i);
+
+	GUEST_DONE();
+}
+
+static void guest_code_phase2(uint64_t gpa, uint64_t size, uint64_t data_size)
+{
+	uint8_t *mem = (uint8_t *)gpa;
+	size_t i;
+
+	for (i = 0; i < data_size; i++) {
+		uint8_t val = get_pattern_byte(i);
+
+		__GUEST_ASSERT(mem[i] == val,
+			       "Data mismatch at offset %lu! Expected 0x%x, got 0x%x",
+			       i, val, mem[i]);
+	}
+
+	GUEST_DONE();
+}
+
+static void run_stage_1(int luo_fd)
+{
+	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	int gmem_fd, session_fd, ret;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+
+	ksft_print_msg("[STAGE 1] Starting pre-kexec setup...\n");
+
+	ksft_print_msg("[STAGE 1] Creating state file for next stage (2)...\n");
+	create_state_file(luo_fd, STATE_SESSION_NAME, STATE_TOKEN, 2);
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
+					guest_code_phase1);
+	gmem_fd = vm_create_guest_memfd(vm, GMEM_SIZE, flags);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
+				 gmem_fd, 0);
+
+	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
+		virt_pg_map(vm, gpa + i, gpa + i);
+
+	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	ksft_print_msg("[STAGE 1] Creating session '%s' and preserving VM/guest_memfd...\n",
+		       SESSION_NAME);
+	session_fd = luo_create_session(luo_fd, SESSION_NAME);
+	TEST_ASSERT(session_fd >= 0, "Failed to create LUO session");
+
+	ret = luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
+	TEST_ASSERT(ret == 0, "Failed to preserve VM file descriptor");
+
+	ret = luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
+	TEST_ASSERT(ret == 0, "Failed to preserve guest_memfd file descriptor");
+
+	printf("\n============================================================\n");
+	printf("Phase 1 Complete Successfully!\n");
+	printf("VM file and guest_memfd file have been preserved via LUO.\n");
+	printf("Tokens: VM_TOKEN=0x%x, GMEM_TOKEN=0x%x\n", VM_TOKEN, GMEM_TOKEN);
+	printf("Machine Size: %llu MB, Data Size: %llu MB\n", GMEM_SIZE / SZ_1M,
+				 DATA_SIZE / SZ_1M);
+	printf("------------------------------------------------------------\n");
+
+	close(luo_fd);
+	daemonize_and_wait();
+}
+
+static struct kvm_vm *vm_create_from_fd(int resurrected_vm_fd,
+					struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm->kvm_fd = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
+	vm->fd = resurrected_vm_fd;
+
+	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
+		vm->stats.fd = vm_get_stats_fd(vm);
+	else
+		vm->stats.fd = -1;
+
+	vm_init_memory_properties(vm);
+
+	return vm;
+}
+
+static void run_stage_2(int luo_fd, int state_session_fd)
+{
+	int retrieved_vm_fd, retrieved_gmem_fd, session_fd, stage;
+	struct vm_shape shape = VM_SHAPE_DEFAULT;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+
+	ksft_print_msg("[STAGE 2] Starting post-kexec verification...\n");
+
+	restore_and_read_stage(state_session_fd, STATE_TOKEN, &stage);
+	if (stage != 2)
+		fail_exit("Expected stage 2, but state file contains %d", stage);
+
+	ksft_print_msg("[STAGE 2] Retrieving session '%s'...\n", SESSION_NAME);
+	session_fd = luo_retrieve_session(luo_fd, SESSION_NAME);
+	TEST_ASSERT(session_fd >= 0, "Failed to retrieve LUO session");
+
+	retrieved_vm_fd = luo_session_retrieve_fd(session_fd, VM_TOKEN);
+	TEST_ASSERT(retrieved_vm_fd >= 0, "Failed to retrieve VM file descriptor");
+
+	retrieved_gmem_fd = luo_session_retrieve_fd(session_fd, GMEM_TOKEN);
+	TEST_ASSERT(retrieved_gmem_fd >= 0, "Failed to retrieve guest_memfd file descriptor");
+
+	vm = vm_create_from_fd(retrieved_vm_fd, shape);
+
+	u64 nr_pages = 2048; /* 8MB is plenty for slot0 pages */
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
+	kvm_vm_elf_load(vm, program_invocation_name);
+
+	for (int i = 0; i < NR_MEM_REGIONS; i++)
+		vm->memslots[i] = 0;
+
+	struct userspace_mem_region *slot0 = memslot2region(vm, 0);
+
+	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
+
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
+				   retrieved_gmem_fd, 0);
+
+	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
+		virt_pg_map(vm, gpa + i, gpa + i);
+
+	vcpu = vm_vcpu_add(vm, 0, guest_code_phase2);
+	kvm_arch_vm_finalize_vcpus(vm);
+
+	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
+
+	printf("Resuming / Running VM in Phase 2...\n");
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	printf("\nSUCCESS: Phase 2 Complete! All 5MB complex data verified intact!\n");
+
+	luo_session_finish(session_fd);
+	close(session_fd);
+
+	ksft_print_msg("[STAGE 2] Finalizing state session...\n");
+	if (luo_session_finish(state_session_fd) < 0)
+		fail_exit("luo_session_finish for state session");
+	close(state_session_fd);
+
+	/* This will also close the vm_fd */
+	kvm_vm_free(vm);
+	close(retrieved_gmem_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+	page_size = getpagesize();
+
+	return luo_test(argc, argv, STATE_SESSION_NAME,
+			run_stage_1, run_stage_2);
+}
-- 
2.55.0.rc0.786.g65d90a0328-goog


