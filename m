Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040CBCDB471
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 23:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:MIME-Version:References:In-Reply-To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Se78T3ehOJrnIX6EVHqhbA3McVgxD20iSWZ28XYCDdw=; b=q1ntnGwuKWpdxw77oxSzEnnC/N
	Jc3b5z+wdvwL2ztP8mIPk9Sbnmxi7BKK3cdInhHQIuXHNsK1uFIQrF/SWPnxieJK8iiRvxbYR/d2u
	N/xeBjGVVniaWiblNrR0XB8qE3TFmrJtqVGaYPyXWjv/aRs1AjbJ5bCgv3kUbiZzwv7ZeqGTQXpxD
	xVe4GmbZrA8H/+MpmLvuy/haUAUB9qkPlmvN3uGUB20UbX6NsEw4KUHHZQT5fCDTjZ1WdaUyZhNLG
	ft7iNjRYHpfYDxTqEsxfPwfK1qvufqw8Fuo2hEOh59ulkX9FGpU9sBKnPDNPvdv/PfDCRckoISdUj
	zS9oHJQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbne6-00000005SNY-2RwD;
	Mon, 22 Jun 2026 23:01:38 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbne4-00000005SN3-0SQd
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 23:01:37 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1384eb94d20so11946115c88.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 16:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782169294; cv=none;
        d=google.com; s=arc-20240605;
        b=SNEWF2lVBQ4349DhKNck02diLG8UeR+iBnTjhGTtr4FBNo0Fk+pCcOFH4snyK8EcnM
         g5zBl21tx6fjbLihLOod6nDQ4KL6ohLdBWpQOmauye5pd5txw/j5Km20GRaWO6UDFoYZ
         p6QWuYDnqYO0aNMIVCvuiU2GQ0a5BESgSmDq8qQNVuUVuE6/dqTAxEFtJAauHxgRaqLS
         PuqtuIMxIMD3a07BpIifvKeKp7wo1DPuajActexIQZI3ZhTUTBFCpprHurYN1IWPtPgU
         4v+cNHbGHDEC/F13rRJNXNppaHBsxGW1MnculS5AzEtRE9HZr0g7Io92vIPIEPmw+E8Y
         lumg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=Se78T3ehOJrnIX6EVHqhbA3McVgxD20iSWZ28XYCDdw=;
        fh=Irw+Swl6NWQu10fo03eMYQAMN+xcCtZCm/t+QTSz6sk=;
        b=PPIv7EAS0Lmp0DWj/7Lm+wlsmRNq1vvQUH8bKdHPyHuvRlZBnlxhwYuG7m7jLeMfy3
         SNIBVsnlboX+Yn4dxH3ixopQNidgrRiqoFMAo5LNlnBvt/TE7xsREGsT0TsINVkjxWRh
         y37/N0HqE0tIQ2hCTJryy2DRxZbBZfL/+ZXS4YEoI3u6eRu7vFe+w0GW8wLcTHC8PDxa
         CoPRUla9jL7xCt0gr+istGikfgzIWHL55aqi1mKwim9df8lMeAz9UPDcanuqNpunTTA8
         Lkb7/7WFQ7hm84FDApGx4K3U5+gtlufCTD5nd07v/fWxFnE1lf55AhkkLJJMFz/Nclg1
         ZJqw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782169294; x=1782774094; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Se78T3ehOJrnIX6EVHqhbA3McVgxD20iSWZ28XYCDdw=;
        b=vAfEsxk1Oc6GOvcujU3jPSkuxC8MCkyFGeIGCel97CK8izRQr8GRfGP/okRK0qLkL5
         AIT4XcGuv5wexADFdpDDdckfsBTuKqd96guQmJ2Um0BgBt/OB6bhRyXIiD3YwNQI+2YW
         y9p76mwiMDHJuT3hu2OC4BZWBpRotBY2+qVMoE8NS8mZHoXCoEfDoe0LnJZ0/9iDTBgM
         li+wbvsi/9CqEPzyqGyblNmmSMVfN/qb+rAoSDpSnbQimYeY0Fn1IIKjFLnxmzpaHji8
         /otW9i31/HER4iZam6bHZGLbrUX3Kl7SjlJTmN27aFkNnwfG9JZsrf4+rn1NlX1UHVN1
         myyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169294; x=1782774094;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Se78T3ehOJrnIX6EVHqhbA3McVgxD20iSWZ28XYCDdw=;
        b=e7V87J0UN4kz/fETGNrVf6j+kywLLvbMwiwH+hse1hfqKKcbfL4lp9zjkZukZs7Hlm
         cmTpVZTEg4pnQ68tk9wO4M2Kwy4eHY0+Z3g94P6auDBfUEo4OwI5adBzHB1DcTyKBKyk
         2/eMq2C8zL79Ev4UuSFMEoiSoPyx9eX0SVoJsS3JlFWn/pxDuc9rqK0d7+k/03DEOU0/
         5C5G/iNfNPzedSSpPDofXJ4/3JpIGolDVXcrPp58Y0RRa6gcYqd2ol1EIKnD63KPfxqU
         iCHCwH7CL/V+Esx8aiLL9gnwhiyAweCbgTwU382cS2E+8WD4L1C4QiUS+Uo3aHHEPlPl
         j3kA==
