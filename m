Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCCCCD4F56
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7OlXwmA5HFHQvyK/b9w4xYG/XKhpdapsDQN7y6zQXo=; b=q6MDV0t3WQuXKmINPHfTCuBhsz
	QidrFKjRJQmbilN78NmpDBSf6Rlyh6SOWPgwPFG73irgTIa21QL0jQQSoaCDbQVuX5GQ5aH+UpQIq
	1xItJj7rSwQcw9PLXlRCY6Qi3mWKElHC+R+gNBrPMPPbscccJbRgGQY5uXOM1TqOpasMs30MGMs49
	smzhFB+MPzzDEIiAa94TORX6WGOdkPXnqJR3wqVYrPs3S7bIye++HvudsnUrWoSPAI0GZ28YvjoYb
	m0v2yDHE6LEcJ0nEF0wtMjG38rVI8+g5WXpcAV/+XyL+Oc7ALnAuJEsRRaTSG+VtiFLuRF/CQ3rHn
	TNHkgSgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuPD-0000000F2op-2uGN;
	Mon, 18 May 2026 09:36:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuPB-0000000F2lx-3ycH
	for kexec@bombadil.infradead.org;
	Mon, 18 May 2026 09:36:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O7OlXwmA5HFHQvyK/b9w4xYG/XKhpdapsDQN7y6zQXo=; b=n1VcGbeRryODRmn0d2s3+KZ/kj
	pJMiwIJ+4YfWbQc5xT99pSssTu6LSHWA7RW5NRHNFSNJQosJesn/fEZi8LHt20geMIMxp2W/72Nwh
	oPmEbhMm7thA1HJ9VnXnsvvIE+JMBm1uANIibcrF/o2lMPgnkqa9o9TVfKTt9Eejk26K8cJ7M880b
	fYs3QM0u1JosaZVbZcYyZh9Czyxwx+xknE7SsAyBHSlXx3qtTb1xu7pd1tvQPOdY6ql85crXaTs0j
	UNuaWPaz9onNgA5U5Ge8+AWYktwpnc2hlvKBfBWpTN2Wpoq6Kexhwljy9dJMLAT1gjryfZ0WA4a3Y
	vHfvPOgg==;
Received: from mail-ed1-x54a.google.com ([2a00:1450:4864:20::54a])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP7-0000000Aazb-1bIS
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 09:36:55 +0000
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-680ff5fbf99so2686455a12.0
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097012; x=1779701812; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7OlXwmA5HFHQvyK/b9w4xYG/XKhpdapsDQN7y6zQXo=;
        b=NI5p9WXtoITT8TorHe1qcDIEdpeWSre4nRdVMxPAfJQpb7gWA+b341vDwZJ5doco12
         Cxt1ZdX50IPwLOEKAVMCnV05FcC2QNsRtGOxdHz/ciyLA/COiIBoOJKgdEUY4YfvLHpa
         jIvLYBxfZWbmHmDpc6cwQUEVFVP5CQRUEqN9l3cTe/xGnEPO/OsYqrt+NUynL3XSpqXv
         49iDvZolrOz+eDjNhhXWGlb0whCDwc5GdTrdLlE/4BSbz3y1j81ChxQZF7sozUNsqiLy
         li0HtpcUygJ+Kq3tIH1nzpbK730dYL/JPXVE8QKx2ptukxjVRgfMY4XTJi6lzsboLuIs
         Ai5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097012; x=1779701812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7OlXwmA5HFHQvyK/b9w4xYG/XKhpdapsDQN7y6zQXo=;
        b=iKfRs7s/CO9i3Kunvq6jJ9BVqUup1sxPNEtwQf3X97S/4kbJyfXkff4aLfAq/gSde1
         VbYEAE+Gf6BQncSYOk8cq6dEAYyQR5Z8QTZL2VaV7BGlDoD1LN+b9Iqo5yhSWeUVmk6C
         n9bKGvtlD8CEmX7vJamngQEWtP3zSguBWzkngWuWRypKqp8FVhwmG1g21WFUyasR3nx+
         HIGbL+hilvrEzkOELXRDm+gSrBExqWXmoeOyV6G92LnZCMsBrvlRkcdp/dCDEzKS8lR/
         N+nR78mGE1FSK2wpIc07LN+EbkRQy3WKvg45xtSSOqgMs05yYCV802ma/GIeuLhY0xZc
         cNGA==
X-Forwarded-Encrypted: i=1; AFNElJ+gcl1rr+0wZaTUDYhd+X9ukML5R2J1NUxdP5LMqYugvlD010X1Kn/gs0PN1ZMXoQ3m2BopmA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwT69xF/A7rmcsZriEaaChwsDXDjk4XN4T5jPB2yQoA7b1phv8W
	OSBB0f9ZoCcWpPq5Mu04i0Tijf0JeJ5MHT+4DuHdog7x/lUP2w7vbcCJnDEUvm/Kv8GBgqIpb9j
	yuCjLHL+Y7rnHdbQ4bw==
