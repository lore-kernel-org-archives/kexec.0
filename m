Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F374CD98EE
	for <kexec@archiver.kernel.org>; Wed, 17 Jun 2026 05:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wl/b1H6lyqT+eJVtBXSh9FlKcpFv/tWHhPfCuy8ZBfA=; b=rylIHd3DHryMhsrvrT/StswiQ6
	PQpD0mjywtVY6vJniaImKaPzZ5WWaiqv9CT/Efo8NWQSan1QuHbdhuKPMdaP00LB8VCweLc+yOO6J
	fsI+74cp54Xn9COMhfbo+5uwcESM9vNZBeI4tW1oe58S9oDJPSr+9nfYHAbI3tq1riBOS5uHLIaDk
	ByAzDr0GYAVe3bSYMDZ8oQYowVEOV9KQLsuP5djKPViknYSWO3c9Ei5HwsMkEK0M7kjdf+fuZdlej
	vNiJcLQ8+zGRDenM8JKa0nr0Wh39qVETe6QpZwYKsO0AR9U/PqL/yxuGTYREzneavyEMkFeK4irAL
	+wR8BJSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZihB-0000000GdwG-3iBY;
	Wed, 17 Jun 2026 05:20:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZih8-0000000GdvZ-2pyz
	for kexec@lists.infradead.org;
	Wed, 17 Jun 2026 05:20:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781673609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wl/b1H6lyqT+eJVtBXSh9FlKcpFv/tWHhPfCuy8ZBfA=;
	b=K6OUEqeKs/fw3h0S6wjiHG+mHf5w47tW8KRrZLdw3gvft1MGQw2JeoNdj5TiuRU18i4zMT
	3mPYhLn4+/2Lx6VC/K3dGV0VsGEuybnehLzpk1UQkUcsjU9ywdDCLu9NcevupyJzmtFZ+2
	6uJ10y3Xf6jkoA4sslTeZMiht6hX5Pc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-46FR5XiYNzaNTE4soPJSvA-1; Wed, 17 Jun 2026 01:20:07 -0400
X-MC-Unique: 46FR5XiYNzaNTE4soPJSvA-1
X-Mimecast-MFC-AGG-ID: 46FR5XiYNzaNTE4soPJSvA_1781673606
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8604fbe71eso7068401a12.3
        for <kexec@lists.infradead.org>; Tue, 16 Jun 2026 22:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781673606; x=1782278406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wl/b1H6lyqT+eJVtBXSh9FlKcpFv/tWHhPfCuy8ZBfA=;
        b=epRihxjiRzIagvP0FzkeZR1y9vg6PQSuXoL6ontLoWo8cYVoC1D91cbem6pE/3NmZL
         22TwpniqDlJ6xMQu1ureRv8y1573bIMBjQUPr+Es5MX2+wqvaTq+/8z02z+X4WuXxR2M
         jscKJRfFdvZ3Nhgf80Cw0NCZw6O386xLtBfutdyfW5ahktJEfeUt3U35/a7mfgqZbC4y
         8Y/Ny2M7PYLRfJBt5h3UQXmyMUZwh55UNsS7+Xg61U1050nzbgZdeozRhoqOqaEnfLrP
         Rd1aNaT8ncZUkiJIUGWUZwvebfPjmWKQCa0j34O8ZLg5EjCOB0uliCNHItALbX/u8o6I
         z27A==
X-Forwarded-Encrypted: i=1; AFNElJ9f8pa1xfVM+jcwziIiVf31zhRL2JL+ZgUM5SApJ6S0BmnoxRBrPYyn8AfxRYoEPJ/+MCtMdg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJ/CjaPh2Z+xZnfOk2mxwG3CrGKl9g2CpmQKgk/lIxL4izMB5Z
	fQywapfFa2R10NIjYO5LlV1X2SW9wVyLAhodCCKMPYSfOatdu0ivxUwOqOEQdMrdWUOn8qP4J3A
	K2RV+t2kW07+pYjmaCc/ZjHI/IrdVehxhUcsDg2GY/JCxapN0aUi/92R99ALwMw==
X-Gm-Gg: Acq92OGtrFjl2yC4Yzpbi+Xh5sdDwJmG/1W4ODLdcYpRjdmV+bEi6Ku1LlH2mwaWEz3
	73YCoAaUVYSayBR0RsAgGLyekjqIluOUJtYfrt8ciW3710C+Slt2PmhBELjBzlO2Q9Yin+ImjRj
	RpHrXtSmqvjMenMj2n4X8LruUPkCBBoiD33jayJU84YhEhuX5cjyWpkbyJRWbompnN1ygjaRwXa
	b8qXaFf1yVxFoKeodZXG6pV/Iq6HLQXVeQktMIWWScPwqdL77CcBycVAmj981xj6RdECbVUuMiB
	qg4Z0/zvyDa1JQa0xMHi6Vwy+IfFLJJRljKLwPwCgMfV4ct+w6Scm84y2oBABBHSwCohbIVDCx+
	cMccs/Wh4cROPuFcwqiRMQDr86vKhTamm+9MYo7Hz/PflBJV8CQ==
