Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B732DECE577
	for <kexec@archiver.kernel.org>; Mon,  9 Sep 2024 17:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5o44o/OQJWrCxL3bVDbeh+7+0wZM0+z9tjiG7bGH7w=; b=KjuAj+OUDtBuCF
	kr20VqwruQe1c4xHxW8zVnOf4MG/xZL2zMiOUccDZBZeaqgvpEE19YhrGTFMkGHg5PYouRY7LyVix
	nyz03jGoqPOsaaUaOoeR6CSYJFnxQ6OeW8NlKsKfDjEmp7GbtqRlr2YdfIBhy+w1NUIxiHUAIWTlT
	c0HZhrke+Q2TKnFpep56xrqi93LVedP7Q0V4Nxj3ODF1GyaMrGHoc4ml5IY2aFXbluMrulzsRmbWy
	Gs4GPADoSNxBNyomYC9oOGunRU5zmb2V7Op5g2bmjjxkCm89JzwjG0DB/meHO6qok5lqjxGrCZEWd
	bkt5myGtXC4nPP8V2HIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snhwL-00000002mGH-2tIM;
	Mon, 09 Sep 2024 17:12:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snhtR-00000002lhA-1slk
	for kexec@lists.infradead.org;
	Mon, 09 Sep 2024 17:09:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4DCA7A419FF;
	Mon,  9 Sep 2024 17:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184E7C4CEC5;
	Mon,  9 Sep 2024 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725901774;
	bh=/qV0P6xJzrMSUVsz7Z1CsIbU69skcya/dmYXKueZ/lU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=e4KtyCy2WiCK98F3bH7l2m9CUia2bzqaID9ICtWdqJTNuSR67C61vg2hEyDg/8ngo
	 T9IUVXNXNfBMZapo4Gj6LOtBeZB/LOm6Mfrs3aadbj2EEtt78Bbx4OuHDiNNtKcbAS
	 eaY667XHP8he708UdopD2mFkn28mW+HSwG14hdHCsfAvb1G1cKMItNykSJlzkVZG31
	 lcpqA1Ic0fh5k7bqZ/7Ax+XY59vSc0ik+E6v4Hgw4OD3GiaU/1FbCUCzcUkYWulm3X
	 U6SZznf4jupfh1R2tn/JEkD4dKU6wjTJYmPeYpb68HnL2eRU2gaCYuOR8pI7JW4BpH
	 713bWSZ6kVGAA==
Mime-Version: 1.0
Date: Mon, 09 Sep 2024 20:09:30 +0300
Message-Id: <D41X47S8U93M.IDL1ES4DB1Y9@kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Philipp Rudo" <prudo@redhat.com>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Pingfan Liu" <piliu@redhat.com>,
 "Jan Hendrik Farr" <kernel@jfarr.cc>, "Lennart Poettering"
 <mzxreary@0pointer.de>, "Eric Biederman" <ebiederm@xmission.com>, "Baoquan
 He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, <kexec@lists.infradead.org>,
 <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
 <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
 <D400W37FR01S.CLFIKA98YWX7@kernel.org>
 <20240909155555.257e13eb@rotkaeppchen>
In-Reply-To: <20240909155555.257e13eb@rotkaeppchen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_100937_712500_1C45FB97 
X-CRM114-Status: GOOD (  27.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon Sep 9, 2024 at 4:55 PM EEST, Philipp Rudo wrote:
> Hi Jarkko,
>
> On Sat, 07 Sep 2024 14:41:38 +0300
> "Jarkko Sakkinen" <jarkko@kernel.org> wrote:
>
> > On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> > > On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:  
> > > > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:  
> > > > > Let me throw an other wild idea in the ring. Instead of implementing
> > > > > a EFI runtime we could also include a eBPF version of the stub into the
> > > > > images. kexec could then extract the eBPF program and let it run just
> > > > > like any other eBPF program with all the pros (and cons) that come with
> > > > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > > > simply kexec any OS installer. On the other hand it would make it
> > > > > easier to port UKIs et al. to non-EFI systems. What do you think?  
> > > >
> > > > BPF would have some guarantees that are favorable such as programs
> > > > always end, even faulty ones. It always has implicit "ExitBootServices".
> > > >
> > > > Just a remark.  
> > >
> > > Some days ago I was thinking could some of the kernel functionality be
> > > eBPF at least like in formal theory because most of it is amortized,
> > > i.e. does a fixed chunk of work. Not going into that rabbit hole but
> > > I really like this idea and could be good experimentation ground for
> > > such innovation.  
> > 
> > E.g. let's imagine there would imaginary eBPF-TPM driver framework.
> > 
> > How I would go doing that would be to take the existing TPM driver
> > functionality and provide extra functions and resources available for
> > subsystem specific BPF environment, and have the orhestration code as
> > eBPF. I pretty much concluded that there is a chance that such could
> > work out.
> > 
> > Not something in my immediate table but it is still really interesting
> > idea, as instead of using language to separate "safe" and unsafe"
> > regions you would use "VM" environments to create the walls. In the
> > end of the day that would also great venture for Rust in kernel, i.e.
> > compile that BPF from Rust.
> > 
> > Sorry going of the hook the comment triggered me ;-)
>
> I'm glad you like the idea :-)
>
> Sounds like an interesting idea you are having there!

Yeah, if you go forward with this please CC to me any possible
follow-ups :-)

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
