Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE5DC4167B
	for <kexec@archiver.kernel.org>; Fri,  1 Dec 2023 12:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/H0IPJSy1Ou/U0bj+ynQ2C3L5I5ffxViEmD8c81xSgk=; b=of1qTUFtqP4eyV
	vmmdoXDTy6qfbi0Jyt015SOy5uYrZ/6nNuOopuGlKQZSP/aPJFAvni2MtuiWP9FRhJxHoB6TgG5Ou
	GeXXOGo/XZfeqJNobDyYW0DQOK6PH3To7Ildj6UBYYd2vh4ZnKHlygpItekdLDA77jnYReslrpadv
	0KxvNPKN5Y/06tlJr66MywCORs2SQYKHs9iA/3c2o3k24q2ZeDC1HG7lbATgTGcxGRL96nnVCpfyG
	vRbcpNYRaZtSbOpSJvtvLvX1Urcy+ErU036OZWRUpqlZskAriuyW8LXcVeC444MTDGC6MosNsmAJD
	TlAP5HdVUlNwECZSQfDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r92kG-00DZyd-2Z;
	Fri, 01 Dec 2023 12:35:48 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r92kD-00DZxu-2L
	for kexec@lists.infradead.org;
	Fri, 01 Dec 2023 12:35:47 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id A98A51FD68;
	Fri,  1 Dec 2023 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701434141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qpSH/VFJA7oKeS3f7gAfhSd3U4lHBZHK5JZku/5WYQ=;
	b=X+pFGdUQxOA8KtjhjRyMzN3ggAOsn24COaoxnTYbWMIZl5NJczGRliqrqTazExiUqFFmp8
	sVuZvnWSipxXbC/o39m4A3vAu+kRgHkjPYU8yl2JiRvH6EpvZGkz+V+TAaMVxg+Uq5wcab
	XwC0dr+/1U7TeWdotx8FhIorBGweUWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701434141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9qpSH/VFJA7oKeS3f7gAfhSd3U4lHBZHK5JZku/5WYQ=;
	b=+vVnfTwiXLhbdEvutNTmbGnGIaK/VlmQC9iU1KwONAYD5KTA1u01CcOhnJLGaE6BSyc4Zj
	dIptQs22X3O2FBCw==
Date: Fri, 1 Dec 2023 13:35:41 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWnTHWXNWg06pLMg@dwarf.suse.cz>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbvB/4bKu69zMbd@MiWiFi-R3L-srv>
 <ZWcXyeDiI2v251F_@dwarf.suse.cz>
 <ZWgJIAYwfVvA+r8h@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZWgJIAYwfVvA+r8h@MiWiFi-R3L-srv>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.98 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-0.88)[-0.880];
	 MID_RHS_MATCH_FROMTLD(0.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231201_043546_074409_6360AFA6 
X-CRM114-Status: GOOD (  39.55  )
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

On Thu, Nov 30, 2023 at 12:01:36PM +0800, Baoquan He wrote:
> On 11/29/23 at 11:51am, Jiri Bohac wrote:
> > We get a lot of problems reported by partners testing kdump on
> > their setups prior to release. But even if we tune the reserved
> > size up, OOM is still the most common reason for kdump to fail
> > when the product starts getting used in real life. It's been
> > pretty frustrating for a long time.
> 
> I remember SUSE engineers ever told you will boot kernel and do an
> estimation of kdump kernel usage, then set the crashkernel according to
> the estimation. OOM will be triggered even that way is taken? Just
> curious, not questioning the benefit of using ,cma to save memory.

Yes, we do that during the kdump package build. We use this to
find some baseline for memory requirements of the kdump kernel
and tools on that specific product. Using these numbers we
estimate the requirements on the system where kdump is
configured by adding extra memory for the size of RAM, number of
SCSI devices, etc. But apparently we get this wrong in too many cases,
because the actual hardware differs too much from the virtual
environment which we used to get the baseline numbers. We've been
adding silly constants to the calculations and we still get OOMs on
one hand and people hesitant to sacrifice the calculated amount
of memory on the other. 

The result is that kdump basically cannot be trusted unless the
user verifies that the sacrificed memory is still enough after
every major upgrade.

This is the main motivation behind the CMA idea: to safely give
kdump enough memory, including a safe margin, without sacrificing
too much memory.

> > I feel the exact opposite about VMs. Reserving hundreds of MB for
> > crash kernel on _every_ VM on a busy VM host wastes the most
> > memory. VMs are often tuned to well defined task and can be set
> > up with very little memory, so the ~256 MB can be a huge part of
> > that. And while it's theoretically better to dump from the
> > hypervisor, users still often prefer kdump because the hypervisor
> > may not be under their control. Also, in a VM it should be much
> > easier to be sure the machine is safe WRT the potential DMA
> > corruption as it has less HW drivers. So I actually thought the
> > CMA reservation could be most useful on VMs.
> 
> Hmm, we ever discussed this in upstream with David Hildend who works in
> virt team. VMs problem is much easier to solve if they complain the
> default crashkernel value is wasteful. The shrinking interface is for
> them. The crashkernel value can't be enlarged, but shrinking existing
> crashkernel memory is functioning smoothly well. They can adjust that in
> script in a very simple way.

The shrinking does not solve this problem at all. It solves a
different problem: the virtual hardware configuration can easily
vary between boots and so will the crashkernel size requirements.
And since crashkernel needs to be passed on the commandline, once
the system is booted it's impossible to change it without a
reboot. Here the shrinking mechanism comes in handy
- we reserve enough for all configurations on the command line and
during boot the requirements for the currently booted
configuration can be determined and the reservation shrunk to
the determined value.  But determining this value is the same
unsolved problem as above and CMA could help in exactly the same
way.

> Anyway, let's discuss and figure out any risk of ,cma. If finally all
> worries and concerns are proved unnecessary, then let's have a new great
> feature. But we can't afford the risk if the ,cma area could be entangled
> with 1st kernel's on-going action. As we know, not like kexec reboot, we
> only shutdown CPUs, interrupt, most of devices are alive. And many of
> them could be not reset and initialized in kdump kernel if the relevant
> driver is not added in.

Well since my patchset makes the use of ,cma completely optional
and has _absolutely_ _no_ _effect_ on users that don't opt to use
it, I think you're not taking any risk at all. We will never know
how much DMA is a problem in practice unless we give users or
distros a way to try and come up with good ways of determining if
it's safe on whichever specific system based on the hardware,
drivers, etc.

I've successfully tested the patches on a few systems, physical
and virtual. Of course this is not proof that the DMA problem
does not exist but shows that it may be a solution that mostly
works. If nothing else, for systems where sacrificing ~400 MB of
memory is something that prevents the user from having any dump
at all, having a dump that mostly works with a sacrifice of ~100
MB may be useful.

Thanks,

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