X-Forwarded-Encrypted: i=1; AFNElJ9BKx0XHs/FEwNmUzQSTGfH7wc890VhO/M9B8QaBpZ+/QsGxlckSbaW12I2mCia46PjLOwJMA==@lists.infradead.org
X-Gm-Message-State: AOJu0YwHlnwLn1pRb2/tzNTwajbtM0VTggYyrDz70Dqe00cBOIoBZxQS
	yZva7fm/fAOM09n6hbSFXYyxpbJ/iD2XJ5k5gsJnJlyLh565Njk92zmlwd7FD6yT05APhi4/Ksm
	2szt6oKTE1qWWMrkk6QQ28No1gfmAKiEZAEXMmzFG
X-Gm-Gg: AfdE7cmBVXbupZUzFux9U1u2rcA8CYA6MH21li203TA8JkFYqEtuie56CC3ZG5mIOGR
	pSGm8A/TAwCSpZV9lADYU4UkooZESi9ix825k7rG6VlbpsDNf6oqog/4chX37YdMd53lxGgak0s
	uwGW+QBV7K1MgWYDZjOa/W/ideNC9OXpVYlsMOMVwgx5BkCTvjRGd5Hxowz03oWYQ9FwZJKWDBF
	XnQtWGI1CajO9AuftR/eT7dOx8aT48SnW20zDRbfyTX6PCCqGQAt09XMK8QxOhUBN0FbEB2mAZK
	YhUSLKVD4gUo9fULu4im55pT1EbfdCaAo1jgF2z7iCR7w44ox7Y4GBvhr1I=
X-Received: by 2002:a05:7022:78c:b0:137:938a:1044 with SMTP id
 a92af1059eb24-139a216738cmr11302655c88.33.1782169292599; Mon, 22 Jun 2026
 16:01:32 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:01:31 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Jun 2026 16:01:31 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
References: <cover.1780676742.git.tarunsahu@google.com> <deb20fbe3584a8c6bfda276447fe464c6553737d.1780676742.git.tarunsahu@google.com>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:01:31 -0700
X-Gm-Features: AVVi8Cfmvsh-tLhJUbMrgpAzFVY6IGOEzbMnkY3GArVYdQhVqbDKG-2CuMgaTr4
Message-ID: <CAEvNRgE2GZNiDg_g6SP_H9CDsDDAnpN7KTRWJEK18wxpTZFJZw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/10] selftests: kvm: Add guest_memfd_preservation_test
To: Tarun Sahu <tarunsahu@google.com>, Jonathan Corbet <corbet@lwn.net>, vannapurve@google.com, 
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
X-CRM114-CacheID: sfid-20260622_160136_162145_D0C028FF 
X-CRM114-Status: GOOD (  31.72  )
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

Tarun Sahu <tarunsahu@google.com> writes:

> Add a new KVM selftest `guest_memfd_preservation_test` to verify that
> guest memory backed by guest_memfd is preserved properly.
>

Don't think using backticks in commit messages is a common practice but
I might be wrong here.

> The test leverages the Live Update Orchestrator (LUO) infrastructure
> to validate that memory folios and configuration layouts are
> successfully saved and then restored during kernel live updates,
> preventing any memory loss for the guest.
>
> Here, I have used the kvm selftests framework by creating a new
> vm and mapping two memory slots to it. One is the code that is executed
> inside the vm and other is the guest_memfd whose memory is being
> written by the guest code.
>

