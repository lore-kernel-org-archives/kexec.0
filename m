Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC0DC54E65
	for <kexec@archiver.kernel.org>; Wed, 21 May 2025 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYJxRSWIj9WyqHxSTfPZjOkXna9NizDI98LlLiwmMyk=; b=2QNG3wWcgjqnXjL4ZjNiR0GEsM
	sxyKoZMbLKWgvk/ZnFxrw0Qp3w4W5KMAv2F7c2I5tenKkgU0cANlu4tPdvsJ06r0FqNl2hNgO2dE/
	8FHoPIAZ/bJqWOPiYBamGVTC3Z1AY7RMq7+eD0gBRXym03/xcvxd/ZGZ15DdYH3PrgVDmtIMLf250
	Kco8wfRXBhGTGgTrPGXzAskJt8b67XWu1ETQJX+Y58MJJNGWEwOvt6v4H1K9Y7AsE/WnseQk4R309
	CV+jSaqUsMjgcc6K2MCXefZsiLxpZUi36RSHRqdCFtOgGcPmbXaVwZHP3vFvm9XZd+RD1LluV0Tdc
	wmRielBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHfD4-0000000FDJm-0hRt;
	Wed, 21 May 2025 08:53:58 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHf8H-0000000FCe5-2iX3
	for kexec@lists.infradead.org;
	Wed, 21 May 2025 08:49:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 192BC2125A;
	Wed, 21 May 2025 08:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747817338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYJxRSWIj9WyqHxSTfPZjOkXna9NizDI98LlLiwmMyk=;
	b=IYnp7blKnCEQ+CSBUy3sB7zTf5bnWzcKXg4aN4TVqNIJKNGa1Z8gm3PwojSDjrnhIBfWpU
	xRc5vSw66F3bgraR1EQIQEOnhPCZXl3hsFIbjYbE/ymetaSBJW6yfwppvEMXOgbgHlTsEQ
	TcTrEI495qNPL4GxRfIAjfqUPNVskHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747817338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYJxRSWIj9WyqHxSTfPZjOkXna9NizDI98LlLiwmMyk=;
	b=kHeRh3wjbPyBx/6GhLlOhp239jRDYDZADrBbDO/OCDUNXOPZkjYavcQbBr2ko6WBcYaZUf
	mK4tolpeDKljPABg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="0CkkL/cY";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GRdrTkGa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747817337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYJxRSWIj9WyqHxSTfPZjOkXna9NizDI98LlLiwmMyk=;
	b=0CkkL/cYNyrA1hH6nyhrkHau7b3GUDvRZMnQgV/g+FIX9VoPpfTjJ8TY9vK9qvVC9bxwB6
	q75U7fjqLvmb79pWzZv+CabAf9FTT3VkS9CPShLlGqdPZmehKnsE3FH/DguDE3Sg037Qlj
	B/pBG3CkIb+Eyn7Qm3BWNVxZQrgG1bs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747817337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PYJxRSWIj9WyqHxSTfPZjOkXna9NizDI98LlLiwmMyk=;
	b=GRdrTkGaRD8RwdohSA6XOzmHEwc0n7KQtZBuXkisP9h9J3W/Mg/a/BsVH0u3iwi4q3MwxI
	R+JAt3pGVkBdtoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E23AE13AA0;
	Wed, 21 May 2025 08:48:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P1uLNniTLWiaNAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 21 May 2025 08:48:56 +0000
Date: Wed, 21 May 2025 10:48:55 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Changyuan Lyu <changyuanl@google.com>, akpm@linux-foundation.org,
	bhe@redhat.com, chrisl@kernel.org, graf@amazon.com,
	jasonmiu@google.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	pasha.tatashin@soleen.com
Subject: Re: [PATCH 1/2] memblock: show a warning if allocation in KHO
 scratch fails
Message-ID: <aC2TdzP1AwYrQdcW@localhost.localdomain>
References: <aCoFphqeZAMkhq51@kernel.org>
 <20250521070310.2478491-1-changyuanl@google.com>
 <aC2EE1pg9ktQdstI@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aC2EE1pg9ktQdstI@kernel.org>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 192BC2125A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_014901_831176_F881AF1F 
X-CRM114-Status: GOOD (  10.79  )
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

On Wed, May 21, 2025 at 10:43:15AM +0300, Mike Rapoport wrote:
> I think we should just make sparse_init_nid() panic or at least change 
> "sparse_init_nid: node[0] memory map backing failed. Some memory will not be available."
> to something more visible and clear. 

Panicking the system seems a bit too harsh.
Those sections will not be initialized, and sure you will lose some memory,
but still.

I think that making sure that subsection_map_init() does not access
non-initialized values is enough.
Because wrt. error message, I am not sure it can get more clear that we
failed we allocate memory to back the section and so that section will
not be activated :-)

 

-- 
Oscar Salvador
SUSE Labs

