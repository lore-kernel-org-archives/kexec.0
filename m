Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46CED116EA
	for <kexec@archiver.kernel.org>; Fri, 28 Nov 2025 08:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOwiFCph9kB5nDhUyFfKIY6K5xsYWX8zoXXWOUISfAA=; b=Cc6ZC1/wigLq/svbgdh/1htvzv
	6TXLA/c1zlsTcuO0k/2dOovcqIa0Gn0O9Cd4DTn/a6FIK/2OIcU0pvkiWCIK7Ydat1Fya2ykue70+
	2FCWtzLTWOfO2rItxL7wvcWnK8B4vhyc84hYfgSB3T3iELg/lmf2rH+vp5OePnOyBNYQhWiGmZnZM
	q/lUtNblnhLbaecH56P1VVl8fjKbi5X69BDlq2V0QsgwVewSDZcdccCh6s34ULHHiABNAmnLasfCV
	tnQJlA5ZrKsoIptp/nmxUFSOT6e8FMDBHBdqA4xgK9xuHZzJFrBJ+RyXL+WaMG9WgNuQZ0DPpOdya
	tbl9CBSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtZ2-0000000083e-32md;
	Fri, 28 Nov 2025 08:10:48 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtYy-0000000082f-08H8
	for kexec@lists.infradead.org;
	Fri, 28 Nov 2025 08:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764317441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xOwiFCph9kB5nDhUyFfKIY6K5xsYWX8zoXXWOUISfAA=;
	b=CipKwVwVkv1YdE36hLfxMywntr6D2UeaKcfAQQd0bu88fkP/1t4IK0q7mUhRnV/LAW0Agl
	q8Ir/iOoQoYAqbISBnt6gVRkH5VE2ctwC2aP9Qj/01H/OxVgo6of3R8/pAhdkq47rC/9Um
	wkVIzUT1RjVpsdVQZ+K55DMy/2oKU58=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-QJJ0tb_sPv25vcLQRrn05g-1; Fri, 28 Nov 2025 03:10:39 -0500
X-MC-Unique: QJJ0tb_sPv25vcLQRrn05g-1
X-Mimecast-MFC-AGG-ID: QJJ0tb_sPv25vcLQRrn05g_1764317438
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8805c2acd64so32672946d6.3
        for <kexec@lists.infradead.org>; Fri, 28 Nov 2025 00:10:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317438; x=1764922238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xOwiFCph9kB5nDhUyFfKIY6K5xsYWX8zoXXWOUISfAA=;
        b=hGlZTJMA/zxkH0t1ctWUdzQOCdrrCuuAFDstJwOm8p1jDBxvM1t9XzQN43c/RpgbZQ
         FSXHyPyBMNAXjqDyKC9EPzwId6LrlhSFV+4vC2hZapN4tHjzI3riz7ssDg2Oq7a/CMW/
         UHvrx7WVf9W23odLWodShtxEkuaim2IuftBNfPfTKbqBzTmpduwFtcfsSnTovM0EG06K
         RBwKYOLraaal01gzMh5R8tWaKQR1Mfj5IZP085u2/AHERm04B+OrhDMRidGAqIZMhWtU
         xACVYdBN6Lp1bc+Xq/MwVlkAIb8j2qdZqfvIVeh4eLWAQx9vZOpfl4xmb6h8kAqoPSJg
         Sn6A==
X-Forwarded-Encrypted: i=1; AJvYcCVkkLCWaOBsr2H0JuQk70WTBo/pxz8toQy3gRvTnUPmmtkq/Pf2SAHw0LaIawt/Kq9QA3SCmQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyqlhcUqvhqqE3p14I1ufTEUVKMOWck+cgthiX6vO9I84AaHVoR
	DPm6DuYz6xCdqVMmMBG3fVBPUG5Gnml1N8eKlZKbfCto+HeNqfekm78acViZESfro4ih9k48Vqy
	utpHD0i+W9kiCIQ+BUCE6203JSZyk3kMVD3BCLENCuwypBGP3psi6IEQJ4tljn2lbhLh06A3ljz
	xNaNBO+cmP/lFTmPjbIz9gskt8PfhqQ13wAMVpgjQ87nkE
