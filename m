Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8DAC7115A
	for <kexec@archiver.kernel.org>; Thu, 19 Jun 2025 15:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5+fM4MttKE3A03nChZO9COV7itbt2Km8YxBW6g7esUo=; b=ry78KcaBSbwmbqXXdJv/EzPRkh
	MmbRXgem0tYhfiXPWeqR+vIJsHpvv0xyeCsYePLXaEDPdFVG7gxWRuhcP+EtMHN6JLhkt0wM2HpKY
	tRShdwg/WbXiWnelsOZCsA3IrGLI1rIqRSf7hCfME8hOg28/lCZP+ywTvhmyfnzL/3IEpn0qJup9/
	8OfnBcqPFFog27dkWHq2SJVV/OaLmi3R6HWB2Gn+uPyzIZqpz1af/7QEyjJgChUgoY9Mm/Hn2hS0/
	eAp47qRQF6i2UnUNIJwT31DmxeTNdzbrM6FQyjl9avXW/No+q98+zfefYXL2xBotV/vW9qruhK9Y5
	02bJ+d1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSHV1-0000000DWqI-3ej8;
	Thu, 19 Jun 2025 15:48:23 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSEfT-0000000D5kl-0cBe
	for kexec@lists.infradead.org;
	Thu, 19 Jun 2025 12:47:00 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 2E9CA211C6;
	Thu, 19 Jun 2025 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750337216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+fM4MttKE3A03nChZO9COV7itbt2Km8YxBW6g7esUo=;
	b=Z3lXv73KiWY95pdfmh0Pfoybb2uI7JQ/GOM/KUE+4HCpm8wNwpLgJVMr1jyxA1mQ0kYTdq
	qo5CPob2oAwOuLqoPwuED71JRJlAKPh3UsqRt2Z2LXvQsvTlhOw5o4axHBOq6Iet9J7Zqz
	llCXE56uDd/TA5E44rbeitRFwFNHgKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750337216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+fM4MttKE3A03nChZO9COV7itbt2Km8YxBW6g7esUo=;
	b=5FlSBCrgaDGDUb9oa6w9IwyKfAfRQrd/oRtVGPljTKwpZAGsn5pONnUfbtqkNDE6Q1xbJR
	wBFaHrGrQ5zF6cBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750337216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+fM4MttKE3A03nChZO9COV7itbt2Km8YxBW6g7esUo=;
	b=Z3lXv73KiWY95pdfmh0Pfoybb2uI7JQ/GOM/KUE+4HCpm8wNwpLgJVMr1jyxA1mQ0kYTdq
	qo5CPob2oAwOuLqoPwuED71JRJlAKPh3UsqRt2Z2LXvQsvTlhOw5o4axHBOq6Iet9J7Zqz
	llCXE56uDd/TA5E44rbeitRFwFNHgKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750337216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+fM4MttKE3A03nChZO9COV7itbt2Km8YxBW6g7esUo=;
	b=5FlSBCrgaDGDUb9oa6w9IwyKfAfRQrd/oRtVGPljTKwpZAGsn5pONnUfbtqkNDE6Q1xbJR
	wBFaHrGrQ5zF6cBQ==
Date: Thu, 19 Jun 2025 14:46:56 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aFQGwKGwGb69M9VS@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <aEqpgDIBndZ5LXSo@dwarf.suse.cz>
 <20250612164735.76a1ea9a156cd254331ffdc4@linux-foundation.org>
 <925cdfc4-7878-4572-9a4d-9b99d149a652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <925cdfc4-7878-4572-9a4d-9b99d149a652@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250619_054659_331301_F44396C9 
X-CRM114-Status: GOOD (  14.74  )
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

On Fri, Jun 13, 2025 at 11:19:11AM +0200, David Hildenbrand wrote:
> > It's sad to add a 10s delay for something which some systems will never
> > do.  I wonder if there's some simple hack we can add.  Like having a
> > global flag which gets set the first time someone pins a CMA page
> 
> We would likely have to do that for any GUP on such a page (FOLL_GET |
> FOLL_PIN), both from gup-fast and gup-slow.
> 
> Should work, but IMHO can be optimized later, on top of this series.

The 10 s was David's suggestion during the discussion of v2 of
this patchset. We already had a discussion about both the length
of the delay and whether to make it configurable [1] 

We agreed it was best to start with a longer fixed delay to be on the
safe side.

If the CMA reservation becomes popular and anybody complains
about the delay, then we can trivially make this configurable or
think of other improvements.

[1] https://lore.kernel.org/lkml/a1a5af90-bc8a-448a-81fa-485624d592f3@redhat.com/

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


