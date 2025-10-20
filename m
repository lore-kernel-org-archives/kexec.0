Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA9C1CCD1A5
	for <kexec@archiver.kernel.org>; Mon, 20 Oct 2025 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/mTrPVMTg8B4wtz9vwTttnRjqdusRlxVLTGuDdFn9H8=; b=IXtsCnthN6/6myrImxtPZ8kgOb
	X6xmnyYLsAV1jh7MOdm9NHs23AYN0mXjV737WcRxjIfJcGyoqk1pWLTV2W4gYHP477Qqtnq6XZ6ds
	RZvqaaarhugmGdRWwRduH74H0USVZHqBiM/Ay2xKbkay3OEirtDwLw8iotftrokrZYY4I8DDfytIa
	eBfV+4bQLTADmzPNaPN4+knhXJQYD5qTw0XhrECxeogxNXjWpdiquT7b5VeDqnEdUngnwa8i+fjv8
	PS2tmT5oWmw5ofyC3oB+o8hwoOsEoOvAu5PeRAH7tX3SROe6exsX64NscrBbbimElObdbIHIYrsjX
	4z84c6Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIl-0000000FAqO-2Xbi;
	Mon, 20 Oct 2025 22:24:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAyIi-0000000FApR-2GJs
	for kexec@lists.infradead.org;
	Mon, 20 Oct 2025 22:24:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760999062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/mTrPVMTg8B4wtz9vwTttnRjqdusRlxVLTGuDdFn9H8=;
	b=AbHsA8UyGTdymRT4oEVYigitowuIsmkgmGeScxtBONrDrleMfrg8UTm+CVFQlim+koa9TZ
	X6qF4LluVqbURcPiZik6bT8muhlxNg69Vjr//FFahvMudWbdFpPP7TS9oM5ljhZM/L2PUQ
	dwU3tUvx1SSrvZ5V2j8VoUzLTmQMbgg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-PrI44kkaO4GjFOZFe-oFng-1; Mon, 20 Oct 2025 18:24:20 -0400
X-MC-Unique: PrI44kkaO4GjFOZFe-oFng-1
X-Mimecast-MFC-AGG-ID: PrI44kkaO4GjFOZFe-oFng_1760999060
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-781269a9049so8399016b3a.2
        for <kexec@lists.infradead.org>; Mon, 20 Oct 2025 15:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760999059; x=1761603859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mTrPVMTg8B4wtz9vwTttnRjqdusRlxVLTGuDdFn9H8=;
        b=vC7yqyt2UEVbXWxqXQveQhGYpuQfvVOhTzFgrBH0D0t9+gjfSUu0vz3nw0QDKwLpfX
         UXAerxpXdYc8Wo6SzqoxSPjQdZz9vVxEJW45aZTohIig/9LZgWgttGADMMZ2pb0j6cYv
         zMxa4ijoRmoZc+EYrTIJMXWZe1+h9XfJyulrbOwMpPMNlEg1yJlzEWsZxKYjQ0CGIN6z
         O4EfVBJC1S2djni76syBFvkn/YP5SZhyKPpsRFBsaCQXYNB7AyknUoGpecwWPD4opsjH
         AYuv1tMZqWOt6ABLlsIYXGuexJnGzNzDesTdM16IUpTve2a9q/5JLxnYITZeZT692oQn
         inXg==
X-Forwarded-Encrypted: i=1; AJvYcCU6dpgPlBXojxszlSuhukY+b/vZuIQ6m7gnRxrxDHYTEJ5YHARbJDE8Fflcc6G5oYoUM/I6mg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyLzO/5fJ1dJ3BcAZtWNycKPOFLe4tFl/IxekMBcUlDN+ICu3K4
	cTetqyoJED+Cnc4DMqHcR5xCpvsGiqpvHCqACwOsxxEoWx6oHkMnCbb8qTcuESPm3P2AkEFIFrA
	CeWonsaKWb9uh9iz8e7H0UPE3P0PUfMltaOcDP4Vq4GZMGjiyZx0SnMwE60rItA==
