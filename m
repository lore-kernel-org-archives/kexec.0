Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4037DCDB470
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 19:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdsj6Guo7r326E75XLxyGx3YlVfMh6UQRvA3w5OPiCM=; b=pl8Y4sBXn8owepfFSTJzqwjmYb
	JwhqQw1ZPP6yGIEtqIjEhhmFJP1uSQkc3h8jkObTdu7dJM4NVYYcO/xvDCj0CSA6xAZ2G3T3/6MjV
	Qm1hchJ5IilVj9NX0wCu3TA5qYmBONoAjE1Eqv8UkGBe97I++PI/FQiMiGr3V1bNFS3zXrMbIgcPN
	GUfYehggmUNu1OL/aTTBL/2+F067WQkYU7OwZ+pCOUqq9sgAdkKt0Mf6wzLu977+xgjJS5SpVRfff
	veixmaMqvqYGSUB3AL45FaM7ExLqCEGGQvDjZTgED+FAYmJM34VsI4pt+UmMaTGiA9mTj4Ihzrh9Y
	QIZiNK0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc78J-00000006o0z-45O3;
	Tue, 23 Jun 2026 19:50:07 +0000
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc78G-00000006o0d-3QWL
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 19:50:06 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-695b677095eso146662a12.0
        for <kexec@lists.infradead.org>; Tue, 23 Jun 2026 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782244202; x=1782849002; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zdsj6Guo7r326E75XLxyGx3YlVfMh6UQRvA3w5OPiCM=;
        b=cqkxR1uRy4ybBWhwpfahUwGlUBivctEholF2Mf8Whb8gSiw3WBIh+hXN7mxazAyQ57
         hVxEsNiXxdRXf17hSlvGZ9PI79/yzWnQQEE6kzM+XhrX6G/tjflQobyBIrQOYDoIuUi2
         o9ym1OrpuqC096BRHxhHRs5U7knmxcNxttgyJMuhWTtdbM14DQ64MyQhe5k8ROJmbq4A
         uWt497cWcHK4+b3PtxmrcYok4/bs1B2fGQnNgCJ5vtB6IuRnfIwGTP31Tirql1U77UqY
         SmVkZ2JeEI1PdIRwr66n2EDulp72AJZo9Tl21ZscfirRExEFlQKn/30xmXYuVjXuqLdZ
         urqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782244202; x=1782849002;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdsj6Guo7r326E75XLxyGx3YlVfMh6UQRvA3w5OPiCM=;
        b=I5x5ArlBAneCxwyUC+T++XCGYWX3koMXfqZ9m6dCnHnZBAsAkrLrNCJtNA3Y92sv3a
         iksQewlf4v19gTK9cSGbtDWkWCUMuNbNT6Cpm1Iw9yOC3MYI+pDFXZ5gOyvRiOT4DLkc
         lAlqEHnjBXOCDzCQX8zu01OAalWphyS87l0dZxswYVFC1MmjpjV9r2emaNWYW21IEGi7
         mPtk+UqshcZPqA0rrBhQh0RPjz8IdL2w5kAfUG9qzUtQZT5CPpfx9UljxF5CXFRV6njK
         D0qyViiVxEwXHMNlBQ99sHFppMKXcPNUeBW42wUoPjbGY/FCRN8viCaOXiMK8cmUhXRo
         IE1g==
X-Forwarded-Encrypted: i=1; AFNElJ+DsRGul55IU1B4xpcblpQ2bGRpZNa4FAlfeFmAnZwEBonoG3+o7M/IVtEhrbii+++Nfxx9CA==@lists.infradead.org
X-Gm-Message-State: AOJu0YxSuAvc6HBCb6/LkmSrn7ktTlkjN8TlFnSd4rNykM7Fbvr+KNsq
	jM3ls9VbpzNoq2OpblTgsVyS15T3bxHTo124l6ZLlyEkbtXC0ORFXN5b7EUqtG5WbTgOvq4/L2Y
	R3Lm3/ErSm36ZLFoAWA==
