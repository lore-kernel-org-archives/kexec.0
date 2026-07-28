Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE26C53219
	for <kexec@archiver.kernel.org>; Tue, 28 Jul 2026 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLf4NZ8GM7enE5DcNnXkHjbguMY0Wvl4QcagAqNt0Jg=; b=jMqGqqCP5RTAYbXxB0PfBcjLq4
	u/wql2Q2OKbLmSS+P1OpV/WDMvCoDWepuRfMX3M+XHqSYXnKBquYiigsrFNBI1h7wJItGmAAABZpd
	RaU+IE9Mqm5HbfjIr3V+q4Ul88UCbKuxaCHB8SBA/AG01ov3JKezIon0vfgIVR+N1NW8UNbIPrj9f
	QXJkRdyycgxCqJBRvWGPSHKuYwYr3iqNORrvNBRk1nx8AgREszygPFfPI2EMJk79BPTJ8HOoUMhYX
	V7ishceRYo0XHwe+KYXYm+QLPwb0xAnzQa9TtB9Uonw5ZWmIFN+R7+2ozD1dUvHmL4oxyIIcvmvz6
	LT7sim1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf7-00000005Cqs-40VJ;
	Tue, 28 Jul 2026 12:11:57 +0000
Received: from mail-ej1-x646.google.com ([2a00:1450:4864:20::646])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogf5-00000005Clk-36sU
	for kexec@lists.infradead.org;
	Tue, 28 Jul 2026 12:11:57 +0000
Received: by mail-ej1-x646.google.com with SMTP id a640c23a62f3a-c15fc5a1b7eso276160066b.1
        for <kexec@lists.infradead.org>; Tue, 28 Jul 2026 05:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785240713; x=1785845513; darn=lists.infradead.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jLf4NZ8GM7enE5DcNnXkHjbguMY0Wvl4QcagAqNt0Jg=;
        b=i4FygToOqponMJQBwEeaABdhcCz9qbSbrlvhMdFmOYz6uEiWFao7EboDLH/QRuoA6w
         6FkGoYLYleZFeLXOZwFXbkCkjiiLvvmLc27ZYiP57k34Oim0Y9HYQh2AxMDLztFE9q+I
         IodhZTIBT+iBIPinlY3GZ6jZYMk9nxRpStFTrWpq8dzixUY1+dOr+dS8xFMzez8fSSyI
         QOmuQikrQOc9zJp9Qh1ke5d+bG7dvRB7GWFwSkSxFB2P3QdhfjleiBc9cLUIkp0cTrA8
         GYUlBU9tRLLaqCzK1zyMzkOgmgJIICaWMnLUciJQlvJnIZEBGKK4CvtLGyyQcJYMHtTa
         dgtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785240713; x=1785845513;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jLf4NZ8GM7enE5DcNnXkHjbguMY0Wvl4QcagAqNt0Jg=;
        b=qaHZgJhanRLqJx0+IdNPKzH5aKrFanvUPyg96XtI9CocwTYjPl9/LRj/R2d0j+S1DZ
         v3gIhhMsaUBUynlHs3msS1xrNwPke1moZR+yEMWexsksQibANoLzI2/j0Tia55ok+F6w
         V5zMVU4o5gmaGpjfajjitvOFUwTrxTJgyCtJReGsMgp8OvVXiVWKHhIEMe2I7PK8M7Xo
         wNs3OWzV0ODHQsXi0NQHDnh/q/K5PvvhSJckzqX+eCWO4hlXfRBBnQ7bV0DZN4oQJ/Bx
         tfXbEAOAhfgTtOqbC7sJgqqch29i1IjLLTKUJ7vbJvBqX2Odl1DndXCwq1I63r8AS/vU
         OVLw==
X-Forwarded-Encrypted: i=1; AHgh+Ro8vvOlcHk4dzSmL/qjPBId1vfY9RzzUe7y9vR4gHzoZxTp6bNTrN4HP2ss1ihH9axj90xH+Q==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzfy+Ox3l7q5iY+1qAse8FwC1wxeUaX+tdJ+GPyeCXMfxAqXgx/
	iE+vpgRRad0DtUgCAFZee+X9gjKxc1iqjNlk5NwRc871W5hnZeXSqaxR//pNxrdgyqgi2kG9L/3
	z8HXUHYHhQVkqAAn2WA==
