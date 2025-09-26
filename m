Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3BFCAC5B9
	for <kexec@archiver.kernel.org>; Fri, 26 Sep 2025 09:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ml/K68tt8EimGRBokXX7FG0p8xqXVIN4C2XFPLCk+k4=; b=fcMAi3sR7JkBh/VW1VZiMdOXqX
	qU6nj+y9HR4Nsslr+q8Tx1ztSXcOOwO3AYblGKfFR1rZjnMpsVQXLlcOOgwFUdVdXs3++g4bJYmiR
	kKeUhVdkl1bd9Hkfk7233v0+qWHfBNXoqH9dN4AmZ5LKxrOnZaXFAI2QouXDWJhElagbtbKqoZ7W8
	o7hHHFJxy1fLJ8ss1yMILc+h+0SrptFIGJ98hs1FCCJHfCa4pM2DXD9qwtP0AqphSP8LjH2RE6h1w
	qIe+JDk5SnuL9VZ82G1Znjd8D4g8Imwwtw0Y/clRjcW3MgUueXyn71yMp8eIVk5gWDErGWPfp0c5n
	y2nuNvqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v255v-000000008Eo-3HAF;
	Fri, 26 Sep 2025 09:50:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v255u-000000008Eg-3Ibm
	for kexec@lists.infradead.org;
	Fri, 26 Sep 2025 09:50:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3834261CE3;
	Fri, 26 Sep 2025 09:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6347BC4CEF4;
	Fri, 26 Sep 2025 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758880225;
	bh=K1LIWmxcJgPXbCty1TvudCcCG/Db51jwCowiiS1WLyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cC6TftOzZulw88Zy/RIdnz49WQvsFfuCTGHjLnGltVCATuNNwJv7JONJztiYMWfYa
	 62whYl/7yz6SRU/zVD91MX5TkSjEv2rdXF6C3UwtczFjrduOaycKKiG3DOKfln+gAq
	 vG1tQjTt8tNeqXiQXkrf1W4piu+vS2z+MnU9t6PAyd0jWzSuY6J9VD4Zl7HZq6eK8K
	 0yjAsjGGNOw4wbF9Lw/I8soG16mFDSgu5Ii1p2iDLwAcIm86pBCEuyiYcjqTDuGNm6
	 o+5MxBesF5tOS590obpAv/TgxXJDuIyyoYUvc2Ev77DN4qQ+4qrZVJbcCcAJBDMC0b
	 moOtbuI0S1uuA==
Date: Fri, 26 Sep 2025 12:50:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>,
	linux-kernel@vger.kernel.org, pasha.tatashin@soleen.com,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>, kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture
 support
Message-ID: <aNZh3uDdORZ5mfSD@kernel.org>
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
 <78127855-104f-46e2-e5d2-52c622243b08@gentwo.org>
 <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM_iQpU2QucTR7+6TwE9yKb+QZg5u_=r9O_tMfsn7Ss7kJbd9A@mail.gmail.com>
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

On Wed, Sep 24, 2025 at 11:39:44AM -0700, Cong Wang wrote:
> On Wed, Sep 24, 2025 at 10:51 AM Christoph Lameter (Ampere)
> <cl@gentwo.org> wrote:
> > AFAICT various contemporary Android deployments do the multiple kernel
> > approach in one way or another already for security purposes and for
> > specialized controllers. However, the multi kernel approaches are often
> > depending on specialized and dedicated hardware. It may be difficult to
> > support with a generic approach developed here.
> 
> You are right, the multikernel concept is indeed pretty old, the BarrelFish
> OS was invented in around 2009. Jailhouse was released 12 years ago.
> There are tons of papers in this area too.

Jailhouse is quite nice actually. Perhaps you should pick that up
instead, and start refining and improving it? I'd be interested to test
refined jailhouse patches. It's also easy build test images having the
feature both with BuildRoot and Yocto.

It would take me like half'ish day to create build target for it.

> Dual-kernel systems, whether using virtualization or firmware, are indeed
> common at least for automotives today. This is a solid justification of its
> usefulness and real-world practice.

OK so neither virtualization nor firmware are well defined here.
Firmware e.g. can mean anything fro pre-bootloader to full operating
system depending on context or who you ask.

It's also pretty hard to project why VMs are bad for cars, and
despite lacking experience with building operating systems for
cars, I'd like to believe that the hardware enforcement that VT-x
and VT-d type of technologies bring is actually great for cars.

It's like every other infosec con where someone is hacking a car,
and I seen even people who've participated to hackatons by car
manufacturers. That industry is improving gradually and the
challenge would be to create hard evidence that this brings
better isolation than VM based solutions..


> 
> As you stated, it should not depend on any firmware or specialized
> hardware, hence I am making this effort here. Let's join the effort, instead
> of inventing things in isolation. This is why I not only open the source code
> but also open the roadmap and invite the whole communication for
> collaboration.

I'm not sure if specialized hardware means but hardware features
used by e.g., kvm are not in the category of "specialized", unless
you referring specifically to SNP and TDX?

> 
> Regards,
> Cong Wang

BR, Jarkko