X-Received: from edbbp7.prod.google.com ([2002:a05:6402:1467:b0:692:efc2:c022])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:5253:b0:697:aee0:7a4d with SMTP id 4fb4d7f45d1cf-697dba62033mr2212935a12.6.1782244201867;
 Tue, 23 Jun 2026 12:50:01 -0700 (PDT)
Date: Tue, 23 Jun 2026 19:50:00 +0000
In-Reply-To: <CAEvNRgE2GZNiDg_g6SP_H9CDsDDAnpN7KTRWJEK18wxpTZFJZw@mail.gmail.com>
Mime-Version: 1.0
References: <cover.1780676742.git.tarunsahu@google.com> <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
 <CAEvNRgE2GZNiDg_g6SP_H9CDsDDAnpN7KTRWJEK18wxpTZFJZw@mail.gmail.com>
Message-ID: <9huzldc5m3yv.fsf@tarunix.c.googlers.com>
Subject: Re: [RFC PATCH v2 10/10] selftests: kvm: Add guest_memfd_preservation_test
From: tarunsahu@google.com
To: Ackerley Tng <ackerleytng@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
	fvdl@google.com, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, sagis@google.com, aneesh.kumar@kernel.org, 
	skhawaja@google.com, vipinsh@google.com, Pratyush Yadav <pratyush@kernel.org>, 
	david@redhat.com, dmatlack@google.com, mark.rutland@arm.com, 
	Paolo Bonzini <pbonzini@redhat.com>, Mike Rapoport <rppt@kernel.org>, Alexander Graf <graf@amazon.com>, 
	seanjc@google.com, axelrasmussen@google.com
Cc: linux-kselftest@vger.kernel.org, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_125004_912737_45BB481F 
X-CRM114-Status: GOOD (  40.22  )
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

Ackerley Tng <ackerleytng@google.com> writes:

> Tarun Sahu <tarunsahu@google.com> writes:
>
>> Add a new KVM selftest `guest_memfd_preservation_test` to verify that
>> guest memory backed by guest_memfd is preserved properly.
>>
>
> Don't think using backticks in commit messages is a common practice but
> I might be wrong here.
>
>> The test leverages the Live Update Orchestrator (LUO) infrastructure
>> to validate that memory folios and configuration layouts are
>> successfully saved and then restored during kernel live updates,
>> preventing any memory loss for the guest.
>>
>> Here, I have used the kvm selftests framework by creating a new
>> vm and mapping two memory slots to it. One is the code that is executed
>> inside the vm and other is the guest_memfd whose memory is being
>> written by the guest code.
>>
>
> Don't think commit messages with "I" are common either


Will take care of commit message everywhere as per the guidelines,
Sorry about that.
>
>> In Phase 1: Once data is written the vm exits and wait for the user
>> to trigger the kexec.
>>
>> In Phase 2: A new vm is created with retrieved kvm and again two
>> memory slots are assigned. Once for guest code, and another is for
>> retrieved guest_memfd where guest_memfd memory is verified by the
>> executed guest code. If verification succeeds, The test passes.
>>
>>
>> [...snip...]
>>
>> +#define SESSION_NAME "gmem_vm_preservation_session"
>> +#define VM_TOKEN 0x1001
>> +#define GMEM_TOKEN 0x1002
>> +
>> +#define GMEM_SIZE (16ULL * 1024 * 1024)
>> +#define DATA_SIZE (5ULL * 1024 * 1024)
>> +
>> +static size_t page_size;
>> +
>> +/* Deterministic byte pattern generation based on offset */
>> +static inline uint8_t get_pattern_byte(size_t offset)
>> +{
>> +	return (uint8_t)(offset ^ 0x5A);
>> +}
>> +
>> +static void guest_code_phase1(uint64_t gpa, uint64_t size, uint64_t data_size)
>> +{
>> +	uint8_t *mem = (uint8_t *)gpa;
>> +	size_t i;
>> +
>> +	for (i = 0; i < data_size; i++)
>> +		mem[i] = get_pattern_byte(i);
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void guest_code_phase2(uint64_t gpa, uint64_t size, uint64_t data_size)
>> +{
>> +	uint8_t *mem = (uint8_t *)gpa;
>> +	size_t i;
>> +
>> +	for (i = 0; i < data_size; i++) {
>> +		uint8_t val = get_pattern_byte(i);
>> +
>> +		__GUEST_ASSERT(mem[i] == val,
>> +			       "Data mismatch at offset %lu! Expected 0x%x, got 0x%x",
>> +			       i, val, mem[i]);
>> +	}
>> +
>> +	GUEST_DONE();
>> +}
>> +
>> +static void do_phase1(void)
>> +{
>> +	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
>
> Is there a reason to set GUEST_MEMFD_FLAG_MMAP? We're not really
> accessing that memory from the host in this test.

Right, We can skip it.

>
>> +	int gmem_fd, dev_luo_fd, session_fd, ret;
>> +	const uint64_t gpa = SZ_4G;
>> +	struct kvm_vcpu *vcpu;
>> +	const int slot = 1;
>> +	struct kvm_vm *vm;
>> +
>> +	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
>> +					guest_code_phase1);
>> +	gmem_fd = vm_create_guest_memfd(vm, GMEM_SIZE, flags);
>> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
>> +				 gmem_fd, 0);
>> +
>> +	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
>> +		virt_pg_map(vm, gpa + i, gpa + i);
>> +
>> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
>
> If GMEM_SIZE and DATA_SIZE are static I think we don't have to set those
> as vcpu_args_set(), they can be used as macros from within the guest.

