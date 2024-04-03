Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 749E2CD1288
	for <kexec@archiver.kernel.org>; Wed,  3 Apr 2024 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PRAohw4hEapZmG8UZUeS9K94A0PJ/evistjbtL7Se6w=; b=UFZZbkCC3xATdK
	gzQMyZ655uNOuiCe2GKh3j7ixlD2P7CCht2iTOSxNrZ2NmIMs3M8BKcZ5rWqWZ/Xq8EXK+IOt8HHV
	UiG7U6VJ+619zp26mh0vyd91KkViqxQtKJd/wGVc3G0EKLBTMd5G/+kG2ZqZiguN2kh+EjJztiPcM
	eAB216T5cqD5RdktjIG/rUj7Gik/BfxnOODfCSyGk9Xmpx07nWCkQt5VdDexsmnczYBjWXeGq3KzU
	zjwUka20QPSPMWiqQ+bgM0inHqFfklJ4aS9VLsZs/EK2iyRY9MiZwYxCfNwzpDZMpxaZQ3juO6vEr
	EIK7q7zD+HQKgihrirjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsATG-00000000g3w-0ty1;
	Wed, 03 Apr 2024 23:56:46 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsATA-00000000fzf-2que
	for kexec@lists.infradead.org;
	Wed, 03 Apr 2024 23:56:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DB29E6150B;
	Wed,  3 Apr 2024 23:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3407C43394;
	Wed,  3 Apr 2024 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712188599;
	bh=m8IbDM148A6sz7bWT/CQKnE9AfgQW6cHCi6VsGmG9X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t0uM6RPlGuNQ2pvlqrK5sJYW3QIWUD/Ch+blAKlhtyKQCglZyMACwH2YghM8qdYTx
	 eBPDOQhbls3SLnnU19e+ycW267im0qo3s7DmQrGBThEtcKMITPijTtYT1j6u19QNnf
	 amG33e6JWYAg2/i6QR7pitO2x0BsQI9uWn5IiKeG944GH9LkfL4L21VdoeIIgHiyBQ
	 gpoc8t9p9dMFVRKVRDB1eJL2fMFGmILWoJ6R8tS5FM1x1fnZGWHEyoc/jXW7wXeoSu
	 PNyqc9GIixNFegy1D6HYuzxTwLjegR0bNGA4RUOTulmhCHilEkh1v3G/QSiOKtNKIT
	 UfoXU+7DHB84Q==
Date: Wed, 3 Apr 2024 18:56:35 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ross Philipson <ross.philipson@oracle.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	dpsmith@apertussolutions.com, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	"luto@amacapital.net" <luto@amacapital.net>,
	Arvind Sankar <nivedita@alum.mit.edu>,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v8 06/15] x86: Add early SHA support for Secure Launch
 early measurements
Message-ID: <20240403235635.GA24248@quark.localdomain>
References: <CAMj1kXEmMBY_jc0uM5UgZbuZ3-C7NPKzg5AScaunyu9XzLgzZA@mail.gmail.com>
 <98ad92bb-ef17-4c15-88ba-252db2a2e738@citrix.com>
 <CAMj1kXFTu+bV2kQhAyu15hrYai20NcBLb4Zu8XG2Y-XjL0f+rw@mail.gmail.com>
 <1a8e69a7-89eb-4d36-94d6-0da662d8b72f@citrix.com>
 <CAMj1kXEvmGy9RJo4s8tECsFj2dufZ8jBPoJOEtkcGUoj+x2qsw@mail.gmail.com>
 <431a0b3a-47e5-4e61-a7fc-31cdf56f4e4c@citrix.com>
 <20240223175449.GA1112@sol.localdomain>
 <e641e2f1-16cf-4717-8a1f-8afac2644efe@citrix.com>
 <20240223183004.GE1112@sol.localdomain>
 <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <10db421c-77da-4a1c-a25e-2374a7a2ef79@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_165640_889261_35B5EA47 
X-CRM114-Status: GOOD (  36.94  )
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

On Wed, Apr 03, 2024 at 09:32:02AM -0700, Andy Lutomirski wrote:
> On Fri, Feb 23, 2024, at 10:30 AM, Eric Biggers wrote:
> > On Fri, Feb 23, 2024 at 06:20:27PM +0000, Andrew Cooper wrote:
> >> On 23/02/2024 5:54 pm, Eric Biggers wrote:
> >> > On Fri, Feb 23, 2024 at 04:42:11PM +0000, Andrew Cooper wrote:
> >> >> Yes, and I agree.=A0 We're not looking to try and force this in with
> >> >> underhand tactics.
> >> >>
> >> >> But a blind "nack to any SHA-1" is similarly damaging in the opposi=
te
> >> >> direction.
> >> >>
> >> > Well, reviewers have said they'd prefer that SHA-1 not be included a=
nd given
> >> > some thoughtful reasons for that.  But also they've given suggestion=
s on how to
> >> > make the SHA-1 support more palatable, such as splitting it into a s=
eparate
> >> > patch and giving it a proper justification.
> >> >
> >> > All suggestions have been ignored.
> >> =

> >> The public record demonstrates otherwise.
> >> =

> >> But are you saying that you'd be happy if the commit message read
> >> something more like:
> >> =

> >> ---8<---
> >> For better or worse, Secure Launch needs SHA-1 and SHA-256.
> >> =

> >> The choice of hashes used lie with the platform firmware, not with
> >> software, and is often outside of the users control.
> >> =

> >> Even if we'd prefer to use SHA-256-only, if firmware elected to start =
us
> >> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
> >> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in ord=
er
> >> to safely use SHA-256 for everything else.
> >> ---
> >
> > Please take some time to read through the comments that reviewers have =
left on
> > previous versions of the patchset.
> =

> So I went and read through the old comments, and I'm lost.  In brief summ=
ary:
> =

> If the hardware+firmware only supports SHA-1, then some reviewers would p=
refer
> Linux not to support DRTM.  I personally think this is a bit silly, but i=
t's
> not entirely unreasonable.  Maybe it should be a config option?
> =

> If the hardware+firmware does support SHA-256, then it sounds (to me, rea=
ding
> this -- I haven't dug into the right spec pages) that, for optimal securi=
ty,
> something still needs to effectively turn SHA-1 *off* at runtime by cappi=
ng
> the event log properly.  And that requires computing a SHA-1 hash.  And, =
to be
> clear, (a) this is only on systems that already support SHA-256 and that =
we
> should support and (b) *not* doing so leaves us potentially more vulnerab=
le to
> SHA-1 attacks than doing so.  And no SHA-256-supporting tooling will actu=
ally
> be compromised by a SHA-1 compromise if we cap the event log.
> =

> So is there a way forward?  Just saying "read through the comments" seems=
 like
> a dead end.
> =


It seems there may be a justification for some form of SHA-1 support in this
feature.  As I've said, the problem is that it's not explained in the patch=
set
itself.  Rather, it just talks about "SHA" and pretends like SHA-1 and SHA-=
2 are
basically the same.  In fact, SHA-1 differs drastically from SHA-2 in terms=
 of
security.  SHA-1 support should be added in a separate patch, with a clearly
explained rationale *in the patch itself* for the SHA-1 support *specifical=
ly*.

- Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
