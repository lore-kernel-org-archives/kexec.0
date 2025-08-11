Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84633C87FCF
	for <kexec@archiver.kernel.org>; Mon, 11 Aug 2025 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H4QJ8PZBXDZ/T7Bqd9oci9mmzxJwqyVEX8nu1chn+eg=; b=K7Ku+iEQ+J9KkRF0HEtrZ6Hrlk
	XUQ8Jd1do6eh2oGD5AHWkkXvjSRyWOMH4PNSQ0jRR4duvbuzvTZvy6y8D4yBDEOa6g0oJR9oxILhM
	+S8vFtTB8Q0HOEchhPI6DPW+6LQHtHP1RxGSCXsUGYvOTe4j1xFUvYfJJXAfbUc837wSY+TDU93xP
	lGktbRzPJjgjiRCek5WDP5C1r/qkmkm06SEHSzpltbfF+/AvWUGaCLaZElY8WLybR8A/53jZYeGJ+
	z6vqvVZsOmM57jcZEdbymqab8tm3FKZDrG9APBmj+NNxYBmrvzKqZtQuL1ljijvvDe6IjDNH4wEo2
	owlQR0Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulG2X-00000006D9z-0an6;
	Mon, 11 Aug 2025 00:05:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulG2R-00000006D9b-0E0P
	for kexec@lists.infradead.org;
	Mon, 11 Aug 2025 00:05:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754870716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4QJ8PZBXDZ/T7Bqd9oci9mmzxJwqyVEX8nu1chn+eg=;
	b=C9o6dIVFHt65kfSPuDbDvMuBdmhinvCSA3B1Q+aW7+TSBMz29mUOmSXC/hgcypn1sQo1uo
	GBQhTRWtjn+eHErleEYPXEFISzMvrcE/KIWX3IdIhFthqvFYg539uS4ZaQSBWk3B4ESrqV
	jKNTW058RWdR0ySnMJXcPVtFL656RxE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-qpA4uN7JM32yTqJwThHsvA-1; Sun, 10 Aug 2025 20:05:15 -0400
X-MC-Unique: qpA4uN7JM32yTqJwThHsvA-1
X-Mimecast-MFC-AGG-ID: qpA4uN7JM32yTqJwThHsvA_1754870714
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b065932d0bso120230971cf.3
        for <kexec@lists.infradead.org>; Sun, 10 Aug 2025 17:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754870714; x=1755475514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4QJ8PZBXDZ/T7Bqd9oci9mmzxJwqyVEX8nu1chn+eg=;
        b=r7vf9qs+2AFQhtFeFmnwHRKiwpo2yOpK8CS+FMsVjdFcnoBzZ/nFEDo5ApxVQmuxwB
         aRunbMQ7+sKXtl7J9Uq5fGXwv1SCbCAw0jStjt4CTAadH7GKQZpT8h4KzdiAKMjsa6hI
         NUi8bqm/CcEQFon2NupZe9WvowfArij7WU5qU+hTdVVSklV+H1yiy2fY3YdvdS79vm/Z
         jX4cPAm1fNmkCvw7B9XerUAhZ1BfracX4QHo3uHjR5DV2hfsioGsmvv7JaWLZ0HNckjA
         isjFHuBTv1d/P0H8/y3bYThKkOECqwIsw+VKnyBQ5kpAizeuQUCKDuMXYXj2d0rHaNvR
         TJhA==
X-Forwarded-Encrypted: i=1; AJvYcCWPSHxsG6F3gVcemlt2bLoVnDtvmVc0paOpnjvkPqXmOcUdQMmwlKoS/am5MawZynGk0th9Uw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+TIr44PjxBicAPFLhBzY8AS8QPS9iDfFw+FtCkUTEoIykrFfA
	PBVp4WLljg+4zvUEFIUe0ktQcp4fah7gG8NX+3mheGeQrYQakXIMflLyXy2m1AlEY0wxYbhEgie
	3UVc+p/eh7AlrG0uVnxJRtQtknPGe6VOtunfwI3nHf/0zTnPS8oD5VgPAQTt5/OxfsR3W+BRLSA
	dxsD2K/MVuB7ZENIx6n/N6nqdN8ml6irJbCwQdgrhvMzV5CHv6AQ==
X-Gm-Gg: ASbGnctF2DyYSTdiu+uFwPs7WsIsGrjpAWhK01VMr3qvHYrNnacICU+E1tGKP1k8SCK
	FyqUHCXqfYyF4bfrmEFQ74wFzfD0lcWyKS79ozok126RhDrwATsuIyODpAZH30oYu+0oB4uJ6fR
	aPmi2DYOaGvWFt5zboEtpQZA==
X-Received: by 2002:a05:622a:1105:b0:4b0:82d9:7cb5 with SMTP id d75a77b69052e-4b0aed4bf82mr162892791cf.26.1754870714168;
        Sun, 10 Aug 2025 17:05:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUqTq4y6CqkT4vq4lPlh5rR1Af6CjnSh+Bk77MFFDnHIBENU4xp/k5bAwXGLe+nmV3HlzyQzAMBciOeEU0H6U=
