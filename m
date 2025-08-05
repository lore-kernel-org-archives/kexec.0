Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84296C87FCF
	for <kexec@archiver.kernel.org>; Tue,  5 Aug 2025 03:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2R0cOtf/PA/oA8oWBEP22bFfkRjBHmb5eLMUVCLvp2s=; b=StLfvlELBE5j5yDyNc5wr/OxQF
	nxxa/Su8ai9e0JS1/VXXYTe5rFBifPcU+cjNpkxDoc7IKlZAIq35yIbMhcghTzBZOB+uL/R4LumGK
	bDOA9mR/K5JZgzimNvzyxVHdd0O84N+bOHR4cntIy507FlQB1ouDYxt/g6HY0QM5q1Sx9DsIJMmBU
	Sc0Vv8/3OD0dza/+Na0yK8EnJJkLAdf2hi59JZnemyLY6enjjNNUAAgMOcciuGAr2wVq3uoWjsZXO
	llXrR8kWqBzzlaPSOtDas6ifPJCWpgMc3+CXNWJkZqzD1nAMAFBwowdkXFd6hMVuvLWkxss3W3iuN
	7ybaBzFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj8Ag-0000000BfwT-2n0k;
	Tue, 05 Aug 2025 03:17:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj8AZ-0000000Bfw3-2zPP
	for kexec@lists.infradead.org;
	Tue, 05 Aug 2025 03:16:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754363812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2R0cOtf/PA/oA8oWBEP22bFfkRjBHmb5eLMUVCLvp2s=;
	b=hI5Ma/yPWC1T5CPiIf1R2XKZEbdflqtUkwPsJXJk4q1O5iJpRS8EfCmFosozUFKEDcdRxl
	eS50tWN8YbxkjHNKn7lW3/YQzZ95xDssFxCDjygUOvRCDvtQEDiCFR4I0DmzEiVf7J6EFH
	phEFsHYe+aFbARmazeO99mfYNJOHs3k=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-zPhRVKhsOQCbQ570t4Svew-1; Mon, 04 Aug 2025 23:16:51 -0400
X-MC-Unique: zPhRVKhsOQCbQ570t4Svew-1
X-Mimecast-MFC-AGG-ID: zPhRVKhsOQCbQ570t4Svew_1754363811
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab878dfc1aso119450171cf.0
        for <kexec@lists.infradead.org>; Mon, 04 Aug 2025 20:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754363810; x=1754968610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2R0cOtf/PA/oA8oWBEP22bFfkRjBHmb5eLMUVCLvp2s=;
        b=enGVUxIzdEhtZnAaHKQwMwFtspVC57bPs3vU6/6Qjcqh4pRWzTi7BcP06FAEvgUdgX
         fQ+pC62imjYNxpgIzHlL1+NCd2paUYm4FTSKVVahsy1xLn9yPNG9EVhn9MQZaByXaBKp
         G5aVKRHwkZj4aTMcw5I1AfZaLit5p4i40/C3rvaCUiIiKM1Vhfb4sMCMt9yVKWi9g5MG
         QAvIUVpYgPBs20lWv2TX/6PR1rLvsZe5vskKZROMIl4fAfk2PNpsY+I65Zbq+q7czUMT
         GuyeN4gmoOpE8ucZ12QFkgcltLdqhf6i1QE6xO5mqksNBmwqE/46kgt/W/rB13FDm5X4
         Rslg==
X-Forwarded-Encrypted: i=1; AJvYcCXflCvuViLfFHnsaBCFqdpl7SYr43jp2DhpMNkY4si2TUQFnDGi/+AUTIuCVnTpH8txGxTZjA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz/m/zkBdvM1c91Cwv6kZBL4WfMIhW4y3eGjAQO+2WHE7LHZn7
	2wFWrUyg2jQSEWBZIjOKKRuCFN1O9/pMcMTsmLnx+zQ4dUtToAp4K1lZwm9dUaXQN1Xz9+hWXh+
	1ODRaO7hVVBENQ7Md3nSKjNhKK3t6z6ahKYuq26Idz3dp6XrY5vOROVEstFwSMUd67/fiHPxLNL
	BwG9stEP+QMEKGmsa0XmbXJTl4MuYV0FEYhI2+
X-Gm-Gg: ASbGncvVON1OWg645RhbYABT5mYWSzbehZ7Ga7fR/sRLydNTv94RmjnebCaQPj4HgBg
	0uDROTtXp2UFFfmMPZciD3+3ZW6wn0DnwZtseiRo1K/q0RNSZEEJMI6ccQDTyKuUwWfPszI8DEI
	zgdmJULJEMVKvhQRD2dSKQIw==
X-Received: by 2002:a05:622a:260c:b0:4ab:690c:b2b5 with SMTP id d75a77b69052e-4af1095bb73mr173075201cf.10.1754363810434;
        Mon, 04 Aug 2025 20:16:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4uQh7fU8XPnDq7n3dbqmsiXriGnbqZHOwuD4VSkaPO7+XZfntNVJXNFU67u+Vm1sHSj/RRPQh0fkq1mKknoI=
X-Received: by 2002:a05:622a:260c:b0:4ab:690c:b2b5 with SMTP id
 d75a77b69052e-4af1095bb73mr173075001cf.10.1754363809975; Mon, 04 Aug 2025
 20:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com>
