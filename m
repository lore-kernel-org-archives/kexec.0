Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3335CC61DD6
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 08:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehHXm1EA15sH3PAgiH8YRUFi1V46PpThjqluKgx1aNk=; b=dDxv6eVbJ+a6vaDYw8Es757A2u
	kuL8dVMuoswNQR1ne1mj2P6+YArgK1rH2tmNbzZ7oduSCSTm9bKUt5gVTYBqADDUCBUww4/9LMumr
	Bha2Etx4nc+f7paZIYvSUbRtNIvkhpPhVOgNUqHRBsV8lgZaaCX0X4l+7rxrjNaRSewpqTm52crqZ
	AhKjbko/KuOZ3eGX1bovH82A0N6zWQDYoxAZMw00pAKBgCVGrth/1da8gPIbezOMzQMi6J0CisIIv
	evIxTA09o+nDIMeNG31OmVwLIY0m7sGfBLh9PXEnQArgWhr5Xv9d7/H3cgc7dT+bhVctLMJHrF+eZ
	Dp81WmQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fxN-0000000E0hR-3cis;
	Wed, 02 Sep 2026 08:04:29 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1fxM-0000000E0gn-1k8W
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 08:04:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7610F600C8;
	Wed,  2 Sep 2026 08:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7B31F00A3A;
	Wed,  2 Sep 2026 08:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336266;
	bh=ehHXm1EA15sH3PAgiH8YRUFi1V46PpThjqluKgx1aNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zh35Q2XzptRtprN1yUCr/I5u26AWu/2PrtLP4YmUeVqyM235/cQm1rm1vbz/05bew
	 mH4bgWDc1CHFP4x/ZNKM0f85ky7wQFWWGQOv8RqNF/kAWdn4tUAYaS7sxXXFdEfpfZ
	 NTKpvszME857KvGrWT2hRfouBnIavyuV6XMnIffii+1QfkVeEqRIT8ZvG5O7DCFNwC
	 FdH2nh/B+PyP2IPxCNkfLn7Fo5YShbaH/pihDjOpNx8BgunPhwSjYEbp4TNBnRDtP+
	 LIxuKR/eWl1eWJWCrnXfcgS9+pSvCXCyBU1swsIMoft9ST1i03+387h8JcfQMwfKNx
	 BUOwlt6FipT8A==
Date: Wed, 2 Sep 2026 11:04:20 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Baoquan He <baoquan.he@linux.dev>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <apfYhLD0sHt2odi8@kernel.org>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org>
 <ape5s5tdwV6WwPih@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ape5s5tdwV6WwPih@fedora>
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

Hi Baoquan,

On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> On 09/02/26 at 07:34am, Mike Rapoport wrote:
> > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> > > Hi kexec@ mailing list and maintainers,
> > > 
> > > I would like to enable Sashiko code reviews for patches sent to the
> > > kexec mailing list. I have found it useful for patches I have sent and
> > > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> > > enabled.
> > > 
> > > I sent a pull request to Sashiko to add kexec here:
> > > 
> > >   https://github.com/sashiko-dev/sashiko/pull/474
> > 
> > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
> > index e6e4fb57f..e9ad97708 100644
> > --- a/sashiko.dev/email_policy.toml
> > +++ b/sashiko.dev/email_policy.toml
> > @@ -175,6 +175,12 @@ reply_to_author = false
> >  cc_individuals = false
> >  cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
> >  
> > +[subsystems.kexec]
> > +lists = ["kexec@lists.infradead.org"]
> > +reply_to_author = true
> > +send_positive_review = true
> > 
> > Do we really want those?
> 
> Some components don't want to CC list, then other people are welcome to
> drop any comment during reviewing, while cc to maintainer and author
> looks good to me. Just an input, no objection to any move.

Sorry, I wasn't clear, I meant do we really want extra emails saying
sashiko is happy?

-- 
Sincerely yours,
Mike.

