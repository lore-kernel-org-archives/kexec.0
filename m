Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536C9CCA476
	for <kexec@archiver.kernel.org>; Tue,  7 Oct 2025 09:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=; b=l/bjLy9NMfrRgPBbD0NMBzkO5C
	M+ybDUwckR2Khd3rFeqkG5paGpoF9oD7B51OoJT/++xDofry8NHKPhIh4eSjHzrv3nxaUGP/fssSe
	dHANx2PaVXUwkJtuxeDGSm4azuwNp1rxNeJdheKBuOAPL2SdDLEwqShRShPbdY7v5Fi1UIwuBozeV
	14QEKl9WLnbUNWYEKzyulzNchR1w6oFJaYeRoCGlj3ZLzzeDBzLUmjJBAPn4JFtkhhuMl3a9QlCP7
	Q3QNuWvl5N1KxDx0woF55dyHsJhXeR/anZsgc23g2meHCWaMhsbk1AnZsKdn6QcdIopDDENPI37pI
	II7crGCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63jb-00000001gPc-0imr;
	Tue, 07 Oct 2025 09:11:51 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63jX-00000001gOU-0ZGI
	for kexec@lists.infradead.org;
	Tue, 07 Oct 2025 09:11:48 +0000
Received: from localhost (unknown [10.100.12.32])
	by smtp-out1.suse.de (Postfix) with ESMTP id E2F5B336F3;
	Tue,  7 Oct 2025 09:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759828303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=ljO1R0bBwHZiKasEy6MhvQCSGMlm4+xEKkcMA41IC56HN4tKhzzPOFm+eTkjrQzqilrVK3
	UC/yHR6APtQGnjhomDeck1bgfmzaVQmrry8QRd0kPAGBVcwOP8DGrFPGvbqISCnAjhGulb
	rNU4Uie76wFo5+5DZz5J1iEYpTP2aB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759828303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=BxvMRXFMc97Quk4/ZugYs8ialO0F/RJfEsI5Q5x9B6YX01gaJ6jzvuX/oaR8uw2O4xZmKE
	tgpgxhSKqSLMDnBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759828302; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=axDO3gJNswuZeSVfGNwO0ejXnMY06seTp6gjJMbJxdhX3zGYuYB+jGZzlZM9q38syn3Fsu
	PTTnLxfztDzoPNnl44gYiGimfP+ZKAa3Xa3bFoFZkLbFgvafB+E9gjyLbj6iSWDxovtWEu
	5ZB1LFMsTFU1K4kTHxrCz0+chEO9V9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759828302;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yLP+glegqIJBcIb7jt0bclmibbjRxFmE8iklM/lj5FI=;
	b=PFqMaes1rrVopcuRe9tYuxzoLI7wyEtAd2Tb16TNVlhte9BwGzUA/0Q8CyM/FJdYAMDYMS
	W9iYjQfFKU399tBA==
Date: Tue, 7 Oct 2025 11:11:42 +0200
From: Jiri Bohac <jbohac@suse.cz>
To: Baoquan He <bhe@redhat.com>
Cc: David Hildenbrand <dhildenb@redhat.com>,
	Breno Leitao <leitao@debian.org>, kas@kernel.org, riel@surriel.com,
	vbabka@suse.cz, nphamcs@gmail.com, Vivek Goyal <vgoyal@redhat.com>,
	Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
	akpm@linux-foundation.org, Philipp Rudo <prudo@redhat.com>,
	Donald Dutile <ddutile@redhat.com>, Pingfan Liu <piliu@redhat.com>,
	Tao Liu <ltao@redhat.com>, linux-kernel@vger.kernel.org,
	Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH v5 0/5] kdump: crashkernel reservation from CMA
Message-ID: <aOTZTji039KEJ1T0@dwarf.suse.cz>
References: <aEqnxxfLZMllMC8I@dwarf.suse.cz>
 <vojlxf5pelxlr6omsfsccd4e4cdzn5qyxpgiqajorkgmgd7ruh@e5wwhkmvntpb>
 <26ae6b04-3beb-47e9-9639-b081003dc9bb@redhat.com>
 <f7x2flir2c5zpkusgiyk7qnrdqo4dek3iksyldw6w22r55s4vy@4b47lrcv3fag>
 <2e35b6dd-56dd-47e6-8dac-54f446f763f0@redhat.com>
 <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOSO/e68pZ7FGKm1@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_ZERO(0.00)[0];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_CC(0.00)[redhat.com,debian.org,kernel.org,surriel.com,suse.cz,gmail.com,lists.infradead.org,linux-foundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_021147_321251_18717808 
X-CRM114-Status: UNSURE (   5.17  )
X-CRM114-Notice: Please train this message.
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

On Tue, Oct 07, 2025 at 11:55:36AM +0800, Baoquan He wrote:
> And I saw Jiri has excluded the crashk_cma_ranges[] from the dumped
> content via elf_header_exclude_ranges(). 

Exactly, thanks for pointing this out, while I was away from my e-mail.

The crashkernel CMA reservation ranges will not be seen at all by
makedumpfile.

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


