Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C733CAC5BD
	for <kexec@archiver.kernel.org>; Sun, 28 Sep 2025 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40XsfutwklaTrh/ktA8dOMMeeLMpZtvmLMYd8gv8sBc=; b=bPvuwkqSvyuNxKwGTai8QEOFFW
	CVsvwtWFu8yJWMPaFcnQIV38NxbJGEntdJiEiIzwqNryAx/qQOodIjpiTwiAQv5Jyw+0BZ6X2xiew
	WQIl77ho3QgNScQgTqBX+TMGOLsOxBGdb+TdfoWVfcG68ha23L6rjRtSJob1HLWe4Uj16ShnNKf+c
	BtsiqFyyNr6O0rtWWrNGuq0TEVYT70lBe/th5i5zEPz+Bvg/IGqIN+dNwNgNdNN9PFvGcDDAPxudf
	HrmRxRBKmm29YFPsEJAJYujoKcIRMthl6Vi1/TVNOyhBLvlDb4KPtEyGifBXR/+Mq8l7TrKK962UD
	ytAQTFUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2sIX-0000000FzGu-3o28;
	Sun, 28 Sep 2025 14:22:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2sIW-0000000FzFv-0Tua
	for kexec@lists.infradead.org;
	Sun, 28 Sep 2025 14:22:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4319644260;
	Sun, 28 Sep 2025 14:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA39C4CEF0;
	Sun, 28 Sep 2025 14:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759069363;
	bh=Wg1xrNCbGg8db7MqipyCxrrsmMoVbFCLhcRL36NHECw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIaEscUT6E8LJ+NgIrEGjJB2yfmv0DOXQQ3iMgMZewcagvseJj47Zq7TbBcssaQgr
	 rGIH8EVofkWfFbNGyD9UNbpBzi0pz53pYgVouaJYpMKlmDvy9TBwMU+olwn269wf9J
	 T41s4Q3jouYy2lr5tDBEQeiT/eoFSGDOpL0XPUbw3HPWZzVFw+J1z4pE4VH/K+coWe
	 +c/sMEtUxdRwap2G1mPwgXnfFvVaq8LZWqUcrV5n0ZbIzim4JDZucgNI0bkZKhnNWH
	 GRpY/iuBWdp1Ds9iYdYd19AHQgmgAmb9vfi62Kfzhqnu81lPLCvD1oo91CKyc1gyRj
	 N9WRiNJ694s/w==
Date: Sun, 28 Sep 2025 17:22:38 +0300
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
Message-ID: <aNlErhpO1g17gdgM@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
 <aNZh3uDdORZ5mfSD@kernel.org>
 <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpWXFQwtayT7Zv7iJd7zQZ=rX_P1ZK2P11-6ohRhLpg7Xw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_072244_179225_5BB8592F 
X-CRM114-Status: GOOD (  22.04  )
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

On Sat, Sep 27, 2025 at 01:43:23PM -0700, Cong Wang wrote:
> On Fri, Sep 26, 2025 at 2:50 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> > > On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> > > <cl@gentwo.org> wrote:
> > > > AFAICT various contemporary Android deployments do the multiple kernel
> > > > approach in one way or another already for security purposes and for
> > > > specialized controllers. However, the multi kernel approaches are often
> > > > depending on specialized and dedicated hardware. It may be difficult to
> > > > support with a generic approach developed here.
> > >
> > > You are right, the multikernel concept is indeed pretty old, the BarrelFish
> > > OS was invented in around 2009. Jailhouse was released 12 years ago.
> > > There are tons of papers in this area too.
> >
> > Jailhouse is quite nice actually. Perhaps you should pick that up
> > instead, and start refining and improving it? I'd be interested to test
> > refined jailhouse patches. It's also easy build test images having the
> > feature both with BuildRoot and Yocto.
> 
> Static partitioning is not a bad choice, except it is less flexible. We can't
> get dynamic resource allocation with just static partitioning, but we can
> easily get static partitioning with dynamic allocation, in fact, it should be
> the default case.
> 
> In my own opinion, the reason why containers today are more popular
> than VM's is not just performance, it is elasticity too. Static partitioning
> is essentially against elasticity.

How do you make a popularity comparison between VMs and containers, and
what does the word "popularity" means in the context? The whole world
runs basically runs with guest VMs (just go to check AWS, Azure, Oracle
Cloud and what not).

The problem in that argument is that there is no problem.

BR, Jarkko

