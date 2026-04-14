Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54247ED7B9B
	for <kexec@archiver.kernel.org>; Tue, 14 Apr 2026 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8JZhzJv6hTHcGO3+XzjoQOyz/Q7g31G/7Xm3QM/h6nw=; b=yrzt/q5VrD1aN3RKG7z5kfFcC5
	GYRCDy1oWNiSSuE5u3kCp1PcHA3WnyxzwuArawsf8e0z/edxvHG1vNEZxtXZ+DSb4+7ebbGLF5Ugt
	VLIKdxm8n6uLwGNSIISWnMDruclWq5jj1cypRKrtBtcCdQKI3PQnyKOhucUKUGxJ/zwIRC4G/QEig
	mfXPWdBv2kDzjEKSLxet8ydXrbge+e75Hcja/RpeksAfe31tvBznKSWPeCMzn72QQBTBKQKVr4J4s
	pXpzuNFGiqOKAMiFguOTdn2J1RFLINocBU4FlxI0THof+BRj5OOHY4UHsgruktsjyW7kEylAHRbFc
	NCPbVYJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazL-0000000H8mq-3gbw;
	Tue, 14 Apr 2026 10:27:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCazJ-0000000H8lJ-0R1K
	for kexec@lists.infradead.org;
	Tue, 14 Apr 2026 10:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776162438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8JZhzJv6hTHcGO3+XzjoQOyz/Q7g31G/7Xm3QM/h6nw=;
	b=aRT1a+cBvhwpc+ypmyAqoDpBnHdGiUFrRBgqJYmIKcue3eF2haQeD3lKNc/XsA0OI8VzWq
	rjfcKbZaQ8+r/yk57XSwdbKGSsYmZrW/fuZt9BK4OQD8+kuiAhGMQ47p/IUFmg5BysMv8x
	uvxjysJIBu4AJwEZ4gsFbmBxA00gq/A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-07sIvQubPLaW5zzS5eI8-g-1; Tue, 14 Apr 2026 06:27:16 -0400
X-MC-Unique: 07sIvQubPLaW5zzS5eI8-g-1
X-Mimecast-MFC-AGG-ID: 07sIvQubPLaW5zzS5eI8-g_1776162435
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b241be0126so105688055ad.3
        for <kexec@lists.infradead.org>; Tue, 14 Apr 2026 03:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162435; x=1776767235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JZhzJv6hTHcGO3+XzjoQOyz/Q7g31G/7Xm3QM/h6nw=;
        b=epmdwktK6m5DqmaasKdN5jjisoD8M8ifDmCAn7WrzGt1hpDVSex39AxHhARyZJ6jWn
         6Qhvj12gDniwMCnBPLM8lkequVdr+Ya4UZOahq6rPXNPDZ/6gfqHzQsJScGwFOpNZxi5
         H0nDdcy3eowcAYrXJ2MNJfIcubI53Elf3iGG4FtY+pt/vV+Hb4xBjLYVGiKHHr6NlDrZ
         IQeGeA245fx5l58AEyUcj7tdSTPO9W0C6l5Do24b/kOFHpXWyu39pu/wt9Vng6Tzz0m+
         jbgCWuB+MmW53Z7KmpmhN78W2Ij/1rHVGvQ9PX1Ikn3EM7g4J65e3I64xhkSn76xAJ1T
         G17Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lPm5DrUoLP4xJgQuHRj5jkd6itQMYqa/fv6qGZIcZPTkObMOYY6dHKDOiqjtQZKRzfsBpcA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyEXF/TIzE1uIkiG1wY1isIJZUNSsq0tpCVlTo8tcvBK0JYChyV
	kP4+yHIxjdGuIs/wDU+O78NIqSrkLj9VZK96X4iOvC7e1QfOW2Z+sSu5Cai62QtPARafqguFZG7
	3IXfxu8x9m3IP0z99/O2Aollz+68F/CHkk0LtZDIxNfbwX7LNGwyj7ZAoF6t3lQ==
