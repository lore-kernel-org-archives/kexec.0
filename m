Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90739D2ED11
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 03:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4mmpF7RchETmgdDywcCU16iLRqh8vHqTscrSwH97rcU=; b=foPrgLN/V4N1jzWnEIJ8MlCjQF
	wet2rP3MCPZfF+jAW/iAlaPLyqBBRD6d48DApzIa+fHIA7rx5krfQ70szsGE2jjnuyecN+bdWa7Eo
	MpHT/9c944FczxhDSdA26SaYy0EyOaF7l6Xqg9jTTjSt4hqutWEvfQr2CxAoaZsBohpQEmSVkZ1DL
	vO/k2i/ylWcuFYhvoSudbBQzfzGS/XeGm/+gdHikvMuj2ADryyL9CTk65CnFTBmONUhIyoLpsDLNU
	q8+2bKshWzOXoKa2rVshPXY3eu2QnlWk+sfhv6SyXPHz9YDJMecOLimyjYWBown1D3kcfZut82hvg
	22hSGGdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aR-00000003818-3EuA;
	Tue, 20 Jan 2026 03:39:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi2aO-0000000380B-0Npj
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 03:39:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768880356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4mmpF7RchETmgdDywcCU16iLRqh8vHqTscrSwH97rcU=;
	b=BJVgCCpS5+E/CHQAZu7mp/rZq8x+mB8EZZ7p3i2Ey3HFuQ2ApSNsa/M6o4/P9qCzmyoQh4
	JoWO79sm6yq2TN65y82V1nOpWZfVKbIJJ9dVQlhGFE3kPTJrHq79IaSKOs6MA/dRNEFuGS
	DDXavZ/Lz6f1OO1ElbMACpCV81JSRPU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-wrdW_ta6O6CYxvB2gmep7A-1; Mon, 19 Jan 2026 22:39:14 -0500
X-MC-Unique: wrdW_ta6O6CYxvB2gmep7A-1
X-Mimecast-MFC-AGG-ID: wrdW_ta6O6CYxvB2gmep7A_1768880354
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34ac814f308so7281522a91.3
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 19:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768880353; x=1769485153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mmpF7RchETmgdDywcCU16iLRqh8vHqTscrSwH97rcU=;
        b=aiCfKBNiWyvAXlI4+kmv7PcJepb3Ndgy6r/RGSakZPU+ROgy8QfTsbzoRWuV7ot5DB
         SSAOaABABf1sYoQjh8NA3mstoZLHu5RunouJpLqsFKGHUow8iSw03HN6EptJIH5W76ap
         KYro+tPj/bqnMoH50EKPcdgX91gQVQbXcfP88oL6W32Sz8p12YoF2Fzm7kb9bg6AJTZs
         bAG2ve6wsg+d+207NOPoXXncyEIMKZ+MVaYB1PCWbOy3l4q03922VHrOX8JI4A0w8QLJ
         9sv1ZeLMZcLC544GBD1x7ABc8bELcF9bzFEcIxRQbFpKuwY+oXCPWgdGldRzXSGUi7aN
         G6jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP31bR7Abug1+tJuNbgTqKhO2BgpfASPsuAKah1XCUoSDdR9Z6D7duqtxEHd6fw4YKERpVMQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy32h2qBezD2mfxqlJT9PbKtOa6HjTnXIVgBIBOjesj6hPfAPHG
	YgJ8rtbxIEZoKK4oZshOsHsdw9gxoj/hiNOlMiQQ2UKMLGX+Wpd8dXulpmgS5zqJhxtwDJDM2u5
	7o4GaD9xCqVU7k5xBgFrkfhbQMLHx0zKMlurQo7cdy2xiWznVHc7u+VFOL4pmP+ai3uOGdg==
X-Gm-Gg: AZuq6aLhxbHKCFXWU7JRKwxeQAqQDKTcqI7A4UYamkueXmSVzAKb4UFhB9ZMADXeRXH
	Uq0n551E3+Ni0moR4LVJe2C6fXHef2a40XpHmUAFO+A7XfOuVUUWjZXID3StzU4S+KuZVFpFDL4
	4HZfUlbAhmwLur2e+XOjHCpAApb1oqnCxsJd3lZPfhtNHEyknTc/0hxCF0v7wfDiMaV9LQCd031
	LUDJRp8hQQkZok3XKAYNGNvc8jU3llyso0B/QZ4MAt2l32vBNUmiZti7NjCTCiSAYc+u9amIibk
	s3W9nBhZt2WuTGW7/MPn/uKviygII37vpJgxBBuSASV0zvPeOZNU9nbaE1s+fiPU6V1KA5BpCRZ
	RY4ft/MLahQ00b4fZeA==
