Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850A1CDB466
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2hLQE11StkUlK0CTXqXjUU/EPcv0l0L8NQfDoUdv0GQ=; b=NaRn7o+wnHjdU1g3DW8sQiFh0a
	qXy6rKfucPee2QwIdrq8FBCCDAwKVKDqX1mzeoKACXdmGQMYEVr95T4WlqecHAMsWdc8424ke/9eB
	+w7bZJqLVJy3s3iLtqOEVzrMmwBQl19C8BJREdpCSqzCGlcPglHCiGq34PkfIDH3NXtBTpArNDdyz
	0dtNw+b+j/QTL4Mmi/AMa4Tkg4rtK/7gVYOPSNu8eBB87gfLRzmpDbAo3w8dZ6nnYx9ENcq6nB6+V
	q9Bx4j4yo28HmhLlBSPt5Dd4RPYdnr10Ie91+RtkVKpUnB76DOISKzfensfMmPub5hJjJrkEePJ2G
	MkqfI+oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhr-00000005JQG-2ief;
	Mon, 22 Jun 2026 18:49:15 +0000
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjho-00000005JKS-3LrG
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:13 +0000
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-462c4593a33so3191391f8f.3
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154150; x=1782758950; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2hLQE11StkUlK0CTXqXjUU/EPcv0l0L8NQfDoUdv0GQ=;
        b=qlAtk7QemdJ1mT1AQjsjSQtXk2xDErsUHeHy3XJAIZLZnx8vYqUdVFQd209SoxHNLW
         kHv2BVkg15hC+zlxVRw1nD8zWvwJtPI/n5WRyrHp3axOS1WNJxvVCw3WMBPIivvbC2Wl
         QhVeooe+DxRSgvRofc+MIasjQE/O0GJQ502yzas3sftqwN+naLm+2GkpPnAhLjPvLkTg
         SiT9+YARAU7nPO5XTsTOapmywesyBRJkokwZtx2jfRSG0qjbHErF2h+mvNzuua+7/LoJ
         501m+wz/SJNR0yoVIYPVaZRH3alsNyMkt9mlxJV+2jevSIQOL/IdZM6BAsNrzQ6VWfsx
         mBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154150; x=1782758950;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hLQE11StkUlK0CTXqXjUU/EPcv0l0L8NQfDoUdv0GQ=;
        b=JC4g/zmh9ZKt/KBFZCv2kPFwJuvszOBOx/xRJy9WrQ+l9uFWJIW7wdIGKtf0RzFaGc
         ZzBqfto6BUvNYixMUyFZ2KiWgvEj4pBzp69O5mif6gYy/liB5XdTyKlQ40PjyJrnqK/O
         3e65txQBYoFL65kp8rS3yC/Hu/HnR97FVlUyrdfChhbAMpFrGi7Msw0ZVOUADMAYKBLo
         yGMPzYB3zhTBXWxSa8RjW6a7QJAryhKK8Foh/LFFW3tPtekCgS+7G1tO+IZjgD7e6fFj
         K7H9WVIGYljysfEFWqyNur5AoLtVkUxLil2SnfNw2zRusl13RQQxQB/e5mGeMGgsUJTl
         baLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+xRx8/jkfnjB3XXzgIGEg5Df7ydaJ7eFNAWpGZnafMK9zYdYoJIvLrKwGJf7uO2wZqi6FZuQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzf22j/G7C+qOz/2uLOZkMmkeRDXTmc3V0W3Y6IZ6e3X47g9R7g
	VL2aVL1qnwlVZiaGCrYY5KM7PVk38wb3KOfkeWyVrWa+Tj+R6mB7CZ9eUxFVcdwa9YgeeUNnHhb
	z00wLsfuDVgJDpy78wQ==
X-Received: from wmat25.prod.google.com ([2002:a05:600c:6d19:b0:492:52c9:b1a7])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5290:b0:490:bcf6:469f with SMTP id 5b1f17b1804b1-49242189b1cmr243494115e9.0.1782154150022;
 Mon, 22 Jun 2026 11:49:10 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:50 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-9-tarunsahu@google.com>
Subject: [PATCH v3 8/9] selftests: kvm: Split ____vm_create() to expose init helpers
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
X-CRM114-CacheID: sfid-20260622_114912_856146_5885AB14 
X-CRM114-Status: GOOD (  11.99  )
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

Refactor `____vm_create()` in the KVM selftest library to extract its
initialization steps into separate, reusable internal helpers.

Introduce `vm_init_fields()` and `vm_init_memory_properties()`. This
allows advanced test setups to perform targeted VM fields or memory
property initializations independently, which is required by upcoming
test cases that restore preserved VMs. No functional changes are
introduced for the existing tests.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  2 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 26 +++++++++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a9101..88de0e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -471,6 +471,8 @@ const char *vm_guest_mode_string(u32 i);
 
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape);
+void vm_init_memory_properties(struct kvm_vm *vm);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 int kvm_memfd_alloc(size_t size, bool hugepages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fd..dc576b8 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -276,13 +276,8 @@ __weak void vm_populate_gva_bitmap(struct kvm_vm *vm)
 		(1ULL << (vm->va_bits - 1)) >> vm->page_shift);
 }
 
-struct kvm_vm *____vm_create(struct vm_shape shape)
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape)
 {
-	struct kvm_vm *vm;
-
-	vm = calloc(1, sizeof(*vm));
-	TEST_ASSERT(vm != NULL, "Insufficient Memory");
-
 	INIT_LIST_HEAD(&vm->vcpus);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
@@ -380,9 +375,10 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	if (vm->pa_bits != 40)
 		vm->type = KVM_VM_TYPE_ARM_IPA_SIZE(vm->pa_bits);
 #endif
+}
 
-	vm_open(vm);
-
+void vm_init_memory_properties(struct kvm_vm *vm)
+{
 	/* Limit to VA-bit canonical virtual addresses. */
 	vm->vpages_valid = sparsebit_alloc();
 	vm_populate_gva_bitmap(vm);
@@ -392,6 +388,20 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
 	/* Allocate and setup memory for guest. */
 	vm->vpages_mapped = sparsebit_alloc();
+}
+
+struct kvm_vm *____vm_create(struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm_open(vm);
+
+	vm_init_memory_properties(vm);
 
 	return vm;
 }
-- 
2.55.0.rc0.786.g65d90a0328-goog