X-Gm-Gg: AeBDievvoSmcOFanWu+bZTlBA4NglXko4m8W6Esp0gUd3SS9VuxoudeXQRPfDxWSJwg
	omM2oK61Lc+MAwchaz9E+CvKW6JNJKa19qJmSA5hS6GaPJgfulbZ30MebpnVkLFcp4JSbEpGKoS
	ycE/Ob9454w9TY6UrZaZxU0QrIqpvielL0iIPl63LV2Ygxfip3u4U2hA+u72/koc+l6VKNFGvtW
	QDkxPgUNznU+sSQgitdAHEhvQlE6eDYuTb+VWpqQvRM9Sgf7DUgaz3OToOgLAzf4Wt1gm7eh41L
	I9bhETngpaLcpQ3JVPb/Z3T6RMeUQ6lwNGyug25cv5CzMCRAZEQCj5+WY8fEoVYeyse7f/IKfs2
	bx/DPsnULhQcDglkI47UK9hcejOHbTGTRQ3GhS+7pUTJFvhlYv5WXp5mXET79O+7CbDr7
X-Received: by 2002:a17:903:1ac4:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2b2d5a69c20mr178827625ad.33.1776162434840;
        Tue, 14 Apr 2026 03:27:14 -0700 (PDT)
X-Received: by 2002:a17:903:1ac4:b0:2b2:4bf9:1766 with SMTP id d9443c01a7336-2b2d5a69c20mr178827275ad.33.1776162434193;
        Tue, 14 Apr 2026 03:27:14 -0700 (PDT)
Received: from localhost.localdomain (122-63-70-7.mobile.spark.co.nz. [122.63.70.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm136809165ad.79.2026.04.14.03.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:27:13 -0700 (PDT)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile extension for mm page filtering
Date: Tue, 14 Apr 2026 22:26:47 +1200
Message-ID: <20260414102656.55200-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g0kqaxw9_afh0VXJgEASmp4uq51n8B1xoUzbPBkoPJg_1776162435
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_032721_217948_2727F7F4 
X-CRM114-Status: GOOD (  18.49  )
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

v5 -> v4:

1) Add "make EXTENSION=on" switch to customize the extension feature.
2) Clean up macros within btf_info.h.
3) Updated doc and a sample extension to demo the extension usage.
4) Use MSG()/ERRMSG() rather than fprintf().
5) Add return value check for readmem().
6) Allow "makedumpfile -d 1 --extension ext.so" to enter extension.
7) The patches are organized as follows:

    --- <customization specific> ---
    9. Add amdgpu mm pages filtering extension

    --- <code should be merged> ---
    8. Doc: Add --extension option to makedumpfile manual
    7. Add sample extension as an example reference
    6. Add makedumpfile extensions support
    5. Implement kernel module's btf resolving
    4. Implement kernel module's kallsyms resolving
    3. Implement kernel btf resolving
    2. Implement kernel kallsyms resolving
    1. Reserve sections for makedumpfile and extenions

    Patch 9 is customization specific, merging depends on the strategy of
    maintenance.
    Patch 1 ~ 8 are common code which should be merged with makedumpfile.

Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@redhat.com/
Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@redhat.com/
Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/

Tao Liu (9):
  Reserve sections for makedumpfile and extenions
  Implement kernel kallsyms resolving
  Implement kernel btf resolving
  Implement kernel module's kallsyms resolving
  Implement kernel module's btf resolving
  Add makedumpfile extensions support
  Add sample extension as an example reference
  Doc: Add --extension option to makedumpfile manual
  Add amdgpu mm pages filtering extension

 Makefile                   |  15 +-
 README                     |   6 +
 btf_info.c                 | 375 +++++++++++++++++++++++++
 btf_info.h                 |  77 ++++++
 extension.c                | 338 ++++++++++++++++++++++
 extension.h                |  16 ++
 extensions/Makefile        |  13 +
 extensions/amdgpu_filter.c | 221 +++++++++++++++
 extensions/maple_tree.c    | 328 ++++++++++++++++++++++
 extensions/maple_tree.h    |   7 +
 extensions/sample.c        |  69 +++++
 kallsyms.c                 | 554 +++++++++++++++++++++++++++++++++++++
 kallsyms.h                 |  87 ++++++
 makedumpfile.8.in          |  11 +-
 makedumpfile.c             |  44 ++-
 makedumpfile.h             |  12 +
 makedumpfile.ld            |  16 ++
 17 files changed, 2180 insertions(+), 9 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h
 create mode 100644 extension.c
 create mode 100644 extension.h
 create mode 100644 extensions/Makefile
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h
 create mode 100644 extensions/sample.c
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h
 create mode 100644 makedumpfile.ld

-- 
2.47.0


