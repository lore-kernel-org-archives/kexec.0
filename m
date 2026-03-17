Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C72FED9E5
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 15:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6DaAAL2lwqSYKjJwVOhIjCPGM3/76LaqZquRa7EmSOE=; b=glEvieMdOAmrrFOWdFPVy1/cA1
	5LYPyyBztzekhbEGEaKiSyaixSD+AUb0bKZFTJqO9VZrySeYmI5el1C9NV1ED9FjVhPhbQHV06OFU
	uKciFc4uT+529hkqnEKHL178XVA0fa5T7MYUkHJu9ETG7koifl0CbN0H5xwNpILJ0FWy+pde+PVWo
	DsDRLr4DxRHulUwpac8jDAURyBRyhRkHdKoG3LCgA9mt5vxDmzLWt/n+QF1KvMeC4+sWGdLnlBggu
	5XgV+cHhUqTWi36L0yWbUzVZvg4e6GRuk/Y0Tk/hcPIIYZWmOQYqWN4RdUz1/+kZa8WCEKBbf9/Fh
	g1BJ8yBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2Y-00000006grr-3WwO;
	Tue, 17 Mar 2026 15:09:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2W2U-00000006gp6-1bJR
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 15:09:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773760136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6DaAAL2lwqSYKjJwVOhIjCPGM3/76LaqZquRa7EmSOE=;
	b=Z9dxwomzvsOIyfnls1+aU04WdBMv4exdDT6ZEp89bZ038QpLPkOLX9wOiwMKrsDi+MWXoR
	1YG9ccpOFwgFVQYMLsa9hReJTLvB/V8h78LBmYwKS02g1vc4f8DdFr/gCFT/EqoLcSkIrD
	MoP5u5SEb9i4M0732pBMWzIk3b+JZ/Y=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-ati15xLBNA-hoTN4MGaAtQ-1; Tue, 17 Mar 2026 11:08:54 -0400
X-MC-Unique: ati15xLBNA-hoTN4MGaAtQ-1
X-Mimecast-MFC-AGG-ID: ati15xLBNA-hoTN4MGaAtQ_1773760133
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829fe177bbbso2952029b3a.1
        for <kexec@lists.infradead.org>; Tue, 17 Mar 2026 08:08:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773760133; x=1774364933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6DaAAL2lwqSYKjJwVOhIjCPGM3/76LaqZquRa7EmSOE=;
        b=rOoBfN5LZlu+xvgoiNw0vWOniMP5/JVoMB+98ApIw6ZxKWHbSmzcewgix/wG9Vorr/
         T1AoZpv6rTM29eFueTTlVZig+EyIknsjXrmm4PRqhgk4K43l8w87opx3Y5c2EQfmtLb1
         zYcpHmug3VhGNg0uDpOm2A61D9emlQBxoGYztQMvlwZTH+uCBl4Am2kQg/zpLsPMK0w3
         0s/xkiV5kWD27hBe33imDdl+B+D73SjxPihuW+wHdUA6rjas7FV44kCrgq64dW03QZ4R
         JEsE4pIaU7e0hRJLc65YIlhs7R4RmzqRqqiSYj/TTeQohKlKZtBR9Wr+f0JNc2tLFJu3
         Rzjg==
X-Forwarded-Encrypted: i=1; AJvYcCVhOg2Wk7QqFMZEHSzXtgH56zytA0zybK5ZqTLxsIxNkL6J/RY8CUGqx1ZZb645Rg8NtjC3CA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdEPOEfqZjrq9aUVaFoHffQ3W9lnUuGeLZe06tTEbAaC1XphVb
	+t41+u1FV19nmvbZ71/8BIgc6rCy7tmotrBQMLSc8i5ndu4hIQxSj3WgbthTkeGfLcMYjozmQFD
	WYkkE9r+AhOtUAyFhvrfNXmkkdev3GPgnom+1WQFHKox65bgGCw5A5VCwGz8jqurB8hAzJg==