X-Received: from edgg22.prod.google.com ([2002:a05:6402:1ed6:b0:67e:2459:8ce9])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c2:b0:67c:7ffc:c4b with SMTP id 4fb4d7f45d1cf-683bd384cdbmr7475294a12.19.1779097011469;
 Mon, 18 May 2026 02:36:51 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:39 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <a1bc78e4f43b5b6b079012954af9af1cf864b3f8.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 9/9] selftests: kvm: Add guest_memfd_preservation_test
From: Tarun Sahu <tarunsahu@google.com>
To: axelrasmussen@google.com, mark.rutland@arm.com, skhawaja@google.com, 
	Mike Rapoport <rppt@kernel.org>, sagis@google.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shuah Khan <shuah@kernel.org>, ackerleytng@google.com, corbet@lwn.net, 
	dmatlack@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, vannapurve@google.com, 
	Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, aneesh.kumar@kernel.org, 
	vipinsh@google.com, Alexander Graf <graf@amazon.com>, David Hildenbrand <david@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kexec@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	kvm@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_103653_724488_F427375D 
X-CRM114-Status: GOOD (  27.29  )
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

The test leverages the Live Update Orchestrator (LUO) infrastructure
to validate that memory folios and configuration layouts are
successfully saved and then restored during kernel live updates,
preventing any memory loss for the guest.

Here, I have used the kvm selftests framework by creating a new
vm and mapping two memory slots to it. One is the code that is executed
inside the vm and other is the guest_memfd whose memory is being
written by the guest code.

In Phase 1: Once data is written the vm exits and wait for the user
to trigger the kexec.

In Phase 2: A new vm is created with retrieved kvm and again two
memory slots are assigned. Once for guest code, and another is for
retrieved guest_memfd where guest_memfd memory is verified by the
executed guest code. If verification succeeds, The test passes.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../kvm/guest_memfd_preservation_test.c       | 285 ++++++++++++++++++
 3 files changed, 288 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e5402a56ab98..647d60f6a1e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14413,6 +14413,7 @@ L:	kexec@lists.infradead.org
 L:	kvm@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux.git
+F:	tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 F:	virt/kvm/guest_memfd_luo.c
 F:	virt/kvm/kvm_luo.c
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9118a5a51b89..4ea6cb7bf001 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -161,6 +161,8 @@ TEST_GEN_PROGS_x86 += pre_fault_memory_test
 
 # Compiled outputs used by test targets
 TEST_GEN_PROGS_EXTENDED_x86 += x86/nx_huge_pages_test
+# Manual test that forks a persistent background daemon; skip auto CI run
+TEST_GEN_PROGS_EXTENDED_x86 += guest_memfd_preservation_test
 
 TEST_GEN_PROGS_arm64 = $(TEST_GEN_PROGS_COMMON)
 TEST_GEN_PROGS_arm64 += arm64/aarch32_id_regs
