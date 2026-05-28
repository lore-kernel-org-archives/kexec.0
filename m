Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2431BCD5BD5
	for <kexec@archiver.kernel.org>; Thu, 28 May 2026 22:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yY1+1/kICEAwNazq4XRR+LashV2IBW54oXMAlKCKHxw=; b=4bAnXjd24S8hLdj+0rkzJ0dx8y
	kq/HyDFdyhOlnas89BkPPJXSKNkTcBxAoySdb7lj4f3349DJIyO2hUYLtBCZXWIsjp7mN5XVEzzDX
	KiCxJVqo4c07u8NCk3KvZJS7JdE7jbDr2eG9romFCHiWHPhAqSPYDs0B7RbcMXTishwoXiLZrOgGX
	A7U6YKR0BwB1uHJG43EG3B6+tiRKJLi65kgx+4lLDYjL3i8XZ7ziozgXIF6Ei/N9kzDl/j9LX47C6
	xNlKt1whwXWiDI0QiLFeBm/vlPc1/xAxviVful+2FA2FeawbbbeVYozkcY3P9GtvnikjMuCWi3D/V
	1Y8YKdeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSioT-00000006Rm2-34j2;
	Thu, 28 May 2026 22:02:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSioP-00000006RlG-424Z
	for kexec@lists.infradead.org;
	Thu, 28 May 2026 22:02:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780005763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yY1+1/kICEAwNazq4XRR+LashV2IBW54oXMAlKCKHxw=;
	b=c7tNjfN2FdchBkbrmwTrE4pCyOTE8PLvSKav+8D1EmQ2LIYy9JCQ2nVkpNnL3/SfhJ82n7
	rtxmqNWRm1QOkDdb3F3aGk+F7GQRhkBN0qfbIeC9SvpzYrfAXlxjm/iPrHUmZ5fljSiHnP
	LJ/92x5HvkLVm+CPFM9FEIgRRKYK/cI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-qW3ljQ5aPWmQOAw11-4kWw-1; Thu, 28 May 2026 18:02:41 -0400
X-MC-Unique: qW3ljQ5aPWmQOAw11-4kWw-1
X-Mimecast-MFC-AGG-ID: qW3ljQ5aPWmQOAw11-4kWw_1780005761
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-914be3ed6caso189991985a.1
        for <kexec@lists.infradead.org>; Thu, 28 May 2026 15:02:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780005761; x=1780610561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yY1+1/kICEAwNazq4XRR+LashV2IBW54oXMAlKCKHxw=;
        b=JbiWGrt24ipuMgHsUQQBIV3LhQ+qv8DP0JXvlAb7sRV04DvEJjPKeCf/OFMfkXFsYc
         3hgC084Kij9ykChgsYnHrHo+tA/OGIf+1oG8lfcQ3gvxwbHJFLVqJdiM1DUjRXCG5lJO
         pMEVlWcU+EKsTk44c7wLgTzm0e0+h0q6R5VTwvLdadZzbeEBUbfD3/fV4or9ZY0n8g4/
         I1vZO6bmgf+A2Wrq4hsL6gUvjHHLSDceN45HGzeObcTH0owSi2bhkl1sfsN/BxH3gav5
         bTcADOmxy5yXBBFX6fc7I+6aqMDK+5ulwj/uwqph3NZhn91XPaquhlxghIFIXAzim5bk
         GB7Q==
X-Forwarded-Encrypted: i=1; AFNElJ8EIcfHqbzGt5dQoeHhTqZibYiUyiG7RReITcbJVRiEFZtJNzUI3El5Zjlc2eTGis/BHO4xgw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzMaUOk0DNGFGDtV7WQEWdrxNd1a4lcD9YRDxqDpoDd+TSYyfL3
	SA7hj7YN3gdFWX/Lin9uW3su/8GV9dCbhRSbhl8NMIj135Mw3In8Tu+2t/CJ2/n37FdR4tKQ87u
	isYl+FxEzqmuNrXsVfZaWJZBV07vYrbfb2kINJFlBJPm1gfolqhoHtEgroskw6jAYzEmTuXUn2s
	myVVhr/FRps2Gs3T4bxC/lks8ezbFg7RK4ixl9
X-Gm-Gg: Acq92OG29kda3HkpX35duM1pqLdicsmPLBc2j64O/rwGhue9Msnmx1qOvmfu+eZYPu3
	Gg0lh8tuq8JIB1R3tXUQJCFiQSI/5AjdXgOTJMUIACRCdji/yKJmcolVJQZY7qYvBw3hIFLud68
	h295aZ2v+vlT3jSievqiUTfGQRXFMZ4Bck9hrwWRPWjyJuGU9pkZGc9hH20Qm7N4HGS0PVFYZWv
	+4cwcrG1MK3zt1Z
X-Received: by 2002:a05:620a:690d:b0:914:ca5a:60ac with SMTP id af79cd13be357-9152fd2bc13mr26979885a.16.1780005761215;
        Thu, 28 May 2026 15:02:41 -0700 (PDT)
