Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387EEE71080
	for <kexec@archiver.kernel.org>; Sat,  7 Sep 2024 11:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:
	Subject:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7H1GBYP4BFT53PR8CiCc3+c83Z1fcqA/Qj9l2Dg1xKU=; b=M0VtpWXesyI06Q
	GnIgKbwbp4IxRqw4WuIekQ18idkTL5+70uKXHAhefdAGvLYyg7uQSkjEg47HxzSTdRC7BucSolLLl
	YHWPhA543NhjaY98T/KidGx3W1Ikm3TzucGIw0q4HdSv0XKZHyBFHLyX9edt85EoAsyW82ST/Hb6z
	YIW6krhjz6MuYLbQxeDozGSvzKMqWL0N7+wawkIs35AJsCiV/Ln8w6iMVrr52sUlaH2nw93Pj/4Q0
	kqOKNqC6hmqym/WrzGQ1qUwUEEGhTXmY779xSghdVJiw5omLOcDiZdwFbMT/XqyKilOrbpPJmL1oB
	FWZGojzXexHyy+0oPnpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtp4-0000000Ew7e-1EGv;
	Sat, 07 Sep 2024 11:41:46 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtp1-0000000Ew7B-1f5a
	for kexec@lists.infradead.org;
	Sat, 07 Sep 2024 11:41:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 47597A40201;
	Sat,  7 Sep 2024 11:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2846C4CEC2;
	Sat,  7 Sep 2024 11:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725709302;
	bh=5BvnWm80oXcTcRI+nnG3/BNTU5tdY3GPplxqRwUqxIg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=A7QcIwe1yd8HhMzhKhBXj1O2t0CGPqP8NCaXH0DWj1flZ9+8j3keUqNw6oL3gs2PC
	 vSzzvj5qYiDqCh9BuEinI1EA0K24ZFZJGv/PRMSp9cLM2onqQEE7IIGkRFCnyrcrQZ
	 iGQrra3hsQ7Xsv8HLGqoWKaRCqT4TRMUDwL6acrNZYxgutip/wO966Q2VRQBSZ/Sw2
	 UgeBxQz4MYXbo/+aXBN01MHuIRJ/GIVHI1AwtibEUk569WxMIoLkkWutBc7HE8KcTc
	 LWv0O2V+7P4q1mIJ/Q5cwevSjCTJ70k7B/we0GbmUixgQFfvJNBcue/rhPlvQLgjFW
	 utn3u1L67bZJw==
Mime-Version: 1.0
Date: Sat, 07 Sep 2024 14:41:38 +0300
Message-Id: <D400W37FR01S.CLFIKA98YWX7@kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Philipp Rudo"
 <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
 <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
In-Reply-To: <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240907_044143_524381_B61CCD4E 
X-CRM114-Status: GOOD (  17.83  )
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

On Sat Sep 7, 2024 at 2:31 PM EEST, Jarkko Sakkinen wrote:
> On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:
> > On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> > > Let me throw an other wild idea in the ring. Instead of implementing
> > > a EFI runtime we could also include a eBPF version of the stub into the
> > > images. kexec could then extract the eBPF program and let it run just
> > > like any other eBPF program with all the pros (and cons) that come with
> > > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > > simply kexec any OS installer. On the other hand it would make it
> > > easier to port UKIs et al. to non-EFI systems. What do you think?
> >
> > BPF would have some guarantees that are favorable such as programs
> > always end, even faulty ones. It always has implicit "ExitBootServices".
> >
> > Just a remark.
>
> Some days ago I was thinking could some of the kernel functionality be
> eBPF at least like in formal theory because most of it is amortized,
> i.e. does a fixed chunk of work. Not going into that rabbit hole but
> I really like this idea and could be good experimentation ground for
> such innovation.

E.g. let's imagine there would imaginary eBPF-TPM driver framework.

How I would go doing that would be to take the existing TPM driver
functionality and provide extra functions and resources available for
subsystem specific BPF environment, and have the orhestration code as
eBPF. I pretty much concluded that there is a chance that such could
work out.

Not something in my immediate table but it is still really interesting
idea, as instead of using language to separate "safe" and unsafe"
regions you would use "VM" environments to create the walls. In the
end of the day that would also great venture for Rust in kernel, i.e.
compile that BPF from Rust.

Sorry going of the hook the comment triggered me ;-)

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
