Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E91C54798
	for <kexec@archiver.kernel.org>; Fri, 23 Feb 2024 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GAyN/xjBa8sZoJwms2Vkuk2C1UG8Dcju9qancAAfnus=; b=3HD5yDgJLIiqm3
	u7M4RVZx59M4CCor03iv+Xvukzd0NlS0wZuNjvdSoZhyWarBRoSmbzOL71yeUBnIyK1KFDCXN0nXg
	CzG0MHtewA2YkFe/RjXK6O+bHSr+ThiguiYCj0CnNdEfSY+mB0IuziICNWQO842oD0Ip9d4Kan3QP
	ICYP+h4gieBrpfZKboZHyRv51+6QyMfO6Gu7F7cf/hFz1EDWHVA/dA1BayJLIZEaoRFJORmB/Ezy6
	QWoS4ZvDtMZYdT6//D5Fq0JNdoXywGNk2OQVf7sn3c0fRmz2DuYdOVsw+0WK08SxEAzq4w7x1SlE/
	o5R5edKBkr2jCGxld1dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdaJG-0000000ArGx-39Lo;
	Fri, 23 Feb 2024 18:30:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rdaJD-0000000ArGK-3nds
	for kexec@lists.infradead.org;
	Fri, 23 Feb 2024 18:30:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1277C61575;
	Fri, 23 Feb 2024 18:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFCDC433F1;
	Fri, 23 Feb 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708713006;
	bh=h4pO3Tgr1PTkYatoEkKrET/MjLlwGSker91U7kqaO1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbO0L3o5nidphoFvFp61Tw3dg+tZlos4tvnVsxt3LBum2bv9S4cTfrRbYtCdgcpk8
	 2K3+Bqs4WAKaIaUXuBtYuzhcR3M9qhvTbIwBIFPCyZaItSaQjQrr8Jd56PmZEqrQZb
	 acEwsL077wp13g1v9RpB2z0nSaHiOLwmaOr9HiFeBHfwJxnAsJU8yhUiKDdA+zvn9n
	 RHBDNQixtUS8LsYmrCB85aI7TzZ//EdZ8jMmeSMNGs5bSkm8fzONPNSAGQWnNkLgVx
	 h4oof10cHJMT7hRlxo70kTubFphVQMWuM+RE2weKDWruUnrzxYplMjxaZS63eqxuam
	 ++gfEOXUOc9gQ==
Date: Fri, 23 Feb 2024 10:30:04 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, kanth.ghatraju@oracle.com,
	trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20240223183004.GE1112@sol.localdomain>
References: <20240214221847.2066632-1-ross.philipson@oracle.com>
 <20240214221847.2066632-7-ross.philipson@oracle.com>
 <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
 <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240223_103008_064346_939D229D 
X-CRM114-Status: GOOD (  20.60  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, Feb 23, 2024 at 06:20:27PM +0000, Andrew Cooper wrote:
> On 23/02/2024 5:54 pm, Eric Biggers wrote:
> > On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> >> Yes, and I agree.=A0 We're not looking to try and force this in with
> >> underhand tactics.
> >>
> >> But a blind "nack to any SHA-1" is similarly damaging in the opposite
> >> direction.
> >>
> > Well, reviewers have said they'd prefer that SHA-1 not be included and =
given
> > some thoughtful reasons for that.  But also they've given suggestions o=
n how to
> > make the SHA-1 support more palatable, such as splitting it into a sepa=
rate
> > patch and giving it a proper justification.
> >
> > All suggestions have been ignored.
> =

> The public record demonstrates otherwise.
> =

> But are you saying that you'd be happy if the commit message read
> something more like:
> =

> ---8<---
> For better or worse, Secure Launch needs SHA-1 and SHA-256.
> =

> The choice of hashes used lie with the platform firmware, not with
> software, and is often outside of the users control.
> =

> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
> to safely use SHA-256 for everything else.
> ---

Please take some time to read through the comments that reviewers have left=
 on
previous versions of the patchset.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