X-Received: by 2002:a05:620a:690d:b0:914:ca5a:60ac with SMTP id
 af79cd13be357-9152fd2bc13mr26976485a.16.1780005760768; Thu, 28 May 2026
 15:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com> <87o6hzpegz.fsf@oracle.com>
In-Reply-To: <87o6hzpegz.fsf@oracle.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 29 May 2026 10:02:04 +1200
X-Gm-Features: AVHnY4L6lT0hfdZtbjKa-DYdR6dxGWZ6n0yZO-1W8YHrInX-h9e-5vaHqU-7ESU
Message-ID: <CAO7dBbVVun57JRpckqY8Sx+s1kYFv6TB4SADGSVgj+_QtguasQ@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org, 
	aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g5hAJ8dd0nGcv6POlUp_6OlDZtlJU66iRsR7omvEqiw_1780005761
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_150246_080207_EF3BBDCE 
X-CRM114-Status: GOOD (  42.90  )
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

Hi Stephen,

Thanks a lot for your code review, I really appreciate it! And I have
enjoyed the process of cooperating with you on the code discussion,
design, and implementation. Thanks again for your help on this! :)

Hi maintainers,

Just a kind ask: any comments on the v5 patchset? I'm happy to make
further modifications. Thanks!

Thanks,
Tao Liu

On Fri, May 29, 2026 at 6:38=E2=80=AFAM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Tao Liu <ltao@redhat.com> writes:
> > A) This patchset will introduce the following features to makedumpfile:
> >
> >   1) Add .so extension support to makedumpfile
> >   2) Enable btf and kallsyms for symbol type and address resolving.
> >
> > B) The purpose of the features are:
> >
> >   1) Currently makedumpfile filters mm pages based on page flags, becau=
se flags
> >      can help to determine one page's usage. But this page-flag-checkin=
g method
> >      lacks of flexibility in certain cases, e.g. if we want to filter t=
hose mm
> >      pages occupied by GPU during vmcore dumping due to:
> >
> >      a) GPU may be taking a large memory and contains sensitive data;
> >      b) GPU mm pages have no relations to kernel crash and useless for =
vmcore
> >         analysis.
> >
> >      But there is no GPU mm page specific flags, and apparently we don'=
t need
> >      to create one just for kdump use. A programmable filtering tool is=
 more
> >      suitable for such cases. In addition, different GPU vendors may us=
e
> >      different ways for mm pages allocating, programmable filtering is =
better
> >      than hard coding these GPU specific logics into makedumpfile in th=
is case.
> >
> >   2) Currently makedumpfile already contains a programmable filtering t=
ool, aka
> >      eppic script, which allows user to write customized code for data =
erasing.
> >      However it has the following drawbacks:
> >
> >      a) cannot do mm page filtering.
> >      b) need to access to debuginfo of both kernel and modules, which i=
s not
> >         applicable in the 2nd kernel.
> >      c) eppic library has memory leaks which are not all resolved [1]. =
This
> >         is not acceptable in 2nd kernel.
> >
> >      makedumpfile need to resolve the dwarf data from debuginfo, to get=
 symbols
> >      types and addresses. In recent kernel there are dwarf alternatives=
 such
> >      as btf/kallsyms which can be used for this purpose. And btf/kallsy=
ms info
> >      are already packed within vmcore, so we can use it directly.
> >
> >   With these, this patchset introduces makedumpfile extensions, which i=
s based
> >   on btf/kallsyms symbol resolving, and is programmable for mm page fil=
tering.
> >   The following section shows its usage and performance, please note th=
e tests
> >   are performed in 1st kernel.
> >
> >   3) Compile and run makedumpfile extensions:
> >
> >   $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don EXT=
ENSION=3Don
> >   $ make extensions
> >
> >   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-=
06-10-18\:03\:12/vmcore
> >     /tmp/extension.out --extension amdgpu_filter.so
> >     Loaded extension: ./extensions/amdgpu_filter.so
> >     makedumpfile Completed.
> >         User time (seconds): 5.08
> >         System time (seconds): 0.84
> >         Percent of CPU this job got: 99%
> >         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
> >         Maximum resident set size (kbytes): 17360
> >         ...
> >
> >      To contrast with eppic script of v2 [2]:
> >
> >   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-=
06-10-18\:03\:12/vmcore
> >     /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >     makedumpfile Completed.
> >         User time (seconds): 8.23
> >         System time (seconds): 0.88
> >         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
> >         Maximum resident set size (kbytes): 57128
> >         ...
> >
> >   -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
> >   -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
> >   -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-20=
25-06-10-18:03:12/vmcore
> >
> > C) Discussion:
> >
> >   1) GPU types: Currently only tested with amdgpu's mm page filtering, =
others
> >      are not tested.
> >   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/pp=
c64.
> >      rhel8.x is not supported, others are not tested.
> >
> > D) Testing:
> >
> >      If you don't want to create your vmcore, you can find a vmcore whi=
ch I
> >      created with amdgpu mm pages unfiltered [3], the amdgpu mm pages a=
re
> >      allocated by program [4]. You can use the vmcore in 1st kernel to =
filter
> >      the amdgpu mm pages by the previous performance testing cmdline. T=
o
> >      verify the pages are filtered in crash:
> >
> >      Unfiltered:
> >      crash> search -c "!QAZXSW@#EDC"
> >      ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXX
> >      ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXX
> >      crash> rd ffff96b7fa800000
> >      ffff96b7fa800000:  405753585a415121                    !QAZXSW@
> >      crash> rd ffff96b87c800000
> >      ffff96b87c800000:  405753585a415121                    !QAZXSW@
> >
> >      Filtered:
> >      crash> search -c "!QAZXSW@#EDC"
> >      crash> rd ffff96b7fa800000
> >      rd: page excluded: kernel virtual address: ffff96b7fa800000  type:=
 "64-bit KVADDR"
