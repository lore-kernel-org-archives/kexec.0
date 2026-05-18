Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3749CCD4F54
	for <kexec@archiver.kernel.org>; Mon, 18 May 2026 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=; b=BUK6ixgVDLiwcG/zc+PCwWAsaR
	p0YmaNTpatGNjA1FJjuDvbfYvbO/I6IaY2jdzfk99Aga7H8mYpdL4vDfktVDcaz/ASziXPCieTuOT
	SEcVk39Ks2rgyccxuBwTXfrSnbFL7NeByT9GY+xrwJ5tRjJK1WOBL44mZJnkTFw4qr9BPcEvQDVIx
	ATCP+ACaSEWlQNr0nwLNbn/fV8J3bJfrveTu0gt0Jq+H0pweI6ZbNfqlRmb+CiZfZBnzTogc7pwwm
	nyaD7GJhW1s83nC6Ok25O8rsRiVvan0bZWPF+pYIAW6DUZYiWR75sT29tTfhO+NujIcjiRiQ2F93j
	BQqWPFFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuPD-0000000F2nd-16sQ;
	Mon, 18 May 2026 09:36:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuPA-0000000F2jT-0AWt
	for kexec@bombadil.infradead.org;
	Mon, 18 May 2026 09:36:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=; b=YlRbsvxMPw+i4HeQMq10nLicN0
	EEFq/hJqyC7T1jy/d0RdYM9F2XWByZ/WWqrOXfqr7l7ClJLHOP8QvWcGaVeH9gUp9DHvm56sk8YLn
	8n2FiQYqBsRVfKwrrg08tBQ3AAmdKm+Jw9uiWOGifIYw0A8jrq5VIbK68OU+S69uCz2lAam9QLkOw
	mw9mrZw2u48wLXw2qdNKPt1s0Y3spIAzUGy08LulNvys4TsCjBHjZ4HC+yr8GYu6L9EUb5GVSZjqU
	7o7dLXuTTNrHHNEwUPy4RFu89hr0Mt86NnDMN3cnLD7wy5HHow5+eNf0SdRPpkBqwpxbpiIMeJOme
	P/wd+qsA==;
Received: from mail-ej1-x64a.google.com ([2a00:1450:4864:20::64a])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOuP6-0000000AazP-3jf3
	for kexec@lists.infradead.org;
	Mon, 18 May 2026 09:36:54 +0000
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-bcdbb46dce2so178767166b.1
        for <kexec@lists.infradead.org>; Mon, 18 May 2026 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779097011; x=1779701811; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=;
        b=KpJuF+JpZbXmCfTuJUp3ypzY/TC7QIU1GWwRWeGsoN4ei2ZidFig5orOSCPt3YfwZq
         F9RoeoDW/zU5ZMac8v7952E1L+ZA+7fveuhrcbBMFZ9MItWEBuJgz6AFcu40RRcKtLAV
         EKU7YLzgAPJNKzV2Fn1IGqT/7Y99qw/wQUXnhnUd4jDAsgifFIwmyEeJe01YYH8mEyU0
         VSC6RI5D8UfZiN3IgBF33HCLaZxKSsMUNs6gIHqSHM0rLMaqffuENhhA9ftyhMgDm/OH
         IrBHLekmn2Sjf+RYD5dW0nwbjYPDzMotOaZW43nL3AFzM9S7tm3EMOCUWLVM6EuHQii+
         CyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097011; x=1779701811;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJXHhvWcO8WVbNSPa5FuUDQ4B9keuIjD7ZJ/qh+m6Pg=;
        b=TsT70+ZKZZqXntxObO7hYoj54KLuxYGaJWHTdxdwJPuhTgspOWzJy1yc1ef1K0F3ro
         939JqZNcdsjXZaJ+eRZ2DpXtKMVM6k1cdSSiquFtyejHBntLpcLfLiwi96f53V/Ppu8o
         L4yhrLAw4a7EEUVVGedSmcVjKmChpTZ9LfOzFU7lo+Y5IfQEyS7I+ABL0IvT0uwS7dDz
         /f6TwbxwkVyBX2vuk4u4J4ZR7X4Uh2vm7z5XT87+1Bi3rEYDRPqnS70AYLbKgBfyIC23
         A9pAY0AMxTRuVN88igPFQp1Hlc+wneHzu9KEUAyM48IpZI/K+wennQERDcX0r5Jpqmlh
         4FjA==
X-Forwarded-Encrypted: i=1; AFNElJ+ozX5xJDJCt0Q4U+yFLEB8kpEXmuFCEr1x7rsi8mQoxYRh+I9U8zDCdGXx9eQTUTOuFrKbtA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyru/ABDldN1vEAR2lFF3Hf++BDNzPuYO8cugW0FzD2SJzwqTkj
	9AKrN+gFIgHJmNz8Knz3D8yoZIZyVv5BwEn/SJ3pgHgYVoOwbBwWKUhhD3MvLji1zMmki7EWgtd
	OoQdgt+ZMHo1JeJs7eQ==
X-Received: from edcc7.prod.google.com ([2002:a05:6402:1f87:b0:67c:a74a:6214])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1b1b:b0:b9c:3d56:e4ec with SMTP id a640c23a62f3a-bd51797a576mr551071666b.24.1779097010457;
 Mon, 18 May 2026 02:36:50 -0700 (PDT)
Date: Mon, 18 May 2026 09:36:38 +0000
In-Reply-To: <cover.1779080766.git.tarunsahu@google.com>
Mime-Version: 1.0
References: <cover.1779080766.git.tarunsahu@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <8bf92f738d3456ea71ffe2a8406714e0d2afa114.1779080766.git.tarunsahu@google.com>
Subject: [RFC PATCH v1 8/9] selftests: kvm: Split ____vm_create() to expose
 init helpers
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
X-CRM114-CacheID: sfid-20260518_103653_262306_DA32DBD5 
X-CRM114-Status: GOOD (  11.80  )
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
index 2a76eca7029d..f4cd06d34ce9 100644
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
2.54.0.563.g4f69b47b94-goog


