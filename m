Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C078CDB466
	for <kexec@archiver.kernel.org>; Tue, 23 Jun 2026 01:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9YcrmYwbNt0RCYJ3J9aS+ukwCUWNKcnEAdN095lDbyc=; b=Bhm5SEiS/SBkqLMJqZiGSjgGIi
	esuswDBB6JX5qWbK2x3Uc5T3m7k5KYA7ZM8+ca8oYRznguyaJw0XRsl50xfkM0ihrpdb0or5/Zdnj
	twsuTdKLjcUzjjY8gHsYox7Wtz0FM3PTXR97W+IBP0i4o/YnF6cTHrnTFzW1a6zp27eBXA5CKqqoP
	c/LnizStYdRPHqYtu7hnONNCwlHjVBG0WdQUIv5IYGPuBXHbdhq8ROjbVcC4OyrxhYuSaT9w/wcOu
	/jG5P69vBBpg5d7ZoyMeigL+GypNJuYHFkN70/QK444NM4iylWwEuz6qu90NgSLfIbAR1laSGAklx
	lqRkAqXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbqGS-00000005Ynd-0DPp;
	Tue, 23 Jun 2026 01:49:24 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbqGN-00000005YnA-2Nto
	for kexec@lists.infradead.org;
	Tue, 23 Jun 2026 01:49:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782179358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9YcrmYwbNt0RCYJ3J9aS+ukwCUWNKcnEAdN095lDbyc=;
	b=CJUX/8ZRKzigGxNV1bt6vgH/hSwpDRsbwA15jsS8ftWQ+PoIGR60FG623eSxf3R42bhRZ5
	aJEPtpBDWuYHLHuCyWWtxkOptbaT7mDkHpd/ab9jzFzPKt1/5UN0CwP5FxdmxIYKGpmMQP
	zaN9RMF7wV0WAQMk0fJzw533SmQoZ/Y=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-9Hwa13E5OlWe65QTfPyXUg-1; Mon, 22 Jun 2026 21:49:16 -0400
X-MC-Unique: 9Hwa13E5OlWe65QTfPyXUg-1
X-Mimecast-MFC-AGG-ID: 9Hwa13E5OlWe65QTfPyXUg_1782179356
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517787172b0so95500451cf.0
        for <kexec@lists.infradead.org>; Mon, 22 Jun 2026 18:49:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782179356; x=1782784156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9YcrmYwbNt0RCYJ3J9aS+ukwCUWNKcnEAdN095lDbyc=;
        b=Zv2TGGcmgGK046h/o47bzrNoR8VCiWTUM20w9He3L5DG8lAi+ml7OxcfzoI5Ng+663
         qGgNbiYlFAJXNSswq7phEWmR5LBnDo5nned/f19Ah3Ebm9wpRTQaLQYIrRWT3LQ69nX7
         P+PVeaRVQhSMRcph6ozaORlTaSWpbbisdmQ9geI4yThGhnVrBU+2AXFtPh/0w7esmVno
         qOlAt8yLaDUAXFtMrflH3tJcWTf7mOw8bAToYqAPFUwO2C8Q2P1s9wHeV/8Z1CIASB4W
         bIqg6qR45cWYcM/QVyU2p695nYl6URy7fH6H8ZuyCjvocc0gKLOOENCBSnadrKWi2aI/
         hfTw==
X-Forwarded-Encrypted: i=1; AFNElJ9AGZeXFIOHeAdLqM/wQ8WKPcS1XYxcppAQsXj8FOCYOiBnrjjJjZAba6t2faWxUqA3xrqcTg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yz4ZWJNb1E6eiUoZMx7zIf8BvvJnw7KXEUOblKq3aUKCPbSbpqv
	NYUvVwaCMqRFfAC6YJ9gHozAhv+k1R/i82KnKjwn+5BfslsZ9AVpyaN5OWIwsEHH//t/VJwhsLu
	WwTvOi7QuQNvjwTU7IEa9bAcyRomP55+gymA4oDch9D/dC90KNxbDpYJSkKTFGtOjrSTKvzRXpe
	KS03Ob7GmGJ9FlAiMbvaLAGueGOKxpNUP2pski