diff --git a/tools/testing/selftests/kvm/guest_memfd_preservation_test.c b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
new file mode 100644
index 000000000000..ad7b305b48c3
--- /dev/null
+++ b/tools/testing/selftests/kvm/guest_memfd_preservation_test.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026, Google LLC.
+ *
+ * Author: Tarun Sahu <tarunsahu@google.com>
+ *
+ * Test for VM and guest_memfd preservation across kexec (Live Update) via LUO.
+ *
+ * NOTE: This is a MANUAL test and is excluded from automated CI/testing
+ * frameworks because Phase 1 daemonizes into the background to pin resources
+ * and requires a human operator to manually trigger kexec before Phase 2
+ * is executed. Running Phase 1 automatically would leak the background daemon
+ * and cause CI runners to falsely interpret it as a passed test.
+ *
+ * Usage:
+ * Phase 1: ./guest_memfd_preservation_test
+ * Phase 2: ./guest_memfd_preservation_test --phase2
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
+#include "../../../../include/uapi/linux/liveupdate.h"
+
+#define SESSION_NAME "gmem_vm_preservation_session"
+#define VM_TOKEN 0x1001
+#define GMEM_TOKEN 0x1002
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
+static void do_phase1(void)
+{
+	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
+	int gmem_fd, dev_luo_fd, ret;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+	struct liveupdate_ioctl_create_session create_sess = {
+		.size = sizeof(create_sess),
+		.name = SESSION_NAME,
+	};
+	struct liveupdate_session_preserve_fd preserve_vm = {
+		.size = sizeof(preserve_vm),
+		.token = VM_TOKEN,
+	};
+	struct liveupdate_session_preserve_fd preserve_gmem = {
+		.size = sizeof(preserve_gmem),
+		.token = GMEM_TOKEN,
+	};
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
+					guest_code_phase1);
+	gmem_fd = vm_create_guest_memfd(vm, GMEM_SIZE, flags);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
+				 gmem_fd, 0);
+	ret = fallocate(gmem_fd, FALLOC_FL_KEEP_SIZE, 0, GMEM_SIZE);
+	TEST_ASSERT(!ret, "fallocate failed, errno = %d (%s)", errno, strerror(errno));
+
+	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
+		virt_pg_map(vm, gpa + i, gpa + i);
+
+	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+
+	dev_luo_fd = open("/dev/liveupdate", O_RDWR);
+	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
+
+	TEST_ASSERT(ioctl(dev_luo_fd, LIVEUPDATE_IOCTL_CREATE_SESSION,
+			  &create_sess) == 0,
+			  "Failed to create LUO session");
+	TEST_ASSERT(create_sess.fd >= 0, "Invalid session fd");
+
+	preserve_vm.fd = vm->fd;
+	TEST_ASSERT(ioctl(create_sess.fd, LIVEUPDATE_SESSION_PRESERVE_FD,
+			  &preserve_vm) == 0,
+			  "Failed to preserve VM file descriptor");
+
+	preserve_gmem.fd = gmem_fd;
+	TEST_ASSERT(ioctl(create_sess.fd, LIVEUPDATE_SESSION_PRESERVE_FD,
+		    &preserve_gmem) == 0,
+		    "Failed to preserve guest_memfd file descriptor");
+
+	printf("\n============================================================\n");
+	printf("Phase 1 Complete Successfully!\n");
+	printf("VM file and guest_memfd file have been preserved via LUO.\n");
+	printf("Tokens: VM_TOKEN=0x%x, GMEM_TOKEN=0x%x\n", VM_TOKEN, GMEM_TOKEN);
+	printf("Machine Size: %llu MB, Data Size: %llu MB\n", GMEM_SIZE / SZ_1M,
+				 DATA_SIZE / SZ_1M);
+	printf("------------------------------------------------------------\n");
+
+	pid_t pid;
+
+	printf("Forking background process to hold sessions open...\n");
+	pid = fork();
+	TEST_ASSERT(pid >= 0, "fork failed");
+
+	if (pid > 0) {
+		printf("Background child process PID: %d. Resources are pinned.\n", pid);
+		printf("ACTION REQUIRED: Trigger kexec now to boot into Phase 2 kernel.\n");
+		exit(EXIT_SUCCESS);
+	}
+
+	/* Child process: detach from terminal and hold resources */
+	if (setsid() < 0)
+		exit(EXIT_FAILURE);
+
+	close(STDIN_FILENO);
+	close(STDOUT_FILENO);
+	close(STDERR_FILENO);
+
+	while (1)
+		sleep(60);
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
+static void do_phase2(void)
+{
+	int retrieved_vm_fd, retrieved_gmem_fd, dev_luo_fd;
+	struct vm_shape shape = VM_SHAPE_DEFAULT;
+	const uint64_t gpa = SZ_4G;
+	struct kvm_vcpu *vcpu;
+	const int slot = 1;
+	struct kvm_vm *vm;
+	struct liveupdate_ioctl_retrieve_session retrieve_sess = {
+		.size = sizeof(retrieve_sess),
+		.name = SESSION_NAME,
+	};
+	struct liveupdate_session_retrieve_fd retrieve_vm = {
+		.size = sizeof(retrieve_vm),
+		.token = VM_TOKEN,
+	};
+	struct liveupdate_session_retrieve_fd retrieve_gmem = {
+		.size = sizeof(retrieve_gmem),
+		.token = GMEM_TOKEN,
+	};
+
+	dev_luo_fd = open("/dev/liveupdate", O_RDWR);
+	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
+
+	TEST_ASSERT(ioctl(dev_luo_fd, LIVEUPDATE_IOCTL_RETRIEVE_SESSION, &retrieve_sess) == 0,
+		    "Failed to retrieve LUO session");
+	TEST_ASSERT(retrieve_sess.fd >= 0, "Invalid retrieved session fd");
+
+	TEST_ASSERT(ioctl(retrieve_sess.fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &retrieve_vm) == 0,
+		    "Failed to retrieve VM file descriptor");
+	retrieved_vm_fd = retrieve_vm.fd;
+
+	TEST_ASSERT(ioctl(retrieve_sess.fd, LIVEUPDATE_SESSION_RETRIEVE_FD, &retrieve_gmem) == 0,
+		    "Failed to retrieve guest_memfd file descriptor");
+	retrieved_gmem_fd = retrieve_gmem.fd;
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
+	close(retrieve_sess.fd);
+	close(dev_luo_fd);
+	/* This will also close the vm_fd */
+	kvm_vm_free(vm);
+	close(retrieved_gmem_fd);
+}
+
+int main(int argc, char *argv[])
+{
+	bool phase2 = false;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
+	page_size = getpagesize();
+
+	for (int i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--phase2") == 0)
+			phase2 = true;
+	}
+
+	if (phase2)
+		do_phase2();
+	else
+		do_phase1();
+
+	return 0;
+}
-- 
2.54.0.563.g4f69b47b94-goog


