Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD51FD39423
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a1Tv5dyEFVLeCv4Is/9LY0zjm6zQPl9um3jEFkYYu2c=; b=wuKCjWA0KGgiAj1dzMF2hDpuww
	twjYdWQy0pM1ODECaCW28Du/mWL/eMEdbnRwiJf7GW8cmWejFKsZQDbViLDn3+MvGQVpjKR6Rhj/f
	eEKuM3h541SHbyPZZJVNF9Bre34zxjgwwjgwSgKuw+G0wRaUBZYPf2w7FkoOf/03ZAOsKyM0dI0OR
	oT4owZS5Kw9RQP7zEjNb+GqUgYEC9QrBXLl9gt1l+CtR+GB33tkaTFuRFfsplimrLFsz/uZEGRkWL
	ncp8vlpvJ2dd4m/H+S6lFsbOA3fWytFzOpxyOC4KUzoboH2J5fuFGyOOL54OghSGTs7PlgvHrD/LO
	Q8Kw5OGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HGA-000000004hu-2Jjm;
	Thu, 02 Apr 2026 12:34:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w77Nr-0000000AmvL-2HeZ
	for kexec@lists.infradead.org;
	Mon, 30 Mar 2026 07:50:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2708E44590
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 07:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BBBEC2BCB5
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774857003;
	bh=6kNN1RP6hfrxfLPYE0OI9tP3SvLOgSwkQmqyXhzTfyQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EMLHc9RRxxgF/q9IZFv1dePuIbnzTXNBuB6kVaoFukkr1ucrR8VtgGKJZxfHAPeda
	 NoOd5dNf4iw60IKhVuiihGzS20d2asneYTQFmIOPC+oibw6j5mB26gshymPA5cOnQU
	 8GwY3XAP/WUOAwUMhNJWulE7D51LKZLfsJ9jYrL2MWSm1AILniv6msGhMHwB2u72wL
	 NV3ZtFjq+6XUwCBsWxZDTcToYuFN8/MCoIOLkqqGR2/HpQGpyQ0uABqlI4zp2AJnVK
	 Rx/alDJqKvr0Bm4U2x6vI4IQVFXpJjTEyE984Dy+/l4J9Tk2CuS6GlGU6iWDdxPTfe
	 2ky4e5ATIv/aQ==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so584307f8f.3
        for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 00:50:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX7jOD+ezzW6X6aeDgTZagIzDwqCU3vvZ6PuEIogEcLTjYD+iYaUk3NpRaF5p2Ecm0Iypbx0A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxs1OjbArM/5YfW3RIaXl9kdI1yBZ+Pii7RDXEKR1jKc1vtnS9H
	L/gNeQ1zPX3EXtaygdVZRG9zoI456vS7jOB8lfobwpw1ZBbs/CvSy0H3Fwl9dSJIFphi5s/PCTD
	Nn6iL5c9EplBrGyI9K5KvYmMnX43huzI=
X-Received: by 2002:a05:6000:2409:b0:43b:447a:11b8 with SMTP id
 ffacd0b85a97d-43b9e9d6050mr19116932f8f.6.1774857000398; Mon, 30 Mar 2026
 00:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260328074013.3589544-1-ruanjinjie@huawei.com>
 <20260328074013.3589544-2-ruanjinjie@huawei.com> <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
 <baa90080-9e6e-c1e5-13a1-b17496c690b4@huawei.com>