Don't think commit messages with "I" are common either

> In Phase 1: Once data is written the vm exits and wait for the user
> to trigger the kexec.
>
> In Phase 2: A new vm is created with retrieved kvm and again two
> memory slots are assigned. Once for guest code, and another is for
> retrieved guest_memfd where guest_memfd memory is verified by the
> executed guest code. If verification succeeds, The test passes.
>
>
> [...snip...]
>
> +#define SESSION_NAME "gmem_vm_preservation_session"
> +#define VM_TOKEN 0x1001
> +#define GMEM_TOKEN 0x1002
> +
> +#define GMEM_SIZE (16ULL * 1024 * 1024)
> +#define DATA_SIZE (5ULL * 1024 * 1024)
> +
> +static size_t page_size;
> +
> +/* Deterministic byte pattern generation based on offset */
> +static inline uint8_t get_pattern_byte(size_t offset)
> +{
> +	return (uint8_t)(offset ^ 0x5A);
> +}
> +
> +static void guest_code_phase1(uint64_t gpa, uint64_t size, uint64_t data_size)
> +{
> +	uint8_t *mem = (uint8_t *)gpa;
> +	size_t i;
> +
> +	for (i = 0; i < data_size; i++)
> +		mem[i] = get_pattern_byte(i);
> +
> +	GUEST_DONE();
> +}
> +
> +static void guest_code_phase2(uint64_t gpa, uint64_t size, uint64_t data_size)
> +{
> +	uint8_t *mem = (uint8_t *)gpa;
> +	size_t i;
> +
> +	for (i = 0; i < data_size; i++) {
> +		uint8_t val = get_pattern_byte(i);
> +
> +		__GUEST_ASSERT(mem[i] == val,
> +			       "Data mismatch at offset %lu! Expected 0x%x, got 0x%x",
> +			       i, val, mem[i]);
> +	}
> +
> +	GUEST_DONE();
> +}
> +
> +static void do_phase1(void)
> +{
> +	uint64_t flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;

Is there a reason to set GUEST_MEMFD_FLAG_MMAP? We're not really
accessing that memory from the host in this test.

> +	int gmem_fd, dev_luo_fd, session_fd, ret;
> +	const uint64_t gpa = SZ_4G;
> +	struct kvm_vcpu *vcpu;
> +	const int slot = 1;
> +	struct kvm_vm *vm;
> +
> +	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1,
> +					guest_code_phase1);
> +	gmem_fd = vm_create_guest_memfd(vm, GMEM_SIZE, flags);
> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
> +				 gmem_fd, 0);
> +
> +	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
> +		virt_pg_map(vm, gpa + i, gpa + i);
> +
> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);

If GMEM_SIZE and DATA_SIZE are static I think we don't have to set those
as vcpu_args_set(), they can be used as macros from within the guest.

> +
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
> +
> +	dev_luo_fd = luo_open_device();
> +	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
> +
> +	session_fd = luo_create_session(dev_luo_fd, SESSION_NAME);
> +	TEST_ASSERT(session_fd >= 0, "Failed to create LUO session");
> +
> +	ret = luo_session_preserve_fd(session_fd, vm->fd, VM_TOKEN);
> +	TEST_ASSERT(ret == 0, "Failed to preserve VM file descriptor");
> +
> +	ret = luo_session_preserve_fd(session_fd, gmem_fd, GMEM_TOKEN);
> +	TEST_ASSERT(ret == 0, "Failed to preserve guest_memfd file descriptor");
> +

Thanks for showing how this works :)

> +	printf("\n============================================================\n");
> +	printf("Phase 1 Complete Successfully!\n");
> +	printf("VM file and guest_memfd file have been preserved via LUO.\n");
> +	printf("Tokens: VM_TOKEN=0x%x, GMEM_TOKEN=0x%x\n", VM_TOKEN, GMEM_TOKEN);
> +	printf("Machine Size: %llu MB, Data Size: %llu MB\n", GMEM_SIZE / SZ_1M,
> +				 DATA_SIZE / SZ_1M);
> +	printf("------------------------------------------------------------\n");
> +
> +	daemonize_and_wait();
> +}
> +
> +static struct kvm_vm *vm_create_from_fd(int resurrected_vm_fd,
> +					struct vm_shape shape)
> +{
> +	struct kvm_vm *vm;
> +
> +	vm = calloc(1, sizeof(*vm));
> +	TEST_ASSERT(vm != NULL, "Insufficient Memory");
> +
> +	vm_init_fields(vm, shape);

What would happen if the shape was changed between preserving and
restoring?

> +
> +	vm->kvm_fd = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
> +	vm->fd = resurrected_vm_fd;
> +
> +	if (kvm_has_cap(KVM_CAP_BINARY_STATS_FD))
> +		vm->stats.fd = vm_get_stats_fd(vm);
> +	else
> +		vm->stats.fd = -1;
> +
> +	vm_init_memory_properties(vm);
> +
> +	return vm;
> +}
> +

