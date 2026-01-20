Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0738D2ED0F
	for <kexec@archiver.kernel.org>; Tue, 20 Jan 2026 04:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w+oR0Ns3A/pa0mFSnqUnQ+HOA14fFZhNL6lwwnnDk44=; b=Ly07HdbJ6JUOCXDKzTN6SVzURk
	L67Rm/6NAaqwkVr2elqNzkkbrEALMu+5fXbw1NnWLCg11GIBElOGPHL18rawLPR4EBc9240uPARL9
	6bMrdG5jc5GN/FDWmioUDSc1azGayh8Wo1qX+BUFhCW6rcdF2kcBJ479XmbGoAhC3vK+zkg30e2uj
	dMAos6HN1miPkNzQaWMhgifOnZJ/JYGWesXE9XvG2qbCKMq7yaswXPDDHwtT+D5pfQJQsHRmJcz3P
	swbttKwqHsoOy+iZo7sRY1+nOqXPpPTJhBkIBlnnP7S2yheVidnVDZSUt1J+W85/dqq+pa9kKyauv
	SKo8nnbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi3Yi-00000003Chg-2Iqp;
	Tue, 20 Jan 2026 04:41:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vi3YW-00000003ChH-45fq
	for kexec@lists.infradead.org;
	Tue, 20 Jan 2026 04:41:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768884088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+oR0Ns3A/pa0mFSnqUnQ+HOA14fFZhNL6lwwnnDk44=;
	b=TD7Bu+yBFAcqOLmx80K+N2NqWj2c8Va0mzNyi/Ga3d4pvMi2MBigtJNWjTE7K6zoVi9yRw
	PCW2QakmFV1iefTLvKNZyKOdcKKQsITrobRSpzU4tANUatVQ2Pm1KbKiRwBehzGvD9eDtQ
	TyatZM/0OhoTE78LiocWYuvqlUojyFw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-_qRNJoOuPcC-hwtV-ou4MA-1; Mon, 19 Jan 2026 23:40:00 -0500
X-MC-Unique: _qRNJoOuPcC-hwtV-ou4MA-1
X-Mimecast-MFC-AGG-ID: _qRNJoOuPcC-hwtV-ou4MA_1768884000
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5014c9ee70bso128382841cf.1
        for <kexec@lists.infradead.org>; Mon, 19 Jan 2026 20:40:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768884000; x=1769488800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w+oR0Ns3A/pa0mFSnqUnQ+HOA14fFZhNL6lwwnnDk44=;
        b=oacBYJor0h2/8JArTgs8HSQJ/fjxhHfHnwirrpHMWAAZCBVq+J30R7ZODevx3Mna2y
         LhS2DQOV2WdNEklE6OHNzOw5jd75lkWXSGDkbIBA50+kAi3+Otm64tNoKj6KkyMIhXkR
         WmWTOqWF3bYCR1rjSpc2a47W0Hp7fbCtGlsoRhfgIbI6b3z/OAfeW8BuASHgvfXC97lg
         mNQEPLEJqAwZp4NAFi2Yr/Ba5eMDNbU44k2LZkOTtN4jwpHejwKkcbbXFi5/MphrRdSW
         cCl87JmGKvP8ObskchWDK5rCdhvJtq8F4Fw6SR+ZeQH75hnSXUgTj4U28nMdzP+IhEmg
         BOXw==
X-Forwarded-Encrypted: i=1; AJvYcCWjIJsE9FkDjWKgNweo7gxtx9i56rS40my83yy6CtFHv3kiuidyBBj5dqD4MhSIRGXtiCO5iQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzvxAQJLaSKJm26K7wGrOiOx6mPwmGjKfMI8XaVulGKzwuRW3gz
	h8uubBIA9jY0d6DR+pkz3bGWe/+jU1maom5XQ+9wFpa+WTr7n8/dBpP8bxz+m0Es9yIMrTR6zGF
	oIBfZguCkeY/H1qlPn4BdX+HF4HVM8oWPaVmy+YOzZ1icJvLUJ8Pge+Km/H8gEylQML3Latxnsu
	NjlOq0ZccUt6hKvEASzjEAVHJdaFpK/2DCtLxA
X-Gm-Gg: AY/fxX5DDicQMsL9ShzC2aae01fXGE8AslHm/npGRMlc9lrcQ6SlemETGzAcg2ZXpk+
	4S5doWfOdkWlA0P8dX3o+TdGU8FPOUN/tiqbk/IuXJCdX6vtOtqRM58y4nvoDkcedIZl9x2i7pr
	Jeq0rYJLRAEGjAw0IOgAAjvrSlxHAczsjVHIK7RLN0VfiDEWRaVrMMc3pKnhfz2pLoaOE=
X-Received: by 2002:a05:622a:19a1:b0:4ee:1563:2837 with SMTP id d75a77b69052e-502a1f78db4mr181805721cf.67.1768883999774;
        Mon, 19 Jan 2026 20:39:59 -0800 (PST)
