Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C86C6CD98F2
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nac52aGX3C1Hx+TvqYDuAOPnfxayVFA5kQK+3l4OkYQ=; b=tD/KggNzr9A5wcJ9PS4rcn3JEH
	fK3N4JClO1PUFi5PtHX+A8c+8ExjLe+jkifMiFrs6ZXop2hCWf6RWQJPnLI6LDtuDEBu0Oevrn4j9
	ldtZjZxIf/rSDvPkDesQAB1Jw/QvZ0V1LQVyQR/ob0AwWNVmhKb2U+de56OYUkxFCiZnCq0TT9qYB
	YC/JzP8uIiC9mzUOrwxRbJcGDJu8BHwLgPUvJFMizqfY6/2ryYJ2IW4DwibOagz41/xF1BjNsUScf
	Lz2tW37GyIes+7n3BzwXSjHRYjv7UgzxRLB64fEKhcQNtHH/pqWC8sPd9n/nJLUVWe9TijeD7/fEk
	CsbNhY7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjoN-00000005JuJ-1x6S;
	Mon, 22 Jun 2026 18:55:59 +0000
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjoK-00000005Jth-2q41
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:55:58 +0000
Received: by mail-wm1-x349.google.com with SMTP id 5b1f17b1804b1-490bae3a39bso42816535e9.1
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154555; x=1782759355; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nac52aGX3C1Hx+TvqYDuAOPnfxayVFA5kQK+3l4OkYQ=;
        b=vPSTcW4egVVIcx6xU3oKNoHKHjjrIPp0HZUzKwq9pcW8ymWEoXeEzqx+W1t1+9JlIr
         racRGN2hWh0SMS+w4sFemdg7PiTIGRKsOlM6P+6KuKGov5/9mmUEN8QteU5R3eS7dzBz
         9uUau/1MwMzKkQzv4sBuh0a/ZmI4QC82dFlS4AHFKZxdRc/AtCTOpdzLShpcpgY71lFz
         WmsZLmB0tp4hAt5bch5clcaQAdo3Wi5vcuhJ8qy2Pk63mY1nnGRek8QtmygUboz9nzYw
         CixORd3UUsAKLXND6EA7DSR3t4Fk+K69oz2KF+VvO3jJs8PXDhZ99GTbx2sXD7cecXe+
         VaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154555; x=1782759355;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nac52aGX3C1Hx+TvqYDuAOPnfxayVFA5kQK+3l4OkYQ=;
        b=ZU7DJcv3U/+jduVU37gy28RAZ8qL6f8N/QDdyLaUHun54nz4aoO1te5tA2LwnGo5uC
         LcT6ZJHouqczSvD6bR8UjAIE5KvuZK/yYmnXn9IUsknDakcqhV4uZ3GxpcxpH7cTvbxU
         PzjzyG/pBxkqD62G0iNxUl2Rngx8mIsiw/tbzU/oIH7eKO91wTRbQBLfY4inlN0dEYT8
         6RGirNPMuDgJGm9A5iz77aKwNrF6nFF/0a09LWOV881LWCbTfRJg2JE2pWR9YSdSrpWq
         qKxElWIADOYWIcQ8oz4+eM3AaMn2mG2+ai0y9rocQdSnFrPDVrt2USc7a++s/zewMRP+
         ioCg==
X-Forwarded-Encrypted: i=1; AFNElJ8wDzXAHLm0YZxWZrO0zRbOb8cDGHVMI9gbBfuVHPuCaOEth0RKpCt3au+iaQAIudOljDbm+A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3lJ1z51wyhcc0BEst/HTqVM1su3oR2dn8CEHabNqFPFXM+w/F
	5WK9vv6rY8KEvBvNsHCcEO1zbmKv9DE0woz4MexNYlYvuL1m70icDUWgJZGbsvVdyneTMJQhFI8
	BfEEjzgYnUeW0yOCgKw==
X-Received: from wmbg28.prod.google.com ([2002:a05:600c:a41c:b0:492:413d:b354])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3516:b0:490:c2a2:e91c with SMTP id 5b1f17b1804b1-4924258fbbdmr240564905e9.34.1782154554506;
 Mon, 22 Jun 2026 11:55:54 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:55:53 +0000
In-Reply-To: <20260622184851.2309827-1-tarunsahu@google.com>
Mime-Version: 1.0
References: <20260622184851.2309827-1-tarunsahu@google.com>
Message-ID: <9huzwlvqqu9y.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v3 0/9] liveupdate: kvm: guest_memfd preservation
From: tarunsahu@google.com
To: Jonathan Corbet <corbet@lwn.net>, Mike Rapoport <rppt@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, seanjc@google.com, 
	ackerleytng@google.com, aneesh.kumar@kernel.org, fvdl@google.com, 
	sagis@google.com, david@redhat.com, dmatlack@google.com, mark.rutland@arm.com
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_115556_744181_0C6C25EC 
X-CRM114-Status: GOOD (  20.07  )
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


