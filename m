Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FCDCAC587
	for <kexec@archiver.kernel.org>; Tue,  9 Sep 2025 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IbcbPIbckW8bLpXWXAsYZKDYEkPetvZjJpcalKQfD/s=; b=nh7SbPusjCCzwKvxduKFjMQMIF
	pUGKK8GyM7ZdsyOa4iHLIzsHYd9tRLH3J+/M8TRcCN/EobBa2gY/gjOZN5yX74ctu2Ff6tzKvSj/Q
	N+tbwMvrec2ja8FGNpXg1Ocs/BMOEws1jCMXleQ6mHhLjx1fl6rlockL3P1wKT9JjQSu7UrmcEoSQ
	sEjpwAokuQ9ntsQaGONggI2WbuBd1nlHAi01DUbB+kRjQPks4rroy6tUghOCN/uhy1K4jDZ9bn6zd
	G7AArxaXUnezk9FnfowGvtRZibCU0JoVAP0Y6RuS6b0IkJERSfTPm5LBlQN4zMFYgVQR1rIHS4bWX
	w1QSlydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvsGq-00000004vqG-2UmA;
	Tue, 09 Sep 2025 06:56:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvnb7-00000003ZEN-3lIv
	for kexec@lists.infradead.org;
	Tue, 09 Sep 2025 01:56:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757382999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IbcbPIbckW8bLpXWXAsYZKDYEkPetvZjJpcalKQfD/s=;
	b=QQuxSm3Lk3q2oTBe+WK6/4229HvJZ38VIEY0yxoW3tWEZGcq2LmZO9a+wT09hOPKupihnN
	CbiUI90Jm6f2TJGpCojvcb/2P3ETQBd7LprS3PpmgDxrAsIwDsJbx02TI53pu+SWYcQ7J0
	INwhu9629QoUdu0wsNDRYnU8chw+4+g=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ztnSSwxyN8aObmjPRZuKbA-1; Mon, 08 Sep 2025 21:56:37 -0400
X-MC-Unique: ztnSSwxyN8aObmjPRZuKbA-1
X-Mimecast-MFC-AGG-ID: ztnSSwxyN8aObmjPRZuKbA_1757382997
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-80b27b09051so1196630585a.0
        for <kexec@lists.infradead.org>; Mon, 08 Sep 2025 18:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757382997; x=1757987797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbcbPIbckW8bLpXWXAsYZKDYEkPetvZjJpcalKQfD/s=;
        b=HZyX1PNVaCOpEhTV6l7+IpgOpSI/j0ZBs4i1W+6WYjy4zVl22E+TnYmwd9CWCIV5vI
         jZf/SSb+FkfTYzSGMbYStt3W71TPqGWPbOrse2a/4Udbd3IuhlFV7HrwGNE5+dUrTXzk
         +9uV3WTB8AmoPuC6+9Vev5AYwnAhW+OZchGMVqC30ttzLdjI93k1tLk3aLsv0bG1dfAU
         LqAhfem8pOT9yR9L4A/Ur9XfQd27evvIjgbgdWed8Bc8YyBJ7c6dCwMzG2ki7r2MtRt2
         Jcodwcj9G0LCTy+g40Nkj7p+47YWaLcGV48lIUwXkvQaWUWXsSpkZ11zk3z//59RwViV
         d9wg==
X-Forwarded-Encrypted: i=1; AJvYcCVxaO6hCHFN8GwW0g8e49HYP6oyiRu+oy1CMrsKy7b48AkLeX43gdlWkw6wDks2TBdqFcZRzw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzdUsufM3gYbzOA4CUWkX+kIB8iLVldzlAev10hfCdzKepcqgGi
	BJI4v5nHlIokCFJc8vxTZ/ZxVRPIOBsY8rPw1l0C6SlHipGYq0WFyfPx6vRFT/ctP2w0NuuGKfE
	s5UtqT+cLR31lfZC9Ki+LH2QSIp6s8iesKTkA3fbd8eoJMWIvYKD0ZRgvoRUu/rxg6jFrRENou6
	DFd2V8SciJ0M3Xoxp1OAKv1tJ9IUBMpocZa7tl
