Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3CFE67490
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:From:Subject:Cc:
	To:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HlMcf/jflvD5NA2WsrhxdhtxghF4/Va7OQujJtLArO8=; b=FIq5cXF8KPCp5Q
	KAOacqna8raOhCTVeJblIqBT8UGUL85Mgy7m77PUYx7JSA7j+Rks/XYq1ACi3WcM58TFaox9872sE
	Hq182ASIZ/q92U8EKwzwqIo8aQHuyhD+z6iJPShAMfDISsEUE5xaSaUi9aKWsXajmAXcXzqHigbIC
	GSbqptXcccS3lAFvZCzoZh59f8ApZvMmR713dfiJw7JdN4Sa+OVqUsATDWrG4g8FyGJWMnyCtd7qC
	YrggIac3wa/xnNF9GI4WiExvuG0l/4YyhRzpAkU0iBqE5JsLC8+XvTJUYJuioh/NjD0AlVkZ8xfx8
	Wk9WgfewKthFB9wJzn4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6fgR-00000005Juo-0kia;
	Fri, 01 Nov 2024 00:38:35 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6fbd-00000005JDb-2pvi
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 00:33:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 2A391A44CB8;
	Fri,  1 Nov 2024 00:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC80C4CED4;
	Fri,  1 Nov 2024 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730421215;
	bh=JOqTpgy5T4UYFfRSxeC8Hsvp7K+oY1FR38Cm1XCvAJw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=tDVdeGoShHzHJ4KUpuULtbcdXFySN9uy/gfThoWBusIWDUa0IeYatInt0hkyM5Tzq
	 LouYEGFgfBSs7YLVVjbNDXK5ZYwAjZXxEA1h5tKRMPrn43fIt5SZuDMqJRJvQlMvp7
	 A9aR3ACyH58sUg0szTxRf1mgBWMn0RPcGMBsD/hVZpa+SuWf0VXva9aEOSMxSN21FY
	 AbU4us6aTzDvpv+c22zTeTKelXaCjrMDHkfeSY5qLViLUCs4M24IsERwqFWkCSlmNs
	 0KNTrffIhVhY5TaEgY0gKtHrAPqhzmq2vVKG6HPxD6QQeuBmQ8M+FcEozYJMGq+VEy
	 bUhV66CbYt8rQ==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 02:33:30 +0200
Message-Id: <D5AF4HY1I6AA.27WRBDDGLYH39@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
Cc: <dpsmith@apertussolutions.com>, <mingo@redhat.com>, <bp@alien8.de>,
 <hpa@zytor.com>, <dave.hansen@linux.intel.com>, <ardb@kernel.org>,
 <mjg59@srcf.ucam.org>, <James.Bottomley@hansenpartnership.com>,
 <peterhuewe@gmx.de>, <jgg@ziepe.ca>, <luto@amacapital.net>,
 <nivedita@alum.mit.edu>, <herbert@gondor.apana.org.au>,
 <davem@davemloft.net>, <corbet@lwn.net>, <ebiederm@xmission.com>,
 <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>,
 <kanth.ghatraju@oracle.com>, <andrew.cooper3@citrix.com>,
 <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx>
In-Reply-To: <87ldy3vpjh.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_173337_864174_66ECCB86 
X-CRM114-Status: GOOD (  28.36  )
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

On Fri Nov 1, 2024 at 1:08 AM EET, Thomas Gleixner wrote:
> On Fri, Nov 01 2024 at 00:37, Jarkko Sakkinen wrote:
> > On Thu Oct 31, 2024 at 9:25 PM EET, Thomas Gleixner wrote:
> >> So this looks pretty reasonable to me by now and I'm inclined to take it
> >> through the tip x86 tree, but that needs reviewed/acked-by's from the
> >> crypto and TPM folks. EFI has been reviewed already.
> >>
> >> Can we make progress on this please?
> >
> > So TPM patches do have bunch of glitches:
> >
> > - 15/20: I don't get this. There is nothing to report unless tree
> >   is falling. The reported-by tag literally meaningless. Maybe this
> >   is something that makes sense with this feature. Explain from that
> >   angle.
> > - 16/20: Is this actually a bug fix? If it is should be before 15/20.
> > - 17/20: the commit message could do a better job explaining how the
> >   locality can vary. I'm not sure how this will be used by rest of
> >   the patch set.
> > - 18/20: I'm not confident we want to give privilege to set locality
> >   to the user space. The commit message neither makes a case of this.
> >   Has this been tested to together with bus encryption (just checking)?
>
> Can you please explicitely voice your detailed technical concerns in
> replies to the actual patches?

- 15/20 looks like a rigged patch. I don't really know why it is done
  so it is hard to either suggest how "resolve it".
- 16/20 probably makes sense but if it is a bug fix or part of it is,
  the bug fix should have relevant fixes etc tags so that it can be
  picked up to stable kernels.
- 17-18/20: I'd speak about this as the "one whole" i.e. here the
  privilege to be able change locality during run-time is really
  concerning. Could the locality be figured out for the kernel
  command-line instead? The sysfs attribute can exist as read-only.

So yeah, the way I see it 15-16 are the more trivial issue to sort
out (probably) but with 17-18 we have an actual architectural concern
for kernel overall.

> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