Yes, There are multiple places we can skip it, Like passing them as the
argument in the guest_code_phase1/2. Will update it.

>
>> +
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
>> +
>> +	dev_luo_fd = luo_open_device();
>> +	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
>> +
>> +	session_fd = luo_create_session(dev_luo_fd, SESSION_NAME);
>> +	TEST_ASSERT(session_fd >= 0, "Failed to create LUO session");
>> +
>> +	ret = luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
>> +	TEST_ASSERT(ret == 0, "Failed to preserve VM file descriptor");
>> +
>> +	ret = luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
>> +	TEST_ASSERT(ret == 0, "Failed to preserve guest_memfd file descriptor");
>> +
>
> Thanks for showing how this works :)

Glad to know. it helped.
. .
 v


>
>> +	printf("\n============================================================\n");
>> +	printf("Phase 1 Complete Successfully!\n");
>> +	printf("VM file and guest_memfd file have been preserved via LUO.\n");
>> +	printf("Tokens: VM_TOKEN=0x%x, GMEM_TOKEN=0x%x\n", VM_TOKEN, GMEM_TOKEN);
>> +	printf("Machine Size: %llu MB, Data Size: %llu MB\n", GMEM_SIZE / SZ_1M,
>> +				 DATA_SIZE / SZ_1M);
>> +	printf("------------------------------------------------------------\n");
>> +
>> +	daemonize_and_wait();
>> +}
>> +
>> +static struct kvm_vm *vm_create_from_fd(int resurrected_vm_fd,
>> +					struct vm_shape shape)
>> +{
>> +	struct kvm_vm *vm;
>> +
>> +	vm = calloc(1, sizeof(*vm));
>> +	TEST_ASSERT(vm != NULL, "Insufficient Memory");
>> +
>> +	vm_init_fields(vm, shape);
>
> What would happen if the shape was changed between preserving and
> restoring?
Shape must be consistent across kexec. It may break. struct vm_shape
includes two fields
1. mode: 4k, 16k or 64k mapping, how many page table bit etc.
         which are used to setup mapping with guest code, and memory.
         guest_memfd does not support mapping other than PAGE_SIZE.
2. type: This is userspace side of the vm type. And it will not have
         information about the preserved vm_type via vm_file (kernel).
         If userspace changes this on stage2, some action might not
         work. for example, if userspace is expecting vm_type to be
         COCO VM and preserved vm_type is shared, this will have
         conflict when userspace will try to perform some operation that
         only works with COCO VM.


My Question is: Why should someone change the shape, unless they are
                planning to make the vm fail?

>
>> +
>> +	vm->kvm_fd = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
>> +	vm->fd = resurrected_vm_fd;
>> +
>> +	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
>> +		vm->stats.fd = vm_get_stats_fd(vm);
>> +	else
>> +		vm->stats.fd = -1;
>> +
>> +	vm_init_memory_properties(vm);
>> +
>> +	return vm;
>> +}
>> +
>
> I think vm_create_from_fd() could be introduced in an earlier patch to
> reduce the amount of new code in this patch. Also, I think it could
> perhaps be moved to kvm_util.c assuming that other test will use it too.
>
Makes sense, Will take of it next revision v4.


