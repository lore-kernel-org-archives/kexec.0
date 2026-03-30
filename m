Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83794D3941E
	for <kexec@archiver.kernel.org>; Thu,  2 Apr 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W7U7BTXS8iu2ikkIeTXCYXN1EZ8TvQ225S/V4SWCkaY=; b=adNDGzbG+9B9t7PRlH8V/skfvg
	ZaLT+/30iigiPyAARmWeFbhkJDv8k6rLMP8fpKjrubjzjGEy0v1kPAU4tQjMWc43naaYkaT/vwsCd
	OIIbWApENUe5rN1wxDIe4BUvLB482V2rycU/UNl6eHay2rw52J2YNEsrzMnjtWp2dvldPD2f6F5ZD
	RVRXBkbDtApB2C6I3lr1JPUvnNf/TlzQOluFy2m2wBrRtf79/9YAzbnF6tpH5EIp+B8JPLoiFgXaw
	FIwqVVAs76UQ1gW5YpcbBBOJhkkK3nrNLtWq+RiXhqhx2vLEhR2kVQOKYuZHeAo8BoPBIBXLJ5EYB
	jBUMWP2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8HG9-000000004f3-2J2D;
	Thu, 02 Apr 2026 12:34:53 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w73dO-0000000AZTu-0uIn
	for kexec@lists.infradead.org;
	Mon, 30 Mar 2026 03:49:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D31B744557
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 03:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84F4C2BCB2
	for <kexec@lists.infradead.org>; Mon, 30 Mar 2026 03:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774842589;
	bh=obCDFOyxCbjX0f8M408do6wNaHwmsZQneN83knIeC68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eoZ8B/stmhNenV55/GZwaY1J2F6+Mdl80yqD9NRcEWBOsoYl+9c7bLnMbhuDm8UCy
	 /HdFRjzUQbmAk/UyPSD+aNwyk+7+AXRsactruboxv4TBhmx7ZVUw3PnXCFXHbt/2Tv
	 8gPyg7oqfxDRPwPwOxonENTYb7rY2pfqtB3H6lN+8wTRbtHFo5byuP+ppf4WRnAd5Y
	 XciAnSMYuc3D6bWIB/pXvfsgHa26rnCnF4gtv6axbQIdyVpVlSoEdBsZ3ZtXIwQJfW
	 magEl9/ciAmyJ46LOqRQucXon3Rz5vlKU6TS+JdRCMl0FTU+kXQTbAQM34dEaStji4
	 KbhEz4mM9Fraw==
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43cfa33a983so464670f8f.1
        for <kexec@lists.infradead.org>; Sun, 29 Mar 2026 20:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjB8sufL3s8DGeEeh2w8gHcBET1aTH4iy9ATzncYFcjpWgdjtuNbbB1UZBWLkTJ49X27o+ag==@lists.infradead.org
X-Gm-Message-State: AOJu0YxI0YOO7l07xCFdLcrwBEG2kjc5G2jd2N8iiBG5UK3kQ+SoTl6Y
	JIYdiv/uL4H2GBzOQDlAUyD7sNN+nRP1ValUQlxWwZEXEYKlr7Q0YrlJlPOxom9JpgWg9S+JjW1
	DWpwl4PpYT+z4pqwYN65dgSbZzEuuIDw=
X-Received: by 2002:a05:6000:250f:b0:43c:f4df:923c with SMTP id
 ffacd0b85a97d-43cf4dfaca4mr10913170f8f.49.1774842587366; Sun, 29 Mar 2026
 20:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260328074013.3589544-1-ruanjinjie@huawei.com> <20260328074013.3589544-2-ruanjinjie@huawei.com>
In-Reply-To: <20260328074013.3589544-2-ruanjinjie@huawei.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 30 Mar 2026 11:49:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
X-Gm-Features: AQROBzDiH9EGqvtsmkvuTI8F_a_MxhnUfiDn46oBgBr7JyKcMW8nH_9Y5zS6MkE
Message-ID: <CAJF2gTRN=RpgzQsQ7QDbwjDmyQZP9anQZ+CaK2r-Mrz9dQbohQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260329_204950_294789_D803A7B4 
X-CRM114-Status: GOOD (  17.94  )
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

On Sat, Mar 28, 2026 at 3:41=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> As done in commit 944a45abfabc ("arm64: kdump: Reimplement crashkernel=3D=
X")
> and commit 4831be702b95 ("arm64/kexec: Fix missing extra range for
> crashkres_low.") for arm64, while implementing crashkernel=3DX,[high,low]=
,
> riscv should have excluded the "crashk_low_res" reserved ranges from
> the crash kernel memory to prevent them from being exported through
> /proc/vmcore, and the exclusion would need an extra crash_mem range.
>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Fixes: 5882e5acf18d ("riscv: kdump: Implement crashkernel=3DX,[high,low]"=
)
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/kernel/machine_kexec_file.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/machine_kexec_file.c b/arch/riscv/kernel/m=
achine_kexec_file.c
> index 54e2d9552e93..3f7766057cac 100644
> --- a/arch/riscv/kernel/machine_kexec_file.c
> +++ b/arch/riscv/kernel/machine_kexec_file.c
> @@ -61,7 +61,7 @@ static int prepare_elf_headers(void **addr, unsigned lo=
ng *sz)
>         unsigned int nr_ranges;
>         int ret;
>
> -       nr_ranges =3D 1; /* For exclusion of crashkernel region */
> +       nr_ranges =3D 2; /* For exclusion of crashkernel region */
>         walk_system_ram_res(0, -1, &nr_ranges, get_nr_ram_ranges_callback=
);
>
>         cmem =3D kmalloc_flex(*cmem, ranges, nr_ranges);
> @@ -76,8 +76,16 @@ static int prepare_elf_headers(void **addr, unsigned l=
ong *sz)
>
>         /* Exclude crashkernel region */
>         ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk_re=
s.end);
> -       if (!ret)
> -               ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz)=
;
> +       if (ret)
> +               goto out;
> +
> +       if (crashk_low_res.end) {
> +               ret =3D crash_exclude_mem_range(cmem, crashk_low_res.star=
t, crashk_low_res.end);
Exclude crashk_low_res is reasonable, but have you tested this?

> +               if (ret)
> +                       goto out;
> +       }
> +
> +       ret =3D crash_prepare_elf64_headers(cmem, true, addr, sz);
>
>  out:
>         kfree(cmem);
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren

