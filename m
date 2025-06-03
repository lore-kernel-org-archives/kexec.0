Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7223AC5AD49
	for <kexec@archiver.kernel.org>; Tue,  3 Jun 2025 16:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BUk9jbPIucKKsoagkVDdcs5GDWgOlMvLesrezUz89m8=; b=I05OLe9kGgNFs2HI2CRllLqiIU
	8lifDVSHYocbh+KfHQvwznvE/M0jUF05RwDr6/FUPNEuGjcH7XBMB+fzPTPAOyKozH6IqqJSDp7BC
	AZ0o0Cr6YGzRBk+uQNfSiXGn8MXBifugBxWa1HHrXjNtAjRsb+zezqO6xhcHKZv4YtojDqlXmjsWA
	wkQiR3lpM5nO23ePbig5R/4O8C+feUrWrTq6bBJwDGfcELOwakK3l20TCj4MulXYzq9OnhpsNFp4Q
	0LGCtRSOMNL6B5clRMQZvvfkNB0yXSYydVS1iG/L62uYFAKuF3ZNvXO2RiRHhUY8J9veJ4A9OxfW4
	Od7C0YyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMU4o-0000000BMOC-2Oyg;
	Tue, 03 Jun 2025 16:01:22 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMU3C-0000000BM91-3AJd
	for kexec@lists.infradead.org;
	Tue, 03 Jun 2025 15:59:44 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id 412681FD43;
	Tue,  3 Jun 2025 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748966381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUk9jbPIucKKsoagkVDdcs5GDWgOlMvLesrezUz89m8=;
	b=ZFqQykiIIr82L5nadIauvlpxk59e/yuOmhZrZigvOHSqA5mNfb+q+In4EXr/Dnu/KIKyQl
	2km/jrG55844cq/FMff8mfzBwxUnObrUQ0iB5VBEN/dxp+EtalXYyxMsiZtB1pu2B0/xBA
	biFF8byknCyhy/nNcyhgZUQyQp85/a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748966381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUk9jbPIucKKsoagkVDdcs5GDWgOlMvLesrezUz89m8=;
	b=QEHqr3q8TUQr1ZfPoaWhgd3TE7hgbgNy7jqXlMJ3qIvTEHIY64DVYgFutO+IXKYLS+KDFA
	zij5zewkl7CyUlDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748966381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUk9jbPIucKKsoagkVDdcs5GDWgOlMvLesrezUz89m8=;
	b=ZFqQykiIIr82L5nadIauvlpxk59e/yuOmhZrZigvOHSqA5mNfb+q+In4EXr/Dnu/KIKyQl
	2km/jrG55844cq/FMff8mfzBwxUnObrUQ0iB5VBEN/dxp+EtalXYyxMsiZtB1pu2B0/xBA
	biFF8byknCyhy/nNcyhgZUQyQp85/a4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748966381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUk9jbPIucKKsoagkVDdcs5GDWgOlMvLesrezUz89m8=;
	b=QEHqr3q8TUQr1ZfPoaWhgd3TE7hgbgNy7jqXlMJ3qIvTEHIY64DVYgFutO+IXKYLS+KDFA
	zij5zewkl7CyUlDg==
Date: Tue, 3 Jun 2025 17:59:41 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: David Hildenbrand <david@redhat.com>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	Philipp Rudo <prudo@redhat.com>, Donald Dutile <ddutile@redhat.com>,
	Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
	linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v4 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <aD8b7Q8Z9sC8meGU@dwarf.suse.cz>
References: <aDoT08LfXUEkS9E4@dwarf.suse.cz>
 <aDoVO4H4CpXPjAdI@dwarf.suse.cz>
 <da52a835-6a4b-4f11-acac-f4ef995da7e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da52a835-6a4b-4f11-acac-f4ef995da7e1@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250603_085942_975540_8DFDA0E2 
X-CRM114-Status: GOOD (  22.79  )
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

On Tue, Jun 03, 2025 at 03:15:03PM +0200, David Hildenbrand wrote:
> On 30.05.25 22:29, Jiri Bohac wrote:
> > When re-using the CMA area for kdump there is a risk of pending DMA into
> > pinned user pages in the CMA area.
> > 
> > Pages that are pinned long-term are migrated away from CMA, so these are
> > not a concern. Pages pinned without FOLL_LONGTERM remain in the CMA and may
> > possibly be the source or destination of a pending DMA transfer.
> 
> I'll note that we right now do have an upstream BUG where that is sometimes
> not the case. I mentioned it previously that such bugs will be a problem :(
> 
> https://lkml.kernel.org/r/20250523023709epcms1p236d4f55b79adb9366ec1cf6d5792b06b@epcms1p2

I'll just reitarate the whole purpose of this patchset, as
added to Documentation:

+       This option increases the risk of a kdump failure: DMA transfers
+       configured by the first kernel may end up corrupting the second
+       kernel's memory.
+
+       This reservation method is intended for systems that can't afford to
+       sacrifice enough memory for standard crashkernel reservation and where
+       less reliable and possibly incomplete kdump is preferable to no kdump at
+       all.

It is expected that kdump may be less reliable when ,cma is used.
You mentioned a bug that augments this unreliability and that is surely going to get fixed.
I think this is fine.

The whole point is getting a completely optional best-effort kdump when
otherwise we would have no kdump.

> > +static void crash_cma_clear_pending_dma(void)
> > +{
> > +	unsigned int s = cma_dma_timeout_sec;
> > +
> > +	if (!crashk_cma_cnt)
> > +		return;
> > +
> > +	while (s--)
> > +		mdelay(1000);
> 
> Any reason we cannot do it in a single mdelay() invocation?
> 
> mdelay() already is a loop around udelay on larger values IIUC.

No good reasons ;)
I just wanted to prevent a totally theoretical overflow (if cma_dma_timeout_sec was made configurable;
I also anticipated someone might want to add some progress printks into the cycle (without verifying if
that's even possible in this context).

If you want, I have no problem changing this to:
+	mdelay(cma_dma_timeout_sec * 1000); 

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


