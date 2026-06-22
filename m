Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58A1CDB476
	for <kexec@archiver.kernel.org>; Mon, 22 Jun 2026 18:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:Mime-Version:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OEWwFi6TggeUgPIb5O1s/aY8eVgW9dSMubR6vHRGBr0=; b=HBpLqs+7bbQmfl+AbORLe7Mzpd
	8/lRQ+oq5g4EacJa0WXh5IHXVCNw93o/VIZZhpea9bQJIT+xHqycIIcZfnqFzGu3IoMA86vpaAR42
	v+Ix53q7qVegpfZyLwDxzbGmWq3fuVqceIZPBatzK81EtJgcdnFzMVVz63A9EJ8auMllPvtPCLYLp
	VPzPB6uyhH8QXcGYxX85cFDSjhMZHh7f1hP3yodTl3u901nGzb+WMZfVBlEfIVFH1srtWB8gV2rrv
	1x/uhfpZ4f/FiwY0MXF59jIbTyrHKyOaYFcr98Er/qaf+2f4sog6hoYwYzk20ux6zuWow9oGG8QFd
	LvOIfOiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhi-00000005JGq-2C9g;
	Mon, 22 Jun 2026 18:49:06 +0000
Received: from mail-wm1-x34a.google.com ([2a00:1450:4864:20::34a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbjhf-00000005JFW-2jjm
	for kexec@lists.infradead.org;
	Mon, 22 Jun 2026 18:49:05 +0000
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-49221de4ed4so30527515e9.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 11:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782154141; x=1782758941; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OEWwFi6TggeUgPIb5O1s/aY8eVgW9dSMubR6vHRGBr0=;
        b=nx9lh4+jgSxlewZUzswNO+sFipQcDAf0jUB16C63Pbv9/oQUe7BnmTogez3GZk1fh8
         lPKeVY6RTCsvSfaCZbn9+ZmpYOZKDIf1Rn5i8OLEZVJ4iQwNLmrJUvpiFw2WIpjqy8Jc
         1VYVhbHdCbO8mR/hKBJc1Jhc9gvIEtq+1NotgEXhzX0LS7VgyH8NrlEvNJaDq+qOqqH2
         4zeAy1ddgk/LPBKJNXmY3T1ezU0pdE3CRKO2k2KFz09yOFcTdP2+pkz6NBZZs8Z1jkS3
         6mrQWhfBkceCfVfq5Ap96stNAOhVEjJeQd3MSasNDg3sRnkE7PJ4XKW/RBl1O4k0ALoN
         vuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782154141; x=1782758941;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OEWwFi6TggeUgPIb5O1s/aY8eVgW9dSMubR6vHRGBr0=;
        b=gxwBDN797IDYPSu5/+i3kncZmtT4CKFS4YRCXkRQVpzgomkBwpLWB1zQOUDTruBqOm
         UPLg9gM9Bm+MsHgOOg5HhwgJpx2sHUed6zJHdp+Nc+vuxYJR5LPp8S3AhAxhQp4IVGuz
         pk+ScJYCfVtlsHStvguts6tGWJuhrGtNKAYfKQLxzQ5xEevUfCvf1nH7IYDXzxFva44I
         Skn1B4A1IFOopMDQCvdt1kSCEFhuQKnVKDE4Q3EXg78+UcahQLtH8E2KEV4kVG+PbHSb
         rQnjRxVHaLseIyea9dJ9QV0gCgrx2VjN8R+xx9nI1Krt6NdPp9D0VpfQ6VkuX+fmX3LH
         yMYw==
X-Forwarded-Encrypted: i=1; AFNElJ/CqUX6OCSo0EVTaaFMNdJvMc+tG5umMUXo1AF8L6kgraqwAPm9etKgf7zCX2qKizOBgkfIzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwMMIwf1xFsRdnsMsgPlY5C2G/2Q1PelZP0xo6qY5T3Jhk0Ihvz
	Yqu0jZVoLEsxuAsOj7BmLnCot+JaK5/LaiH4giizjCh0VmwdQtORJ5wELgrCoylTtrk0m2hI/BB
	bEcpET/VbV1Um1HvpBg==
X-Received: from wmnj21.prod.google.com ([2002:a05:600c:755:b0:492:4a9f:3d5a])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c059:10b0:490:bb45:79da with SMTP id 5b1f17b1804b1-49240e427f0mr195668185e9.13.1782154140754;
 Mon, 22 Jun 2026 11:49:00 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:48:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260622184851.2309827-1-tarunsahu@google.com>
Subject: [PATCH v3 0/9] liveupdate: kvm: guest_memfd preservation
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
X-CRM114-CacheID: sfid-20260622_114903_707773_269E5C37 
X-CRM114-Status: GOOD (  12.43  )
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

Hello,
This is Non-RFC patch series for guest_memfd preservation. After
having multiple discussion across hypervisor liveupdate meeting,
guest_memfd bi-weekly meeting, the design for the basic support of
guest_memfd preservation is final. This series is going to include
guest_memfd which are fully shared and does not support private mem
and backed by PAGE_SIZE pages.

Steps to test:
1. Compile Kernel with CONFIG_LIVEUPDATE_GUEST_MEMFD=y
2. boot kernel with command line: kho=on liveupdate=on
3. run the following kselftest
	$ .selftests/kvm/guest_memfd_preservation_test --stage 1
	$ <kexec> --reuse-cmdline
	$ .selftests/kvm/guest_memfd_preservation_test --stage 2

NOTE: Assert the following:
	$ ls /dev/liveupdate
	$ ls /dev/kvm
	$ dmesg | grep liveupdate # (should have kvm_vm_luo &&
		# guest_memfd_luo handler registered)

The changes are rebased on:
	kvm/next + liveupdate/next (merge) + [3] + [4] + [5]
	Where,
	[3]: luo: conversion of serialized_data to KHOSER_PTR
	[4]: luo: APIs to retrieve file internally from session
	[5]: selftests: liveupdate sefltests library
Here is the github repo:
	https://github.com/tar-unix/linux/tree/gmem-pre

V3 <- RFC V2 [2]
1. Finalize the design
2. resolve sashiko reported bugs
3. Use of KHOSER_PTR instead of raw serialized_data as per [3]

RFC V2 [2] <- RFC V1 [1]
1. Removed mem_attr_array as it is not needed for fully-shared
2. Removed pre-faulted condition
3. Added vm_type preservation for ARM64.
4. Removed liveupdate_get_file_incoming api patch as it is sent
   separately [4] by Samiullah.

[1] https://lore.kernel.org/all/cover.1779080766.git.tarunsahu@google.com/
[2] https://lore.kernel.org/all/c054ba0fb2639932bbe354420d3f4f84cce84905.1780676742.git.tarunsahu@google.com/
[3] https://lore.kernel.org/all/20260622111215.4157974-1-tarunsahu@google.com/
[4] https://lore.kernel.org/all/20260613012521.835490-1-skhawaja@google.com/
[5] https://lore.kernel.org/all/20260612214512.464146-1-vipinsh@google.com/

Tarun Sahu (9):
  liveupdate: Add LIVEUPDATE_GUEST_MEMFD config option
  kvm: Prepare core VM structs and helpers for LUO support
  kvm: kvm_luo: Allow kvm preservation with LUO
  kvm: guest_memfd: Move internal definitions and helper to new header
  kvm: guest_memfd: Add support for freezing and unfreezing mappings
  kvm: guest_memfd_luo: add support for guest_memfd preservation
  docs: add documentation for guest_memfd preservation via LUO
  selftests: kvm: Split ____vm_create() to expose init helpers
  selftests: kvm: Add guest_memfd_preservation_test

 Documentation/core-api/liveupdate.rst         |   1 +
 Documentation/liveupdate/vmm.rst              | 107 ++++
 MAINTAINERS                                   |  14 +
 include/linux/kho/abi/kvm.h                   | 106 ++++
 include/linux/kvm_host.h                      |  14 +
 kernel/liveupdate/Kconfig                     |  15 +
 tools/testing/selftests/kvm/Makefile.kvm      |   6 +-
 .../kvm/guest_memfd_preservation_test.c       | 236 +++++++++
 .../testing/selftests/kvm/include/kvm_util.h  |   2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  26 +-
 virt/kvm/Makefile.kvm                         |   1 +
 virt/kvm/guest_memfd.c                        | 185 +++++--
 virt/kvm/guest_memfd.h                        |  44 ++
 virt/kvm/guest_memfd_luo.c                    | 497 ++++++++++++++++++
 virt/kvm/kvm_luo.c                            | 195 +++++++
 virt/kvm/kvm_main.c                           |  94 +++-
 virt/kvm/kvm_mm.h                             |  15 +
 17 files changed, 1477 insertions(+), 81 deletions(-)
 create mode 100644 Documentation/liveupdate/vmm.rst
 create mode 100644 include/linux/kho/abi/kvm.h
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_preservation_test.c
 create mode 100644 virt/kvm/guest_memfd.h
 create mode 100644 virt/kvm/guest_memfd_luo.c
 create mode 100644 virt/kvm/kvm_luo.c

-- 
2.55.0.rc0.786.g65d90a0328-goog