>> +static void do_phase2(void)
>> +{
>> +	int retrieved_vm_fd, retrieved_gmem_fd, dev_luo_fd, session_fd;
>> +	struct vm_shape shape = VM_SHAPE_DEFAULT;
>> +	const uint64_t gpa = SZ_4G;
>> +	struct kvm_vcpu *vcpu;
>> +	const int slot = 1;
>> +	struct kvm_vm *vm;
>> +
>> +	dev_luo_fd = luo_open_device();
>> +	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
>> +
>> +	session_fd = luo_retrieve_session(dev_luo_fd, SESSION_NAME);
>> +	TEST_ASSERT(session_fd >= 0, "Failed to retrieve LUO session");
>> +
>> +	retrieved_vm_fd = luo_session_retrieve_fd(session_fd, VM_TOKEN);
>> +	TEST_ASSERT(retrieved_vm_fd >= 0, "Failed to retrieve VM file descriptor");
>> +
>> +	retrieved_gmem_fd = luo_session_retrieve_fd(session_fd, GMEM_TOKEN);
>> +	TEST_ASSERT(retrieved_gmem_fd >= 0, "Failed to retrieve guest_memfd file descriptor");
>> +
>> +	vm = vm_create_from_fd(retrieved_vm_fd, shape);
>> +
>> +	u64 nr_pages = 2048; /* 8MB is plenty for slot0 pages */
>> +
>
> I don't think declarations are usually mixed with regular code.
Okay, will udpate that.

>
>> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
>> +	kvm_vm_elf_load(vm, program_invocation_name);
>> +
>> +	for (int i = 0; i < NR_MEM_REGIONS; i++)
>> +		vm->memslots[i] = 0;
>> +
>> +	struct userspace_mem_region *slot0 = memslot2region(vm, 0);
>> +
>> +	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
>> +
>> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
>> +				   retrieved_gmem_fd, 0);
>> +
>> +	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
>> +		virt_pg_map(vm, gpa + i, gpa + i);
>> +
>> +	vcpu = vm_vcpu_add(vm, 0, guest_code_phase2);
>> +	kvm_arch_vm_finalize_vcpus(vm);
>> +
>> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
>> +
>> +	printf("Resuming / Running VM in Phase 2...\n");
>> +	vcpu_run(vcpu);
>> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
>> +
>> +	printf("\nSUCCESS: Phase 2 Complete! All 5MB complex data verified intact!\n");
>> +
>> +	luo_session_finish(session_fd);
>> +	close(session_fd);
>> +	close(dev_luo_fd);
>> +	/* This will also close the vm_fd */
>> +	kvm_vm_free(vm);
>> +	close(retrieved_gmem_fd);
>> +}
>> +
>> +int main(int argc, char *argv[])
>> +{
>> +	bool phase2 = false;
>> +
>> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
>> +	page_size = getpagesize();
>> +
>> +	for (int i = 1; i < argc; i++) {
>> +		if (strcmp(argv[i], "--phase2") == 0)
>> +			phase2 = true;
>> +	}
>> +
>
> Maybe use getopt() here?

In V3, it is update to use liveupdate library.
>
>> +	if (phase2)
>> +		do_phase2();
>> +	else
>> +		do_phase1();
>> +
>> +	return 0;
>> +}
>> --
>> 2.54.0.1032.g2f8565e1d1-goog
>
> I think we also need tests for trying to allocate while frozen, and
> conversion while frozen, and trying to preserve while preservation is
> not allowed.

Yes, We need those tests. For this series, I wanted to focus on design.
Now that we are aligned, next revision, I will send with more tests.

~Tarun

