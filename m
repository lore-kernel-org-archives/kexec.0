Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49757CFA466
	for <kexec@archiver.kernel.org>; Mon, 24 Nov 2025 04:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHvJ+Xj+LjxUJx2HCBKKdco7ahICauXdgYQDi4KffiU=; b=Cj57hiFb2NLj7jcC4S1kbcDvM+
	PpyOdPeFhEHd53y0qr2vYaQ9PmRw9FCQZmd1ifIcnvfKEIGOm/qIdwyWm6lCigkSfNBGEwOO18vtF
	AdKpFky9BsC6AFXE/sHfgT+CxSDKlE6dB4E5SqMa23k1dzH3bI5l1TnxKkemhOospSYrqKujB7ocm
	x3UKXzxMbsdHNqmR2lUIJxuQLhMIN6CkQWLwBEOY1wBK0wnNnbK+eRF5MZn+dCWZxcPhMYeGQdXqo
	dLbMtG/plHm2aLHycUkCeDvJ7oqPWgoqyAv1Y8MxiztFDZvc2yhohOKHE2JQN4cxyU3rWRCfAgAis
	WoUns7FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNOTy-0000000B5Gu-3493;
	Mon, 24 Nov 2025 04:47:22 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNOTv-0000000B5GH-2K7w
	for kexec@lists.infradead.org;
	Mon, 24 Nov 2025 04:47:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763959636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHvJ+Xj+LjxUJx2HCBKKdco7ahICauXdgYQDi4KffiU=;
	b=CKcLGLHMBmwi50Nbd3DQKhbAKFBoPEVjGMzp6goDtdYWGI0wpT9g08b7oyYMr+sje98uke
	V3N4Vra6G4EAn45Duakhc3uPKmKT3CFjtuusn262qYcEnhmWfuZUIZr343OhKi7xrIJCpT
	tHiJyjQpDhnd3KFObBw8fK4bVQqJ6pc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-p87V7T0NM0WNdPlV4UusWw-1; Sun, 23 Nov 2025 23:47:14 -0500
X-MC-Unique: p87V7T0NM0WNdPlV4UusWw-1
X-Mimecast-MFC-AGG-ID: p87V7T0NM0WNdPlV4UusWw_1763959634
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed6ff3de05so106785731cf.3
        for <kexec@lists.infradead.org>; Sun, 23 Nov 2025 20:47:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763959634; x=1764564434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tHvJ+Xj+LjxUJx2HCBKKdco7ahICauXdgYQDi4KffiU=;
        b=hvKzsnxAh6g3uUyvvUduURo30ECe1D1FosEcfebD5tJTPKLFxKCbzLPuFk7L3KM+70
         oCzbxxQz4lQEHdeXU2mxSMdAaFOgAxrVmizmShFC9CsUoY1cSijVXUPVu5G/h3x0m39/
         Xy27EWdrZTQ2wfqKDbkZIoQZjM3ZZ7llm3xUkZ4agoZTA920/w5jEVEpOCiTLj9AO5rh
         mNJDYqalv8ObpmtF8WI+vY7NCTL8wo/oS53+hjWnTcfg4CTfCkmyXz7amT6wM7+s19Yo
         CVeq3/o+rh/okOZh+PAEGxPJ4kY1zzyp0Z1d1EvNKszdFSBb7GvY5RSphvU6I0iscoy9
         /0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG/kObJkxZmiQ2TzN0rWjaPBBQiUgsHuJ3Lrbza7WYLRBJqJqMyz808z6U+yaC+eEAVcWjYQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyr1pbhk4G/TcTOJr0HgoK2+L0MieLuKIfTkoYOGigk/6w1FP6j
	OB4C+R5JWedsV6G5kj83QfKHBs8HkCw1HNsBH90a0g5DO51qFur61DYtpjgrnEfrjPOYGuAK+ug
	Vy0Q9RDOWXgaw6v+qAHDS7NufIOBkwAtUUbme1SfJAXDPpDaVwavJpXvDkTlzBCXcnZ69MhhmXw
	JGODNS8JabHhKNl9jRtNAQwDPTKupXcw1pGzuc
X-Gm-Gg: ASbGncvwdIrFNukETqn9kGxURFvIRzwZOr4BWr56xuCSIDWM8hNsrXhSY1QBhsx2vBW
	30sw39TuOYk4oUuXZRB0pFWONLaXa4BJrXMxUV7ypKBNQ6XF/2mowQLawnm20VaoDPrpufBe6sO
	rJvm2qy07+FMsyG2RuhM3JiWXG5Tn/OeECccxoQVJpVdC5zYlzjkJv2W4cD+npCNvFdA==
X-Received: by 2002:a05:622a:247:b0:4ed:da3a:c0d4 with SMTP id d75a77b69052e-4ee5893e3a8mr126952251cf.78.1763959634307;
        Sun, 23 Nov 2025 20:47:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnZJCMMnkD/EQWXEZ1zoAWjOH4nVGm3gKZJqercDa8Po4FnOx3wOm2sbMj/erQbm9g8aSV95xHMkCe7OZhN/4=
X-Received: by 2002:a05:622a:247:b0:4ed:da3a:c0d4 with SMTP id
 d75a77b69052e-4ee5893e3a8mr126952091cf.78.1763959633938; Sun, 23 Nov 2025
 20:47:13 -0800 (PST)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com>