X-Received: by 2002:a05:622a:19a1:b0:4ee:1563:2837 with SMTP id
 d75a77b69052e-502a1f78db4mr181805561cf.67.1768883999399; Mon, 19 Jan 2026
 20:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20260120025500.25095-1-ltao@redhat.com>
In-Reply-To: <20260120025500.25095-1-ltao@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 20 Jan 2026 17:39:23 +1300
X-Gm-Features: AZwV_Qjy6wo0X4sXdnX_0XNFN_m1W00YQ3KpgpqTnaRLWcO21UhA2e2AGv9PSYc
Message-ID: <CAO7dBbWLfRfMXvN-we=4=Y+uyUze37=t_pJeq_hv_xJWr5iTAg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] btf/kallsyms based makedumpfile extension for mm
 page filtering
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, stephen.s.brennan@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N-mkmye83jj1lR0vK7zcyfWwXFYovBQfEDWiI5LiybQ_1768884000
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_204130_526594_F3E1A143 
X-CRM114-Status: GOOD (  34.63  )
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

Forget to mention, this patchset is for makedumpfile only.

On Tue, Jan 20, 2026 at 4:39=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
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
>   $ make LINKTYPE=3Ddynamic USELZO=3Don USESNAPPY=3Don USEZSTD=3Don
>   $ make extensions
>
>   $ /usr/bin/time -v ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06=
-10-18\:03\:12/vmcore
>     /tmp/extension.out
>     Loaded extension: ./extensions/amdgpu_filter.so
>     makedumpfile Completed.
>         User time (seconds): 6.37
>         System time (seconds): 0.70
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 0:07.10
>         Maximum resident set size (kbytes): 38024
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
>      Others are not tested.
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
> v3 -> v2:
>
> 1) Removed btf/kallsyms support for eppic script, and introduced
>    makedumpfile .so extension instead. The reason of removing eppic
>    support is:
>    a) Native binary code as .so has better performance than scripting,
>       see the time consumption contrast above.
>    b) Eppic library has memory leaks which hasn't been fixed totally,
>       memeory leaks in 2nd kernel might be fatal.
>
> 2) Removed the code of manually parsing btf info, and used libbpf for
>    btf info parsing instead. The reason of removing manually parsing is:
>    a) Less code modification to makedumpfile, easier to maintain.
>    b) The performance of using libbpf is as good as manual parsing +
>       hash table indexing, as well as less memory consumption, see time
>       and memory consumption contrast above.
>
> 3) The patches are organized as follows:
>
>     --- <only for test purpose, don't merge> ---
>     8.Filter amdgpu mm pages
>     7.Add maple tree support to makedumpfile extension
>
>     --- <code should be merged> ---
>     6.Add page filtering function
>     5.Add makedumpfile extension support
>     4.Implement kernel modules' btf resolving
>     3.Implement kernel modules' kallsyms resolving
>     2.Implement kernel btf resolving
>     1.Implement kernel kallsyms resolving
>
>     Patch 7 & 8 are customization specific, which can be maintained separ=
ately.
>     Patch 1 ~ 6 are common code which should be integrate with makedumpfi=
le.
>
> Link to v2: https://lore.kernel.org/kexec/20251020222410.8235-1-ltao@redh=
at.com/
> Link to v1: https://lore.kernel.org/kexec/20250610095743.18073-1-ltao@red=
hat.com/
>
> Tao Liu (8):
>   Implement kernel kallsyms resolving
>   Implement kernel btf resolving
>   Implement kernel modules' kallsyms resolving
>   Implement kernel modules' btf resolving
>   Add makedumpfile extension support
>   Add page filtering function
>   Add maple tree support to makedumpfile extension
>   Filter amdgpu mm pages
>
>  Makefile                   |   9 +-
>  btf_info.c                 | 260 +++++++++++++++++++++++++
>  btf_info.h                 |  66 +++++++
>  erase_info.c               |  98 ++++++++++
>  erase_info.h               |  12 ++
>  extension.c                |  82 ++++++++
>  extensions/Makefile        |  10 +
>  extensions/amdgpu_filter.c |  90 +++++++++
>  extensions/maple_tree.c    | 336 +++++++++++++++++++++++++++++++++
>  extensions/maple_tree.h    |   6 +
>  kallsyms.c                 | 376 +++++++++++++++++++++++++++++++++++++
>  kallsyms.h                 |  20 ++
>  makedumpfile.c             |  35 +++-
>  makedumpfile.h             |  11 ++
>  14 files changed, 1405 insertions(+), 6 deletions(-)
>  create mode 100644 btf_info.c
>  create mode 100644 btf_info.h
>  create mode 100644 extension.c
>  create mode 100644 extensions/Makefile
>  create mode 100644 extensions/amdgpu_filter.c
>  create mode 100644 extensions/maple_tree.c
>  create mode 100644 extensions/maple_tree.h
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>
> --
> 2.47.0
>