X-Received: by 2002:a05:622a:1105:b0:4b0:82d9:7cb5 with SMTP id
 d75a77b69052e-4b0aed4bf82mr162892431cf.26.1754870713680; Sun, 10 Aug 2025
 17:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <CAO7dBbWyCQvjDFt3-n82BJVcXx_0qzoPzu5VtXobRGb9ZW8n2Q@mail.gmail.com>
 <fb5d89e4-3797-4fc6-ad8a-c8e0cfa3a251@nec.com>
In-Reply-To: <fb5d89e4-3797-4fc6-ad8a-c8e0cfa3a251@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Mon, 11 Aug 2025 12:04:37 +1200
X-Gm-Features: Ac12FXyFrj9iLew2ruh_Z7r6OUXyjHRc3It-KxzoD6T7PyuKmEpNwgt7fUi8BAI
Message-ID: <CAO7dBbUFdOZ=XnpCDPxaSb04paF4i9MK9ZA9u_mZ9FzHjecVqQ@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 00/10] btf/kallsyms based eppic
 extension for mm page filtering
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1pURwWQPDlFQHROYCLNxy55lwnTfaU6jpfYw5tqF3HQ_1754870714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_170519_181691_F3887F60 
X-CRM114-Status: GOOD (  39.66  )
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

Hi YAMAZAKI,

Thanks for your comments.

On Thu, Aug 7, 2025 at 11:42=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Thank you for the suggestion.
> I think it's a good idea,
> but epppic needs careful consideration.

Do you mean there are drawbacks of using eppic?

From my side, one advantage of eppic is, users can use the kernel data
structures/variables directly without redefine it, like:

struct task_struct *p;
p =3D (struct task_struct *)&init_task;

Users don't need to include headers to define what task_struct looks
like, and can use global variable init_task without declaring it. The
callbacks of eppic can resolve these missing info via
dwarf/btf/kallsyms during runtime. I think this feature can make the
eppic scripts tidy and convenient. Also we can use other similar c
interpreters, but I haven't encountered one with the similar feature,
also considering eppic has been in makedumpfile for years, so people
may already be familiar with it...

> I'm sorry, but please let me check for a moment.
>
Sure, no problem, please take your time.

Thanks,
Tao Liu

> Thanks,
> Masa
>
> On 2025/08/05 12:16, Tao Liu wrote:
> > Kindly ping...
> >
> > Any comments for this patchset?
> >
> > Thanks,
> > Tao Liu
> >
> >
> > On Tue, Jun 10, 2025 at 9:57=E2=80=AFPM Tao Liu <ltao@redhat.com> wrote=
:
> >> A) This patchset will introduce the following features to makedumpfile=
:
> >>
> >>    1) Enable eppic script for memory pages filtering.
> >>    2) Enable btf and kallsyms for symbol type and address resolving.
> >>    3) Port maple tree data structures and functions, primarily used fo=
r
> >>       vma iteration.
> >>
> >> B) The purpose of the features are:
> >>
> >>    1) Currently makedumpfile filters mm pages based on page flags, bec=
ause flags
> >>       can help to determine one page's usage. But this page-flag-check=
ing method
> >>       lacks of flexibility in certain cases, e.g. if we want to filter=
 those mm
> >>       pages occupied by GPU during vmcore dumping due to:
> >>
> >>       a) GPU may be taking a large memory and contains sensitive data;
> >>       b) GPU mm pages have no relations to kernel crash and useless fo=
r vmcore
> >>          analysis.
> >>
> >>       But there is no GPU mm page specific flags, and apparently we do=
n't need
> >>       to create one just for kdump use. A programmable filtering tool =
is more
> >>       suitable for such cases. In addition, different GPU vendors may =
use
> >>       different ways for mm pages allocating, programmable filtering i=
s better
> >>       than hard coding these GPU specific logics into makedumpfile in =
this case.
> >>
> >>    2) Currently makedumpfile already contains a programmable filtering=
 tool, aka
> >>       eppic script, which allows user to write customized code for dat=
a erasing.
> >>       However it has the following drawbacks:
> >>
> >>       a) cannot do mm page filtering.
> >>       b) need to access to debuginfo of both kernel and modules, which=
 is not
> >>          applicable in the 2nd kernel.
> >>       c) Poor performance, making vmcore dumping time unacceptable (Se=
e
> >>          the following performance testing).
> >>
> >>       makedumpfile need to resolve the dwarf data from debuginfo, to g=
et symbols
> >>       types and addresses. In recent kernel there are dwarf alternativ=
es such
> >>       as btf/kallsyms which can be used for this purpose. And btf/kall=
syms info
> >>       are already packed within vmcore, so we can use it directly.
> >>
> >>    3) Maple tree data structures are used in recent kernels, such as v=
ma
> >>       iteration. So maple tree poring is needed.
> >>
> >>    With these, this patchset introduces an upgraded eppic, which is ba=
sed on
> >>    btf/kallsyms symbol resolving, and is programmable for mm page filt=
ering.
> >>    The following info shows its usage and performance, please note the=
 tests
