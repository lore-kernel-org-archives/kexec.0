Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6C9C624D3
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vbFyWlTlR2F3Q206BLfRPytzyVYTuzgJDU57OPpqTPk=; b=ZMWuj+yH8WIxj8Fq66GAFIcPcu
	Rq7Z/SnIRUv8NjAzNYmdOh4UwDlvjeWt/RHEuH6W0WrkM5Phb4xXFMiTpI5rIg8bxNAnGPYyhFa4D
	8WQ9yHgp67FxVCDpr80dTDv2cBaLSOxbvkql/qCXgjNZXQyx9wjfw6CZ3CELnvsWuWuqJ1UhXRp9a
	CiO6NBTwbZNfWGNgczaXBSEi5X0tGQzx4UxvLqSBDcVFCKmyPOciN1W/9LlLtkQAzM8SR76wZ7BAU
	6MsCZBkqyL/0/8hAzTyf53yG3YASf1C/pBKZSfBOirUg+Hu42S5Z5mDBVbue0x9OIQW82AmFFFEfU
	hGR6Efmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1ojk-0000000FR00-3mXj;
	Wed, 02 Sep 2026 17:27:00 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1oji-0000000FQzj-3YEb
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 17:26:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E6F99600D0;
	Wed,  2 Sep 2026 17:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D451F00A3A;
	Wed,  2 Sep 2026 17:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788370017;
	bh=vbFyWlTlR2F3Q206BLfRPytzyVYTuzgJDU57OPpqTPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ROekHXGCPrrzQZWI3zasZM5VxV6afXFrizBikSAODQqVPmR57vUdWiWRPYlkM1Fw5
	 NpUF6LU0yJ7kCg+/a9WDNOuhJB3MwcLr7WeRvUOGAdgTvRwwaO4evVRQ4EPpYVUfFM
	 /b8cDQ32cT+pBebZwLTaMX6hLmsQ+BkYuWrhxG44tqoSmmk7asPVWyNAgccfxxYaDr
	 epk7ilO4WW2c3Wm2u9koKvN/rOEXuek+HakNxguMgaSEX2AsnklgLIReVvoi0uDGan
	 SzWGuC8906ZWs3zqMv1Mv5VjGzUlCiIr5DyUxyEPWoEV+1dFTBLEp3aFMrwBJ44X7m
	 lTcbor+3EibvA==
Date: Wed, 2 Sep 2026 20:26:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Baoquan He <baoquan.he@linux.dev>, kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <aphcW-sEaJ7Ff6lm@kernel.org>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org>
 <ape5s5tdwV6WwPih@fedora>
 <apfYhLD0sHt2odi8@kernel.org>
 <CALzav=e7J8XgdNh8998=qEXjqLVyof1DaYDf8swiApFOLVCpLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=e7J8XgdNh8998=qEXjqLVyof1DaYDf8swiApFOLVCpLw@mail.gmail.com>
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

On Wed, Sep 02, 2026 at 09:29:55AM -0700, David Matlack wrote:
> On Wed, Sep 2, 2026 at 1:04 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > Hi Baoquan,
> >
> > On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> > > On 09/02/26 at 07:34am, Mike Rapoport wrote:
> > > > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> > > > > Hi kexec@ mailing list and maintainers,
> > > > >
> > > > > I would like to enable Sashiko code reviews for patches sent to the
> > > > > kexec mailing list. I have found it useful for patches I have sent and
> > > > > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> > > > > enabled.
> > > > >
> > > > > I sent a pull request to Sashiko to add kexec here:
> > > > >
> > > > >   https://github.com/sashiko-dev/sashiko/pull/474
> > > >
> > > > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
> > > > index e6e4fb57f..e9ad97708 100644
> > > > --- a/sashiko.dev/email_policy.toml
> > > > +++ b/sashiko.dev/email_policy.toml
> > > > @@ -175,6 +175,12 @@ reply_to_author = false
> > > >  cc_individuals = false
> > > >  cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
> > > >
> > > > +[subsystems.kexec]
> > > > +lists = ["kexec@lists.infradead.org"]
> > > > +reply_to_author = true
> > > > +send_positive_review = true
> > > >
> > > > Do we really want those?
> > >
> > > Some components don't want to CC list, then other people are welcome to
> > > drop any comment during reviewing, while cc to maintainer and author
> > > looks good to me. Just an input, no objection to any move.
> >
> > Sorry, I wasn't clear, I meant do we really want extra emails saying
> > sashiko is happy?
> 
> This is currently enabled on the PCI mailing list and I have found it
> useful there. It makes it trivial to distinguish between "Sashiko
> reviewed the patch and found no issues" and "Sashiko did not review
> the patch" (could not apply it, backend bugs, whatever) without having
> to go to the Sashiko web UI to confirm. I can stay entirely on the
> mailing list.
> 
> But I am ok with dropping it if you feel strongly. It is a small thing.

Nah, no strong feelings. I can always /dev/null some emails on my side :)

-- 
Sincerely yours,
Mike.