X-Gm-Gg: ASbGncsMYYJ+px73RdR7+jreIMalMPYzB3Tx97ET3Lb1fcC1/QiYwUUwmk9MdqbtMAF
	lolYuWMk35UI6BKSzvSuycxGDhWYr2Ja2QQ8mDGLD8hnaLcFnRJiolOCNQJffyARljvLR9Jr5pj
	uXPR54ScGI1ZUWqEHeezXcSLBvzVnnmHgaS9srMIqLrH8LzWrndi2LILef5K5qecy8fQ==
X-Received: by 2002:a05:622a:1393:b0:4ed:42a2:1293 with SMTP id d75a77b69052e-4ee58841b1emr308132261cf.1.1764317438162;
        Fri, 28 Nov 2025 00:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0SFQP6ykoOoIklHyxOsyq5BSfz49dvoMx2CYeX1FWtvQe3nLupoYp97iFFo9PLbX1Z1x8C/JashKrz/GZdzY=
X-Received: by 2002:a05:622a:1393:b0:4ed:42a2:1293 with SMTP id
 d75a77b69052e-4ee58841b1emr308132111cf.1.1764317437735; Fri, 28 Nov 2025
 00:10:37 -0800 (PST)
MIME-Version: 1.0
References: <20251020222410.8235-1-ltao@redhat.com> <CAO7dBbVLPv3LZTd31XdPvnYFFTfQ3PVaMTS_h3uRgE4sJsS1PA@mail.gmail.com>
 <8b5c5913-34bc-444f-8ffe-9457bde0649c@nec.com>
In-Reply-To: <8b5c5913-34bc-444f-8ffe-9457bde0649c@nec.com>
From: Tao Liu <ltao@redhat.com>
Date: Fri, 28 Nov 2025 21:10:01 +1300
X-Gm-Features: AWmQ_bn-2i3vE_XUlfASaguHlrDeYpMRiq0WCxMMD-YcdQhb1Pcwmt82zZsVbwk
Message-ID: <CAO7dBbX942TTzxKySZzHeo2QuTTeNT7N87Mvsd+nAH0KUv3J2g@mail.gmail.com>
Subject: Re: [PATCH v2][makedumpfile 00/14] btf/kallsyms based eppic extension
 for mm page filtering
To: =?UTF-8?B?SEFHSU8gS0FaVUhJVE8o6JCp5bC+IOS4gOS7gSk=?= <k-hagio-ab@nec.com>
Cc: =?UTF-8?B?WUFNQVpBS0kgTUFTQU1JVFNVKOWxseW0jiDnnJ/lhYkp?= <yamazaki-msmt@nec.com>, 
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hasu9anB7sEq6S2qmIoJHv1k1SgTAI_aKk2C-JZcU_I_1764317438
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_001044_212394_CFA2F8B0 
X-CRM114-Status: GOOD (  42.77  )
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

On Fri, Nov 28, 2025 at 9:04=E2=80=AFPM HAGIO KAZUHITO(=E8=90=A9=E5=B0=BE=
=E3=80=80=E4=B8=80=E4=BB=81)
<k-hagio-ab@nec.com> wrote:
>
> On 2025/11/24 13:46, Tao Liu wrote:
> > Kindly ping... Any comments on this?
>
> Hi Tao,
>
> I'm sorry for the delay. I think I can look into this next month.

No worries, please take your time :)

Thanks,
Tao Liu

>
> Thanks,
> Kazu
>
> >
> > Thanks,
> > Tao Liu
> >
> > On Tue, Oct 21, 2025 at 11:24=E2=80=AFAM Tao Liu <ltao@redhat.com> wrot=
e:
> >>
> >> A) This patchset will introduce the following features to makedumpfile=
:
> >>
> >>    1) Enable eppic script for memory pages filtering.
> >>    2) Enable btf and kallsyms for symbol type and address resolving.
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
> >>    2) OS: The code can work on rhel-10+/rhel9.5+ on x86_64/arm64/s390/=
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
> >> v2 -> v1:
> >>
> >> 1) Moved maple tree related code(for VMA iteration) into eppic script,=
 so we
