Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213FFE6F062
	for <kexec@archiver.kernel.org>; Fri,  1 Nov 2024 14:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:From:Subject:
	Cc:Message-Id:Date:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iBtRXAjaagJEJMZURVAxRAXd7SfQ0Nko6YstrI78DFE=; b=xER+tDhLa3X3H9
	+elmkVhtBEcQVKgx+uSn/C73I+tjtUNhgmNY3y/B7JigWqoVSG7CNV3sUL1WQzFvHrKFrguZCFkUE
	qRBtyeJ/sIFvOO+ef+aGHC94Sb4DfVAsuPzvtguVlq1HHP1RPE/BZsA70ptwcNt8lHoCiNh4DGs7P
	OfdfuJEdN+j6Y47Nx0maATbOHQX8ro2tuIxHXhbdl08Yi7jEgXUS+3tyxPFqSb8cIwBPbuL3NQQAg
	f0imQJwEwtyaEYeJJZEsMuLFHQZx0CTDRhkptyErx+cFzvNo/1XTr+lT7GAx4sz4Be8iFBfFHbCSn
	FXUe0iuahUKn59xzR7hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6t0L-00000007PZg-2qjL;
	Fri, 01 Nov 2024 14:52:01 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6t0G-00000007PW2-1ToI
	for kexec@lists.infradead.org;
	Fri, 01 Nov 2024 14:51:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 982E55C3D84;
	Fri,  1 Nov 2024 14:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7E1C4CECD;
	Fri,  1 Nov 2024 14:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730472715;
	bh=fBmciF+8K11L8eGrwOJGRPAF0tISY2XVqBxqg8Opu4U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=pLhfBdhQcDWy1mnIlIpI0fOGxQXBqk3WkdTqtzWxYa3Xu2vgoWazyk+oRO4J8V1pe
	 J12+zyrD3bpt/2XYSTT9A+rLfKfpZnQooZfbr3hXIKGNmAf/0/fZ5VzYidOSm8s1CB
	 qXRqoncGrKqJsKcpb8FbDwj9ybgRiGjtyguDdA5nxy7drXN+PGO2YFvp5itn7JLMXV
	 fbJNJrTcnGTDVhmMNfF4tuazJXCfSvg/G5WTcKQmKUR7fse/fqr9sdbG+0bKpjMcgv
	 ZOhOnn3yPdMWS3GtiT3Ts0h2JZJl95ikhDcsovwWxxpvK21esgAM8w8igj4MQDpyZm
	 AiQeBW27/ymrA==
Mime-Version: 1.0
Date: Fri, 01 Nov 2024 16:51:50 +0200
Message-Id: <D5AXDOQWNMIY.3RD4A8I5H6OOJ@kernel.org>
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
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ross Philipson"
 <ross.philipson@oracle.com>, <linux-kernel@vger.kernel.org>,
 <x86@kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>,
 <iommu@lists.linux-foundation.org>
X-Mailer: aerc 0.18.2
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <87wmhoulb9.ffs@tglx> <D5ACNMVX5LXB.1L0S9P2J3UDJH@kernel.org>
 <87ldy3vpjh.ffs@tglx>
In-Reply-To: <87ldy3vpjh.ffs@tglx>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_075156_446963_13333EE9 
X-CRM114-Status: GOOD (  23.17  )
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

Yes, I did that.

>
> Thanks,
>
>         tglx

BR, Jarkko

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