X-Gm-Gg: ASbGnctbzFfd4KaC8AgArWSR7v3T1DXV+QkXFoBlB2/T7vzuBs0ticuSZYd9NOoqrkk
	Nw3D4NtI+mnxZgZwGxx2ODUwXEpB8uULbI0viRAxxjjs9y7NdEUkyPpfoIiKtLTF4ctqm/rEIbN
	1HPmwwgZ4NY3btmSMDTSPM
X-Received: by 2002:a05:620a:7114:b0:801:27ac:3c0d with SMTP id af79cd13be357-813c27412b8mr1042241685a.61.1757382997025;
        Mon, 08 Sep 2025 18:56:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFggoQ3yh5xyj6s8KzL8rzv2mrtJoqkBgu6GbSXjSoS1PrRCTHG/7lZwUs5K1aAZacR7GAFO92nD9Bpevu0eN4=
X-Received: by 2002:a05:620a:7114:b0:801:27ac:3c0d with SMTP id
 af79cd13be357-813c27412b8mr1042240485a.61.1757382996492; Mon, 08 Sep 2025
 18:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250610095743.18073-1-ltao@redhat.com> <CAO7dBbWyCQvjDFt3-n82BJVcXx_0qzoPzu5VtXobRGb9ZW8n2Q@mail.gmail.com>
 <fb5d89e4-3797-4fc6-ad8a-c8e0cfa3a251@nec.com> <CAO7dBbUFdOZ=XnpCDPxaSb04paF4i9MK9ZA9u_mZ9FzHjecVqQ@mail.gmail.com>
 <f25f6a49-0168-44c7-b3cf-4201780c7061@nec.com>
In-Reply-To: <f25f6a49-0168-44c7-b3cf-4201780c7061@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Tue, 9 Sep 2025 13:56:00 +1200
X-Gm-Features: Ac12FXxMjWIWWaBkFUJUBSI41kZdDNHQW7udp3Af0-CH0KXQTg18jMG-8I8Ms_w
Message-ID: <CAO7dBbW8OUaWr5U8eDGFGNbWQFDsDe_NNERs+OGbjxj=3yvDiw@mail.gmail.com>
Subject: Re: [PATCH RFC][makedumpfile 00/10] btf/kallsyms based eppic
 extension for mm page filtering
To: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>
Cc: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, 
	"aravinda@linux.vnet.ibm.com" <aravinda@linux.vnet.ibm.com>, 
	"devel@lists.crash-utility.osci.io" <devel@lists.crash-utility.osci.io>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NIUG6hbsk-SRHyRZaxbC5TmOGDnnh1P04CStlnZiZP0_1757382997
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_185642_090838_66D9847F 
X-CRM114-Status: GOOD (  58.80  )
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

Thanks a lot for your comments!

On Sat, Sep 6, 2025 at 12:41=E2=80=AFAM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=B4=
=8E=E3=80=80=E7=9C=9F=E5=85=89)
<yamazaki-msmt@nec.com> wrote:
>
> Hi Liu
>
> I'm sorry it took so long.

No worries. :)

>
> Your proposed issue with regard to GPU memory is useful, but it may not
> be a frequently used feature. I think it would be better to use an extern=
al
> library, script, or option whenever possible.

To add some context, I have received some issue reports about
filtering GPU mem pages out of vmcore, otherwise the vmcore will be
too large. And I think this is a to-do feature, as GPU nowadays are
used more often as AI training, and frankly we have to address the
issue eventually.

>
> As you already know, I am concerned that code related to btf, kallsyms an=
d
> maple tree has been ported. These newer features are appealing. However, =
I
> feel that sharing code with crash will increase future maintenance effort=
s
> if we try to maintain consistency. On the other hand, if they are not
> identical, maintenance will be less frequent and the feature may
> not be updated.

OK, understood. Then I will not make it share code with crash.
>
> I also think that the eppic script would be better treated as an addition=
al
> script. Although some time has passed since the eppic function was added,
> the addition of new scripts and updates to supported versions are limited=
.
>
> I think it would be better to add documentation introducing the script as
> a related script rather than including it directly in the makedumpfile
> repository.

