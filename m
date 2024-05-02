Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BE5C4345F
	for <kexec@archiver.kernel.org>; Thu,  2 May 2024 22:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RBrh+cBkQxbnocfLYjt+ze2MnMBIb2gzD5W1GRfsbZE=; b=kbSRqATTga0vwl
	1+giRAmKrOajQPrQ/sh93wV6sZVX+VSUWtdiyCQOvJyJTN3Rmi7ollcpJvhP39UnWopn9K9zHARWx
	rmZ8XirMcLl0ZI8g+ssJbVfqeM4rWLUYVK4+8giGeHRTtqPsu5kHIEcDtzQIOnQ33ttjcwPqKbRMv
	zO8olfANHDvkJs3vx+qN4FyRQimoJA/lX842MeYYGQz/6g8D1IeND2sCSkobnR4gRI0J0Y+7/6Wbi
	Nmvd670M07NqtPJ5SlXH6xBk8vR/OxZQSEm8WXKv8dCh1ak8Mwsqc1aO2bOy0X4pWHNVQ0kxNlQMr
	0CAWza+7irZN2ZPPALvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2fMq-0000000EBHL-23ax;
	Thu, 02 May 2024 22:57:32 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2fMl-0000000EBGD-0JDj
	for kexec@lists.infradead.org;
	Thu, 02 May 2024 22:57:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BA8521B6D;
	Thu,  2 May 2024 22:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=vXFR8b+47fVienxCNHPpZEgaFl8IRR1Mv71xdUtU2622Csxiucd04oEJVudXAF/3dZZNOL
	5qNcdcB9sSojwmpUriiCZRok+GGh4OGmhrQ7fE2dhTP1etELCXv80VumvTxLCy0EOxtpo/
	H8bcJ9lxrkFjfxAvCydRKS1OSGHKjno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=HNqahZD0v59hLZv9836klkwGH5Zx+9048K1YzBWruiSenefzAMz0+ei9HFfuJv8vmMbSVh
	rve/oT7LivploiAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vXFR8b+4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HNqahZD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=vXFR8b+47fVienxCNHPpZEgaFl8IRR1Mv71xdUtU2622Csxiucd04oEJVudXAF/3dZZNOL
	5qNcdcB9sSojwmpUriiCZRok+GGh4OGmhrQ7fE2dhTP1etELCXv80VumvTxLCy0EOxtpo/
	H8bcJ9lxrkFjfxAvCydRKS1OSGHKjno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714690642;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzZUXDPV0PB0GLA7qoIAy85H9S+PZoQXohv8tj76ZUE=;
	b=HNqahZD0v59hLZv9836klkwGH5Zx+9048K1YzBWruiSenefzAMz0+ei9HFfuJv8vmMbSVh
	rve/oT7LivploiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D3EC1386E;
	Thu,  2 May 2024 22:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XE/sClIaNGauegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 22:57:22 +0000
Date: Fri, 3 May 2024 00:50:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Baoquan He <bhe@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH 1/4] btrfs: Remove duplicate included header
Message-ID: <20240502225006.GU2585@suse.cz>
References: <20240502212631.110175-1-thorsten.blum@toblux.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240502212631.110175-1-thorsten.blum@toblux.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.17 / 50.00];
	BAYES_HAM(-2.96)[99.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,toxicpanda.com,suse.com,redhat.com,kernel.org,szeredi.hu,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 4BA8521B6D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240502_155727_286490_7ACF8DDC 
X-CRM114-Status: UNSURE (   7.33  )
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
Reply-To: dsterba@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, May 02, 2024 at 11:26:28PM +0200, Thorsten Blum wrote:
> Remove duplicate included header file linux/blkdev.h
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Added to for-next, thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