X-Gm-Gg: AfdE7clrklcPFt1YM1QQ5vqDvRdeHAanPIVkty7iXFil84YgajfvbK0zb+cC9DLkvQ7
	6IwkPUflZ3d2LNx38TAWVdCtDgeOKN5t1zwf4fdvJLonmRI28eNFBGJx2H+Gd0MmAFUamC80BU1
	CuV6qIap/U0Aqi+82qd5aAvqOCljkfCV/U2DzFPa0383mblqY8w4DWU1Yi8jHrqLnSnNw=
X-Received: by 2002:a05:622a:4898:b0:519:c97e:b9ae with SMTP id d75a77b69052e-519e4dfc029mr258289391cf.50.1782179355766;
        Mon, 22 Jun 2026 18:49:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4898:b0:519:c97e:b9ae with SMTP id
 d75a77b69052e-519e4dfc029mr258289111cf.50.1782179355254; Mon, 22 Jun 2026
 18:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260617051834.95404-1-ltao@redhat.com> <ce5b6cb7-312a-40c6-81de-0e76f92a1b19@nec.com>
In-Reply-To: <ce5b6cb7-312a-40c6-81de-0e76f92a1b19@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 23 Jun 2026 13:48:38 +1200
X-Gm-Features: AVVi8CeQwj6WLmSGTHSyj6QDqQ5VwJ9J5XXAwQrWgXm1_EoppwgB26uNkjxen9Q
Message-ID: <CAO7dBbWgeM7AsdXz0A6P1Lz130ibq2-tXLcwecXoP67ZB3k7+g@mail.gmail.com>
Subject: Re: [PATCH v6][makedumpfile 00/10] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"stephen.s.brennan@oracle.com" <stephen.s.brennan@oracle.com>, 
	"kjlx@templeofstupid.com" <kjlx@templeofstupid.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NwywXBYdOeK25fFUjuetgc8UYfEunvHbinMVxL2Z-aU_1782179356
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_184919_982851_D28F1968 
X-CRM114-Status: GOOD (  40.62  )
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

Hi Kazu,

On Mon, Jun 22, 2026 at 5:57=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> Hi Tao,
>
> I've tested some, no issue was detected.
>
> [without the patchset]
> 8.09user 1.01system 0:10.04elapsed 90%CPU (0avgtext+0avgdata 4480maxresid=
ent)k
> 18672inputs+763736outputs (0major+268minor)pagefaults 0swaps
>
> [with the patchset without --extension]
> 8.08user 0.99system 0:09.94elapsed 91%CPU (0avgtext+0avgdata 4608maxresid=
ent)k  # +128k
> 19640inputs+763720outputs (4major+277minor)pagefaults 0swaps
>
> [with the patchset with --extension]
> 6.38user 0.74system 0:07.92elapsed 89%CPU (0avgtext+0avgdata 16984maxresi=
dent)k # +12M
> 17048inputs+725240outputs (0major+3121minor)pagefaults 0swaps
>
> There is also no noticeable rise in max rss without --extension.
>
> Maybe support for compound pages can be debatable in the future, but
> I think the current patchset is good enough for extension v1.
> So merged 01/10 - 09/10 patches, thank you for the great work!

Thanks for your testing, also many thanks for your code review and suggesti=
ons!

Thanks,
Tao Liu

>
> Thanks,
> Kazu
>
>
>
> On 2026/06/17 14:18, Tao Liu wrote:
> > A) This patchset will introduce the following features to makedumpfile:
> >
> >    1) Add .so extension support to makedumpfile
> >    2) Enable btf and kallsyms for symbol type and address resolving.
> >
> > B) The purpose of the features are:
> >
> >    1) Currently makedumpfile filters mm pages based on page flags, beca=
use flags
> >       can help to determine one page's usage. But this page-flag-checki=
ng method
> >       lacks of flexibility in certain cases, e.g. if we want to filter =
those mm
> >       pages occupied by GPU during vmcore dumping due to:
> >
> >       a) GPU may be taking a large memory and contains sensitive data;
> >       b) GPU mm pages have no relations to kernel crash and useless for=
 vmcore