Yes, I totally agree. The filter_amdgpu_mm_pages.c is just a POC to
demo the final result that the patchset is doing, all the code
modifications are to serve this eppic script for amdgpu's mm pages
filtering. We won't ship the eppic script to everyone, because it is
not generic to all. My thought is, we empower makedumpfile with the
ability to filter GPU mm pages via BTF/eppic, and end users can use
this feature to address their specific cases, so it's users' duty to
maintain/adapt the eppic scripts.

>
> However, this proposal also includes suggestions for fixing some bugs and
> speeding up existing eppic functions. It seems that these things need to =
be
> incorporated.

The bug fixes related to dwarf_info aren't a must-have for filtering
gpu mm page via eppic. In fact, dwarf or BTF either can be the source
of debuginfo, which will be used to determine the details of kernel
data structures. In other words, we can do gpu mm pages filtering via
(dwarf + eppic + maple_tree), or via (BTF/kallsyms + eppic +
maple_tree). Either path can get the final vmcore with gpu mm page
filtered. But, the 2nd path(BTF/kallsyms + eppic + maple_tree) is more
suitable for kdump in 2nd kernel, because BTF/kallsyms are available
from kernel(in memory & smaller), and dwarf is only available from
debuginfo files(in disk & larger). Also we can make a performance
comparison of the 2 paths. So I added the bug fixes of dwarf_info in
this patch set.

>
> In other words, I think it's better to separate things that can be
> separated.

Yes, sure! I will try to do the separate in v2.

Thanks,
Tao Liu

>
> Sincerely
>
> On 2025/08/11 9:04, Tao Liu wrote:
> > Hi YAMAZAKI,
> >
> > Thanks for your comments.
> >
> > On Thu, Aug 7, 2025 at 11:42=E2=80=AFPM YAMAZAKI MASAMITSU(=E5=B1=B1=E5=
=B4=8E=E3=80=80=E7=9C=9F=E5=85=89)
> > <yamazaki-msmt@nec.com> wrote:
> >> Thank you for the suggestion.
> >> I think it's a good idea,
> >> but epppic needs careful consideration.
> > Do you mean there are drawbacks of using eppic?
> >
> >  From my side, one advantage of eppic is, users can use the kernel data
> > structures/variables directly without redefine it, like:
> >
> > struct task_struct *p;
> > p =3D (struct task_struct *)&init_task;
> >
> > Users don't need to include headers to define what task_struct looks
> > like, and can use global variable init_task without declaring it. The
> > callbacks of eppic can resolve these missing info via
> > dwarf/btf/kallsyms during runtime. I think this feature can make the
> > eppic scripts tidy and convenient. Also we can use other similar c
> > interpreters, but I haven't encountered one with the similar feature,
> > also considering eppic has been in makedumpfile for years, so people
> > may already be familiar with it...
> >
> >> I'm sorry, but please let me check for a moment.
> >>
> > Sure, no problem, please take your time.
> >
> > Thanks,
> > Tao Liu
> >
> >> Thanks,
> >> Masa
> >>
> >> On 2025/08/05 12:16, Tao Liu wrote:
> >>> Kindly ping...
> >>>
> >>> Any comments for this patchset?
> >>>
> >>> Thanks,
> >>> Tao Liu
> >>>
> >>>
> >>> On Tue, Jun 10, 2025 at 9:57=E2=80=AFPM Tao Liu <ltao@redhat.com> wro=
te:
> >>>> A) This patchset will introduce the following features to makedumpfi=
le:
> >>>>
> >>>>     1) Enable eppic script for memory pages filtering.
> >>>>     2) Enable btf and kallsyms for symbol type and address resolving=
.
> >>>>     3) Port maple tree data structures and functions, primarily used=
 for
> >>>>        vma iteration.
> >>>>
> >>>> B) The purpose of the features are:
> >>>>
> >>>>     1) Currently makedumpfile filters mm pages based on page flags, =
because flags
> >>>>        can help to determine one page's usage. But this page-flag-ch=
ecking method
> >>>>        lacks of flexibility in certain cases, e.g. if we want to fil=
ter those mm
> >>>>        pages occupied by GPU during vmcore dumping due to:
> >>>>
> >>>>        a) GPU may be taking a large memory and contains sensitive da=
ta;
> >>>>        b) GPU mm pages have no relations to kernel crash and useless=
 for vmcore
