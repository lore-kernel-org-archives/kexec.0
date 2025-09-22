Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6616FCA100F
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 22:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=; b=mc2P/pD1jpLsDGq2TKP1RMOhnR
	l3IE2fcIbMlcsMjdxkBlu77G9nZpASFuPGI8b8+hHS0Yk7fg10pwXHO3+D5NRzsU4M3tUmc6CBlhK
	b6FeUo935FxAJGYZ29X1M1BVgjQK4pvIm5CLPTKiCpRZf87+WandAfd3B0V9LzjbL5hMpzbkyXF25
	vXOACchdosdGQhhdpUBAGiNEEL18E+OBRZ4DCiA+yi+K7bHLe0lhkknGKHEaWfbJB8c2p/YcFr3Nz
	D8Hayde4g1BT7pRHbtKq8IajBjziU2XTdpIFu6oyKF0Od57O6IcbM5bF3pR6nvI9N6/i7WfmwEmVI
	DGnu9Dqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0pDy-0000000BeqP-2W0A;
	Mon, 22 Sep 2025 22:41:34 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0pDw-0000000Bepz-0QKX
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 22:41:33 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-54a7bf06edfso3295509e0c.0
        for <kexec@lists.infradead.org>; Mon, 22 Sep 2025 15:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758580890; x=1759185690; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=;
        b=U8h5XZS5DN01MJNMWKLdyx7ZRC/AuHnWCYIMQ3Dlk5SJSkPT1nfnbyMOC8W+klHpwW
         ka3trLTMgva3VdAsV27WXsFe3Lwx1etLIaGaHXUmftNBdnj1ynApv+0zoW4Q/M0SI05e
         1Joxhd7XcOxaaDUk+m/t2MEB3cIWzQAu3/UdcbU1QqbOTvSWwLItugCLKi04lOfDGraL
         sHEMdQN4xXZEfUSa1Opiels7bfaICOuW0nY0eWa7Y3Ge1bQIwWH7D+HZHAw66rNFlKYm
         ULVwXZR+aGPRVYxDulrPx3iNL6aKzUTu38ZwOp6VuU5/KIYq03xNXC2vFPF3VcRV8bY4
         Gx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758580890; x=1759185690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yh6sVdAT113ztDhuPxo1MqnAkuhIHDy1HJdIr+aZPU=;
        b=l2Xld5gT9rh9uEPdLT4+Bc+1UMGhvru7Pa4WkUXbCisILOzoh6Umd5RQPJ/qfgljaa
         uoXQCdnp1H8MpQPqlr2+yYNYCFYhOHNc+8BEssHhQf+sNmPlseNwwZhx0YYjJCgbvn7B
         CE3hj1TUwdm8BAHlUQvpad18Um+WYjHpIwgnTlrZVUK/KX38VAxnU/K9Ea15JyrVaicG
         gm3WPlbMMx+fxvWpCEucVawbbaTZF3LVVGYPNkFdgiAknCNHDUcpghiqKx69GN2gJieq
         v0waMemslb0U3uRlJ960Rk+r3GxZyFZAHlH87jTo9NK9eBbeUdoq6TBFs9qwT2Sc1tO4
         yR7w==
X-Forwarded-Encrypted: i=1; AJvYcCXN282ajPTzBS8N9NqCQXPYkTevD4C5BC0E2zCLR4CZGmYSp/g1oNhZ50B9M472pDQN7O1oww==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5kIxseKnduC6ORw2xBXPZ3nOO6nedUV0DIAP8jBDmccF2QdrZ
	5HKoA7sclYSjT3chIaXBws0YLpMcX25bumocf8M78V6+/mjVi4mAfoHwls9cAo5oDygR9kknpD7
	M0ac0fIQBstnZW5vrBANsg3ALvuH0YqE=
X-Gm-Gg: ASbGnct2AfdZCoi0rpV0mu0dzPXeXvVgcAR1apF0NmhfJJNh3yfbR0oOA1WoARQKjS5
	YCfE9geOGWi9TCSx/Tp7Kozms8YvY9n5UpqOlJYddsscxTT8I3yN+2ghrw6T95/g6NO2KWp+fHu
	8zatUWFb5vgsLF7uSwSKvNaf8zhqJPyxm+OJNm7EecZJS7YM8ykn+iwDP90VBF0e5IjI82YgHjm
	0ZVfBW3LNq9VjB8bZZ3YmECoZFJiz/mVKkvHyk=