> >          analysis.
> >
> >       But there is no GPU mm page specific flags, and apparently we don=
't need
> >       to create one just for kdump use. A programmable filtering tool i=
s more
> >       suitable for such cases. In addition, different GPU vendors may u=
se
> >       different ways for mm pages allocating, programmable filtering is=
 better
> >       than hard coding these GPU specific logics into makedumpfile in t=
his case.
> >
> >    2) Currently makedumpfile already contains a programmable filtering =
tool, aka
> >       eppic script, which allows user to write customized code for data=
 erasing.
> >       However it has the following drawbacks:
> >
> >       a) cannot do mm page filtering.
> >       b) need to access to debuginfo of both kernel and modules, which =
is not
> >          applicable in the 2nd kernel.
> >       c) eppic library has memory leaks which are not all resolved [1].=
 This
> >          is not acceptable in 2nd kernel.
> >
> >       makedumpfile need to resolve the dwarf data from debuginfo, to ge=
t symbols
> >       types and addresses. In recent kernel there are dwarf alternative=
s such
> >       as btf/kallsyms which can be used for this purpose. And btf/kalls=
yms info
> >       are already packed within vmcore, so we can use it directly.
> >
> >    With these, this patchset introduces makedumpfile extensions, which =
is based
> >    on btf/kallsyms symbol resolving, and is programmable for mm page fi=
ltering.
> >    The following section shows its usage and performance, please note t=
he tests
> >    are performed in 1st kernel.
> >
> >    3) Compile and run makedumpfile extensions:
> >
> >    $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don EX=
TENSION=3Don
> >    $ make extensions
> >
> >    $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025=
-06-10-18\:03\:12/vmcore
> >      /tmp/extension.out --extension amdgpu_filter.so
> >      Loaded extension: ./extensions/amdgpu_filter.so
> >      makedumpfile Completed.
> >          User time (seconds): 5.08
> >          System time (seconds): 0.84
> >          Percent of CPU this job got: 99%
> >          Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
> >          Maximum resident set size (kbytes): 17360
> >          ...
> >
> >       To contrast with eppic script of v2 [2]:
> >
> >    $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025=
-06-10-18\:03\:12/vmcore
> >      /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >      makedumpfile Completed.
> >          User time (seconds): 8.23
> >          System time (seconds): 0.88
> >          Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
> >          Maximum resident set size (kbytes): 57128
> >          ...
> >
> >    -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
> >    -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
> >    -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2=
025-06-10-18:03:12/vmcore
> >
> > C) Discussion:
> >
> >    1) GPU types: Currently only tested with amdgpu's mm page filtering,=
 others
> >       are not tested.
> >    2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/p=
pc64.
> >       rhel8.x is not supported, others are not tested.
> >
> > D) Testing:
> >
> >       If you don't want to create your vmcore, you can find a vmcore wh=
ich I
> >       created with amdgpu mm pages unfiltered [3], the amdgpu mm pages =
are
> >       allocated by program [4]. You can use the vmcore in 1st kernel to=
 filter