> >>>>           analysis.
> >>>>
> >>>>        But there is no GPU mm page specific flags, and apparently we=
 don't need
> >>>>        to create one just for kdump use. A programmable filtering to=
ol is more
> >>>>        suitable for such cases. In addition, different GPU vendors m=
ay use
> >>>>        different ways for mm pages allocating, programmable filterin=
g is better
> >>>>        than hard coding these GPU specific logics into makedumpfile =
in this case.
> >>>>
> >>>>     2) Currently makedumpfile already contains a programmable filter=
ing tool, aka
> >>>>        eppic script, which allows user to write customized code for =
data erasing.
> >>>>        However it has the following drawbacks:
> >>>>
> >>>>        a) cannot do mm page filtering.
> >>>>        b) need to access to debuginfo of both kernel and modules, wh=
ich is not
> >>>>           applicable in the 2nd kernel.
> >>>>        c) Poor performance, making vmcore dumping time unacceptable =
(See
> >>>>           the following performance testing).
> >>>>
> >>>>        makedumpfile need to resolve the dwarf data from debuginfo, t=
o get symbols
> >>>>        types and addresses. In recent kernel there are dwarf alterna=
tives such
> >>>>        as btf/kallsyms which can be used for this purpose. And btf/k=
allsyms info
> >>>>        are already packed within vmcore, so we can use it directly.
> >>>>
> >>>>     3) Maple tree data structures are used in recent kernels, such a=
s vma
> >>>>        iteration. So maple tree poring is needed.
> >>>>
> >>>>     With these, this patchset introduces an upgraded eppic, which is=
 based on
> >>>>     btf/kallsyms symbol resolving, and is programmable for mm page f=
iltering.
> >>>>     The following info shows its usage and performance, please note =
the tests
> >>>>     are performed in 1st kernel:
> >>>>
> >>>>     $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-1=
8\:03\:12/vmcore
> >>>>       /tmp/dwarf.out -x /lib/debug/lib/modules/6.11.8-300.fc41.x86_6=
4/vmlinux
> >>>>       --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >>>>           real    14m6.894s
> >>>>           user    4m16.900s
> >>>>           sys     9m44.695s
> >>>>
> >>>>     $ time ./makedumpfile -d 31 -l /var/crash/127.0.0.1-2025-06-10-1=
8\:03\:12/vmcore
> >>>>       /tmp/btf.out --eppic eppic_scripts/filter_amdgpu_mm_pages.c
> >>>>           real    0m10.672s
> >>>>           user    0m9.270s
> >>>>           sys     0m1.130s
> >>>>
> >>>>     -rw------- 1 root root 367475074 Jun 10 18:06 btf.out
> >>>>     -rw------- 1 root root 367475074 Jun 10 21:05 dwarf.out
> >>>>     -rw-rw-rw- 1 root root 387181418 Jun 10 18:03 /var/crash/127.0.0=
.1-2025-06-10-18:03:12/vmcore
> >>>>
> >>>> C) Discussion:
> >>>>
> >>>>     1) GPU types: Currently only tested with amdgpu's mm page filter=
ing, others
> >>>>        are not tested.
> >>>>     2) Code structure: There are some similar code shared by makedum=
pfile and
> >>>>        crash, such as maple tree data structure, also I planed to po=
rt the
> >>>>        btf/kallsyms code to crash as well, so there are code duplica=
tions for
> >>>>        crash & makedumpfile. Since I havn't working on crash poring,=
 code change
