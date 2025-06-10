Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E24AC71135
	for <kexec@archiver.kernel.org>; Tue, 10 Jun 2025 10:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1MVYNJb6VkOfalDO9hQasLd/kT0k9VcIXlbkWb/yWuU=; b=WqVtFnLAkJi4KVzdudurEpZLVL
	e2oc+wCJ4SUR+awO7eR0a/hZWfBe+CaylPX9/JmXbIOflqrjEdfz7XwaNAJrNtjss2s6a4DyIRH1c
	mq67vPS7HNFsUtvS4vW8ihfkafIacgNBs6Z9ac+fUHHIKcu+pW/8exjGBwEmc3AMBZsgKlSJn/oxG
	fwhSo6XY+ktsEZkW799mM4qrSE2ej1C3RtBzp14Mo2o70n16YSssy/FA9Tq1VhhHfUnL96aSThjdr
	YDfIfBpA+RIibIlTgjuVL8bQ7QuPIsGQdQMgyCRJgY77UKTmEt2rT0nW5k9z1vGEfFYZvf4MPt0AF
	SBwDeHtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOwez-00000006Y88-3Cu7;
	Tue, 10 Jun 2025 10:56:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOvlS-00000006QbI-1Hs8
	for kexec@lists.infradead.org;
	Tue, 10 Jun 2025 09:59:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749549568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1MVYNJb6VkOfalDO9hQasLd/kT0k9VcIXlbkWb/yWuU=;
	b=gtM8gJ+XuzW0+NxhbuiUIfXcF0BIfplUFAbp763VNQQysFZGuA6fYcZEB6/+3lEe8cLrN4
	jWje2CY/4l0IVBTQi/1W02fhG9jbD1QoF3t10CkUu7qBLtKa3cUH3GvXB4y23R3NWRfEdZ
	E1To6wF5Q7A7JXhNna+OFnrDm3RtA2U=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-cq4BE3LZM8iiwNCgz9fdbw-1; Tue, 10 Jun 2025 05:57:54 -0400
X-MC-Unique: cq4BE3LZM8iiwNCgz9fdbw-1
X-Mimecast-MFC-AGG-ID: cq4BE3LZM8iiwNCgz9fdbw_1749549474
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2362e130be8so16414145ad.0
        for <kexec@lists.infradead.org>; Tue, 10 Jun 2025 02:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549473; x=1750154273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1MVYNJb6VkOfalDO9hQasLd/kT0k9VcIXlbkWb/yWuU=;
        b=DCCn8WM6EHOZbrFDtRPoujyXlhJjrZgryUG0Sfwhbj7/q4E6ATwlw3lCWz36NiLn4v
         MKUEwzMwPWRCGdyMUZ4SO82Z99zLUhZxVHj9HBOZxaoGP30WZaxD+q6YIpWUERyUghnB
         oH4SJNG8Xjb1kq8Aqal1h0RqzrlIg9HBUrZtPbG/U7PmeYTEM5WYg/JsVGgQnB/sdB/r
         Fxx0msqlxr0Ufk7P7J7QNmZMTBX1tK9RvGh8+fhW+qhCX/ObnA3nDBo1ewQm9/MulSEk
         dYSYniLEQs1x++bpilOtb3VRzCqBhR+7DHkHFhj7VaizkqSdCjLoLqZrHKJTmWc9CJ1z
         H5yA==
X-Forwarded-Encrypted: i=1; AJvYcCVbH+pslKN+fbE0LPZGB4CN+aeoKaStQX1Xky1CVuGNTo/ZOb1SGtERQdQXAVO2ytH5HJEtgw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx1bjKC59ApnzWFSB2D92BJI3hADu9Whdr5eVCNFzHlx0LzEw66
	JCqlBF4mr6JNbb9igCckedYtlTO/Jcd5BhQLLYFfVP65L2CAIQjMa5LXGGG3iAhwR/1iDFW0SLK
	fywqXh1s8zdwrFjqmIB/F7oj7SGTLOn06wlKUg4J0nqZfmMXFXzQLSiUC/EOaIjwrwhoYEA==
X-Gm-Gg: ASbGncsYIErBVnOit8P3xaKdU+7WP8kCYu3LSpoFG80Xuw2v28SF+oSSh9w3HA90xCF
	Q7i/sOrMYnMzmuKb50x0+tqGzR8CjrO2+dUaCLTfjzEdmWcqmsmAkkiSwrlz+fvvhpaE0JInyhI
	GdrRrfFcAEGXHAG3GXFW9AcxnZUAwfAaeUg4QkGOn5LPB4UJxxbtxRxw7G5m0J8/8+lptbtqd56
	NTmqWYrrLK7sYw1s93YPuh9y+59z3LzDKvU0QQrnXEgoFPFtowaPiBKLEYMu6Qfhrdp1ed4eJ3e
	OOmkgsmJTgtjFVNhrxyclP4hUGwYxw8=
