Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01954C5B572
	for <kexec@archiver.kernel.org>; Fri, 14 Aug 2026 08:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+WNFzfxSWW15fOIdnEaHeTYbpQjdQsx6jTbj9dE4ksY=; b=CAwiH94q56ZazwGSZw/UQGDmtA
	/UdVDxf27wWSUMkngPMnWSboDFJWUo4YlY2tVcISDgPMGa433bMaQ0XgmYYR66pYwSFsCwi+EHi+6
	fYKaQfRO4SFi40TU1TJdwuYYLWzzD3EazLpklqfuX8gwngbAYbd/5jW/tbjXZZflvxcXkpQ/9rPwW
	zpYcVwT7vjY+2/4r7OStHVA7kMzbM3UMq0oAW1c7rwszUnyTN0TZI1fhwQ4PrhrHXHwQAza2sFPbM
	sUqYUjpFOCjsid9jMEaCh+IGdCwMP4Wu8w8kygRHTSN8ozl8b5DGMst2Grh6pjq4nJ1aoebR7uPol
	EoGdOAhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wunF4-00000002GvA-2hlQ;
	Fri, 14 Aug 2026 08:26:18 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wunF3-00000002Gux-3OjE
	for kexec@lists.infradead.org;
	Fri, 14 Aug 2026 08:26:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AAED7601E0
	for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 08:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616FF1F00A3F
	for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786695976;
	bh=+WNFzfxSWW15fOIdnEaHeTYbpQjdQsx6jTbj9dE4ksY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SMgOxtmN8Vf5EkQdQSMB+lyU6zdP5E/rVzeaMaT5tG37DvvceG22rBwtS4b3YBjJP
	 LHtiprxppMxk76P3Tqs4D2P3wkaJoyHFi9y3e8+bupmb/8bQHh0OKCECOJLmpMa6ES
	 X2ZxouX3gnn7Ahe/4T/D86o/e9/V4HlxSBV8rGnm8XQQxx/9GgKKxaVF97SzsJNfUj
	 gs8dlFaRo7VPgUqJWmlibmGcv1jTfIVtSk6ZmDdMsIfFszF5GC+uTcdNJ/OHcED9f/
	 m/dz0wP+llgLEZCa7RYZ8APKi76J7sFVFVR+Z31p4fgNuL0bbNFOjkMSjwOq5MBuEq
	 DGiLti1auW0Dg==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so1436627a12.1
        for <kexec@lists.infradead.org>; Fri, 14 Aug 2026 01:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoMtv4C8qAidIz590Gn5w++vu/kxQjWICqcNsuOVmG8UsqoQ4+9yrW+9CvQxwviQut3kttXlw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwU819JVlSrTTr8SdV7jibAiJJ9C0O1FQxVbjtR0JJCN3RJaQ6i
	wLFrByBFPYzt2/EINX6LNgbrUjcSHeyyw97DKu966VBOzv3XkvIC5mtn8zIb2JoYGj2JPIAWEYA
	OiF27QGT8Mn1CqB0CdRYlKkFGH+aD1e8=
X-Received: by 2002:a05:6402:324d:b0:6a1:332a:83c1 with SMTP id
 4fb4d7f45d1cf-6a38aedabdamr1544094a12.6.1786695974968; Fri, 14 Aug 2026
 01:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAAhV-H7+1bv6ULPO1+SZ5R=XFxNTh+54rqnYQUAW26kF83kiMg@mail.gmail.com>
 <20260813160307.15130-1-dongtai.guo@linux.dev>
In-Reply-To: <20260813160307.15130-1-dongtai.guo@linux.dev>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 14 Aug 2026 16:26:41 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7XKFj93fSPcKAR9AR6Z4O28pC9va243hVccvPNOxH3qg@mail.gmail.com>
X-Gm-Features: AUfX_mxWy0zifyMkCT_MNsH5vELQu4FCKCmOeWL2rt6IE_4N76SZIZUTr8aX0ys
Message-ID: <CAAhV-H7XKFj93fSPcKAR9AR6Z4O28pC9va243hVccvPNOxH3qg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] selftests/kho: add LoongArch vmtest support
To: George Guo <dongtai.guo@linux.dev>
Cc: rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	shuah@kernel.org, ardb@kernel.org, guodongtai@kylinos.cn, kernel@xen0n.name, 
	graf@amazon.com, liukexin@kylinos.cn, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Aug 14, 2026 at 12:03=E2=80=AFAM George Guo <dongtai.guo@linux.dev>=
 wrote:
>
> Hi Huacai,
>
> On Sun, 9 Aug 2026 at 12:16, Huacai Chen <chenhuacai@kernel.org> wrote:
> > You never answer me why in your test you should disable i8042 from V1
> > until V4. In normal use we use a single kernel for both host and guest.
>
> I owe you an apology: I did not actually understand your question. I
> thought the commit message had already explained the reason (the
> i8042_flush() panic), so I treated it as answered and never addressed
> what you were really asking. Let me answer it directly now.
>
> You are right that this is not just a selftest detail. i8042 is built on
> every LoongArch kernel: arch/loongarch/Kconfig selects
> ARCH_MIGHT_HAVE_PC_SERIO, and KEYBOARD_ATKBD and MOUSE_PS2 (both default
> y) select SERIO_I8042 under it. So your "single kernel for host and
> guest" point is correct -- a normal defconfig kernel has i8042 built in.
>
> On the QEMU virtual machine there is no i8042, so PNP finds nothing and
> i8042_pnp_init() falls back to probing the i8042 status and data
> registers (I8042_STATUS_REG, I8042_DATA_REG) directly. On LoongArch those
> registers are memory-mapped, and on the virtual machine they are not back=
ed
> by any device, so i8042_flush() takes a page fault and the kernel panics
> before userspace. A normal LoongArch defconfig kernel booted as a QEMU
> guest hits the same panic -- the "# CONFIG_SERIO_I8042 is not set" in
> loongarch.conf is only a workaround to let the KHO selftest boot, not a
> fix.
>
> The real fix is separate from the KHO series: make i8042 bail out on
> LoongArch when ACPI/PNP does not describe a controller, so the direct-por=
t
> fallback never runs. I have prepared that as a standalone patch -- the
> relevant hunk is below -- and will send the full patch separately. The
> selftest workaround can be dropped once it lands.
You nearly answered nothing.

Does your employer use different kernels for host and guest in KylinOS?

Huacai

>
> diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/=
i8042-acpipnpio.h
> --- a/drivers/input/serio/i8042-acpipnpio.h
> +++ b/drivers/input/serio/i8042-acpipnpio.h
> @@ -1633,8 +1633,14 @@ static int __init i8042_pnp_init(void)
>  #else
>                 pr_info("PNP: No PS/2 controller found.\n");
>  #if defined(__loongarch__)
> -               if (acpi_disabled =3D=3D 0)
> -                       return -ENODEV;
> +               /*
> +                * LoongArch legacy I/O ports are memory-mapped and are n=
ot
> +                * safely probeable when no controller is present: a dire=
ct
> +                * probe faults on the QEMU virtual machine and on any FD=
T-based
> +                * boot.  Do not fall back to probing them directly; if A=
CPI/PNP
> +                * did not describe a controller, assume there is none.
> +                */
> +               return -ENODEV;
>  #else
>                 if (x86_platform.legacy.i8042 !=3D
>                                 X86_LEGACY_I8042_EXPECTED_PRESENT)
>
> Thanks,
> George