> >      crash> rd ffff96b87c800000
> >      rd: page excluded: kernel virtual address: ffff96b87c800000  type:=
 "64-bit KVADDR"
> >
> > [1]: https://github.com/lucchouina/eppic/pull/32
> > [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.co=
m/
> > [3]: https://people.redhat.com/~ltao/core/vmcore
> > [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
> >
> > v5 -> v4:
> >
> > 1) Add "make EXTENSION=3Don" switch to customize the extension feature.
> > 2) Clean up macros within btf_info.h.
> > 3) Updated doc and a sample extension to demo the extension usage.
> > 4) Use MSG()/ERRMSG() rather than fprintf().
> > 5) Add return value check for readmem().
> > 6) Allow "makedumpfile -d 1 --extension ext.so" to enter extension.
> > 7) The patches are organized as follows:
> >
> >     --- <customization specific> ---
> >     9. Add amdgpu mm pages filtering extension
> >
> >     --- <code should be merged> ---
> >     8. Doc: Add --extension option to makedumpfile manual
> >     7. Add sample extension as an example reference
> >     6. Add makedumpfile extensions support
> >     5. Implement kernel module's btf resolving
> >     4. Implement kernel module's kallsyms resolving
> >     3. Implement kernel btf resolving
> >     2. Implement kernel kallsyms resolving
> >     1. Reserve sections for makedumpfile and extenions
> >
> >     Patch 9 is customization specific, merging depends on the strategy =
of
> >     maintenance.
> >     Patch 1 ~ 8 are common code which should be merged with makedumpfil=
e.
>
> Hi Tao,
>
> Just to be thorough, I did re-read the code of each patch, in addition
> to reviewing the diff from v4 to v5.
>
> I've also re-based my userspace stack extension on this new version.
> I think it is ready to go.
>
> Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>
> Thanks,
> Stephen
>
> > Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@r=
edhat.com/
> > Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@r=
edhat.com/
> > Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@re=
dhat.com/
> > Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@r=
edhat.com/
> >
> > Tao Liu (9):
> >   Reserve sections for makedumpfile and extenions
> >   Implement kernel kallsyms resolving
> >   Implement kernel btf resolving
> >   Implement kernel module's kallsyms resolving
> >   Implement kernel module's btf resolving
> >   Add makedumpfile extensions support
> >   Add sample extension as an example reference
> >   Doc: Add --extension option to makedumpfile manual
> >   Add amdgpu mm pages filtering extension
> >
> >  Makefile                   |  15 +-
> >  README                     |   6 +
> >  btf_info.c                 | 375 +++++++++++++++++++++++++
> >  btf_info.h                 |  77 ++++++
> >  extension.c                | 338 ++++++++++++++++++++++
> >  extension.h                |  16 ++
> >  extensions/Makefile        |  13 +
> >  extensions/amdgpu_filter.c | 221 +++++++++++++++
> >  extensions/maple_tree.c    | 328 ++++++++++++++++++++++
> >  extensions/maple_tree.h    |   7 +
> >  extensions/sample.c        |  69 +++++
> >  kallsyms.c                 | 554 +++++++++++++++++++++++++++++++++++++
> >  kallsyms.h                 |  87 ++++++
> >  makedumpfile.8.in          |  11 +-
> >  makedumpfile.c             |  44 ++-
> >  makedumpfile.h             |  12 +
> >  makedumpfile.ld            |  16 ++
> >  17 files changed, 2180 insertions(+), 9 deletions(-)
> >  create mode 100644 btf_info.c
> >  create mode 100644 btf_info.h
> >  create mode 100644 extension.c
> >  create mode 100644 extension.h
> >  create mode 100644 extensions/Makefile
> >  create mode 100644 extensions/amdgpu_filter.c
> >  create mode 100644 extensions/maple_tree.c
> >  create mode 100644 extensions/maple_tree.h
> >  create mode 100644 extensions/sample.c
> >  create mode 100644 kallsyms.c
> >  create mode 100644 kallsyms.h
> >  create mode 100644 makedumpfile.ld
> >
> > --
> > 2.47.0
>