X-Received: by 2002:a17:90b:3e4e:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-352c40a9cf1mr652730a91.26.1768880353251;
        Mon, 19 Jan 2026 19:39:13 -0800 (PST)
X-Received: by 2002:a17:90b:3e4e:b0:340:d81d:7874 with SMTP id 98e67ed59e1d1-352c40a9cf1mr652709a91.26.1768880352870;
        Mon, 19 Jan 2026 19:39:12 -0800 (PST)
Received: from localhost.localdomain ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678c6a3dsm13375935a91.13.2026.01.19.19.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 19:39:12 -0800 (PST)
From: Tao Liu <ltao@redhat.com>
To: yamazaki-msmt@nec.com,
	k-hagio-ab@nec.com,
	kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com,
	stephen.s.brennan@oracle.com,
	Tao Liu <ltao@redhat.com>
Subject: [PATCH v3 0/8] btf/kallsyms based makedumpfile extension for mm page filtering
Date: Tue, 20 Jan 2026 15:54:52 +1300
Message-ID: <20260120025500.25095-1-ltao@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pTMAJQB0RpOihj6TJJ43vR0vvT9xoaI8Y9TD9QMoMEY_1768880354
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_193920_252745_F89B0E0B 
X-CRM114-Status: GOOD (  20.15  )
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
    /tmp/extension.out
    Loaded extension: ./extensions/amdgpu_filter.so
    makedumpfile Completed.
        User time (seconds): 6.37
        System time (seconds): 0.70
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:07.10
        Maximum resident set size (kbytes): 38024
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

v3 -> v2:

1) Removed btf/kallsyms support for eppic script, and introduced
   makedumpfile .so extension instead. The reason of removing eppic
   support is: 
   a) Native binary code as .so has better performance than scripting,
      see the time consumption contrast above.
   b) Eppic library has memory leaks which hasn't been fixed totally,
      memeory leaks in 2nd kernel might be fatal.  

2) Removed the code of manually parsing btf info, and used libbpf for
   btf info parsing instead. The reason of removing manually parsing is:
   a) Less code modification to makedumpfile, easier to maintain.
   b) The performance of using libbpf is as good as manual parsing +
      hash table indexing, as well as less memory consumption, see time
      and memory consumption contrast above. 

3) The patches are organized as follows:

    --- <only for test purpose, don't merge> ---
    8.Filter amdgpu mm pages
    7.Add maple tree support to makedumpfile extension

    --- <code should be merged> ---
    6.Add page filtering function
    5.Add makedumpfile extension support
    4.Implement kernel modules' btf resolving
    3.Implement kernel modules' kallsyms resolving
    2.Implement kernel btf resolving
    1.Implement kernel kallsyms resolving

    Patch 7 & 8 are customization specific, which can be maintained separately.
    Patch 1 ~ 6 are common code which should be integrate with makedumpfile.

Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@redhat.com/

Tao Liu (8):
  Implement kernel kallsyms resolving
  Implement kernel btf resolving
  Implement kernel modules' kallsyms resolving
  Implement kernel modules' btf resolving
  Add makedumpfile extension support
  Add page filtering function
  Add maple tree support to makedumpfile extension
  Filter amdgpu mm pages

 Makefile                   |   9 +-
 btf_info.c                 | 260 +++++++++++++++++++++++++
 btf_info.h                 |  66 +++++++
 erase_info.c               |  98 ++++++++++
 erase_info.h               |  12 ++
 extension.c                |  82 ++++++++
 extensions/Makefile        |  10 +
 extensions/amdgpu_filter.c |  90 +++++++++
 extensions/maple_tree.c    | 336 +++++++++++++++++++++++++++++++++
 extensions/maple_tree.h    |   6 +
 kallsyms.c                 | 376 +++++++++++++++++++++++++++++++++++++
 kallsyms.h                 |  20 ++
 makedumpfile.c             |  35 +++-
 makedumpfile.h             |  11 ++
 14 files changed, 1405 insertions(+), 6 deletions(-)
 create mode 100644 btf_info.c
 create mode 100644 btf_info.h
 create mode 100644 extension.c
 create mode 100644 extensions/Makefile
 create mode 100644 extensions/amdgpu_filter.c
 create mode 100644 extensions/maple_tree.c
 create mode 100644 extensions/maple_tree.h
 create mode 100644 kallsyms.c
 create mode 100644 kallsyms.h

-- 
2.47.0