> >>>>        on btf/kallsyms is expected. How can we share the code, creat=
ing a common
> >>>>        library or keep the duplication as it is?
> >>>>     3) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s3=
90/ppc64.
> >>>>        Others are not tested.
> >>>>
> >>>> D) Testing:
> >>>>
> >>>>     1) If you don't want to create your vmcore, you can find a vmcor=
e which I
> >>>>        created with amdgpu mm pages unfiltered [1], the amdgpu mm pa=
ges are
> >>>>        allocated by program [2]. You can use the vmcore in 1st kerne=
l to filter
> >>>>        the amdgpu mm pages by the previous performance testing cmdli=
ne. To
> >>>>        verify the pages are filtered in crash:
> >>>>
> >>>>        Unfiltered:
> >>>>        crash> search -c "!QAZXSW@#EDC"
> >>>>        ffff96b7fa800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXX
> >>>>        ffff96b87c800000: !QAZXSW@#EDCXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XXXXXXXXXXXXX
> >>>>        crash> rd ffff96b7fa800000
> >>>>        ffff96b7fa800000:  405753585a415121                    !QAZXS=
W@
> >>>>        crash> rd ffff96b87c800000
> >>>>        ffff96b87c800000:  405753585a415121                    !QAZXS=
W@
> >>>>
> >>>>        Filtered:
> >>>>        crash> search -c "!QAZXSW@#EDC"
> >>>>        crash> rd ffff96b7fa800000
> >>>>        rd: page excluded: kernel virtual address: ffff96b7fa800000  =
type: "64-bit KVADDR"
> >>>>        crash> rd ffff96b87c800000
> >>>>        rd: page excluded: kernel virtual address: ffff96b87c800000  =
type: "64-bit KVADDR"
> >>>>
> >>>>     2) You can use eppic_scripts/print_all_vma.c against an ordinary=
 vmcore to
> >>>>        test only btf/kallsyms functions by output all VMAs if no amd=
gpu
> >>>>        vmcores/machine avaliable.
> >>>>
> >>>> [1]: https://people.redhat.com/~ltao/core/
> >>>> [2]: https://gist.github.com/liutgnu/a8cbce1c666452f1530e1410d1f352d=
f
> >>>>
> >>>> Tao Liu (10):
> >>>>     dwarf_info: Support kernel address randomization
> >>>>     dwarf_info: Fix a infinite recursion bug for search_domain
> >>>>     Add page filtering function
> >>>>     Add btf/kallsyms support for symbol type/address resolving
> >>>>     Export necessary btf/kallsyms functions to eppic extension
> >>>>     Port the maple tree data structures and functions
> >>>>     Supporting main() as the entry of eppic script
> >>>>     Enable page filtering for dwarf eppic
> >>>>     Enable page filtering for btf/kallsyms eppic
> >>>>     Introducing 2 eppic scripts to test the dwarf/btf eppic extensio=
n
> >>>>
> >>>>    Makefile                               |   6 +-
> >>>>    btf.c                                  | 919 ++++++++++++++++++++=
+++++
> >>>>    btf.h                                  | 176 +++++
> >>>>    dwarf_info.c                           |  15 +-
> >>>>    eppic_maple.c                          | 431 ++++++++++++
> >>>>    eppic_maple.h                          |   8 +
> >>>>    eppic_scripts/filter_amdgpu_mm_pages.c |  36 +
> >>>>    eppic_scripts/print_all_vma.c          |  29 +
> >>>>    erase_info.c                           | 123 +++-
> >>>>    erase_info.h                           |  22 +
> >>>>    extension_btf.c                        | 218 ++++++
> >>>>    extension_eppic.c                      |  41 +-
> >>>>    extension_eppic.h                      |   6 +-
> >>>>    kallsyms.c                             | 371 ++++++++++
> >>>>    kallsyms.h                             |  42 ++
> >>>>    makedumpfile.c                         |  21 +-
> >>>>    makedumpfile.h                         |  11 +
> >>>>    17 files changed, 2448 insertions(+), 27 deletions(-)
> >>>>    create mode 100644 btf.c
> >>>>    create mode 100644 btf.h
> >>>>    create mode 100644 eppic_maple.c
> >>>>    create mode 100644 eppic_maple.h
> >>>>    create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
> >>>>    create mode 100644 eppic_scripts/print_all_vma.c
> >>>>    create mode 100644 extension_btf.c
> >>>>    create mode 100644 kallsyms.c
> >>>>    create mode 100644 kallsyms.h
> >>>>
> >>>> --
> >>>> 2.47.0
> >>>>