> >>     don't need to port maple tree code to makedumpfile.
> >>
> >> 2) Reorganized the patchset as follows:
> >>
> >>      --- <common modification> ---
> >>      1.Add page filtering function
> >>      2.Supporting main() as the entry of eppic script
> >>
> >>      --- <dwarf related modification> ---
> >>      3.dwarf_info: Support kernel address randomization
> >>      4.dwarf_info: Fix a infinite recursion bug for rust
> >>      5.eppic dwarf: support anonymous structs member resolving
> >>      6.Enable page filtering for dwarf eppic
> >>
> >>      --- <btf & kallsyms related modification> ---
> >>      7.Implement kernel kallsyms resolving
> >>      8.Implement kernel btf resolving
> >>      9.Implement kernel module's kallsyms resolving
> >>      10.Implement kernel module's btf resolving
> >>      11.Export necessary btf/kallsyms functions to eppic extension
> >>      12.Enable page filtering for btf/kallsyms eppic
> >>      13.Docs: Update eppic related entries
> >>
> >>      --- <only for test purpose, don't merge> ---
> >>      14.Introducing 2 eppic scripts to test the dwarf/btf eppic extens=
ion
> >>
> >>     The modification on dwarf is primary for comparision purpose, that
> >>     for the same eppic program, mm page filtering should get exact sam=
e
> >>     outputs for dwarf & kallsyms/btf based approaches. If outputs unma=
tch,
> >>     this indicates bugs. In fact, we will never take dwarf mm pages fi=
ltering
> >>     in real use, due to its poor performance as well as inaccessibilit=
y
> >>     of debuginfo during kdump in 2nd kernel. So patch 3/4/5 won't affe=
ct
> >>     the function of btf/kallsyms eppic mm page filtering, but there ar=
e
> >>     functions shared in patch 6, so it is a must-have one. Patch 14 is
> >>     only for test purpose, to demonstrate how to write eppic script fo=
r
> >>     mm page filtering, so it isn't a must-have patch.
> >>
> >>     Please note, in patch 14, I have deliberately converted all array
> >>     operation into pointer operation, e.g. modified "node->slot[i]" in=
to
> >>     "*((unsigned long *)&(node->slot) + i)". This is because there are
> >>     bugs for array operation support in extension_eppic.c. I didn't ha=
ve
> >>     effort to test and fix them all because as I mentioned previously,
> >>     mm page filtering in dwarf side is only for comparision and will
> >>     never be used in real use. There is no such issue for kallsyms/btf
> >>     eppic side.
> >>
> >> 3) Since we ported maple tree code to eppic script, several bugs found
> >>     both for eppic library & eppic btf support. Please use master bran=
ch
> >>     of eppic library to co-compile with this patchset.
> >>
> >> Tao Liu (14):
> >>    Add page filtering function
> >>    Supporting main() as the entry of eppic script
> >>    dwarf_info: Support kernel address randomization
> >>    dwarf_info: Fix a infinite recursion bug for rust
> >>    eppic dwarf: support anonymous structs member resolving
> >>    Enable page filtering for dwarf eppic
> >>    Implement kernel kallsyms resolving
> >>    Implement kernel btf resolving
> >>    Implement kernel module's kallsyms resolving
> >>    Implement kernel module's btf resolving
> >>    Export necessary btf/kallsyms functions to eppic extension
> >>    Enable page filtering for btf/kallsyms eppic
> >>    Docs: Update eppic related entries
> >>    Introducing 2 eppic scripts to test the dwarf/btf eppic extension
> >>
> >>   Makefile                               |   6 +-
> >>   btf.c                                  | 919 +++++++++++++++++++++++=
++
> >>   btf.h                                  | 177 +++++
> >>   dwarf_info.c                           |   7 +
> >>   eppic_scripts/filter_amdgpu_mm_pages.c | 255 +++++++
> >>   eppic_scripts/print_all_vma.c          | 239 +++++++
> >>   erase_info.c                           | 120 +++-
> >>   erase_info.h                           |  19 +
> >>   extension_btf.c                        | 258 +++++++
> >>   extension_eppic.c                      | 106 ++-
> >>   extension_eppic.h                      |   6 +-
> >>   kallsyms.c                             | 392 +++++++++++
> >>   kallsyms.h                             |  41 ++
> >>   makedumpfile.8.in                      |  24 +-
> >>   makedumpfile.c                         |  21 +-
> >>   makedumpfile.h                         |  11 +
> >>   print_info.c                           |  11 +-
> >>   17 files changed, 2550 insertions(+), 62 deletions(-)
> >>   create mode 100644 btf.c
> >>   create mode 100644 btf.h
> >>   create mode 100644 eppic_scripts/filter_amdgpu_mm_pages.c
> >>   create mode 100644 eppic_scripts/print_all_vma.c
> >>   create mode 100644 extension_btf.c
> >>   create mode 100644 kallsyms.c
> >>   create mode 100644 kallsyms.h
> >>
> >> --
> >> 2.47.0
> >>


