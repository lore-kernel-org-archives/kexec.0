Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE50AC10DC3
	for <kexec@archiver.kernel.org>; Thu,  7 Dec 2023 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mDh5m6i8vD9uJ08Cclr+QKOy3kN3tB9VrQutKk2Qm98=; b=1FpsYEUbME1c25
	RRgcpS7bxCnqrT8NdaD7SXOFCHHDJ16Rtb9SInbN+/0opuUZlnYHsoo9jXHYOwjXBcW9Mf+N56x+y
	h90W1lHD6/YnI60yTsZea83TiiikDWwbRRqdlsXPdppDKuHxtxrbPsPKGuAFjPLk7wp/Ukqx9A1qb
	6/Jow2jOZ43Rz7hOlBNLd0HYG9/DIXF6soRTQ8/Dhuh0mY9lKx0hxOxQwdcV6BXqnvcNcuGkBshpN
	hRI/cFbRj+mx4+0rBVRutXxhRjNt8YO8lSocyJNUyyhMk6rXZGE7d8R33J/QzdJOzchEbXYP2JvlP
	p4Ey5J6dNBkApy0T91gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBCvm-00Cj7M-1w;
	Thu, 07 Dec 2023 11:52:38 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBCvj-00Cj66-1c
	for kexec@lists.infradead.org;
	Thu, 07 Dec 2023 11:52:37 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 301D421DA2;
	Thu,  7 Dec 2023 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701949953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zXp2pBxzzfhn7WW87mLOEoOlFwRFI4WpDCdw5P4sAjI=;
	b=rVi4JuRLwDorsYJ4fWcMcRnoxwCCfvUMzYiArSjZkSvy1UBYgbhYjGGms1QDCYBsGGBSIN
	UCYYFPUGuU9Mdv4kAWOt6n32Bah80ekgI7eNK7Rmp/1rV1XzUYDE7eP8COXMGUGb3a1QwB
	D1pdAspcrz26eF92s3f/Ni6cHbOYpcQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A5FD13B6A;
	Thu,  7 Dec 2023 11:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7MQrOwCycWUIfQAAD6G6ig
	(envelope-from <mhocko@suse.com>); Thu, 07 Dec 2023 11:52:32 +0000
Date: Thu, 7 Dec 2023 12:52:32 +0100
From: Michal Hocko <mhocko@suse.com>
To: Philipp Rudo <prudo@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXGyANwELvFKpysH@tiehlicka>
References: <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
 <20231207121314.50b8e4c4@rotkaeppchen>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231207121314.50b8e4c4@rotkaeppchen>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_035235_691318_0DAB8B63 
X-CRM114-Status: GOOD (  45.02  )
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

On Thu 07-12-23 12:13:14, Philipp Rudo wrote:
> On Thu, 7 Dec 2023 09:55:20 +0100
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 07-12-23 12:23:13, Baoquan He wrote:
> > [...]
> > > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > > it will be a venture.  
> > 
> > We can't guarantee this of course but AFAIK the DMA shouldn't take
> > minutes, right? While not perfect, waiting for some time before jumping
> > into the crash kernel should be acceptable from user POV and it should
> > work around most of those potential lingering programmed DMA transfers.
> 
> I don't think that simply waiting is acceptable. For one it doesn't
> guarantee that there is no corruption (please also see below) but only
> reduces its probability. Furthermore, how long would you wait?

I would like to talk to storage experts to have some ballpark idea about
worst case scenario but waiting for 1 minutes shouldn't terribly
influence downtime and remember this is an opt-in feature. If that
doesn't fit your use case, do not use it.

> Thing is that users don't only want to reduce the memory usage but also
> the downtime of kdump. In the end I'm afraid that "simply waiting" will
> make things unnecessarily more complex without really solving any issue.

I am not sure I see the added complexity. Something as simple as
__crash_kexec:
	if (crashk_cma_cnt) 
		mdelay(TIMEOUT)

should do the trick.

> > So I guess what we would like to hear from you as kdump maintainers is
> > this. Is it absolutely imperative that these issue must be proven
> > impossible or is a best effort approach something worth investing time
> > into? Because if the requirement is an absolute guarantee then I simply
> > do not see any feasible way to achieve the goal of reusable memory.
> > 
> > Let me reiterate that the existing reservation mechanism is showing its
> > limits for production systems and I strongly believe this is something
> > that needs addressing because crash dumps are very often the only tool
> > to investigate complex issues.
> 
> Because having a crash dump is so important I want a prove that no
> legal operation can corrupt the crashkernel memory. The easiest way to
> achieve this is by simply keeping the two memory regions fully
> separated like it is today. In theory it should also be possible to
> prevent any kind of page pinning in the shared crashkernel memory. But
> I don't know which side effect this has for mm. Such an idea needs to
> be discussed on the mm mailing list first.

I do not see that as a feasible option. That would require to migrate
memory on any gup user that might end up sending data over DMA.

> Finally, let me question whether the whole approach actually solves
> anything. For me the difficulty in determining the correct crashkernel
> memory is only a symptom. The real problem is that most developers
> don't expect their code to run outside their typical environment.
> Especially not in an memory constraint environment like kdump. But that
> problem won't be solved by throwing more memory at it as this
> additional memory will eventually run out as well. In the end we are
> back at the point where we are today but with more memory.

I disagree with you here. While the kernel is really willing to cache
objects into memory I do not think that any particular subsystem is
super eager to waste memory.

The thing we should keep in mind is that the memory sitting aside is not
used in majority of time. Crashes (luckily/hopefully) do not happen very
often. And I can really see why people are reluctant to waste it. Every
MB of memory has an operational price tag on it. And let's just be
really honest, a simple reboot without a crash dump is very likely
a cheaper option than wasting a productive memory as long as the issue
happens very seldom.
 
> Finally finally, one tip. Next time a customer complaints about how
> much memory the crashkernel "wastes" ask them how much one day of down
> time for one machine costs them and how much memory they could buy for
> that money. After that calculation I'm pretty sure that an additional
> 100M of crashkernel memory becomes much more tempting.

Exactly and that is why a simple reboot would be a preferred option than
configuring kdump and invest admin time to keep testing configuration
after every (major) upgrade to make sure the existing setup still works.
From my experience crashdump availability hugely improves chances to get
underlying crash diagnosed and bug solved so it is also in our interest
to encourage kdump deployments as much as possible.

Now I do get your concerns about potential issues and I fully recognize
the pain you have gone through when debugging these subtle issues in the
past but let's not forget that perfect is an enemy of good and that a
best effort solution might be better than crash dumps at all.

At the end, let me just ask a theoretical question. With the experience
you have gained would you nack the kexec support if it was proposed now
just because of all the potential problems it might have?
-- 
Michal Hocko
SUSE Labs

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