In-Reply-To: <20251020222410.8235-1-ltao@redhat.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 24 Nov 2025 17:46:37 +1300
X-Gm-Features: AWmQ_bnIx8I_P6MAiJRzmlpCoMIpxZW0O3r40GdoLT9NXUJ74RwGmlHD7tWTumc
Message-ID: <CAO7dBbVLPv3LZTd31XdPvnYFFTfQ3PVaMTS_h3uRgE4sJsS1PA@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 00/14] btf/kallsyms based eppic extension
 for mm page filtering
To: yamazaki-msmt@nec.com, k-hagio-ab@nec.com, kexec@lists.infradead.org
Cc: aravinda@linux.vnet.ibm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xCRAGRa2O-jhJckhAy_bnwblhv92OINk88Ji-wKRcx4_1763959634
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_204720_015690_0262421E 
X-CRM114-Status: GOOD (  38.46  )
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

Kindly ping... Any comments on this?

Thanks,
Tao Liu

On Tue, Oct 21, 2025 at 11:24=E2=80=AFAM Tao Liu <ltao@redhat.com> wrote:
>
> A) This patchset will introduce the following features to makedumpfile:
>
>   1) Enable eppic script for memory pages filtering.
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
>   2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/ppc6=
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
> v2 -> v1:
>
> 1) Moved maple tree related code(for VMA iteration) into eppic script, so=
 we
>    don't need to port maple tree code to makedumpfile.
>
> 2) Reorganized the patchset as follows:
>
>     --- <common modification> ---
>     1.Add page filtering function
>     2.Supporting main() as the entry of eppic script
>
>     --- <dwarf related modification> ---
>     3.dwarf_info: Support kernel address randomization
>     4.dwarf_info: Fix a infinite recursion bug for rust
>     5.eppic dwarf: support anonymous structs member resolving
>     6.Enable page filtering for dwarf eppic
>
>     --- <btf & kallsyms related modification> ---
>     7.Implement kernel kallsyms resolving
>     8.Implement kernel btf resolving
>     9.Implement kernel module's kallsyms resolving
>     10.Implement kernel module's btf resolving
>     11.Export necessary btf/kallsyms functions to eppic extension
>     12.Enable page filtering for btf/kallsyms eppic
>     13.Docs: Update eppic related entries
>
>     --- <only for test purpose, don't merge> ---
>     14.Introducing 2 eppic scripts to test the dwarf/btf eppic extension
>
>    The modification on dwarf is primary for comparision purpose, that
>    for the same eppic program, mm page filtering should get exact same
>    outputs for dwarf & kallsyms/btf based approaches. If outputs unmatch,
>    this indicates bugs. In fact, we will never take dwarf mm pages filter=
ing
>    in real use, due to its poor performance as well as inaccessibility
>    of debuginfo during kdump in 2nd kernel. So patch 3/4/5 won't affect
>    the function of btf/kallsyms eppic mm page filtering, but there are
>    functions shared in patch 6, so it is a must-have one. Patch 14 is
>    only for test purpose, to demonstrate how to write eppic script for
>    mm page filtering, so it isn't a must-have patch.
>
>    Please note, in patch 14, I have deliberately converted all array
>    operation into pointer operation, e.g. modified "node->slot[i]" into
>    "*((unsigned long *)&(node->slot) + i)". This is because there are
>    bugs for array operation support in extension_eppic.c. I didn't have
>    effort to test and fix them all because as I mentioned previously,
>    mm page filtering in dwarf side is only for comparision and will
>    never be used in real use. There is no such issue for kallsyms/btf
>    eppic side.
>
> 3) Since we ported maple tree code to eppic script, several bugs found
>    both for eppic library & eppic btf support. Please use master branch
>    of eppic library to co-compile with this patchset.
>
> Tao Liu (14):
>   Add page filtering function
>   Supporting main() as the entry of eppic script
>   dwarf_info: Support kernel address randomization
>   dwarf_info: Fix a infinite recursion bug for rust
>   eppic dwarf: support anonymous structs member resolving
>   Enable page filtering for dwarf eppic
>   Implement kernel kallsyms resolving
>   Implement kernel btf resolving
>   Implement kernel module's kallsyms resolving
>   Implement kernel module's btf resolving
>   Export necessary btf/kallsyms functions to eppic extension
>   Enable page filtering for btf/kallsyms eppic
>   Docs: Update eppic related entries
>   Introducing 2 eppic scripts to test the dwarf/btf eppic extension
>
>  Makefile                               |   6 +-
>  btf.c                                  | 919 +++++++++++++++++++++++++
>  btf.h                                  | 177 +++++
>  dwarf_info.c                           |   7 +
>  eppic_scripts/filter_amdgpu_mm_pages.c | 255 +++++++
>  eppic_scripts/print_all_vma.c          | 239 +++++++
>  erase_info.c                           | 120 +++-
>  erase_info.h                           |  19 +
>  extension_btf.c                        | 258 +++++++
>  extension_eppic.c                      | 106 ++-
>  extension_eppic.h                      |   6 +-
>  kallsyms.c                             | 392 +++++++++++
>  kallsyms.h                             |  41 ++
>  makedumpfile.8.in                      |  24 +-
>  makedumpfile.c                         |  21 +-
>  makedumpfile.h                         |  11 +
>  print_info.c                           |  11 +-
>  17 files changed, 2550 insertions(+), 62 deletions(-)
>  create mode 100644 btf.c
>  create mode 100644 btf.h
>  create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
>  create mode 100644 eppic_scripts/print_all_vma.c
>  create mode 100644 extension_btf.c
>  create mode 100644 kallsyms.c
>  create mode 100644 kallsyms.h
>
> --
> 2.47.0
>


