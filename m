Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EE3CA0FE8
	for <kexec@archiver.kernel.org>; Sat, 23 Aug 2025 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=; b=oVyJhBCktTKul2oWM4H09pScwk
	reBY13lFAdufanGREJXW0jYWJQ/01w91enF1HTmDyNnZPe/L8NWyMm0OXH2SpkxS7DL6p5lMf/pEi
	Y+w3i8hnYmnTJRwwGjKC3y4KvGIAEs9aeNB3yatFAY5GhEC9luxUKcjZwHgF0iIlaBT2bT18NARip
	cqJr9uWqcz56ZQ7ma65a7W2FyEhTWlxomGTSFlY/W6ZyjITxmygt+jzj5GJFZrOOACahWXtWXnd+u
	Id5nI8p2+s4Rb52IwsC4MeBV4J5yeuXcf/sSX+NksAdhmx3upukMWXv3AjwBshbJwjCapTCuD/lcR
	UX7IFUMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upjTR-00000004KiG-3uyo;
	Sat, 23 Aug 2025 08:19:41 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upXhX-00000003Ol4-2eKj
	for kexec@lists.infradead.org;
	Fri, 22 Aug 2025 19:45:28 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out2.suse.de (Postfix) with ESMTP id 3DB4D1F385;
	Fri, 22 Aug 2025 19:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755891924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=ykmiMHXHLywLlKWjovo3wMuBcC9OjXvHVvce6gInHppO160d3pLS8/SrRRVF2S7uBCIXZN
	/TDKK3Q3LH4qHUP/InW/qwRBfjzf10szxomjSTez2KQEBXU/yRASH8URciJUpoWKqvaIU9
	hZh3j9+o9t62Cqm/Oy7tkjVudO1R490=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755891924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=8ObR4LnmFAY8qgrZNVVRXc4AEdVPIGwSTKlkycqJmnmTzBuvxefddvHRRHQOmQ2eY9lApm
	nVuNuXMXx5Ks2kCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755891923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=HSCqIWowAoEW7W7H1kg1QIz7YOTX/lPZC25EHLFYieanmwvbLgcy6AszKq9p7q/T6Yzsat
	2JYYFEDJ8T0Q/6lh62t5zPQC+RQ1qoZLTJWBeLDnERceL+gq+TFb7QbASvEaLm91a+PuvR
	ba6H09xtFcOLml5bcZqCaCtDkatCw/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755891923;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M5BMf9ITNHHswVF8PEaR4ndhiHkQMiVdrHDz6mV2kqc=;
	b=5IvjwtjPKRJF0QEu+8kUY7OpVwMJF+lH0M7tM2br3TvUvgU/iAMHD58k5fjc0nxbJtDw2g
	r/YyEoscsNhZcLBQ==
Date: Fri, 22 Aug 2025 21:45:23 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Breno Leitao <leitao@debian.org>
Cc: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	David Hildenbrand <dhildenb@redhat.com>,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aKjI0wcPDXH5mYcL@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <airxp44zdyxskfwrhhveis7gd2vsz5m4f3ipidsghi2x55h64c@s37v5rkuoega>
 <aKX1vbE5jWVUr298@dwarf.suse.cz>
 <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <lofhq3bgtl2bcbrbkgctyyg2gl7ef2naqdrplyb37jyde2xoeh@twcwhwthnzxd>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.983];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost:helo,suse.cz:email,dwarf.suse.cz:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_124527_813328_5232EA75 
X-CRM114-Status: GOOD (  16.40  )
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

On Thu, Aug 21, 2025 at 01:35:35AM -0700, Breno Leitao wrote:
> I have another question. I assume it’s not possible to allocate only the
> CMA crashkernel area for the kdump kernel, since we need to keep the
> loaded kernel in the crashkernel area while the system is running.
> Therefore, specifying crashkernel=X (without ',cma') is necessary.

exactly

> At the same time, since the crashdump environment will use CMA, the
> crashkernel area itself doesn’t need to be very large, as the CMA space
> will be allocated later.
> 
> With that in mind, how do I find what is the recommended size for the
> crashkernel area, assuming the CMA area will be more than sufficient at
> runtime?
>
> Does it need ot be much higher than the size of kdump kernel and initrd?

I don't have a good answer now - I have this on my to-do list
and I need to investigate this more to come up with a formula to
calculate the required size to include this in the kdump tool I
maintain for SUSE. 

When testing the kernel part I used 
crashkernel=100M crashkernel=XXX,cma on a machine that would
normally require something like crashkernel=430M.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


