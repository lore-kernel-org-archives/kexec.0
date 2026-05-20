Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A9D0CD4F5E
	for <kexec@archiver.kernel.org>; Wed, 20 May 2026 04:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jgWHaf2en1S+oBrh0aG8tlZlbuZL4MlFSsuFRKFFFW8=; b=azWs1k5qAipuk3li3vSYOOgYmz
	3YHW1ScsE96Mpyek0jYTuMNorZRTFyFPd9Nlljt5ONzMHC5GbKjvYR0AcVenmo1hMGBFJiOQeRA8M
	otww1CTWpPOLZGnLxIl5kojVVmQ/kxEMAsdF2EAXgZxpVQxgvHfxKdMyrbG+QxgP5NQoPvCf2+UrY
	fTgWe58xkpqqj5w5A8N1w8sh/QRpX1E7J+2ughNXVxe9kvihLsZyX5JG9p4/TOslLAWYThKU3UReJ
	U93C4V2Mb+mKZ1qd5X0zUcXjsiXMXoc6cbglQLyPChRBU5h0rm32M0bqMs6cZ+cfEqF5U4aCtY6YL
	/pUEpetQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPZ0U-00000003WQZ-2NHt;
	Wed, 20 May 2026 04:58:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPZ0N-00000003WPt-1K2M
	for kexec@lists.infradead.org;
	Wed, 20 May 2026 04:58:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779253081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgWHaf2en1S+oBrh0aG8tlZlbuZL4MlFSsuFRKFFFW8=;
	b=H5xP98jqJGeKy5Q9yCJ42XPiZauFKrLbCY/O6jFLcoXDvkPilQH5uxrHi9v+llyemf7Zrw
	isGGErg9rPLhk9ocbFy49H47CwK5pLUxxj3EEiU3GcssSkRb9RKTihrIPm6buV1aO4m01x
	7Geuf6kwYIXJTkQfOa+Tebcn65U3yuw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-Js1qk1dUMyahNej-FN1Q0Q-1; Wed, 20 May 2026 00:55:48 -0400
X-MC-Unique: Js1qk1dUMyahNej-FN1Q0Q-1
X-Mimecast-MFC-AGG-ID: Js1qk1dUMyahNej-FN1Q0Q_1779252948
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-90d7b3406b2so1083317285a.3
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 21:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779252948; x=1779857748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jgWHaf2en1S+oBrh0aG8tlZlbuZL4MlFSsuFRKFFFW8=;
        b=UERRSUVWH3QQ1aUjQPs4C7o3o4RWbmEitN99QExCmmfshwPuEM2tp/1jpxLuXpYoM+
         Z3Tqp6DHnHAb7m+EwL7bdI8CsYmojEnBoUgbP8ESgOzcOonNVHOWNVJELd/8qK5ak4mZ
         NxYYNusKKvYqZHKePejvw1TuUzuJ2N2Zsm0TI12/yQ0/MhxDPNywjufJxF96J/Xk7vT/
         B28PIHZh5AsRiNYgMIhtp/BaVfokRiZW+idDIoa6jZle9EfSzmrBqoPzCcINEx0BpKsT
         Ogh5UCM7qrXh152e/w+CGakZRjwZE+JnjbayTuW2MkdBzUWJBP846WIKAGLIDYWiTS53
         xzAA==
X-Forwarded-Encrypted: i=1; AFNElJ/swoMIdpQrkJGyqDSqrwa2HplmbXvuW8RW3cDVJsRanOw8NXUiLubedAmtn1p2G8LV0r/oaA==@lists.infradead.org
X-Gm-Message-State: AOJu0YzpekeH4lTewkDvusGFb8TWim90sZqZ1mnHiTcWU1//ySK1X+Ou
	RqKnlhViyoZ5WlQninMJNQIOt0OvA9yA0I8oZ2GWZe9NkR5rY6P2gfeBUfc6M3wQfacQ88q1JAS
	Pq9TD7sO9Q08WRNRchatdSAKWvBEs/2SPmk9Rhfg9UoKLNheEmNCd91K6hMRJqMl9ZoJvE9gW11
	pKE51YbQS/g0n+39ysdRYXElkj3GMaKQ3v/Vg9Vxt/iQR2
X-Gm-Gg: Acq92OE/retNEbNOw2ChCHyTcCXU17BLDTTM3n9wmwU7J2fbWrNCNgSZt3CiCwi+Tr2
	4c6mgcBLmFVO7f/pIu501R+LQX1YdJ1mMIMJAt5Pn9tnvq4YiccbUhlcckpen9n7U9vsu/APFpX
	kJX5OBwoOhkRW+ZmkYedvztByEon6VguSQ/L/d1wHAzCcyQ7XBq1IqYPU60lw+GFANcP+EsTu70
	piSjg==