X-Gm-Gg: ATEYQzxq00iqt9JOUJjOPizadoh30rAOXGfNoy7J6u0ClOP1Y3Zo/PQ8M4CQ+YutvG7
	VY1u0GMsplWxl1fTSgSLBWjenYSRUkLUxfE+UQ/RTkyXgCS2Sd+qbh9iPNQnDuUVZAkUREey9YJ
	YQ31M4ZOEam3rYu9P7jF1G+HxFuhndPk7W2BTIAcH9DnvqA7RNkdLPICKnGLjApZiT2b0q8sMnE
	HUYqJTa7JZ0SFuVe+XM6c/QBe3Wk8Mdqd2z1Z0ZTOoi5WLl6+8YNqyYq7F0Vna31ec6+lZKYt82
	5VEin0dgIHYJAbDGVdN65TZ+BJKrJeJcirqwpR/BFzMbX5woCo80Yklrksg5p09pFEqtXZx3TxV
	hpoEPyBNHf93ddAEKaoXPmQujJtl/mQPoJA==
X-Received: by 2002:a05:6a00:9081:b0:827:4372:dd1f with SMTP id d2e1a72fcca58-82a198ef681mr14832152b3a.41.1773760132399;
        Tue, 17 Mar 2026 08:08:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:9081:b0:827:4372:dd1f with SMTP id d2e1a72fcca58-82a198ef681mr14832109b3a.41.1773760131797;
        Tue, 17 Mar 2026 08:08:51 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07340417sm16993404b3a.39.2026.03.17.08.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 08:08:51 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v4][makedumpfile 0/7] btf/kallsyms based makedumpfile extension for mm page filtering
Date: Wed, 18 Mar 2026 04:07:36 +1300
Message-ID: <20260317150743.69590-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -UmRATogWDLk_H2KNaSY_uWuu_fZJde56bJ_hC0EuO8_1773760133
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_080858_492252_10777B21 
X-CRM114-Status: GOOD (  18.56  )
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

A) This patchset will introduce the following features to makedumpfile:

  1) Add .so extension support to makedumpfile
  2) Enable btf and kallsyms for symbol type and address resolving.

B) The purpose of the features are:

  1) Currently makedumpfile filters mm pages based on page flags, because flags
     can help to determine one page's usage. But this page-flag-checking method
     lacks of flexibility in certain cases, e.g. if we want to filter those mm
     pages occupied by GPU during vmcore dumping due to:

     a) GPU may be taking a large memory and contains sensitive data;
     b) GPU mm pages have no relations to kernel crash and useless for vmcore
        analysis.

     But there is no GPU mm page specific flags, and apparently we don't need
     to create one just for kdump use. A programmable filtering tool is more
     suitable for such cases. In addition, different GPU vendors may use
     different ways for mm pages allocating, programmable filtering is better
     than hard coding these GPU specific logics into makedumpfile in this case.

  2) Currently makedumpfile already contains a programmable filtering tool, aka
     eppic script, which allows user to write customized code for data erasing.
     However it has the following drawbacks:

     a) cannot do mm page filtering.
     b) need to access to debuginfo of both kernel and modules, which is not
        applicable in the 2nd kernel.
     c) eppic library has memory leaks which are not all resolved [1]. This
        is not acceptable in 2nd kernel.

     makedumpfile need to resolve the dwarf data from debuginfo, to get symbols
     types and addresses. In recent kernel there are dwarf alternatives such
     as btf/kallsyms which can be used for this purpose. And btf/kallsyms info
     are already packed within vmcore, so we can use it directly.

  With these, this patchset introduces makedumpfile extensions, which is based
  on btf/kallsyms symbol resolving, and is programmable for mm page filtering.
  The following section shows its usage and performance, please note the tests
  are performed in 1st kernel.

  3) Compile and run makedumpfile extensions:

  $ make LINKTYPE=dynamic USELZO=on USESNAPPY=on USEZSTD=on
  $ make extensions
  
  $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/extension.out --extension amdgpu_filter.so
    Loaded extension: ./extensions/amdgpu_filter.so
    makedumpfile Completed.
	User time (seconds): 5.08
	System time (seconds): 0.84
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
        Maximum resident set size (kbytes): 17360
        ...
 
     To contrast with eppic script of v2 [2]:

  $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c   
    makedumpfile Completed.
        User time (seconds): 8.23
        System time (seconds): 0.88
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
        Maximum resident set size (kbytes): 57128
        ...

  -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
  -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
  -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025-06-10-18:03:12/vmcore