> >       the amdgpu mm pages by the previous performance testing cmdline. =
To
> >       verify the pages are filtered in crash:
> >
> >       Unfiltered:
> >       crash> search -c "!QAZXSW@#EDC"
> >       ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXX
> >       ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXX
> >       crash> rd ffff96b7fa800000
> >       ffff96b7fa800000:  405753585a415121                    !QAZXSW@
> >       crash> rd ffff96b87c800000
> >       ffff96b87c800000:  405753585a415121                    !QAZXSW@
> >
> >       Filtered:
> >       crash> search -c "!QAZXSW@#EDC"
> >       crash> rd ffff96b7fa800000
> >       rd: page excluded: kernel virtual address: ffff96b7fa800000  type=
: "64-bit KVADDR"
> >       crash> rd ffff96b87c800000
> >       rd: page excluded: kernel virtual address: ffff96b87c800000  type=
: "64-bit KVADDR"
> >
> > [1]: https://github.com/lucchouina/eppic/pull/32
> > [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.co=
m/
> > [3]: https://people.redhat.com/~ltao/core/vmcore
> > [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
> >
> > v6 -> v5:
> >
> > 1) Add erase_sample extension for data erasure sample.
> > 2) Replace fprintf() to MSG()/ERRMSG() in kallsyms.h.
> > 3) Use handle_cbs_len in extension_has_callback() for callback check.
> > 4) Fix bug[5].
> > 5) Add handle_cbs[i]->cb =3D NULL in init_extensions() to reset the
> >     callback if one extension's init() is skipped.
> > 6) The patches are organized as follows:
> >
> >     ---- <customization specific> ---
> >     10. Add amdgpu mm pages filtering extension
> >
> >      --- <code should be merged> ---
> >      9. Doc: Add --extension option to makedumpfile manual
> >      8. Add erase_sample extension as an data erase reference
> >      7. Add sample extension as an example reference
> >      6. Add makedumpfile extensions support
> >      5. Implement kernel module's btf resolving
> >      4. Implement kernel module's kallsyms resolving
> >      3. Implement kernel btf resolving
> >      2. Implement kernel kallsyms resolving
> >      1. Reserve sections for makedumpfile and extenions
> >
> >      Patch 10 is customization specific, merging depends on the strateg=
y of
> >      maintenance.
> >      Patch 1 ~ 9 are common code which should be merged with makedumpfi=
le.
> >
> > [5]: https://lore.kernel.org/kexec/ab1b5e58-bad6-4565-a408-b1fb3d489465=
@nec.com/
> >
> > Link to v5: https://lore.kernel.org/kexec/20260414102656.55200-1-ltao@r=
edhat.com/
> > Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@r=
edhat.com/
> > Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@r=
edhat.com/
> > Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@re=
dhat.com/
> > Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@r=
edhat.com/
> >
> > Tao Liu (10):
> >    Reserve sections for makedumpfile and extenions
> >    Implement kernel kallsyms resolving
> >    Implement kernel btf resolving
> >    Implement kernel module's kallsyms resolving
> >    Implement kernel module's btf resolving
> >    Add makedumpfile extensions support
> >    Add sample extension as an example reference
> >    Add erase_sample extension as an data erase reference
> >    Doc: Add --extension option to makedumpfile manual
> >    Add amdgpu mm pages filtering extension
> >
> >   Makefile                   |  15 +-
> >   README                     |   6 +
> >   btf_info.c                 | 371 +++++++++++++++++++++++++
> >   btf_info.h                 |  77 ++++++
> >   extension.c                | 355 ++++++++++++++++++++++++
> >   extension.h                |  16 ++
> >   extensions/Makefile        |  13 +
> >   extensions/amdgpu_filter.c | 221 +++++++++++++++
> >   extensions/erase_sample.c  |  78 ++++++
> >   extensions/maple_tree.c    | 328 ++++++++++++++++++++++
> >   extensions/maple_tree.h    |   7 +
> >   extensions/sample.c        |  69 +++++
> >   kallsyms.c                 | 550 ++++++++++++++++++++++++++++++++++++=
+
> >   kallsyms.h                 |  86 ++++++
> >   makedumpfile.8.in          |  11 +-
> >   makedumpfile.c             |  44 ++-
> >   makedumpfile.h             |  12 +
> >   makedumpfile.ld            |  16 ++
> >   18 files changed, 2266 insertions(+), 9 deletions(-)
> >   create mode 100644 btf_info.c
> >   create mode 100644 btf_info.h
> >   create mode 100644 extension.c
> >   create mode 100644 extension.h
> >   create mode 100644 extensions/Makefile
> >   create mode 100644 extensions/amdgpu_filter.c
> >   create mode 100644 extensions/erase_sample.c
> >   create mode 100644 extensions/maple_tree.c
> >   create mode 100644 extensions/maple_tree.h
> >   create mode 100644 extensions/sample.c
> >   create mode 100644 kallsyms.c
> >   create mode 100644 kallsyms.h
> >   create mode 100644 makedumpfile.ld
> >


