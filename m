Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9285C5B552
	for <kexec@archiver.kernel.org>; Fri, 30 May 2025 10:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oTc0O1aCLWM1UbhnV91t7SUS7ltmWzNQHuNqAgRfetQ=; b=ZTl6Fsz1DIFyOxuENTskOIv3ON
	bHVa0aLRUwAlKlANMDSr1H9yUxdCYN229LhpDeJlf7mKDJy5ou887VheLnW5oQEDDHd4F1hwGerwY
	4DZRBVTGn+7MZb9DrihiTQm8/lh0hgRY5KhIQRfiExP5v7D5r049TiZfBPIzTKfcfeQQ0CTrrBQZO
	DVxU+P/2iMY9XXdmpJWn+KvaFKYil+U65k7Ew6ss23mF/2xU+ao6RsBvQpyWy5LL8AgdTu9amlSd2
	ZwdP+leTuA84oyCKdoOU4L5+LlOb01X1UPyxFjag8qJXIrw/273BDY+9myRCqIWmgnnOFM76vXr/4
	m11UFoXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKwdW-00000000Fqp-0QVT;
	Fri, 30 May 2025 10:06:50 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKwdT-00000000Fok-2JJ2
	for kexec@lists.infradead.org;
	Fri, 30 May 2025 10:06:49 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id BE4C01F7A3;
	Fri, 30 May 2025 10:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748599606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTc0O1aCLWM1UbhnV91t7SUS7ltmWzNQHuNqAgRfetQ=;
	b=VTv1CdGxeFX8+klTuFS5VxcB15rY2yd0lg5UXEoPfw0xRh0dRKYxQz0EtMIE6jiDWp2+qb
	tPKuzEJicHonel/2goaUrqbEbVOTa9Jkctac9V2mBusIGST0tkU5g7dZ6YsTvcQVnok3LN
	BVo6DdvExsJ8IU5zZC4M/yi/tzgq+fk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748599606;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTc0O1aCLWM1UbhnV91t7SUS7ltmWzNQHuNqAgRfetQ=;
	b=PH9UWdzCF649Gyycuuecjp1JIDgP96LfgA0oWeu5Zh8CnLlJENe5zeOEK3a14xb8JsMMFR
	YVvGMAT+faCjhyCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748599605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTc0O1aCLWM1UbhnV91t7SUS7ltmWzNQHuNqAgRfetQ=;
	b=OM/sFBq0rL7Vs7xXiVCe8dcsY021Y2a25yLjl8eZjebZCN8c2CMUPMMzr5ZuEET05jj8z1
	iT0fAKgDMQkh8CwYPzhK292SFHDRdpuPxPXp11EP9i2yNWLUPcMIZJM1XNMcWydJa89EnE
	JYvbP/9jhTV+HDH7uGneBWa9vgT0PIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748599605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oTc0O1aCLWM1UbhnV91t7SUS7ltmWzNQHuNqAgRfetQ=;
	b=rBudCxP3JBcJYezhOTJhuh8HXGvJDmBpmWCUAq4jQ2hF3jfpMLyVNaCy28LC59D3h3LR5A
	K3kYFOsqxSnNh9Aw==
Date: Fri, 30 May 2025 12:06:45 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Baoquan He <bhe@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH v2 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aDmDNdhW75eXw_4M@dwarf.suse.cz>
References: <Z8Z/gnbtiXT9QAZr@MiWiFi-R3L-srv>
 <e9c5c247-85fb-43f1-9aa8-47d62321f37b@redhat.com>
 <aDgQ0lbt1h5v0lgE@tiehlicka>
 <a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com>
 <aDlsF5tAcUxo4VgT@tiehlicka>
 <e0f7fc1e-2227-4c6b-985a-34a697a52679@redhat.com>
 <aDl1ViMpK_6q_z06@tiehlicka>
 <04a49de5-eb79-431b-ba5b-eae2536781c6@redhat.com>
 <aDl7rHb34zIXEf6j@dwarf.suse.cz>
 <f95f2f30-1393-4ae1-96b1-96e4abfc368f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95f2f30-1393-4ae1-96b1-96e4abfc368f@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,dwarf.suse.cz:mid,localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250530_030647_734835_D3BDF3BD 
X-CRM114-Status: GOOD (  25.11  )
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

On Fri, May 30, 2025 at 11:47:46AM +0200, David Hildenbrand wrote:
> > > > crashkernel=1G,cma,cma_sane_dma # no wait on transition
> > > 
> > > But is no wait ok? I mean, any O_DIRECT with any device would at least take
> > > a bit, no?
> > > 
> > > Of course, there is a short time between the crash and actually triggerying
> > > kdump.
> > > 
> > > > crashkernel=1G,cma # wait on transition with e.g. 10s timeout
> > > 
> > > In general, would work for me.
> > 
> > I don't like extending the crashkernel= syntax like this.
> > It would make hooking into the generic parsing code in
> > parse_crashkernel() really ugly. The syntax is already
> > convoluted as is and hard enough to explain in the documentation.
> 
> Would another boolean flag (on top of the other one you are adding) really
> make this significantly more ugly?

the current code does not split the parameter by commas and treat
the part as boolean flags.

Both ",cma" and ",cma,cma_sane_dma" (and possibly
",cma_sane_dma,cma") would need to be added to suffix_tbl[]
(carefully thinking about the order because one is a prefix of the
other); then handled almost the same except setting the flag.

Also I think using the command line is way less flexible than
sysfs. E.g. the userspace tool loading the crash kernel (kdump)
may want to decide if the hardware is sane using its own
whitelist/blacklist...

> > I am inclined to just setting the fixed delay to 10s for now and
> > adding a sysfs knob later if someone asks for it.
> > 
> > Would that work for you?
> 
> Sure. We could always add such a flag later if it's really a problem for
> someone.

OK, thanks! Will post the v4 shortly.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


