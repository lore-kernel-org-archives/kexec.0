Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E1CAC5BD
	for <kexec@archiver.kernel.org>; Sun, 28 Sep 2025 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AxygTYPsyDIO3n3TnSdkY5wM9WsVygTw8LCKh40a5Zo=; b=j97GcFdkDg++8N6asSI/PL9gjV
	yTz1KPjQPX96/sjeIZMJ2JIPIOadzPk/bGV73Y5OCn1PoiNhFO7+5AtdH9QYT02z5BCSNZqcfHKkb
	LWVIvomTWIzi0nVjKRg5NS1Z5b0K+aFO/DpYGkwNmTgHYowleEBBMM9ZTQT5nFEXJxYuRK1fno8ZL
	K4vWnS0nRO5FCW1fUK85nQIU+0rIt/jnlcGkAX75H9eeIz3JGZD279bUSuIT3zqUK8/VYZoosKExe
	KRkdKc/gNza2gOpcZ8BguV0z9T2zZpExAzwFEu9X7c0WSif7xdk8NYIy9GU6dpKL5e/SPYYn+0sWR
	Zn1r4IJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2sb8-0000000G4Y1-19F0;
	Sun, 28 Sep 2025 14:41:58 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2sb7-0000000G4Xh-0cPT
	for kexec@lists.infradead.org;
	Sun, 28 Sep 2025 14:41:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9018F62175;
	Sun, 28 Sep 2025 14:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAF9C4CEF5;
	Sun, 28 Sep 2025 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759070516;
	bh=SzzdI+GX07mAERTWzTnj3dkki2cHhdg6x0GIVS4BA9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m0Iw+J01S0fGdnbq0MAZ6PTKcjL5BY1ZlP4amzY+Kn/GmtCBnY9dg7UsSWwM1Yorm
	 Cd2dsk1mHNjW5aDtyRHfS5v+K5t2fQOYDgVR5NhZ53bD4iWJOh9aqzXG45qM4Blxir
	 0emDc2Vs5ir0T7W06O8Fnia5yaxbnYy1kEdS1AL2SWBMsPd+xvmeAr2t1russfADFJ
	 LmwTnZaw7OCcQLjHiCJtpMNOS8JnuYDb2HudfgMCMcvg9vgongLpQPlPYArVRORTR/
	 sLwXxYgBzKeBbQ30FVP+VRBHnkyPf4N2ZhvocRvD2jIuO43CU8/sbkK4yek2c/W59H
	 iH7YAtiOApm1A==
Date: Sun, 28 Sep 2025 17:41:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org, multikernel@lists.linux.dev
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNlJMAHhFE-O3IX9@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
 <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
 <aNlErhpO1g17gdgM@kernel.org>
 <aNlH6-hFc6OmDF_e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNlH6-hFc6OmDF_e@kernel.org>
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

On Sun, Sep 28, 2025 at 05:36:32PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 28, 2025 at 05:22:43PM +0300, Jarkko Sakkinen wrote:
> > On Sat, Sep 27, 2025 at 01:43:23PM -0700, Cong Wang wrote:
> > > On Fri, Sep 26, 2025 at 2:50 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > > > > On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> > > > > <cl@gentwo.org> wrote:
> > > > > > AFAICT various contemporary Android deployments do the multiple kernel
> > > > > > approach in one way or another already for security purposes and for
> > > > > > specialized controllers. However, the multi kernel approaches are often
> > > > > > depending on specialized and dedicated hardware. It may be difficult to
> > > > > > support with a generic approach developed here.
> > > > >
> > > > > You are right, the multikernel concept is indeed pretty old, the BarrelFish
> > > > > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > > > > There are tons of papers in this area too.
> > > >
> > > > Jailhouse is quite nice actually. Perhaps you should pick that up
> > > > instead, and start refining and improving it? I'd be interested to test
> > > > refined jailhouse patches. It's also easy build test images having the
> > > > feature both with BuildRoot and Yocto.
> > > 
> > > Static partitioning is not a bad choice, except it is less flexible. We can't
> > > get dynamic resource allocation with just static partitioning, but we can
> > > easily get static partitioning with dynamic allocation, in fact, it should be
> > > the default case.
> > > 
> > > In my own opinion, the reason why containers today are more popular
> > > than VM's is not just performance, it is elasticity too. Static partitioning
> > > is essentially against elasticity.
> > 
> > How do you make a popularity comparison between VMs and containers, and
> > what does the word "popularity" means in the context? The whole world
> > runs basically runs with guest VMs (just go to check AWS, Azure, Oracle
> > Cloud and what not).
> > 
> > The problem in that argument is that there is no problem.
> 
> If I was working on such a feature I would probably package it for e.g,
> BuildRoot with BR2_EXTERNAL type of Git and create a user space that
> can run some test and benchmarks that actually highlight the benefits.
> 
> Then, I would trash the existing cover letter with something with clear
> problem statement and motivation instead of whitepaper alike claims.
> 
> We can argue to the eterenity with qualitative aspects of any feature
> but it is the quantitative proof that actually drives things forward.

I'd also carefully check as per modifying kexec that more complex use
cases are compatible such as IMA. I don't know if there is an issue with
secure boot but I'd make sure that there is no friction with it either.

There's also shared security related hardware resources such as TPM,
and in this context two instances end up thus sharing it for e.g.
measurements, and that type of cross-communication could have 
unpredictable consequences (would need to be checked).

BR, Jarkko