X-Google-Smtp-Source: AGHT+IHFB6pkceMUZ77NeXmuYnJm1V8ontKaUDy90T/NYBaMVOfoW99El5NLWv56d5b2UvDdU+jygkw5mvczc9Xzk18=
X-Received: by 2002:a05:6102:4492:b0:4c3:6393:83f4 with SMTP id
 ada2fe7eead31-5a57d8d7f2bmr255887137.2.1758580890508; Mon, 22 Sep 2025
 15:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <20250919212650.GA275426@fedora> <CAM_iQpXnHr7WC6VN3WB-+=CZGF5pyfo9y9D4MCc_Wwgp29hBrw@mail.gmail.com>
 <20250922142831.GA351870@fedora>
In-Reply-To: <20250922142831.GA351870@fedora>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 22 Sep 2025 15:41:18 -0700
X-Gm-Features: AS18NWB9iArZm8gNoiOyRm5CUi70i_coc1Ea1AEenDW54lVyHBPMys3KfUjFGeg
Message-ID: <CAM_iQpWO71vSV_0qXiUYeKYZMYF0xWNz8MrUVRkqKwDEtQvKqA@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com, 
	Cong Wang <cwang@multikernel.io>, Andrew Morton <akpm@linux-foundation.org>, 
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org, 
	multikernel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_154132_152775_25581497 
X-CRM114-Status: GOOD (  26.94  )
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

On Mon, Sep 22, 2025 at 7:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> On Sat, Sep 20, 2025 at 02:40:18PM -0700, Cong Wang wrote:
> > On Fri, Sep 19, 2025 at 2:27=E2=80=AFPM Stefan Hajnoczi <stefanha@redha=
t.com> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 03:25:59PM -0700, Cong Wang wrote:
> > > > This patch series introduces multikernel architecture support, enab=
ling
> > > > multiple independent kernel instances to coexist and communicate on=
 a
> > > > single physical machine. Each kernel instance can run on dedicated =
CPU
> > > > cores while sharing the underlying hardware resources.
> > > >
> > > > The multikernel architecture provides several key benefits:
> > > > - Improved fault isolation between different workloads
> > > > - Enhanced security through kernel-level separation
> > >
> > > What level of isolation does this patch series provide? What stops
> > > kernel A from accessing kernel B's memory pages, sending interrupts t=
o
> > > its CPUs, etc?
> >
> > It is kernel-enforced isolation, therefore, the trust model here is sti=
ll
> > based on kernel. Hence, a malicious kernel would be able to disrupt,
> > as you described. With memory encryption and IPI filtering, I think
> > that is solvable.
>
> I think solving this is key to the architecture, at least if fault
> isolation and security are goals. A cooperative architecture where
> nothing prevents kernels from interfering with each other simply doesn't
> offer fault isolation or security.

Kernel and kernel modules can be signed today, kexec also supports
kernel signing via kexec_file_load(). It migrates at least untrusted
kernels, although kernels can be still exploited via 0-day.

>
> On CPU architectures that offer additional privilege modes it may be
> possible to run a supervisor on every CPU to restrict access to
> resources in the spawned kernel. Kernels would need to be modified to
> call into the supervisor instead of accessing certain resources
> directly.
>
> IOMMU and interrupt remapping control would need to be performed by the
> supervisor to prevent spawned kernels from affecting each other.

That's right, security vs performance. A lot of times we have to balance
between these two. This is why Kata Container today runs a container
inside a VM.

This largely depends on what users could compromise, there is no single
right answer here.

For example, in a fully-controlled private cloud, security exploits are
probably not even a concern. Sacrificing performance for a non-concern
is not reasonable.

>
> This seems to be the price of fault isolation and security. It ends up
> looking similar to a hypervisor, but maybe it wouldn't need to use
> virtualization extensions, depending on the capabilities of the CPU
> architecture.

Two more points:

1) Security lockdown. Security lockdown transforms multikernel from
"0-day means total compromise" to "0-day means single workload
compromise with rapid recovery." This is still a significant improvement
over containers where a single kernel 0-day compromises everything
simultaneously.

2) Rapid kernel updates: A more practical way to eliminate 0-day
exploits is to update kernel more frequently, today the major blocker
is the downtime required by kernel reboot, which is what multikernel
aims to resolve.

I hope this helps.

Regards,
Cong Wang

