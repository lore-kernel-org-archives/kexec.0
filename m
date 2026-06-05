Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80767CD8C85
	for <kexec@archiver.kernel.org>; Fri,  5 Jun 2026 17:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2ojTho6pPozBEn1mINsChz/MA151sbs8LFhRJ1lhS4=; b=dAjVLbzd1rrXVMMFAQXjux1NSM
	LtTkveyAihSmK2ZuhwnV/d3b9scc9Q31YxOkNowDTvCnw9KWnqttyk1cI7wgtrsLx/mjTUNgIwrG0
	dpgftMycY1OYtM2yLfTrR1++r19206LsgZYBQX/Pxc8EOOnY9NfXxB2/LT5xLqM5KpGqPZbwWMuU4
	ixVUq/ifoFfCyoegTEDt4veBwmEBHxJHDpRQ8yoTYxXiQdnzlR3TCqvvvQ5WBqrTqYhUV+4yuHqD5
	LPRO6ihWMDJZ8MGdrcLHcVfnGN8ZInsBcwRzIyPR/U655iAGVDDt8T3b5SVQDwdNpU8Y3TFIKfoME
	ks1BW8nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2S-00000000xKV-1RPo;
	Fri, 05 Jun 2026 17:08:56 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVY2P-00000000xFy-3HGm
	for kexec@lists.infradead.org;
	Fri, 05 Jun 2026 17:08:55 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-68f9f08cfcaso1695131a12.2
        for <kexec@lists.infradead.org>; Fri, 05 Jun 2026 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780679332; x=1781284132; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g2ojTho6pPozBEn1mINsChz/MA151sbs8LFhRJ1lhS4=;
        b=pynVnVTEf1gzSG2UYJaps+ZCkN2cvDYU5k+NcpIKZQkgqTr9HfCdcr4grJ+8mRZGTf
         ulvwzZX5a2LiUtm0V6FsvTthfOZGU3doniGbUl38kx+S6sXLBxSIApaJwUK6MWC2u2nO
         ItdAuCZGxdFAJBpYrbU7T1Yqowpfty2x+6zjEoWAZmzIk5t+TmX/9IhfxS+OzzU/8VdZ
         uuoGPKCWkdAuSbS18ZkFC+xSUSov2o/g02OtnPoAp+LGD3I3ljKXd3C7d0kpQYGVgSWx
         hsb701h4wSBGDXWMu+EhBI6mqQe5WCKnIp7B6J4AeG+IpAyytbqvOvyQzT5xdY1Idj0N
         6ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780679332; x=1781284132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2ojTho6pPozBEn1mINsChz/MA151sbs8LFhRJ1lhS4=;
        b=NaxCRYMIKk/74YQL6BEQI81YrVy5Ej+Rxctw9fhU3QCCvs4C8xTbWzrSMJGs8oxZzS
         8X130YFHDOIl50Qzqgow53JejDdPil+juJgId/TwZxCgZQovMrhNCzwSjqE6yWyTwf6U
         ge7OXp6n4YgssXiLYzOEMA51y9HnLOODI5yIhHyuvB9Cht3d9KDLXraQzlMLwd0welVI
         r8SHUmCwRmU9Fs8a2UUQgjZ7GRHbTsvl35mk4oOEDJ+BFyLMEZxxfrKPxW13VdRYOHDz
         kBFBJUxZYDP4aqVyWQ8Zvae02uvi8Dxzk96B9zmgThHKhDZMZ8aLcX5H9kfFEHSBLRLi
         UDlg==
X-Forwarded-Encrypted: i=1; AFNElJ9rBiiDbGV7NtaZkERFic3LKrlnUBzrywBRIyZ2wpUyLboED9xT53GqYphAziuVJHPzG/tmtA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMkS2+XNVCdyn18sYS/RqWsZs7wrXFyqq0v81E56NdAQFSYGDU
	E/AhIfPFRppxyoX+HQ07lN1h5qKM8ya1dKx2SBUAlw8TbNSJvtWEtxst/NmMKecEPEqN6rF6ybb
	uC0pnIkiXAHxxgZrltQ==
X-Received: from edra26.prod.google.com ([2002:aa7:d91a:0:b0:678:e4b0:ff8d])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:11d2:b0:691:5124:45de with SMTP id 4fb4d7f45d1cf-69151244880mr66851a12.16.1780679331513;
 Fri, 05 Jun 2026 10:08:51 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:08:34 +0000
In-Reply-To: <cover.1780676742.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <4af286e970b7a44b539f78d746e92b91571c18fa.1780676742.git.tarunsahu@google.com>
Subject: [RFC PATCH v2 09/10] selftests: kvm: Split ____vm_create() to expose
 init helpers
From: Tarun Sahu <tarunsahu@google.com>
To: Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	Tarun Sahu <tarunsahu@google.com>, fvdl@google.com, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, 
	aneesh.kumar@kernel.org, skhawaja@google.com, vipinsh@google.com, 
	ackerleytng@google.com, Pratyush Yadav <pratyush@kernel.org>, david@redhat.com, 
	dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_100854_013741_62874183 
X-CRM114-Status: GOOD (  11.32  )
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
index 2ecaaa0e9965..d10cd25d0658 100644
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
index e08967ef7b7b..d3e6508e9863 100644
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
2.54.0.1032.g2f8565e1d1-goog


