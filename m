Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KHKEp-0002j3-No
	for kexec@lists.infradead.org; Fri, 11 Jul 2008 15:08:48 +0000
Received: from Relay2.suse.de (relay-ext.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 2B81A45C76
	for <kexec@lists.infradead.org>; Fri, 11 Jul 2008 17:08:46 +0200 (CEST)
Date: Fri, 11 Jul 2008 17:07:20 +0200
From: Bernhard Walle <bwalle@suse.de>(by way of Bernhard Walle
	<bwalle@suse.de>)
Message-ID: <20080711170720.22533ccb@halley.suse.de>
In-Reply-To: <20080710230827.GC11227@verge.net.au>
References: <20080710112912.21641167@halley.suse.de>
	<20080710230827.GC11227@verge.net.au>
Mime-Version: 1.0
Subject: Re: Future of kexec-tools-testing
Resent-Message-ID: <20080711170927.1aec8a83@halley.suse.de>
Resent-To: kexec@lists.infradead.org
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>

* Simon Horman [2008-07-11 09:08]:
> On Thu, Jul 10, 2008 at 11:29:12AM +0200, Bernhard Walle wrote:
> > 
> > SUSE uses now kexec-tools-testing releases since about one year and
> > we never had severe problems (compared to other software). It's well
> > maintained (thanks Simon!), gets frequent releases, patches are
> > accepted, so:
> > 
> >  - I would suggest that kexec-tools-testing could be renamed to
> >    kexec-tools somewhere in the future since kexec-tools is not
> >    maintained any more by Eric. It only causes confusion since
> >    some distributions still use kexec-tools (the original ones)
> >    with lots of patches.
> 
> I agree.
> 
> Perhaps we could make the next release kexec-tools 2.0.0, perhaps
> after a few beta releases?

Sounds reasonable.

> I can rename my git tree to coincide with this move.

I think the name of the git tree is not that important, but it makes
also sense to rename that. Since there is no "kexec-tools" tree anyway.

> Perhaps the best thing to do now would be to hash out a release roadmap.
> Fortunately the code is pretty small, so it shouldn't be a very long road.
> 
> Do you think there is anything currently missing from the tree?
> If not, I can make a beta release early next week (I have to leave
> my desk for an extended weekend shortly).

No, the current state is fine for me (from a functional point of view).
So, just release kexec-tools-2.0.0-rc1 next week. I think we don't need
alpha and beta versions here.

I'll help to test that release then (by updating SUSE/Factory :-)).

I think we don't need changes in the release policy because it worked
out fine in the past. And when 2.0.0 is out, I think then also all
other major distributions like Debian, Fedora, etc. update to that
release and drop their patches.

Thanks a lot for your effort!


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
