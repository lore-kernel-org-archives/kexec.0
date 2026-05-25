Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FFC2CD6E57
	for <kexec@archiver.kernel.org>; Tue,  2 Jun 2026 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qV78+XoJ5yl4lw7jTkTV5DIdhzm9s8UbSBBAw5Rneo4=; b=QOr+PtfwOMgliELMdhj0LXe+dJ
	YxRlcjMX0iy2KmVMzGn7I9dOoRvP2XglpZZKaUoUId57GJ79y4GoLrRXWyyAUv2d+voQw/1bC3SxO
	C9Il8GrYCufKSrzgo3pMvtQ5FPAVmuLb260TpcKNl7TmD3WvSW7gsyQxIXtKdmq8Y4Fj10PmVMal+
	NW97TJjjzeV64VdhQtZCpCKVzGbI5KQp1cH7ZbQDpUrHGPQfrbXLqMzuaREnrHEKMrgjKnBfrbMQQ
	LlrU4JNwOpJQH0ykXoFbyPXnsBdZJl3EQrGpVx3lkXRu2RuoFBv8NJbL5Hbw6scCTr4BbtkO7g3dj
	tqPakDYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUQr6-0000000DI1i-2oM3;
	Tue, 02 Jun 2026 15:16:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRVBY-0000000HI9e-21uc
	for kexec@lists.infradead.org;
	Mon, 25 May 2026 13:17:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 36074438E3
	for <kexec@lists.infradead.org>; Mon, 25 May 2026 13:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5371F00A3E
	for <kexec@lists.infradead.org>; Mon, 25 May 2026 13:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779715056;
	bh=qV78+XoJ5yl4lw7jTkTV5DIdhzm9s8UbSBBAw5Rneo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dCpzrAvfgk9mSUU6JI5HHHez6L14UFh5dckZN5DAlujdAQMm/PYPxcKDOMc41IypU
	 NgmmttTk+nJ7gpnOe4Eg8v+8FV8RT+v5Ae+glRPhqcxzGZd/+6hgMw0F7yv/+6rQz4
	 X95gdQuJUyAKc1hWH3Gy1/l+TIZX2idKqbCpGmaVwhcsQRUGGQYoJHz3dhHrh2l/au
	 j0SXMMWwm+qgnDiXn93t6TJoPrAZ5gm82qSecFVClh3KPL2gWZzu9niNd8OSefMoGl
	 agHzEYaoQKd6HOPeiZMWEfzv0bjMM/EusAmU3Hy1nMtvCCD/Sa2YxNSMJTFxPK7Fzo
	 JaK+HMaC87z/g==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd124546379so1468488166b.3
        for <kexec@lists.infradead.org>; Mon, 25 May 2026 06:17:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8sD1ieDtpo1rONCOxhhy3gSAL+JrpV8uvi0u1QUU1H9QJUMVgucuMXNOSqscYJTJZ2vY34gg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxhgDcHu/OHzAyut7sSKKNSPXfY0wFV7G7HUJ3irQ/BpmxIJizZ
	YseSD+6x7CZBme0ODl1U95bllYxduEqZLm0S2520uX3pBeN327iF4BHqn+7VsyeI8IYTdZUOJVA
	YtvdcXbn1tPPibVGz0mgIAX43tGy0EP0=
X-Received: by 2002:a17:906:5a58:b0:bd5:7c2:7622 with SMTP id
 a640c23a62f3a-bdd26fcc664mr633046266b.49.1779715053431; Mon, 25 May 2026
 06:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260525084932.934910-1-ruanjinjie@huawei.com>
 <CAAhV-H4NA7vgyxKnK+N_3C6pWBnwXc2URUyLh_h1m-MO=MnsGQ@mail.gmail.com> <ahQ0WRiMsB011tym@kernel.org>
