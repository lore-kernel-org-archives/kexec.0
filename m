Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E668EB64C5
	for <kexec@archiver.kernel.org>; Sat,  7 Sep 2024 11:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wXVPPYxqR2XC3cJBoNMEVY3Ij51JmsSEluXjtx0xXaA=; b=r8ym1WgoXDgnXb
	uaFwX/qKfT4P+g5VCadAjwTK7XYT8Jf/7u0yP44Auh137cYch3+2fvrFXJO7xwOopUytte9ywBnRo
	y05MFMdiFnnt8lW09jBAtcQZ6FKRydKMMVvgIsbV1WLVMpQf/Xvt6P64MpRWvtM2v2RyM4K8fIKAk
	38hQSZukK7DnRN4ol4GtHX3VpUFm9z3tbnqPdo6TTiz+vOTE2GF8YZvWKwpxbrQajYiOsaFRMh6sk
	4vfeHRVmVmyEjMjK0+bvPve+DuJoOXbKlIZrlsiuac1frO/dpQp4Li2Wfh86Fg/7fF+N8qUdPuCdM
	l4B+nR9MZT3rYEfdt7Jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtfT-0000000EvWv-0UTr;
	Sat, 07 Sep 2024 11:31:51 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smtfP-0000000EvWV-3GQH
	for kexec@lists.infradead.org;
	Sat, 07 Sep 2024 11:31:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7A389A404F3;
	Sat,  7 Sep 2024 11:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02483C4CEC2;
	Sat,  7 Sep 2024 11:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708706;
	bh=efk1JOla+fXnaGRV8mAv/M39xrggt3sD41Iy3FnCrpk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Sv4JhscTcVihP0i6jCXpUm2sov6FUqr1PCfWWuw6lRkZpIw9wxglUmH/2GaXtKYZF
	 ydqPWeeIKO8qxVNmO8yS42UggxhewJnGioNkZtbe74GkSeqnylctbvllZPdVCQlJqH
	 8Ilqcr23mP8Zb0irRhg8SoMcwszBhLam2zileDI8ukpXuiK1CofNP58jAzfYQqSRCt
	 yMBOIlOw6NcvuLd6owhTqXgkTUiEMnoCBCCClpOin3ZJbpFP6LKwYRqgyjNrOzfiOB
	 YDAGy50fLKeeMFQYJ0+rKDEqwrZTTmMrLUeUxDpYXSMN5LaNZX2lT9R1Gxwfwjr1b+
	 YKTLFtbr4oQTQ==
Mime-Version: 1.0
Date: Sat, 07 Sep 2024 14:31:42 +0300
Message-Id: <D400OHF2ODNK.3JF7DJ87Q4BYI@kernel.org>
Cc: "Pingfan Liu" <piliu@redhat.com>, "Jan Hendrik Farr" <kernel@jfarr.cc>,
 "Lennart Poettering" <mzxreary@0pointer.de>, "Eric Biederman"
 <ebiederm@xmission.com>, "Baoquan He" <bhe@redhat.com>, "Dave Young"
 <dyoung@redhat.com>, "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon"
 <will@kernel.org>, "Catalin Marinas" <catalin.marinas@arm.com>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Philipp Rudo"
 <prudo@redhat.com>, "Ard Biesheuvel" <ardb@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240819145417.23367-1-piliu@redhat.com>
 <CAMj1kXGB3VF=NAQBADkdmodSVaZyf8h2n0FXwi5fXLUE2WgXag@mail.gmail.com>
 <20240906125438.1e54c5f6@rotkaeppchen>
 <D400L4YN4K7K.264IDL4O8374F@kernel.org>
In-Reply-To: <D400L4YN4K7K.264IDL4O8374F@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240907_043147_905349_A013CEDC 
X-CRM114-Status: GOOD (  11.65  )
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

On Sat Sep 7, 2024 at 2:27 PM EEST, Jarkko Sakkinen wrote:
> On Fri Sep 6, 2024 at 1:54 PM EEST, Philipp Rudo wrote:
> > Let me throw an other wild idea in the ring. Instead of implementing
> > a EFI runtime we could also include a eBPF version of the stub into the
> > images. kexec could then extract the eBPF program and let it run just
> > like any other eBPF program with all the pros (and cons) that come with
> > it. That won't be as generic as the EFI runtime, e.g. you couldn't
> > simply kexec any OS installer. On the other hand it would make it
> > easier to port UKIs et al. to non-EFI systems. What do you think?
>
> BPF would have some guarantees that are favorable such as programs
> always end, even faulty ones. It always has implicit "ExitBootServices".
>
> Just a remark.

Some days ago I was thinking could some of the kernel functionality be
eBPF at least like in formal theory because most of it is amortized,
i.e. does a fixed chunk of work. Not going into that rabbit hole but
I really like this idea and could be good experimentation ground for
such innovation.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