In-Reply-To: <20250610095743.18073-1-ltao@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 5 Aug 2025 15:16:13 +1200
X-Gm-Features: Ac12FXympf6JWXVJwqLfEAk5kBNlCSENpfmzGLUClWpc6LJmpJ7wbw0lJF0yJTg
Message-ID: <CAO7dBbWyCQvjDFt3-n82BJVcXx_0qzoPzu5VtXobRGb9ZW8n2Q@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 00/10] btf/kallsyms based eppic
 extension for mm page filtering
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com, devel@lists.crash-utility.osci.io
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RyhglT2Evd5kQsxmyYd_rqGDExWHTpNtZpQ8lGFPFHg_1754363811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_201656_311504_FDDBBC9C 
X-CRM114-Status: GOOD (  32.64  )
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

Kindly ping...

Any comments for this patchset?

Thanks,
Tao Liu


On Tue, Jun 10, 2025 at 9:57=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote:
>
> A) This patchset will introduce the following features to makedumpfile:
>
>   1) Enable eppic script for memory pages filtering.
>   2) Enable btf and kallsyms for symbol type and address resolving.
>   3) Port maple tree data structures and functions, primarily used for
>      vma iteration.
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
>      c) Poor performance, making vmcore dumping time unacceptable (See
>         the following performance testing).
>
>      makedumpfile need to resolve the dwarf data from debuginfo, to get s=
ymbols
>      types and addresses. In recent kernel there are dwarf alternatives s=
uch
>      as btf/kallsyms which can be used for this purpose. And btf/kallsyms=
 info
>      are already packed within vmcore, so we can use it directly.
>
>   3) Maple tree data structures are used in recent kernels, such as vma
>      iteration. So maple tree poring is needed.
>
>   With these, this patchset introduces an upgraded eppic, which is based =
on
>   btf/kallsyms symbol resolving, and is programmable for mm page filterin=
g.
>   The following info shows its usage and performance, please note the tes=
ts
>   are performed in 1st kernel:
>
>   $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:=
12/vmcore
>     /tmp/dwarf.out -x /lib/debug/lib/modules/6.11.8-300.fc41.x86_64/vmlin=
ux
>     --eppic eppic_scripts/filter_amdgpu_mm_pages.c
>         real    14m6.894s
>         user    4m16.900s
>         sys     9m44.695s
>
>   $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:03\:=
12/vmcore
>     /tmp/btf.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
>         real    0m10.672s
>         user    0m9.270s
>         sys     0m1.130s
>
>   -rw------- 1 root root 367475074 Jun 10 18:06 btf.out
>   -rw------- 1 root root 367475074 Jun 10 21:05 dwarf.out
>   -rw-rw-rw- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-2025=
-06-10-18:03:12/vmcore
>
> C) Discussion:
>
>   1) GPU types: Currently only tested with amdgpu's mm page filtering, ot=
hers
>      are not tested.
>   2) Code structure: There are some similar code shared by makedumpfile a=
nd
>      crash, such as maple tree data structure, also I planed to port the
>      btf/kallsyms code to crash as well, so there are code duplications f=
or
>      crash & makedumpfile. Since I havn't working on crash poring, code c=
hange
>      on btf/kallsyms is expected. How can we share the code, creating a c=
ommon
>      library or keep the duplication as it is?
>   3) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc6=
4.
>      Others are not tested.
>
> D) Testing:
>
>   1) If you don't want to create your vmcore, you can find a vmcore which=
 I
>      created with amdgpu mm pages unfiltered [1], the amdgpu mm pages are
>      allocated by program [2]. You can use the vmcore in 1st kernel to fi=
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
>   2) You can use eppic_scripts/print_all_vma.c against an ordinary vmcore=
 to
>      test only btf/kallsyms functions by output all VMAs if no amdgpu
>      vmcores/machine avaliable.
>
> [1]: https://people.redhat.com/~ltao/core/
> [2]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
>
> Tao Liu (10):
>   dwarf_info: Support kernel address randomization
>   dwarf_info: Fix a infinite recursion bug for search_domain
>   Add page filtering function
>   Add btf/kallsyms support for symbol type/address resolving
>   Export necessary btf/kallsyms functions to eppic extension
>   Port the maple tree data structures and functions
>   Supporting main() as the entry of eppic script
>   Enable page filtering for dwarf eppic
>   Enable page filtering for btf/kallsyms eppic
>   Introducing 2 eppic scripts to test the dwarf/btf eppic extension
>
>  Makefile                               |   6 +-
>  btf.c                                  | 919 +++++++++++++++++++++++++
>  btf.h                                  | 176 +++++
>  dwarf_info.c                           |  15 +-
>  eppic_maple.c                          | 431 ++++++++++++
>  eppic_maple.h                          |   8 +
>  eppic_scripts/filter_amdgpu_mm_pages.c |  36 +
>  eppic_scripts/print_all_vma.c          |  29 +
>  erase_info.c                           | 123 +++-
>  erase_info.h                           |  22 +
>  extension_btf.c                        | 218 ++++++
>  extension_eppic.c                      |  41 +-
>  extension_eppic.h                      |   6 +-
>  kallsyms.c                             | 371 ++++++++++
>  kallsyms.h                             |  42 ++
>  makedumpfile.c                         |  21 +-
>  makedumpfile.h                         |  11 +
>  17 files changed, 2448 insertions(+), 27 deletions(-)
>  create mode 100644 btf.c
>  create mode 100644 btf.h
>  create mode 100644 eppic_maple.c
>  create mode 100644 eppic_maple.h
>  create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
>  create mode 100644 eppic_scripts/print_all_vma.c
>  create mode 100644 extension_btf.c
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>
> --
> 2.47.0
>