X-Received: by 2002:a05:620a:294f:b0:8ee:7878:af33 with SMTP id af79cd13be357-911cdc49379mr3305588385a.4.1779252948166;
        Tue, 19 May 2026 21:55:48 -0700 (PDT)
X-Received: by 2002:a05:620a:294f:b0:8ee:7878:af33 with SMTP id
 af79cd13be357-911cdc49379mr3305586785a.4.1779252947690; Tue, 19 May 2026
 21:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260414102656.55200-1-ltao@redhat.com>
In-Reply-To: <20260414102656.55200-1-ltao@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Wed, 20 May 2026 16:55:11 +1200
X-Gm-Features: AVHnY4IIKzflxcQNxLasLMiPeJ-6YPMMXukUNP6f59MvCVIU4d0y0uJYdp0-NLI
Message-ID: <CAO7dBbXOpsFmUOO6CR+bEudHcL162neVdMTUmPK_w8tBLHNJng@mail.gmail.com>
Subject: Re: [PATCH v5][makedumpfile 0/9] btf/kallsyms based makedumpfile
 extension for mm page filtering
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JeuEV4GO2P97aaxaRYNW3CatP0fUHuuaN7_kirfTSEI_1779252948
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_215806_723595_EA63CB80 
X-CRM114-Status: GOOD (  34.65  )
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

Kindly ping, Any comments for this patchset?

Thanks,
Tao Liu

On Tue, Apr 14, 2026 at 10:27=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> A) This patchset will introduce the following features to makedumpfile:
>
>   1) Add .so extension support to makedumpfile
>   2) Enable btf and kallsyms for symbol type and address resolving.
>
> B) The purpose of the features are:
>
>   1) Currently makedumpfile filters mm pages based on page flags, because=
 flags
>      can help to determine one page's usage. But this page-flag-checking =
method
>      lacks of flexibility in certain cases, e.g. if we want to filter tho=
se mm
>      pages occupied by GPU during vmcore dumping due to:
>
>      a) GPU may be taking a large memory and contains sensitive data;
>      b) GPU mm pages have no relations to kernel crash and useless for vm=
core
>         analysis.
>
>      But there is no GPU mm page specific flags, and apparently we don't =
need
>      to create one just for kdump use. A programmable filtering tool is m=
ore
>      suitable for such cases. In addition, different GPU vendors may use
>      different ways for mm pages allocating, programmable filtering is be=
tter
>      than hard coding these GPU specific logics into makedumpfile in this=
 case.
>
>   2) Currently makedumpfile already contains a programmable filtering too=
l, aka
>      eppic script, which allows user to write customized code for data er=
asing.
>      However it has the following drawbacks:
>
>      a) cannot do mm page filtering.
>      b) need to access to debuginfo of both kernel and modules, which is =
not
>         applicable in the 2nd kernel.
>      c) eppic library has memory leaks which are not all resolved [1]. Th=
is
>         is not acceptable in 2nd kernel.
>
>      makedumpfile need to resolve the dwarf data from debuginfo, to get s=
ymbols
>      types and addresses. In recent kernel there are dwarf alternatives s=
uch
>      as btf/kallsyms which can be used for this purpose. And btf/kallsyms=
 info
>      are already packed within vmcore, so we can use it directly.
>
>   With these, this patchset introduces makedumpfile extensions, which is =
based
>   on btf/kallsyms symbol resolving, and is programmable for mm page filte=
ring.
>   The following section shows its usage and performance, please note the =
tests
>   are performed in 1st kernel.
>
>   3) Compile and run makedumpfile extensions:
>
>   $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don EXTEN=
SION=3Don
>   $ make extensions
>
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06=
-10-18\:03\:12/vmcore
>     /tmp/extension.out --extension amdgpu_filter.so
>     Loaded extension: ./extensions/amdgpu_filter.so
>     makedumpfile Completed.
>         User time (seconds): 5.08
>         System time (seconds): 0.84
>         Percent of CPU this job got: 99%
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:05.95
>         Maximum resident set size (kbytes): 17360
>         ...
>
>      To contrast with eppic script of v2 [2]:
>
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06=
-10-18\:03\:12/vmcore
>     /tmp/eppic.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
>     makedumpfile Completed.
>         User time (seconds): 8.23
>         System time (seconds): 0.88
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:09.16
>         Maximum resident set size (kbytes): 57128
>         ...
>
>   -rw------- 1 root root 367475074 Jan 19 19:01 /tmp/extension.out
>   -rw------- 1 root root 367475074 Jan 19 19:48 /tmp/eppic.out
>   -rw------- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025=
-06-10-18:03:12/vmcore
>
> C) Discussion:
>
>   1) GPU types: Currently only tested with amdgpu's mm page filtering, ot=
hers
>      are not tested.
>   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc6=
4.
>      rhel8.x is not supported, others are not tested.
>
> D) Testing:
>
>      If you don't want to create your vmcore, you can find a vmcore which=
 I