X-Received: by 2002:a17:902:f682:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-23601d4ecf6mr250543005ad.25.1749549473338;
        Tue, 10 Jun 2025 02:57:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi6gGERTNyTVXxnu1MZ8kkAJdFbs9Pf+z7aXPU7zV+ZLj1dDfWJS1inUjl/NrhQ52eh8xajQ==
X-Received: by 2002:a17:902:f682:b0:235:e1d6:4e45 with SMTP id d9443c01a7336-23601d4ecf6mr250542705ad.25.1749549472974;
        Tue, 10 Jun 2025 02:57:52 -0700 (PDT)
Received: from localhost.localdomain ([118.148.112.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405f5fsm68189085ad.172.2025.06.10.02.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:57:52 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	devel@lists.crash-utility.osci.io,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH RFC][makedumpfile 00/10] btf/kallsyms based eppic extension for mm page filtering
Date: Tue, 10 Jun 2025 21:57:33 +1200
Message-ID: <20250610095743.18073-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MGBZlc42uEqoNoHleJEExPlCLz9mUB5WvQZUSKHNN3Y_1749549474
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_025930_419356_5BD1E283 
X-CRM114-Status: GOOD (  19.89  )
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
  3) Port maple tree data structures and functions, primarily used for
     vma iteration.

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

  3) Maple tree data structures are used in recent kernels, such as vma
     iteration. So maple tree poring is needed.

  With these, this patchset introduces an upgraded eppic, which is based on
  btf/kallsyms symbol resolving, and is programmable for mm page filtering.
  The following info shows its usage and performance, please note the tests
  are performed in 1st kernel:

  $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/dwarf.out -x /lib/debug/lib/modules/6.11.8-300.fc41.x86_64/vmlinux
    --eppic eppic_scripts/filter_amdgpu_mm_pages.c 
	real	14m6.894s
	user	4m16.900s
	sys	9m44.695s

  $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:12/vmcore
    /tmp/btf.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
	real	0m10.672s
	user	0m9.270s
	sys	0m1.130s

  -rw------- 1 root root 367475074 Jun 10 18:06 btf.out
  -rw------- 1 root root 367475074 Jun 10 21:05 dwarf.out
  -rw-rw-rw- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025-06-10-18:03:12/vmcore

C) Discussion:

  1) GPU types: Currently only tested with amdgpu's mm page filtering, others
     are not tested.
  2) Code structure: There are some similar code shared by makedumpfile and
     crash, such as maple tree data structure, also I planed to port the
     btf/kallsyms code to crash as well, so there are code duplications for
     crash & makedumpfile. Since I havn't working on crash poring, code change
     on btf/kallsyms is expected. How can we share the code, creating a common
     library or keep the duplication as it is?
  3) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc64.
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

Tao Liu (10):
  dwarf_info: Support kernel address randomization
  dwarf_info: Fix a infinite recursion bug for search_domain
  Add page filtering function
  Add btf/kallsyms support for symbol type/address resolving
  Export necessary btf/kallsyms functions to eppic extension
  Port the maple tree data structures and functions
  Supporting main() as the entry of eppic script
  Enable page filtering for dwarf eppic
  Enable page filtering for btf/kallsyms eppic
  Introducing 2 eppic scripts to test the dwarf/btf eppic extension

 Makefile                               |   6 +-
 btf.c                                  | 919 +++++++++++++++++++++++++
 btf.h                                  | 176 +++++
 dwarf_info.c                           |  15 +-
 eppic_maple.c                          | 431 ++++++++++++
 eppic_maple.h                          |   8 +
 eppic_scripts/filter_amdgpu_mm_pages.c |  36 +
 eppic_scripts/print_all_vma.c          |  29 +
 erase_info.c                           | 123 +++-
 erase_info.h                           |  22 +
 extension_btf.c                        | 218 ++++++
 extension_eppic.c                      |  41 +-
 extension_eppic.h                      |   6 +-
 kallsyms.c                             | 371 ++++++++++
 kallsyms.h                             |  42 ++
 makedumpfile.c                         |  21 +-
 makedumpfile.h                         |  11 +
 17 files changed, 2448 insertions(+), 27 deletions(-)
 create mode 100644 btf.c
 create mode 100644 btf.h
 create mode 100644 eppic_maple.c
 create mode 100644 eppic_maple.h
 create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
 create mode 100644 eppic_scripts/print_all_vma.c
 create mode 100644 extension_btf.c
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

-- 
2.47.0


