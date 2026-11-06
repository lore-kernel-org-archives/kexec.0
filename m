Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23177606A332
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DOYkHKMC;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pvRI/D8R;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AzVXIHVV;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=pvRI/D8R;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AzVXIHVV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DbWVk74jXjpvpjgKYrK4/CAQhS2u1tHZBMZnBzvHIS8=; b=DOYkHKMCJPVLvADw2nJkEvIJOA
	Mn7gGlbQBw8jeBgYs2pp5MeUUAfEAATrtAAbFQuNnddjI70vJ5QFvytAoYMvGFz4NB1JaF99n4nTU
	FGW/ruF7xS5Mu688Y/v4Pc4FX68X7F4sslMHqL92WBmR1zZvq+DSYAJ9f30zglhVTT4csa/K2wZgQ
	kk+qTm9/NM8Aa52gRXC0RPD0BjLOYMylCTjjBnDSc7EGyiySWDZfQjfRSi68z3GoFwWDYX1Hc9IDx
	7CwSFjQEZWVfDWL+csieQ6zMx2rkgxOs68AGxze11ROp7bYt/6zZtxETAJwkdqfHrHow5NKFse9V/
	++V48x3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKhY-0000000CcCJ-3SzY;
	Fri, 06 Nov 2026 14:13:56 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKhV-0000000CcB4-47tK
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:13:55 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A268E22130;
	Fri,  6 Nov 2026 14:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793974430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbWVk74jXjpvpjgKYrK4/CAQhS2u1tHZBMZnBzvHIS8=;
	b=pvRI/D8RopcbFtgNPfW+iZ2eH21pmmfyjNXaTBk2vE1ikaUyi5ZiBfpUI9DBHxSg056LZ/
	bgaYzzIfmdjyGKdvkKYDTONndhOEEdBNMQoBgWoZ/a8TN+unCtfVpYKTENumVFgNiyx8PU
	jzG6MUyNuwxCdK8tH73YdFpwQlrjj68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793974430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbWVk74jXjpvpjgKYrK4/CAQhS2u1tHZBMZnBzvHIS8=;
	b=AzVXIHVVE8uagLfECKc27F9aiHHqwykOgSHiYeP032HqnsmkIBLN0HR+sxphwH+ZhZ+jLJ
	ogoAPHclIxaMcyCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793974430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbWVk74jXjpvpjgKYrK4/CAQhS2u1tHZBMZnBzvHIS8=;
	b=pvRI/D8RopcbFtgNPfW+iZ2eH21pmmfyjNXaTBk2vE1ikaUyi5ZiBfpUI9DBHxSg056LZ/
	bgaYzzIfmdjyGKdvkKYDTONndhOEEdBNMQoBgWoZ/a8TN+unCtfVpYKTENumVFgNiyx8PU
	jzG6MUyNuwxCdK8tH73YdFpwQlrjj68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793974430;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DbWVk74jXjpvpjgKYrK4/CAQhS2u1tHZBMZnBzvHIS8=;
	b=AzVXIHVVE8uagLfECKc27F9aiHHqwykOgSHiYeP032HqnsmkIBLN0HR+sxphwH+ZhZ+jLJ
	ogoAPHclIxaMcyCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AC9C134E9;
	Fri,  6 Nov 2026 14:13:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ao+wFZ7g7WoTZAAAD6G6ig
	(envelope-from <jbohac@suse.cz>); Fri, 06 Nov 2026 14:13:50 +0000
Date: Fri, 6 Nov 2026 15:13:50 +0100
From: Jiri Bohac <jbohac@suse.cz>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Give crashkernel CMA areas unique names
Message-ID: <au3gnsckVTK6tUs5@dwarf.suse.cz>
References: <20261106104309.3669583-1-zaslonko@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106104309.3669583-1-zaslonko@linux.ibm.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_061354_196908_51121314 
X-CRM114-Status: GOOD (  15.20  )
X-Spam-Score: -4.4 (----)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 11:43:09AM +0100, Mikhail Zaslonko wrote:
> reserve_crashkernel_cma() names every CMA area it reserves
> "crashkernel". If the requested size can't be reserved in one piece,
> it falls back to several smaller areas, all with the same name.
> With CONFIG_CMA_SYSFS, cma_sysfs_init() then fails to create the second
> directory:
> 
>   sysfs: cannot create duplicate filename '/kernel/mm/cma/crashkernel'
> 
> and the error path removes the sysfs entries of all CMA areas.
> 
> With CONFIG_CMA_DEBUGFS, debugfs refuses the duplicate directories as
> well:
> 
>   debugfs: 'crashkernel' already exists in 'cma'
> 
> so only the first area shows up in debugfs.
> 
> Keep the name of the first area and add the index to the others:
> crashkernel, crashkernel1, crashkernel2, ...
> 
> Fixes: ab475510e042 ("kdump: implement reserve_crashkernel_cma")
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Thanks for fixing this.

I don't think we really need the special case for crashk_cma_cnt == 0 
and that "crashkernel0" would be fine. But I don't mind either way.

Acked-by: Jiri Bohac <jbohac@suse.cz>

-- 
Jiri Bohac <jbohac@suse.cz>
SUSE Labs, Prague, Czechia