>      created with amdgpu mm pages unfiltered [3], the amdgpu mm pages are
>      allocated by program [4]. You can use the vmcore in 1st kernel to fi=
lter
>      the amdgpu mm pages by the previous performance testing cmdline. To
>      verify the pages are filtered in crash:
>
>      Unfiltered:
>      crash> search -c "!QAZXSW@#EDC"
>      ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXX
>      ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXX
>      crash> rd ffff96b7fa800000
>      ffff96b7fa800000:  405753585a415121                    !QAZXSW@
>      crash> rd ffff96b87c800000
>      ffff96b87c800000:  405753585a415121                    !QAZXSW@
>
>      Filtered:
>      crash> search -c "!QAZXSW@#EDC"
>      crash> rd ffff96b7fa800000
>      rd: page excluded: kernel virtual address: ffff96b7fa800000  type: "=
64-bit KVADDR"
>      crash> rd ffff96b87c800000
>      rd: page excluded: kernel virtual address: ffff96b87c800000  type: "=
64-bit KVADDR"
>
> [1]: https://github.com/lucchouina/eppic/pull/32
> [2]: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redhat.com/
> [3]: https://people.redhat.com/~ltao/core/vmcore
> [4]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
>
> v5 -> v4:
>
> 1) Add "make EXTENSION=3Don" switch to customize the extension feature.
> 2) Clean up macros within btf_info.h.
> 3) Updated doc and a sample extension to demo the extension usage.
> 4) Use MSG()/ERRMSG() rather than fprintf().
> 5) Add return value check for readmem().
> 6) Allow "makedumpfile -d 1 --extension ext.so" to enter extension.
> 7) The patches are organized as follows:
>
>     --- <customization specific> ---
>     9. Add amdgpu mm pages filtering extension
>
>     --- <code should be merged> ---
>     8. Doc: Add --extension option to makedumpfile manual
>     7. Add sample extension as an example reference
>     6. Add makedumpfile extensions support
>     5. Implement kernel module's btf resolving
>     4. Implement kernel module's kallsyms resolving
>     3. Implement kernel btf resolving
>     2. Implement kernel kallsyms resolving
>     1. Reserve sections for makedumpfile and extenions
>
>     Patch 9 is customization specific, merging depends on the strategy of
>     maintenance.
>     Patch 1 ~ 8 are common code which should be merged with makedumpfile.
>
> Link to v4: https://lore.kernel.org/kexec/20260317150743.69590-1-ltao@red=
hat.com/
> Link to v3: https://lore.kernel.org/kexec/20260120025500.25095-1-ltao@red=
hat.com/
> Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redh=
at.com/
> Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@red=
hat.com/
>
> Tao Liu (9):
>   Reserve sections for makedumpfile and extenions
>   Implement kernel kallsyms resolving
>   Implement kernel btf resolving
>   Implement kernel module's kallsyms resolving
>   Implement kernel module's btf resolving
>   Add makedumpfile extensions support
>   Add sample extension as an example reference
>   Doc: Add --extension option to makedumpfile manual
>   Add amdgpu mm pages filtering extension
>
>  Makefile                   |  15 +-
>  README                     |   6 +
>  btf_info.c                 | 375 +++++++++++++++++++++++++
>  btf_info.h                 |  77 ++++++
>  extension.c                | 338 ++++++++++++++++++++++
>  extension.h                |  16 ++
>  extensions/Makefile        |  13 +
>  extensions/amdgpu_filter.c | 221 +++++++++++++++
>  extensions/maple_tree.c    | 328 ++++++++++++++++++++++
>  extensions/maple_tree.h    |   7 +
>  extensions/sample.c        |  69 +++++
>  kallsyms.c                 | 554 +++++++++++++++++++++++++++++++++++++
>  kallsyms.h                 |  87 ++++++
>  makedumpfile.8.in          |  11 +-
>  makedumpfile.c             |  44 ++-
>  makedumpfile.h             |  12 +
>  makedumpfile.ld            |  16 ++
>  17 files changed, 2180 insertions(+), 9 deletions(-)
>  create mode 100644 btf_info.c
>  create mode 100644 btf_info.h
>  create mode 100644 extension.c
>  create mode 100644 extension.h
>  create mode 100644 extensions/Makefile
>  create mode 100644 extensions/amdgpu_filter.c
>  create mode 100644 extensions/maple_tree.c
>  create mode 100644 extensions/maple_tree.h
>  create mode 100644 extensions/sample.c
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>  create mode 100644 makedumpfile.ld
>
> --
> 2.47.0
>