X-Gm-Gg: ASbGnctXclY6XM8wYT9vN+ZBgzmiaYNSP/nXELrtqTUIpTNP0F5J5zgtsJ08audBszD
	3Dz6LkGOI/7U/nMP0D9wf1Tj01TiFjCbkTl/34jUaQYJxPrNZB+Ow7hP/M2cOqubiXXbwD6dusp
	HhBBJD98KXbrm3jiwHRuNi0sDC+rWg2WXIgKos1rMOtlEwfySFBbe/3eB+j+n/xTJ5Bf0zvNwEm
	uF6PZPnhzlIkhL3QncGYjIHuY+ZmEkHGTqCb0KuF3grT5utQrJq2zPA+60ELRwH9KhOv5cKMoRd
	wt9FhChGsf5SHiTyBkmDyzIngCk9jkkbTwIGfwQROaWMUEd+4l9N7Ehtuqdi6mBMharLng110uF
	xqFKEBYicmk82guLceP3G4Il6L/F+c3/IFQPh6B2SdZs=
X-Received: by 2002:a05:6a00:94c2:b0:79a:f5eb:3dce with SMTP id d2e1a72fcca58-7a220d5792amr17121683b3a.31.1760999059443;
        Mon, 20 Oct 2025 15:24:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp6x1GB2tRznJ1+F3JZ7ygqypGd88EdxpoEyPU7g1AaZmKMeGmVT28l/Cbs7FqZ3uiqb6tEg==
X-Received: by 2002:a05:6a00:94c2:b0:79a:f5eb:3dce with SMTP id d2e1a72fcca58-7a220d5792amr17121660b3a.31.1760999058980;
        Mon, 20 Oct 2025 15:24:18 -0700 (PDT)
Received: from localhost.localdomain (115-189-93-209.mobile.spark.co.nz. [115.189.93.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e265sm9229263b3a.52.2025.10.20.15.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 15:24:18 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v2][makedumpfile 00/14] btf/kallsyms based eppic extension for mm page filtering
Date: Tue, 21 Oct 2025 11:23:56 +1300
Message-ID: <20251020222410.8235-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JwKyt8PT-Q9G6kWuA8whd-qsTSo-8wr0NzWthEmCCuI_1760999060
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_152424_656400_1494F88A 
X-CRM114-Status: GOOD (  23.26  )
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

  1) Enable eppic script for memory pages filtering.
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
     c) Poor performance, making vmcore dumping time unacceptable (See
        the following performance testing).

     makedumpfile need to resolve the dwarf data from debuginfo, to get symbols
     types and addresses. In recent kernel there are dwarf alternatives such
     as btf/kallsyms which can be used for this purpose. And btf/kallsyms info
     are already packed within vmcore, so we can use it directly.

  With these, this patchset introduces an upgraded eppic, which is based on
  btf/kallsyms symbol resolving, and is programmable for mm page filtering.
  The following info shows its usage and performance, please note the tests
  are performed in 1st kernel:

  $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/dwarf.out -x /lib/debug/lib/modules/6.11.8-300.fc41.x86_64/vmlinux
    --eppic eppic_scripts/filter_amdgpu_mm_pages.c
        real    14m6.894s
        user    4m16.900s
        sys     9m44.695s

  $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/btf.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
        real    0m10.672s
        user    0m9.270s
        sys     0m1.130s

  -rw------- 1 root root 367475074 Jun 10 18:06 btf.out
  -rw------- 1 root root 367475074 Jun 10 21:05 dwarf.out
  -rw-rw-rw- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025-06-10-18:03:12/vmcore

C) Discussion:

  1) GPU types: Currently only tested with amdgpu's mm page filtering, others
     are not tested.
  2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc64.
     Others are not tested.

D) Testing:

  1) If you don't want to create your vmcore, you can find a vmcore which I
     created with amdgpu mm pages unfiltered [1], the amdgpu mm pages are
     allocated by program [2]. You can use the vmcore in 1st kernel to filter
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

  2) You can use eppic_scripts/print_all_vma.c against an ordinary vmcore to
     test only btf/kallsyms functions by output all VMAs if no amdgpu
     vmcores/machine avaliable.

[1]: https://people.redhat.com/~ltao/core/
[2]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df

v2 -> v1:

