Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CE9C77B7F
	for <kexec@archiver.kernel.org>; Fri, 12 May 2023 07:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WbeK4Zdr3O/Z6XYLtJZNIVlPrEvx4Gt77mq1/Z/ojY4=; b=ByKsrtKlAFM3Lv
	1dwhm5WR9ul7QjZirIhEx3xR1x7oKdXOqjqVgIZCWVC0sZ4j3+ExLBDGNzzhzQYxCdNGslC/bPC/d
	ODpq20SPRRF/5jJSAfrEHN9wIWnKBLFNFTYpq2C/rD7pIhJYwrp7ITw8BVkO0WtOCF0ymhYFeb3b0
	pdZwpi6RU93M6Z8enMEwkfYxqGemKiZJYZEtLM6OHMc7mEtbgwSbdX9JW9o9oBSRhE1K+Jy3QOVFb
	KdpxjRWPWDh82ho9e6iuWj1GVm5gPy20HQ3gjR5oOYCHIMF5xXtZN7+58Mgasv++gecyd3BWCF7++
	EPrrJPvxR5UNHEm30ASg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxNKw-00BDCm-33;
	Fri, 12 May 2023 07:37:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxNKu-00BDAc-0z
	for kexec@lists.infradead.org;
	Fri, 12 May 2023 07:37:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B15232026A;
	Fri, 12 May 2023 07:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1683877021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l2RcZ5OiQDlOAZwVC4wZDp7xE/KP28JMr7T0JUjHIA=;
	b=xzqi8jnuIyijNa3h3Plecfa5lXXF/5hJh89LbsnedU/pSZeIgI0SEkD7EYwfLZv325vFEn
	2mPoHGIj2uebGwWGnpLQvR6pYsqcDKys9HMg4CoP9RrvQbKJboEXY8Lz8hVPLoh9Mxf4z5
	cmeQHbPuTS+vwgn9LkqPkRuEe/f2ebM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1683877021;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3l2RcZ5OiQDlOAZwVC4wZDp7xE/KP28JMr7T0JUjHIA=;
	b=NtkLUxu2q7fOZ72b/4eRcRYWyKuW9U/jX1XOU79nKwwGAlClPStBTA2UwWxyRRGs9kOjxL
	gyunVyN4heX0joCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 253CA13499;
	Fri, 12 May 2023 07:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7gy2B53sXWTvCAAAMHmgww
	(envelope-from <dsterba@suse.cz>); Fri, 12 May 2023 07:37:01 +0000
Date: Fri, 12 May 2023 09:31:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] filesystems: start removal of the kthread freezer
Message-ID: <20230512073100.GC32559@twin.jikos.cz>
References: <20230508011927.4036707-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011927.4036707-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_003708_495176_4C07D830 
X-CRM114-Status: UNSURE (   8.52  )
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

On Sun, May 07, 2023 at 06:19:24PM -0700, Luis Chamberlain wrote:
> Here's 3 filesystems converted over to remove the kthread freezer.
> 
> Luis Chamberlain (3):
>   ext4: replace kthread freezing with auto fs freezing
>   btrfs: replace kthread freezing with auto fs freezing
>   xfs: replace kthread freezing with auto fs freezing

All patches add FS_AUTOFREEZE but I don't see it defined anywhere, it's
not in linux-next either. Also please drop the SMPL code from the
changelog, it's not necessary for such targeted change (unlike for a
tree-wide one).

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
