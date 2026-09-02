Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1A8C624D0
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WNiNVksiMebQXNB6BfTPDIdvDV9+sXKv5uJMV01GPUU=; b=APUMfc3OKtNB/mqTAyFgtzj6Un
	6KjS7YzoVWiwhjSl49hlQ4UnV1X2JNvgQ4pS1JRHz60H48JeWsb16uQrHeWcic8yB5rD5HF5HFIDs
	lsukOdC1nL6Cdb9Tbo4ZIhw/LxO/gOykjJNWVGa2j9zb3AIm/v34FKMVqP3+rTyfytMvicUTKwyOn
	yej1J1O5vFDTeKJoOaxH3JI+Gq1cejb7QHYUn5O8ejnfrIJhSY0hRNwTnvx86NQVmhhd7PE00ilo3
	uANxpnmYvgt3qGNXDefkaX3qZIahfUW8SVzOrKGaWRHKbf0dutYXHtbA62NtGPawUocSAr2zbHHfM
	96No7V4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1gI5-0000000E5aS-1MMK;
	Wed, 02 Sep 2026 08:25:53 +0000
Received: from out-87.mta0.migadu.com ([2001:41d0:1004:224b::57] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1gI1-0000000E5Yx-1up6
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 08:25:51 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=c5AnjOsth7z0l9wwijdIFCGPFva5jsXgTmFyBVaitUA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788337547; v=1; x=1788942347;
 b=Q6mHmmnBSAN7mPCxfe2mV2cm4RVI2dbq/qxSls/J9DmRriG+UfBEeSxyW5DUq1xV9FtYQla0
 xPpmkGa2oAs/QYRxo70XOhIdageW7cVQWHrEQJGRRuhCX9RkhcZDPQ1pt26+f7ncgR4jlNT2Bll
 y6EPwTcvJCoy+yFQTwKTjwIo=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta12.migadu.com with ESMTPS id 5b11c574515e99db;
	Wed, 02 Sep 2026 08:25:47 +0000
X-Mizu-Trace-ID: 5b11c574515e99db
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 16:25:42 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Mike Rapoport <rppt@kernel.org>
Cc: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <apfdhh0YYwo4am7A@fedora>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org>
 <ape5s5tdwV6WwPih@fedora>
 <apfYhLD0sHt2odi8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apfYhLD0sHt2odi8@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_012549_628688_A544C5E4 
X-CRM114-Status: GOOD (  25.82  )
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

On 09/02/26 at 11:04am, Mike Rapoport wrote:
> Hi Baoquan,
> 
> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> > On 09/02/26 at 07:34am, Mike Rapoport wrote:
> > > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> > > > Hi kexec@ mailing list and maintainers,
> > > > 
> > > > I would like to enable Sashiko code reviews for patches sent to the
> > > > kexec mailing list. I have found it useful for patches I have sent and
> > > > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> > > > enabled.
> > > > 
> > > > I sent a pull request to Sashiko to add kexec here:
> > > > 
> > > >   https://github.com/sashiko-dev/sashiko/pull/474
> > > 
> > > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
> > > index e6e4fb57f..e9ad97708 100644
> > > --- a/sashiko.dev/email_policy.toml
> > > +++ b/sashiko.dev/email_policy.toml
> > > @@ -175,6 +175,12 @@ reply_to_author = false
> > >  cc_individuals = false
> > >  cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
> > >  
> > > +[subsystems.kexec]
> > > +lists = ["kexec@lists.infradead.org"]
> > > +reply_to_author = true
> > > +send_positive_review = true
> > > 
> > > Do we really want those?
> > 
> > Some components don't want to CC list, then other people are welcome to
> > drop any comment during reviewing, while cc to maintainer and author
> > looks good to me. Just an input, no objection to any move.
> 
> Sorry, I wasn't clear, I meant do we really want extra emails saying
> sashiko is happy?

Oh, sorry. I misunderstood, I thought you had agreed to introduce
sashiko to part of list/author/maintainer or all.

I think there are two different ways and they have different impact:

1) CC list (CC author and maintainer can be ignored beause all people
can see it)
  This equals to cc author and push other reviewers away. And no
  reviewers will be patient and curious enough to check the sashiko
  report except of maintainers. Because maintainers need pick patch
  and may check if all reported issues are handled;

2) Cc maintainers when patch is cooked
  Maintainers tell patch author to check the report. Maybe CC patch
  author directly can save maintainers' effort. 

I personally think 2) is good. About whether introducing sashiko, 
I would vote yes. I buy token by myself, sashiko would be a plus.

Thanks
Baoquan