> >>    are performed in 1st kernel:
> >>
> >>    $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:=
03\:12/vmcore
> >>      /tmp/dwarf.out -x /lib/debug/lib/modules/6.11.8-300.fc41.x86_64/v=
mlinux
> >>      --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >>          real    14m6.894s
> >>          user    4m16.900s
> >>          sys     9m44.695s
> >>
> >>    $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-18\:=
03\:12/vmcore
> >>      /tmp/btf.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >>          real    0m10.672s
> >>          user    0m9.270s
> >>          sys     0m1.130s
> >>
> >>    -rw------- 1 root root 367475074 Jun 10 18:06 btf.out
> >>    -rw------- 1 root root 367475074 Jun 10 21:05 dwarf.out
> >>    -rw-rw-rw- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0.1-=
2025-06-10-18:03:12/vmcore
> >>
> >> C) Discussion:
> >>
> >>    1) GPU types: Currently only tested with amdgpu's mm page filtering=
, others
> >>       are not tested.
> >>    2) Code structure: There are some similar code shared by makedumpfi=
le and
> >>       crash, such as maple tree data structure, also I planed to port =
the
> >>       btf/kallsyms code to crash as well, so there are code duplicatio=
ns for
> >>       crash & makedumpfile. Since I havn't working on crash poring, co=
de change
> >>       on btf/kallsyms is expected. How can we share the code, creating=
 a common
> >>       library or keep the duplication as it is?
> >>    3) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/=
ppc64.
> >>       Others are not tested.
> >>
> >> D) Testing:
> >>
> >>    1) If you don't want to create your vmcore, you can find a vmcore w=
hich I
> >>       created with amdgpu mm pages unfiltered [1], the amdgpu mm pages=
 are
> >>       allocated by program [2]. You can use the vmcore in 1st kernel t=
o filter
> >>       the amdgpu mm pages by the previous performance testing cmdline.=
 To
> >>       verify the pages are filtered in crash:
> >>
> >>       Unfiltered:
> >>       crash> search -c "!QAZXSW@#EDC"
> >>       ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXX
> >>       ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXX
> >>       crash> rd ffff96b7fa800000
> >>       ffff96b7fa800000:  405753585a415121                    !QAZXSW@
> >>       crash> rd ffff96b87c800000
> >>       ffff96b87c800000:  405753585a415121                    !QAZXSW@
> >>
> >>       Filtered:
> >>       crash> search -c "!QAZXSW@#EDC"
> >>       crash> rd ffff96b7fa800000
> >>       rd: page excluded: kernel virtual address: ffff96b7fa800000  typ=
e: "64-bit KVADDR"
> >>       crash> rd ffff96b87c800000
> >>       rd: page excluded: kernel virtual address: ffff96b87c800000  typ=
e: "64-bit KVADDR"
> >>
> >>    2) You can use eppic_scripts/print_all_vma.c against an ordinary vm=
core to
> >>       test only btf/kallsyms functions by output all VMAs if no amdgpu
> >>       vmcores/machine avaliable.
> >>
> >> [1]: https://people.redhat.com/~ltao/core/
> >> [2]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352df
> >>
> >> Tao Liu (10):
> >>    dwarf_info: Support kernel address randomization
> >>    dwarf_info: Fix a infinite recursion bug for search_domain
> >>    Add page filtering function
> >>    Add btf/kallsyms support for symbol type/address resolving
> >>    Export necessary btf/kallsyms functions to eppic extension
> >>    Port the maple tree data structures and functions
> >>    Supporting main() as the entry of eppic script
> >>    Enable page filtering for dwarf eppic
> >>    Enable page filtering for btf/kallsyms eppic
> >>    Introducing 2 eppic scripts to test the dwarf/btf eppic extension
> >>
> >>   Makefile                               |   6 +-
> >>   btf.c                                  | 919 +++++++++++++++++++++++=
++
> >>   btf.h                                  | 176 +++++
> >>   dwarf_info.c                           |  15 +-
> >>   eppic_maple.c                          | 431 ++++++++++++
> >>   eppic_maple.h                          |   8 +
> >>   eppic_scripts/filter_amdgpu_mm_pages.c |  36 +
> >>   eppic_scripts/print_all_vma.c          |  29 +
> >>   erase_info.c                           | 123 +++-
> >>   erase_info.h                           |  22 +
> >>   extension_btf.c                        | 218 ++++++
> >>   extension_eppic.c                      |  41 +-
> >>   extension_eppic.h                      |   6 +-
> >>   kallsyms.c                             | 371 ++++++++++
> >>   kallsyms.h                             |  42 ++
> >>   makedumpfile.c                         |  21 +-
> >>   makedumpfile.h                         |  11 +
> >>   17 files changed, 2448 insertions(+), 27 deletions(-)
> >>   create mode 100644 btf.c
> >>   create mode 100644 btf.h
> >>   create mode 100644 eppic_maple.c
> >>   create mode 100644 eppic_maple.h
> >>   create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
> >>   create mode 100644 eppic_scripts/print_all_vma.c
> >>   create mode 100644 extension_btf.c
> >>   create mode 100644 kallsyms.c
> >>   create mode 100644 kallsyms.h
> >>
> >> --
> >> 2.47.0
> >>


