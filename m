Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387BBC282EC
	for <kexec@archiver.kernel.org>; Tue, 11 Mar 2025 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=; b=fPcvuQWRu9/blRh8IK/MD/8jC8
	+tAbUS31klRI3TYmHdPBtvORCehTbA4SPIOTiE/XoyDE2UrqoS94IPWIIrD6O3qqLoda02rH9h0xJ
	WYxa/7FHTcEGgm9zjvsGrsMxbwN0jXDkcujA/CvA/wN0W+SPfAPkejNm3N9rUmyZtynQYL204X9Jl
	ZiS5EUsCCPO725kBRl+dXHEmo93JIVnHG82P9wSs9PCSXGcVQKzGrYZc38wdCdqd80cBSVDH/nId8
	NTzWHTza9VwVfgIjqfgr7rVU5710WCjSbvdp5mqdazCfs+kpLsxQ16vIWYYO3Xy9b+2ClWMBm7xTJ
	r/hyjkMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tryHi-00000005Y7n-00hr;
	Tue, 11 Mar 2025 12:00:34 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tryHf-00000005Y76-1AOa
	for kexec@lists.infradead.org;
	Tue, 11 Mar 2025 12:00:32 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1060D2117D;
	Tue, 11 Mar 2025 12:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741694428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=vBIeQqR9gJGCprOzJvE8U38YdIcTjjSKjKx09YIiqEc/VFCj9oVYGWtFbhuR4MYobQeV0S
	vKZr050O4csrIn3QPrZq7p1YmnnRN4jKmUMSH/G7c2vPNlK5dg+GTYwkmf7tFvrYKO9I+u
	reom673AlFCk5A5fEmKBatc4hkPySj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741694428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=kuoDrVEno3+Qe8velVwmuLL+SaoaDe8p6or5q+nTiq/09nKhZYx0xK2CpQ9Mtz1Iza+NhR
	XsfLA47NwE4U3xBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741694428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=vBIeQqR9gJGCprOzJvE8U38YdIcTjjSKjKx09YIiqEc/VFCj9oVYGWtFbhuR4MYobQeV0S
	vKZr050O4csrIn3QPrZq7p1YmnnRN4jKmUMSH/G7c2vPNlK5dg+GTYwkmf7tFvrYKO9I+u
	reom673AlFCk5A5fEmKBatc4hkPySj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741694428;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WkA39bFX3GqqFALG3OsmUN05f4JXXHMUC4Yp+Z/J4=;
	b=kuoDrVEno3+Qe8velVwmuLL+SaoaDe8p6or5q+nTiq/09nKhZYx0xK2CpQ9Mtz1Iza+NhR
	XsfLA47NwE4U3xBA==
Date: Tue, 11 Mar 2025 13:00:28 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v2 4/5] kdump: wait for DMA to finish when using CMA
Message-ID: <Z9Al3DI_PsWPN83k@dwarf.suse.cz>
References: <Z7dc9Cd8KX3b_brB@dwarf.suse.cz>
 <Z7demEmgm-D_fqi2@dwarf.suse.cz>
 <Z8UNvvEF2Ow/qigk@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8UNvvEF2Ow/qigk@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_050031_491956_1674C564 
X-CRM114-Status: GOOD (  14.16  )
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

On Mon, Mar 03, 2025 at 10:02:38AM +0800, Baoquan He wrote:
> On 02/20/25 at 05:55pm, Jiri Bohac wrote:
> > +static void crash_cma_clear_pending_dma(void)
> > +{
> > +	if (!crashk_cma_cnt)
> > +		return;
> > +
> > +	mdelay(CMA_DMA_TIMEOUT_MSEC);
> > +}
> > +
> >  /*
> >   * No panic_cpu check version of crash_kexec().  This function is called
> >   * only when panic_cpu holds the current CPU number; this is the only CPU
> > @@ -116,6 +125,7 @@ void __noclone __crash_kexec(struct pt_regs *regs)
> >  		if (kexec_crash_image) {
> >  			struct pt_regs fixed_regs;
> >  
> > +			crash_cma_clear_pending_dma();
> 
> This could be too ideal, I am not sure if it's a good way. When crash
> triggered, we need do the urgent and necessary thing as soon as
> possible, then shutdown all CPU to avoid further damage. This one second
> of waiting could give the strayed system too much time. My personal
> opinion.

Good point! I think it makes sense to move the call to crash_cma_clear_pending_dma()
past the call of machine_crash_shutdown where all the shutdown
happens, like this:

> >  			crash_setup_regs(&fixed_regs, regs);
> >  			crash_save_vmcoreinfo();
> >  			machine_crash_shutdown(&fixed_regs);

+			crash_cma_clear_pending_dma();

I'll post a v3 with this change included.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


