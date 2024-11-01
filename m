Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AECE6F061
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4K1AQs+lsnR+0/0zUlDU3nB/b33Tr/XJY1zZRzLlE8A=; b=Uwl94Cs5lMu1FH
	EiMnznh7feAR3WXas03WI3giv/NJ4/Tjrq1eD0rFIoBBC5JFTMlycExeP6CtbeH/z3150nGdSWQAz
	JyLQtFeROA3zwahVFkOJqJMvVubZTIlxNpWaz4fKiTVWA/gDyPJmJ1f81EgpcnnXC89LYP/uPKjv+
	WkRtiMFpWzlfpVdSNlT3cxCGQFlB9u2bqmpCnMYkJgorg1kw5vKmqvxf5SftDRtDyouWoEX/WkGHw
	XH51/UgUsmmj0w5InPoHesMt4XwLLA9w/4ETfa8shwpa/xpoaLuoEx8pAMj6qThMu6lBGMtxGc256
	+PtAOdm0bJ0AQajqB2jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sWY-00000007JDb-1i1b;
	Fri, 01 Nov 2024 14:21:14 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s8X-00000007FgA-2Noe
	for kexec@bombadil.infradead.org;
	Fri, 01 Nov 2024 13:56:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:References:Subject:Cc:To:
	From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:Mime-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=j39P6Y3cWs4+SruOn05MpL/vv3o6bChQ+aOW/lHMlms=; b=mG8UZzTWrk1wq+rxYGAEat9Lxu
	rRq92CjFd0+jopNQgLW+BMvBr/gFYvGqKVyQu8K+jhC16vF2iGQ8NuLSf5sg/06pdBY8aS1RAFj2J
	H7rLQhwKDvCiYkzT9tUnVtaplaQTjM5KPIJobfqOMpDxnGlBjyHQUgHLFLau1J/PmCjERIZ4kHoa4
	UHh4C6Tvm20gOggZmowg4IvaUZ7WgQJreqejLT+3Zj8lZCuvzntdmOyq9htyMfzRvp3sha2PpBl8S
	Ef0x9LV279hSGFZRAaG64WABXNrdfC/7UJ/lDcCdlPLupeRLeAnsI7aowVX1IqMSo4Y4zuZII5jc+
	FaDosSOg==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s8S-0000000AilH-3Prg
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 13:56:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 37AFE5CC351;
	Fri,  1 Nov 2024 09:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3E0C4CECD;
	Fri,  1 Nov 2024 09:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730452694;
	bh=VwuvobxN/JIIGvwQbzSNttNtS7UwYf45TGMjGF3SOJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d5qz6zlAZ/yf0UDelwHeivmWA7K7ngw7ePGaEXVLDbXRY77Sl87i9xABFv/CsbuR9
	 YQhJ9a2XQQEHXI+3qcl61MWwwXk3L3kIdwhGCjhl7n+fSXXaZ7GfTUDdNpXxQF/9TC
	 wuvJkC7JPSrp9kZzDxhd9hT8DRVdjqs9Ifu9znfFyMHnswqPqhtNfQAxnU6qP+BtT1
	 1vlWWJdq11vYvvl+IhSSra8zkwWYV91Dx9pZ1/FvUvDK5sOp3dvnPWKNpqVUteIiaB
	 DQ8E3XX+wB5GLYMdlvYmd4wFFbH/jW6QmaKUHoA3C8/RSFWU9xgKuZnkgoNU9sCYdZ
	 QvFTh6pue4bQw==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 11:18:10 +0200
Message-Id: <D5AQA7LCE0KW.1QHQJLG2D2WQK@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Ard Biesheuvel" <ardb@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>, <dpsmith@apertussolutions.com>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <dave.hansen@linux.intel.com>, <mjg59@srcf.ucam.org>,
 <James.Bottomley@hansenpartnership.com>, <peterhuewe@gmx.de>,
 <jgg@ziepe.ca>, <luto@amacapital.net>, <nivedita@alum.mit.edu>,
 <herbert@gondor.apana.org.au>, <davem@davemloft.net>, <corbet@lwn.net>,
 <ebiederm@xmission.com>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx> <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>
 <D5AF9K79H8WO.PVW93P31GHMH@kernel.org>
 <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHFDMKEH46MG3731FS043XyxHchoTJtDOst6kvfMezUuQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_135621_388792_ECB9BB25 
X-CRM114-Status: GOOD (  41.24  )
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

On Fri Nov 1, 2024 at 10:50 AM EET, Ard Biesheuvel wrote:
> On Fri, 1 Nov 2024 at 01:40, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Fri Nov 1, 2024 at 2:33 AM EET, Jarkko Sakkinen wrote:
> > > On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> > > > On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > > > > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> > > > >> So this looks pretty reasonable to me by now and I'm inclined to take it
> > > > >> through the tip x86 tree, but that needs reviewed/acked-by's from the
> > > > >> crypto and TPM folks. EFI has been reviewed already.
> > > > >>
> > > > >> Can we make progress on this please?
> > > > >
> > > > > So TPM patches do have bunch of glitches:
> > > > >
> > > > > - 15/20: I don't get this. There is nothing to report unless tree
> > > > >   is falling. The reported-by tag literally meaningless. Maybe this
> > > > >   is something that makes sense with this feature. Explain from that
> > > > >   angle.
> > > > > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > > > > - 17/20: the commit message could do a better job explaining how the
> > > > >   locality can vary. I'm not sure how this will be used by rest of
> > > > >   the patch set.
> > > > > - 18/20: I'm not confident we want to give privilege to set locality
> > > > >   to the user space. The commit message neither makes a case of this.
> > > > >   Has this been tested to together with bus encryption (just checking)?
> > > >
> > > > Can you please explicitely voice your detailed technical concerns in
> > > > replies to the actual patches?
> > >
> > > - 15/20 looks like a rigged patch. I don't really know why it is done
> > >   so it is hard to either suggest how "resolve it".
> > > - 16/20 probably makes sense but if it is a bug fix or part of it is,
> > >   the bug fix should have relevant fixes etc tags so that it can be
> > >   picked up to stable kernels.
> > > - 17-18/20: I'd speak about this as the "one whole" i.e. here the
> > >   privilege to be able change locality during run-time is really
> > >   concerning. Could the locality be figured out for the kernel
> > >   command-line instead? The sysfs attribute can exist as read-only.
> > >
> > > So yeah, the way I see it 15-16 are the more trivial issue to sort
> > > out (probably) but with 17-18 we have an actual architectural concern
> > > for kernel overall.
> >
> > Further:
> >
> > 15/20: I can accept this without reported-by tag (or changed as
> > suggested-by). It does not harm.
> > 16/20: I'll re-review this with time. I'll try to get this done
> > latest next week.
> >
> > So let's put focus only on 17 and 18. Can this problem be sorted out
> > by kernel command-line parameter? In the case of locality we want to
> > keep regular "chain of trust" i.e. boot-loader makes the decision,
> > *even* in the case of DRTM. I would call this almost as constraint
> > that would be wise to set.
> >
>
> Please don't add a kernel command line parameter for this - the code
> running in the decompressor will be the one setting it and there are
> better ways to pass information between these components (and the
> slaunch stack is already doing that in any case)

Not sure if I follow this (I don't know what "decompressor" is).

> Also, let's have this discussion in the appropriate place, i.e., on
> the thread for each respective patch.

Sure, I just did not have a lot of time to download the patch.

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