1) Moved maple tree related code(for VMA iteration) into eppic script, so we
   don't need to port maple tree code to makedumpfile.

2) Reorganized the patchset as follows:

    --- <common modification> ---
    1.Add page filtering function                                                    
    2.Supporting main() as the entry of eppic script                                 

    --- <dwarf related modification> ---
    3.dwarf_info: Support kernel address randomization                               
    4.dwarf_info: Fix a infinite recursion bug for rust                              
    5.eppic dwarf: support anonymous structs member resolving                        
    6.Enable page filtering for dwarf eppic                                          

    --- <btf & kallsyms related modification> ---
    7.Implement kernel kallsyms resolving                                            
    8.Implement kernel btf resolving                                                 
    9.Implement kernel module's kallsyms resolving                                   
    10.Implement kernel module's btf resolving                                        
    11.Export necessary btf/kallsyms functions to eppic extension                     
    12.Enable page filtering for btf/kallsyms eppic                                   
    13.Docs: Update eppic related entries                                             

    --- <only for test purpose, don't merge> ---
    14.Introducing 2 eppic scripts to test the dwarf/btf eppic extension     

   The modification on dwarf is primary for comparision purpose, that
   for the same eppic program, mm page filtering should get exact same
   outputs for dwarf & kallsyms/btf based approaches. If outputs unmatch,
   this indicates bugs. In fact, we will never take dwarf mm pages filtering
   in real use, due to its poor performance as well as inaccessibility
   of debuginfo during kdump in 2nd kernel. So patch 3/4/5 won't affect
   the function of btf/kallsyms eppic mm page filtering, but there are
   functions shared in patch 6, so it is a must-have one. Patch 14 is
   only for test purpose, to demonstrate how to write eppic script for
   mm page filtering, so it isn't a must-have patch.

   Please note, in patch 14, I have deliberately converted all array
   operation into pointer operation, e.g. modified "node->slot[i]" into
   "*((unsigned long *)&(node->slot) + i)". This is because there are
   bugs for array operation support in extension_eppic.c. I didn't have
   effort to test and fix them all because as I mentioned previously,
   mm page filtering in dwarf side is only for comparision and will
   never be used in real use. There is no such issue for kallsyms/btf
   eppic side.

3) Since we ported maple tree code to eppic script, several bugs found
   both for eppic library & eppic btf support. Please use master branch
   of eppic library to co-compile with this patchset.

Tao Liu (14):
  Add page filtering function
  Supporting main() as the entry of eppic script
  dwarf_info: Support kernel address randomization
  dwarf_info: Fix a infinite recursion bug for rust
  eppic dwarf: support anonymous structs member resolving
  Enable page filtering for dwarf eppic
  Implement kernel kallsyms resolving
  Implement kernel btf resolving
  Implement kernel module's kallsyms resolving
  Implement kernel module's btf resolving
  Export necessary btf/kallsyms functions to eppic extension
  Enable page filtering for btf/kallsyms eppic
  Docs: Update eppic related entries
  Introducing 2 eppic scripts to test the dwarf/btf eppic extension

 Makefile                               |   6 +-
 btf.c                                  | 919 +++++++++++++++++++++++++
 btf.h                                  | 177 +++++
 dwarf_info.c                           |   7 +
 eppic_scripts/filter_amdgpu_mm_pages.c | 255 +++++++
 eppic_scripts/print_all_vma.c          | 239 +++++++
 erase_info.c                           | 120 +++-
 erase_info.h                           |  19 +
 extension_btf.c                        | 258 +++++++
 extension_eppic.c                      | 106 ++-
 extension_eppic.h                      |   6 +-
 kallsyms.c                             | 392 +++++++++++
 kallsyms.h                             |  41 ++
 makedumpfile.8.in                      |  24 +-
 makedumpfile.c                         |  21 +-
 makedumpfile.h                         |  11 +
 print_info.c                           |  11 +-
 17 files changed, 2550 insertions(+), 62 deletions(-)
 create mode 100644 btf.c
 create mode 100644 btf.h
 create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
 create mode 100644 eppic_scripts/print_all_vma.c
 create mode 100644 extension_btf.c
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

-- 
2.47.0


