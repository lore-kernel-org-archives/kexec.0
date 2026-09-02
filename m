Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0293CC624D0
	for <kexec@archiver.kernel.org>; Wed,  2 Sep 2026 09:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ajHupntF/zlDXKUve2FSsO4qQJ74hiwygPHwpZqa29o=; b=firyvGvcLsTj21dZP0PZvvJ5TC
	+A7C8onFUCFykJogX6xns1oJQdkfRO/g9wxKJ0ZJvE3RKPhRgH2kvdYbb8/+jrvD4e6hnKQ7eVyui
	3uVYXCnlvYH93TPozuxD+lZ6Gkty9xvYUo2WZZdJHp3HK2Y770oeomoQuIIINd+XiPtznmxSlrAGK
	23r8iI6EUQtBkug9F+Vz8nhKf2LMBFpzIIRROz2EEkDzCYaV2rQ4gYMpKu/UDiygu6gHwDDzHZoyT
	xyKB1EpUhisyrOD1UV4Y1dp7oVP4BERrjmEu9rSUgUBW9CDNkf9WPjx8CNyd+2OUE2q4TpXVpa6aB
	XqUO1GBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1heo-0000000EGrr-0aJO;
	Wed, 02 Sep 2026 09:53:26 +0000
Received: from out-34.mta0.migadu.com ([2001:41d0:1004:224b::22] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1hek-0000000EGqd-1kNt
	for kexec@lists.infradead.org;
	Wed, 02 Sep 2026 09:53:24 +0000
X-Envelope-To: kexec@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=rQTA5ht8YMdQlBcn0mb5vIvC0nr1C4Fz+07+l6/g1zE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788342799; v=1; x=1788947599;
 b=IYmj95Qw41i9dHv6k6UxEYihAuAD+sQO56Q++EDShRfHsVHV2pgFFFVfahH+18jzjsJdP0+E
 xqSlte6RgMV2+k6GoZDPzGpJJoT4uSyq57o0Jwp2OeAG00jjyMvLuPZDV5b4614j/octVTtplB2
 R/srN8B/Jj18OlXWzhx5QPw8=
X-Envelope-To: kexec@lists.infradead.org
Received: by mta11.migadu.com with ESMTPS id fa9db46d4987209e;
	Wed, 02 Sep 2026 09:53:19 +0000
X-Mizu-Trace-ID: fa9db46d4987209e
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 17:53:11 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, David Matlack <dmatlack@google.com>,
	kexec@lists.infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Dave Young <ruirui.yang@linux.dev>,
	Alexander Graf <graf@amazon.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: RFC: Enable Sashiko code reviews for kexec@lists.infradead.org
Message-ID: <apfyB_5MIK7VieNw@fedora>
References: <CALzav=eL-cARsaH4AO4PzeOPNDmTHpCZbYh9yX_U8pbz96qdTQ@mail.gmail.com>
 <apenOdHJmH_VeD-X@kernel.org>
 <ape5s5tdwV6WwPih@fedora>
 <apfYhLD0sHt2odi8@kernel.org>
 <apfdhh0YYwo4am7A@fedora>
 <2vxzqzjcxb8r.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzqzjcxb8r.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_025322_883696_F5FE4069 
X-CRM114-Status: GOOD (  52.64  )
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

On 09/02/26 at 11:18am, Pratyush Yadav wrote:
> +Cc Roman because I am complaining about Sashiko ;-)
> 
> On Wed, Sep 02 2026, Baoquan He wrote:
> 
> > On 09/02/26 at 11:04am, Mike Rapoport wrote:
> >> Hi Baoquan,
> >> 
> >> On Wed, Sep 02, 2026 at 01:52:51PM +0800, Baoquan He wrote:
> >> > On 09/02/26 at 07:34am, Mike Rapoport wrote:
> >> > > On Tue, Sep 01, 2026 at 01:27:34PM -0700, David Matlack wrote:
> >> > > > Hi kexec@ mailing list and maintainers,
> >> > > > 
> >> > > > I would like to enable Sashiko code reviews for patches sent to the
> >> > > > kexec mailing list. I have found it useful for patches I have sent and
> >> > > > reviewed on the kvm and linux-pci mailing lists, which have Sashiko
> >> > > > enabled.
> >> > > > 
> >> > > > I sent a pull request to Sashiko to add kexec here:
> >> > > > 
> >> > > >   https://github.com/sashiko-dev/sashiko/pull/474
> >> > > 
> >> > > diff --git a/sashiko.dev/email_policy.toml b/sashiko.dev/email_policy.toml
> >> > > index e6e4fb57f..e9ad97708 100644
> >> > > --- a/sashiko.dev/email_policy.toml
> >> > > +++ b/sashiko.dev/email_policy.toml
> >> > > @@ -175,6 +175,12 @@ reply_to_author = false
> >> > >  cc_individuals = false
> >> > >  cc = ["Chuck Lever <cel@kernel.org>", "Jeff Layton <jlayton@kernel.org>", "Anna Schumaker <anna@kernel.org>"]
> >> > >  
> >> > > +[subsystems.kexec]
> >> > > +lists = ["kexec@lists.infradead.org"]
> >> > > +reply_to_author = true
> >> > > +send_positive_review = true
> >> > > 
> >> > > Do we really want those?
> >> > 
> >> > Some components don't want to CC list, then other people are welcome to
> >> > drop any comment during reviewing, while cc to maintainer and author
> >> > looks good to me. Just an input, no objection to any move.
> >> 
> >> Sorry, I wasn't clear, I meant do we really want extra emails saying
> >> sashiko is happy?
> >
> > Oh, sorry. I misunderstood, I thought you had agreed to introduce
> > sashiko to part of list/author/maintainer or all.
> >
> > I think there are two different ways and they have different impact:
> >
> > 1) CC list (CC author and maintainer can be ignored beause all people
> > can see it)
> 
> This is a side topic, but if we only Cc the list then Sashiko won't Cc
> the other people in the thread, like the usual "reply to all" every mail
> clients does. It will _only_ Cc the list. See [0] for example.
> 
> I don't think that is a good idea, because Sashiko might complain about
> something, and then the patch author can reply to the complaint. People
> who are not subscribed to the list will neither see Sashiko's complaint
> nor the author's response. So they lose a useful part of the patch
> review process.
> 
> I am one of those people. I don't subscribe to any mailing lists and
> instead use lei [1] to fetch them. I treat my inbox as the primary
> stream of patches, and then glance at the lists every now and then. If I
> get some patches in my inbox but then I don't get any of the follow-ups
> from the author to Sashiko, that's annoying. Sure, I might see them on
> the list later, but it is still annoying.
> 
> And of course, there might be patches that touch multiple subsystems and
> maintainers of that subsystem might not subscribe to or track kexec@ at
> all. So they will entirely miss the conversation.
> 
> If Sashiko is useful enough to send replies on the list, then I think it
> is useful enough to reply to everyone.
> 
> IIRC some people have complained in the past about automatically getting
> replies from Sashiko so maybe that is why this behaviour exists? Roman,
> is that correct? Is there any appetite yet to change that behaviour?
> 
> Or could we perhaps have an unsubscribe mechanism where people who don't
> want to see anything from Sashiko can unsubscribe themselves and Sashiko
> will skip them when replying?
> 
> [0] https://lore.kernel.org/kvm/20260902072059.90ADC1F000E9@smtp.kernel.org/
> [1] https://public-inbox.org/lei.txt
> 
> >   This equals to cc author and push other reviewers away. And no
> >   reviewers will be patient and curious enough to check the sashiko
> >   report except of maintainers. Because maintainers need pick patch
> >   and may check if all reported issues are handled;
> >
> > 2) Cc maintainers when patch is cooked
> >   Maintainers tell patch author to check the report. Maybe CC patch
> >   author directly can save maintainers' effort. 
> >
> > I personally think 2) is good. About whether introducing sashiko, 
> > I would vote yes. I buy token by myself, sashiko would be a plus.
> 
> FWIW, Sashiko already tracks the kexec@ list and you can see all the
> patches in the web interface [2]. So you don't need to burn your tokens
> on reviewing kexec patches ;-)

Thats's cool and it's enough. No, I am not saying sashiko will save
tokens for maintainers. I meant if people post patches, sashiko can
review and report from different models' side, that save patch authors'
tokens to some extent. Maybe most of people don't need to consider
this. :-)

> 
> What David is proposing is to send those reviews to the list.
> 
> [2] https://sashiko.dev/#/?list=org.infradead.lists.kexec
> 
> >
> > Thanks
> > Baoquan
> 
> -- 
> Regards,
> Pratyush Yadav