+ Adding More people to the series (To:) which I missed in my original message.

~Tarun

Tarun Sahu <tarunsahu@google.com> writes:

> Hello,
> This is Non-RFC patch series for guest_memfd preservation. After
> having multiple discussion across hypervisor liveupdate meeting,
> guest_memfd bi-weekly meeting, the design for the basic support of
> guest_memfd preservation is final. This series is going to include
> guest_memfd which are fully shared and does not support private mem
> and backed by PAGE_SIZE pages.
>
> Steps to test:
> 1. Compile Kernel with CONFIG_LIVEUPDATE_GUEST_MEMFD=y
> 2. boot kernel with command line: kho=on liveupdate=on
> 3. run the following kselftest
> 	$ .selftests/kvm/guest_memfd_preservation_test --stage 1
> 	$ <kexec> --reuse-cmdline
> 	$ .selftests/kvm/guest_memfd_preservation_test --stage 2
>
> NOTE: Assert the following:
> 	$ ls /dev/liveupdate
> 	$ ls /dev/kvm
> 	$ dmesg | grep liveupdate # (should have kvm_vm_luo &&
> 		# guest_memfd_luo handler registered)
>
> The changes are rebased on:
> 	kvm/next + liveupdate/next (merge) + [3] + [4] + [5]
> 	Where,
> 	[3]: luo: conversion of serialized_data to KHOSER_PTR
> 	[4]: luo: APIs to retrieve file internally from session
> 	[5]: selftests: liveupdate sefltests library
> Here is the github repo:
> 	https://github.com/tar-unix/linux/tree/gmem-pre
>
> V3 <- RFC V2 [2]
> 1. Finalize the design
> 2. resolve sashiko reported bugs
> 3. Use of KHOSER_PTR instead of raw serialized_data as per [3]
>
> RFC V2 [2] <- RFC V1 [1]
> 1. Removed mem_attr_array as it is not needed for fully-shared
> 2. Removed pre-faulted condition
> 3. Added vm_type preservation for ARM64.
> 4. Removed liveupdate_get_file_incoming api patch as it is sent
>    separately [4] by Samiullah.
>
> [1] https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/
> [2] https://lore.kernel.org/all/c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com/
> [3] https://lore.kernel.org/all/20260622111215.4157974-1-tarunsahu@google.com/
> [4] https://lore.kernel.org/all/20260613012521.835490-1-skhawaja@google.com/
> [5] https://lore.kernel.org/all/20260612214512.464146-1-vipinsh@google.com/
>
> Tarun Sahu (9):
>   liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
>   kvm: Prepare core VM structs and helpers for LUO support
>   kvm: kvm_luo: Allow kvm preservation with LUO
>   kvm: guest_memfd: Move internal definitions and helper to new header
>   kvm: guest_memfd: Add support for freezing and unfreezing mappings
>   kvm: guest_memfd_luo: add support for guest_memfd preservation
>   docs: add documentation for guest_memfd preservation via LUO
>   selftests: kvm: Split ____vm_create() to expose init helpers
>   selftests: kvm: Add guest_memfd_preservation_test
>
>  Documentation/core-api/liveupdate.rst         |   1 +
>  Documentation/liveupdate/vmm.rst              | 107 ++++
>  MAINTAINERS                                   |  14 +
>  include/linux/kho/abi/kvm.h                   | 106 ++++
>  include/linux/kvm_host.h                      |  14 +
>  kernel/liveupdate/Kconfig                     |  15 +
>  tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
>  .../kvm/guest_memfd_preservation_test.c       | 236 +++++++++
>  .../testing/selftests/kvm/include/kvm_util.h  |   2 +
>  tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
>  virt/kvm/Makefile.kvm                         |   1 +
>  virt/kvm/guest_memfd.c                        | 185 +++++--
>  virt/kvm/guest_memfd.h                        |  44 ++
>  virt/kvm/guest_memfd_luo.c                    | 497 ++++++++++++++++++
>  virt/kvm/kvm_luo.c                            | 195 +++++++
>  virt/kvm/kvm_main.c                           |  94 +++-
>  virt/kvm/kvm_mm.h                             |  15 +
>  17 files changed, 1477 insertions(+), 81 deletions(-)
>  create mode 100644 Documentation/liveupdate/vmm.rst
>  create mode 100644 include/linux/kho/abi/kvm.h
>  create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
>  create mode 100644 virt/kvm/guest_memfd.h
>  create mode 100644 virt/kvm/guest_memfd_luo.c
>  create mode 100644 virt/kvm/kvm_luo.c
>
> -- 
> 2.55.0.rc0.786.g65d90a0328-goog