I think vm_create_from_fd() could be introduced in an earlier patch to
reduce the amount of new code in this patch. Also, I think it could
perhaps be moved to kvm_util.c assuming that other test will use it too.

> +static void do_phase2(void)
> +{
> +	int retrieved_vm_fd, retrieved_gmem_fd, dev_luo_fd, session_fd;
> +	struct vm_shape shape = VM_SHAPE_DEFAULT;
> +	const uint64_t gpa = SZ_4G;
> +	struct kvm_vcpu *vcpu;
> +	const int slot = 1;
> +	struct kvm_vm *vm;
> +
> +	dev_luo_fd = luo_open_device();
> +	TEST_ASSERT(dev_luo_fd >= 0, "Failed to open /dev/liveupdate");
> +
> +	session_fd = luo_retrieve_session(dev_luo_fd, SESSION_NAME);
> +	TEST_ASSERT(session_fd >= 0, "Failed to retrieve LUO session");
> +
> +	retrieved_vm_fd = luo_session_retrieve_fd(session_fd, VM_TOKEN);
> +	TEST_ASSERT(retrieved_vm_fd >= 0, "Failed to retrieve VM file descriptor");
> +
> +	retrieved_gmem_fd = luo_session_retrieve_fd(session_fd, GMEM_TOKEN);
> +	TEST_ASSERT(retrieved_gmem_fd >= 0, "Failed to retrieve guest_memfd file descriptor");
> +
> +	vm = vm_create_from_fd(retrieved_vm_fd, shape);
> +
> +	u64 nr_pages = 2048; /* 8MB is plenty for slot0 pages */
> +

I don't think declarations are usually mixed with regular code.

> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, 0);
> +	kvm_vm_elf_load(vm, program_invocation_name);
> +
> +	for (int i = 0; i < NR_MEM_REGIONS; i++)
> +		vm->memslots[i] = 0;
> +
> +	struct userspace_mem_region *slot0 = memslot2region(vm, 0);
> +
> +	ucall_init(vm, slot0->region.guest_phys_addr + slot0->region.memory_size);
> +
> +	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, GMEM_SIZE, NULL,
> +				   retrieved_gmem_fd, 0);
> +
> +	for (size_t i = 0; i < GMEM_SIZE; i += page_size)
> +		virt_pg_map(vm, gpa + i, gpa + i);
> +
> +	vcpu = vm_vcpu_add(vm, 0, guest_code_phase2);
> +	kvm_arch_vm_finalize_vcpus(vm);
> +
> +	vcpu_args_set(vcpu, 3, gpa, GMEM_SIZE, DATA_SIZE);
> +
> +	printf("Resuming / Running VM in Phase 2...\n");
> +	vcpu_run(vcpu);
> +	TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
> +
> +	printf("\nSUCCESS: Phase 2 Complete! All 5MB complex data verified intact!\n");
> +
> +	luo_session_finish(session_fd);
> +	close(session_fd);
> +	close(dev_luo_fd);
> +	/* This will also close the vm_fd */
> +	kvm_vm_free(vm);
> +	close(retrieved_gmem_fd);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	bool phase2 = false;
> +
> +	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
> +	page_size = getpagesize();
> +
> +	for (int i = 1; i < argc; i++) {
> +		if (strcmp(argv[i], "--phase2") == 0)
> +			phase2 = true;
> +	}
> +

Maybe use getopt() here?

> +	if (phase2)
> +		do_phase2();
> +	else
> +		do_phase1();
> +
> +	return 0;
> +}
> --
> 2.54.0.1032.g2f8565e1d1-goog

I think we also need tests for trying to allocate while frozen, and
conversion while frozen, and trying to preserve while preservation is
not allowed.