In-Reply-To: <ahQ0WRiMsB011tym@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 25 May 2026 21:17:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
X-Gm-Features: AVHnY4KF6iz3ZOONNz4YfBuRaFyzFjWLq0_9v1vlnlGZ6xwTI_B6DWjmlURC67Q
Message-ID: <CAAhV-H5x3m08=acrUr2VOAQ8-r2PhN1xTdr3NihHocoPM5=3hQ@mail.gmail.com>
Subject: Re: [PATCH v14 00/17] arm64/riscv: Add support for crashkernel CMA reservation
To: Mike Rapoport <rppt@kernel.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, corbet@lwn.net, skhan@linuxfoundation.org, 
	catalin.marinas@arm.com, will@kernel.org, kernel@xen0n.name, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, robh@kernel.org, 
	saravanak@kernel.org, akpm@linux-foundation.org, bhe@redhat.com, 
	pasha.tatashin@soleen.com, pratyush@kernel.org, ruirui.yang@linux.dev, 
	rdunlap@infradead.org, pmladek@suse.com, feng.tang@linux.alibaba.com, 
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com, 
	kuba@kernel.org, lirongqing@baidu.com, ebiggers@kernel.org, 
	paulmck@kernel.org, thuth@redhat.com, ardb@kernel.org, masahiroy@kernel.org, 
	mark.rutland@arm.com, maz@kernel.org, james.morse@arm.com, leitao@debian.org, 
	sourabhjain@linux.ibm.com, yeoreum.yun@arm.com, coxu@redhat.com, 
	jbohac@suse.cz, ryan.roberts@arm.com, cfsworks@gmail.com, 
	tangyouling@kylinos.cn, ritesh.list@gmail.com, songshuaishuai@tinylab.org, 
	junhui.liu@pigmoral.tech, vishal.moola@gmail.com, kas@kernel.org, 
	debug@rivosinc.com, namcao@linutronix.de, liaoyuanhong@vivo.com, 
	fuqiang.wang@easystack.cn, seanjc@google.com, guoren@kernel.org, 
	chenjiahao16@huawei.com, hbathini@linux.ibm.com, bgwin@google.com, 
	takahiro.akashi@linaro.org, lizhengyu3@huawei.com, x86@kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260525_061736_553401_60DC0AD4 
X-CRM114-Status: GOOD (  15.82  )
X-Mailman-Approved-At: Tue, 02 Jun 2026 08:16:35 -0700
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

On Mon, May 25, 2026 at 7:37=E2=80=AFPM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> Hi Huacai,
>
> On Mon, May 25, 2026 at 06:14:52PM +0800, Huacai Chen wrote:
> > On Mon, May 25, 2026 at 4:50=E2=80=AFPM Jinjie Ruan <ruanjinjie@huawei.=
com> wrote:
> > >
> > > Jinjie Ruan (16):
> > >   riscv: kexec_file: Fix crashk_low_res not exclude bug
> > >   powerpc/crash: Fix possible memory leak in update_crash_elfcorehdr(=
)
> > >   arm64: kexec: Fix image->elf_headers memory leak during retry loop
> > >   x86/kexec: Fix potential buffer overflow in prepare_elf_headers()
> > >   arm64: kexec_file: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   riscv: kexec_file: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   LoongArch: kexec: Fix potential buffer overflow in
> > >     prepare_elf_headers()
> > >   crash: Add crash_prepare_headers() to exclude crash kernel memory
> > >   arm64: kexec_file: Use crash_prepare_headers() helper to simplify c=
ode
> > >   x86/kexec: Use crash_prepare_headers() helper to simplify code
> > >   riscv: kexec_file: Use crash_prepare_headers() helper to simplify c=
ode
> > >   LoongArch: kexec: Use crash_prepare_headers() helper to simplify co=
de
> > >   crash: Use crash_exclude_core_ranges() on powerpc
> > >   arm64: kexec: Add support for crashkernel CMA reservation
> > >   riscv: kexec: Add support for crashkernel CMA reservation
> > >   arm64/crash: Add crash hotplug support
> > I have some bikesheedings about the subjects. Can we unify the prefix f=
ormats?
> > x86/kexec, arm64: kexec_file, riscv: kexec_file, LoongArch: kexec .....
>
> It might look weird in the series, but powerpc and x86 use '/' and arm64 =
and
> riscv use ':' so in the logs in arch/ this would be actually fine.
OK, but at least we can unify kexec and kexec_file.

Huacai

>
> With the only exception of arm64/crash that should have been arm64: crash=
:
>
> > Huacai
>
> --
> Sincerely yours,
> Mike.