X-Received: from ejet14.prod.google.com ([2002:a17:906:178e:b0:c09:e2fc:4344])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a02:b0:c1f:586a:8514 with SMTP id a640c23a62f3a-c1f725124camr96102666b.65.1785240713183;
 Tue, 28 Jul 2026 05:11:53 -0700 (PDT)
Date: Tue, 28 Jul 2026 12:11:37 +0000
In-Reply-To: <20260728121138.1103610-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260728121138.1103610-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260728121138.1103610-11-tarunsahu@google.com>
Subject: [PATCH v4 10/11] KVM: selftests: Split ____vm_create() and add vm_create_from_fd()
From: Tarun Sahu <tarunsahu@google.com>
To: ackerleytng@google.com, fuad.tabba@linux.dev, 
	Andrew Morton <akpm@linux-foundation.org>, seanjc@google.com, dmatlack@google.com, 
	Shuah Khan <skhan@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, david@redhat.com, 
	Tarun Sahu <tarunsahu@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, sagis@google.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>
Cc: linux-kselftest@vger.kernel.org, andre.przywara@arm.com, 
	michael.roth@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	will@kernel.org, vannapurve@google.com, maz@kernel.org, fvdl@google.com, 
	kvm@vger.kernel.org, oliver.upton@linux.dev, kvmarm@lists.linux.dev, 
	alexandru.elisei@arm.com, skhawaja@google.com, aneesh.kumar@kernel.org, 
	linux-doc@vger.kernel.org, David Hildenbrand <david@kernel.org>, yan.y.zhao@intel.com, 
	kexec@lists.infradead.org, suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_051155_880026_12AAA5ED 
X-CRM114-Status: GOOD (  13.85  )
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

Refactor ____vm_create() in the KVM selftest library to extract its
initialization steps into separate helpers vm_init_fields() and
vm_init_memory_properties(). Also introduce vm_create_from_fd() to
instantiate a struct kvm_vm from an existing VM file descriptor.

This allows test setups (such as guest_memfd preservation tests) to
reconstruct and initialize a struct kvm_vm when restoring preserved
VMs across live updates. No functional change is introduced for
existing tests.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
---
 .../testing/selftests/kvm/include/kvm_util.h  |  3 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 49 ++++++++++++++++---
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 04a910164a29..0626efa5a73b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -471,6 +471,9 @@ const char *vm_guest_mode_string(u32 i);
 
 void kvm_vm_free(struct kvm_vm *vmp);
 void kvm_vm_restart(struct kvm_vm *vmp);
+void vm_init_fields(struct kvm_vm *vm, struct vm_shape shape);
+void vm_init_memory_properties(struct kvm_vm *vm);
+struct kvm_vm *vm_create_from_fd(int vm_fd, struct vm_shape shape);
 void kvm_vm_release(struct kvm_vm *vmp);
 void kvm_vm_elf_load(struct kvm_vm *vm, const char *filename);
 int kvm_memfd_alloc(size_t size, bool hugepages);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 195f3fdae1e3..d3f98d9eb709 100644
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
@@ -392,10 +388,47 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 
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
+
+	return vm;
+}
+
+struct kvm_vm *vm_create_from_fd(int vm_fd, struct vm_shape shape)
+{
+	struct kvm_vm *vm;
+
+	vm = calloc(1, sizeof(*vm));
+	TEST_ASSERT(vm != NULL, "Insufficient Memory");
+
+	vm_init_fields(vm, shape);
+
+	vm->kvm_fd = _open_kvm_dev_path_or_exit(O_RDWR);
+	vm->fd = vm_fd;
+
+	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
+		vm->stats.fd = vm_get_stats_fd(vm);
+	else
+		vm->stats.fd = -1;
+
+	vm_init_memory_properties(vm);
 
 	return vm;
 }
 
+
 static u64 vm_nr_pages_required(enum vm_guest_mode mode,
 				u32 nr_runnable_vcpus,
 				u64 extra_mem_pages)
-- 
2.55.0.229.g6434b31f56-goog