C) Discussion:

  1) GPU types: Currently only tested with amdgpu's mm page filtering, others
     are not tested.
  2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc64.
     Others are not tested.

D) Testing:

     If you don't want to create your vmcore, you can find a vmcore which I
     created with amdgpu mm pages unfiltered [3], the amdgpu mm pages are
     allocated by program [4]. You can use the vmcore in 1st kernel to filter
     the amdgpu mm pages by the previous performance testing cmdline. To
     verify the pages are filtered in crash:

     Unfiltered:
     crash> search -c "!QAZXSW@#EDC"
     ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
     crash> rd ffff96b7fa800000
     ffff96b7fa800000:  405753585a415121                    !QAZXSW@
     crash> rd ffff96b87c800000
     ffff96b87c800000:  405753585a415121                    !QAZXSW@

     Filtered:
     crash> search -c "!QAZXSW@#EDC"
     crash> rd ffff96b7fa800000
     rd: page excluded: kernel virtual address: ffff96b7fa800000  type: "64-bit KVADDR"
     crash> rd ffff96b87c800000
     rd: page excluded: kernel virtual address: ffff96b87c800000  type: "64-bit KVADDR"

[1]: https://github.com/lucchouina/eppic/pull/32
[2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
[3]: https://people.redhat.com/~ltao/core/vmcore
[4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df

v4 -> v3:

1) Get rid of all hash table usage. So only required syms/types info
   will be stored, rather than install all kernel's syms/types. To do this,
   special elf sections as .init_ksyms/ktypes are used for the required info
   declaration/storage.

2) Support extension callback for makedumpfile, so during mm page
   filtering, extension can help to decide if keep/discard the page. 

3) The patches are organized as follows:

    --- <only for test purpose, don't merge> ---
    7. Filter amdgpu mm pages

    --- <code should be merged> ---
    6. Add makedumpfile extensions support
    5. Implement kernel module's btf resolving
    4. Implement kernel module's kallsyms resolving
    3. Implement kernel btf resolving
    2. Implement kernel kallsyms resolving
    1. Reserve sections for makedumpfile and extenions

    Patch 7 is customization specific, which can be maintained separately.  
    Patch 1 ~ 6 are common code which should be integrate with makedumpfile.

Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@redhat.com/
Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/

Tao Liu (7):
  Reserve sections for makedumpfile and extenions
  Implement kernel kallsyms resolving
  Implement kernel btf resolving
  Implement kernel module's kallsyms resolving
  Implement kernel module's btf resolving
  Add makedumpfile extensions support
  Filter amdgpu mm pages

 Makefile                   |  11 +-
 btf_info.c                 | 345 +++++++++++++++++++++++++++
 btf_info.h                 |  92 ++++++++
 extension.c                | 300 +++++++++++++++++++++++
 extension.h                |  12 +
 extensions/Makefile        |  12 +
 extensions/amdgpu_filter.c | 190 +++++++++++++++
 extensions/maple_tree.c    | 307 ++++++++++++++++++++++++
 extensions/maple_tree.h    |   6 +
 kallsyms.c                 | 473 +++++++++++++++++++++++++++++++++++++
 kallsyms.h                 |  94 ++++++++
 makedumpfile.c             |  41 +++-
 makedumpfile.h             |  13 +
 makedumpfile.ld            |  15 ++
 14 files changed, 1903 insertions(+), 8 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h
 create mode 100644 extension.c
 create mode 100644 extension.h
 create mode 100644 extensions/Makefile
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h
 create mode 100644 makedumpfile.ld

-- 
2.47.0