X-Received: by 2002:a05:6a20:9f07:b0:3b7:d8d5:232b with SMTP id adf61e73a8af0-3b8b573105fmr2719317637.8.1781673606251;
        Tue, 16 Jun 2026 22:20:06 -0700 (PDT)
X-Received: by 2002:a05:6a20:9f07:b0:3b7:d8d5:232b with SMTP id adf61e73a8af0-3b8b573105fmr2719287637.8.1781673605727;
        Tue, 16 Jun 2026 22:20:05 -0700 (PDT)
Received: from localhost.localdomain (122-63-72-97.mobile.spark.co.nz. [122.63.72.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a84sm17234894b3a.38.2026.06.16.22.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 22:20:05 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	kjlx@templeofstupid.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v6][makedumpfile 00/10] btf/kallsyms based makedumpfile extension for mm page filtering
Date: Wed, 17 Jun 2026 17:18:24 +1200
Message-ID: <20260617051834.95404-1-ltao@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XRFJ-ezZDqN-5jc73CkDsKsW_8AxoyefMDARG3Bu5kQ_1781673606
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260616_222010_804390_77A16820 
X-CRM114-Status: GOOD (  18.55  )
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

  $ make LINKTYPE=dynamic USELZO=on USESNAPPY=on USEZSTD=on EXTENSION=on
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
     rhel8.x is not supported, others are not tested.

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

v6 -> v5:

1) Add erase_sample extension for data erasure sample.
2) Replace fprintf() to MSG()/ERRMSG() in kallsyms.h. 
3) Use handle_cbs_len in extension_has_callback() for callback check.
4) Fix bug[5].
5) Add handle_cbs[i]->cb = NULL in init_extensions() to reset the
   callback if one extension's init() is skipped.
6) The patches are organized as follows:

   ---- <customization specific> ---
   10. Add amdgpu mm pages filtering extension

    --- <code should be merged> ---
    9. Doc: Add --extension option to makedumpfile manual
    8. Add erase_sample extension as an data erase reference
    7. Add sample extension as an example reference
    6. Add makedumpfile extensions support
    5. Implement kernel module's btf resolving
    4. Implement kernel module's kallsyms resolving
    3. Implement kernel btf resolving
    2. Implement kernel kallsyms resolving
    1. Reserve sections for makedumpfile and extenions

    Patch 10 is customization specific, merging depends on the strategy of
    maintenance.
    Patch 1 ~ 9 are common code which should be merged with makedumpfile.

[5]: https://lore.kernel.org/kexec/ab1b5e58-bad6-4565-a408-b1fb3d489465@nec.com/ 

Link to v5: https://lore.kernel.org/kexec/20260414102656.55200-1-ltao@redhat.com/
Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@redhat.com/
Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@redhat.com/
Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/

Tao Liu (10):
  Reserve sections for makedumpfile and extenions
  Implement kernel kallsyms resolving
  Implement kernel btf resolving
  Implement kernel module's kallsyms resolving
  Implement kernel module's btf resolving
  Add makedumpfile extensions support
  Add sample extension as an example reference
  Add erase_sample extension as an data erase reference
  Doc: Add --extension option to makedumpfile manual
  Add amdgpu mm pages filtering extension

 Makefile                   |  15 +-
 README                     |   6 +
 btf_info.c                 | 371 +++++++++++++++++++++++++
 btf_info.h                 |  77 ++++++
 extension.c                | 355 ++++++++++++++++++++++++
 extension.h                |  16 ++
 extensions/Makefile        |  13 +
 extensions/amdgpu_filter.c | 221 +++++++++++++++
 extensions/erase_sample.c  |  78 ++++++
 extensions/maple_tree.c    | 328 ++++++++++++++++++++++
 extensions/maple_tree.h    |   7 +
 extensions/sample.c        |  69 +++++
 kallsyms.c                 | 550 +++++++++++++++++++++++++++++++++++++
 kallsyms.h                 |  86 ++++++
 makedumpfile.8.in          |  11 +-
 makedumpfile.c             |  44 ++-
 makedumpfile.h             |  12 +
 makedumpfile.ld            |  16 ++
 18 files changed, 2266 insertions(+), 9 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h
 create mode 100644 extension.c
 create mode 100644 extension.h
 create mode 100644 extensions/Makefile
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/erase_sample.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h
 create mode 100644 extensions/sample.c
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h
 create mode 100644 makedumpfile.ld

-- 
2.54.0