In-Reply-To: <baa90080-9e6e-c1e5-13a1-b17496c690b4@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 15:49:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQE58ooXwyPSztDHbrxMRWCWhJNMKcRJZJsmKznBD12wA@mail.gmail.com>
X-Gm-Features: AQROBzBd-gKOewl3PX_5GW7wfDT6ZMEcMbV186WYHO9lbJECvy1QYs-DBc7P3MM
Message-ID: <CAJF2gTQE58ooXwyPSztDHbrxMRWCWhJNMKcRJZJsmKznBD12wA@mail.gmail.com>
Subject: Re: [PATCH v11 01/11] riscv: kexec_file: Fix crashk_low_res not
 exclude bug
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com, 
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	vgoyal@redhat.com, dyoung@redhat.com, rdunlap@infradead.org, 
	peterz@infradead.org, feng.tang@linux.alibaba.com, 
	pawan.kumar.gupta@linux.intel.com, dapeng1.mi@linux.intel.com, 
	kees@kernel.org, elver@google.com, paulmck@kernel.org, lirongqing@baidu.com, 
	rppt@kernel.org, leitao@debian.org, ardb@kernel.org, cfsworks@gmail.com, 
	osandov@fb.com, jbohac@suse.cz, tangyouling@kylinos.cn, 
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com, eajames@linux.ibm.com, 
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com, vishal.moola@gmail.com, 
	junhui.liu@pigmoral.tech, coxu@redhat.com, fuqiang.wang@easystack.cn, 
	liaoyuanhong@vivo.com, chenjiahao16@huawei.com, hbathini@linux.ibm.com, 
	takahiro.akashi@linaro.org, james.morse@arm.com, lizhengyu3@huawei.com, 
	x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260330_005003_626005_D53B7F0E 
X-CRM114-Status: GOOD (  23.09  )
X-Mailman-Approved-At: Thu, 02 Apr 2026 05:34:24 -0700
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

On Mon, Mar 30, 2026 at 3:11=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
>
>
> On 2026/3/30 11:49, Guo Ren wrote:
> > On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> >>
> >> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=
=3DX")
> >> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
> >> crashkres_low.") for arm64, while implementing crashkernel=3DX,[high,l=
ow],
> >> riscv should have excluded the "crashk_low_res" reserved ranges from
> >> the crash kernel memory to prevent them from being exported through
> >> /proc/vmcore, and the exclusion would need an extra crash_mem range.
> >>
> >> Cc: Guo Ren <guoren@kernel.org>
> >> Cc: Baoquan He <bhe@redhat.com>
> >> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=3DX,[high,lo=
w]")
> >> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> >> ---
> >>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
> >>  1 file changed, 11 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kerne=
l/machine_kexec_file.c
> >> index 54e2d9552e93..3f7766057cac 100644
> >> --- a/arch/riscv/kernel/machine_kexec_file.c
> >> +++ b/arch/riscv/kernel/machine_kexec_file.c
> >> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned=
 long *sz)
> >>         unsigned int nr_ranges;
> >>         int ret;
> >>
> >> -       nr_ranges =3D 1; /* For exclusion of crashkernel region */
> >> +       nr_ranges =3D 2; /* For exclusion of crashkernel region */
> >>         walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callb=
ack);
> >>
> >>         cmem =3D kmalloc_flex(*cmem, ranges, nr_ranges);
> >> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigne=
d long *sz)
> >>
> >>         /* Exclude crashkernel region */
> >>         ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk=
_res.end);
> >> -       if (!ret)
> >> -               ret =3D crash_prepare_elf64_headers(cmem, true, addr, =
sz);
> >> +       if (ret)
> >> +               goto out;
> >> +
> >> +       if (crashk_low_res.end) {
> >> +               ret =3D crash_exclude_mem_range(cmem, crashk_low_res.s=
tart, crashk_low_res.end);
> > Exclude crashk_low_res is reasonable, but have you tested this?
>
> Just simply tested on qemu with crashkernel=3D4G with following kexec
> mentioned in
> https://lore.kernel.org/all/20230726175000.2536220-1-chenjiahao16@huawei.=
com/.
> And the second kernel can be started normally.
>
> https://github.com/chenjh005/kexec-tools/tree/build-test-riscv-v2
>
> # dmesg | grep crash
> [    0.000000] crashkernel low memory reserved: 0xf8000000 - 0x100000000
> (128 MB)
> [    0.000000] crashkernel reserved: 0x000000017fe00000 -
> 0x000000027fe00000 (4096 MB)
Adding a test log to the commit log makes the patch more trustworthy.

Reviewed-by: Guo Ren <guoren@kernel.org>

>
>
>
> >
> >> +               if (ret)
> >> +                       goto out;
> >> +       }
> >> +
> >> +       ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz);
> >>
> >>  out:
> >>         kfree(cmem);
> >> --
> >> 2.34.1
> >>
> >
> >



--=20
Best Regards
 Guo Ren

