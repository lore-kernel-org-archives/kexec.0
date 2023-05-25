Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD2CC7EE29
	for <kexec@archiver.kernel.org>; Thu, 25 May 2023 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ysnlMCeAI8+A/dEYDZJUDzV+2m6G/BaYgjbs1TIUwQQ=; b=rUVkvzzCJkEo1W
	Vuh6XgajX2oo1MXCReiAXuY/IXVg9BMyOwUVArw+Sl0rIDhD/AhaKb6EP2OYUXhmYR1l1ivTiDr+o
	eB8kghTB3dFndgjA/Fz8Vmlu5uE7Ox8kzU6lSeSr7/AaSB9iwOUm7Rh26QdSs7uVxtyucbE2cwyp9
	fTY9bQ21ottXGqGWrt3Qbv+2penlTUl07XGKwub13Cny7L4zU9GgWqBX9kxcI+lw/xptCXj78DkZZ
	l07XKGUPJWno29Pa4i2cegcd2NbMvoqLH5apHvtMbNWIuy4hxHN5pMWSpC2GYFgKPt0+B7t1uJpd7
	I/8G3N0nWZQZJeaLC23Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q29wF-00GbOs-2s;
	Thu, 25 May 2023 12:19:27 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q29wD-00GbNg-2B
	for kexec@lists.infradead.org;
	Thu, 25 May 2023 12:19:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DFE11FE56;
	Thu, 25 May 2023 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1685017164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nY73Ob7i9/yszN4HxG34KoA67z+MTS83xA9FlnqxOvk=;
	b=1VUxox0NDiJaPMB2SjrAkEBNzxU3Qk/uwOorE1RBIN9XCysvFJiV//9Q+i6uaI3DPufqYD
	zUnOqRRd85+c32qiYXm5F6UHzSykAAxCv3jAv1MX9J7dKjhhwmFRcETc6xJpiXlp56CpvD
	Lo0L4MMCrwh4Ob18X74fg4r5Oe5oH5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1685017164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nY73Ob7i9/yszN4HxG34KoA67z+MTS83xA9FlnqxOvk=;
	b=zupC0LSZ4V0QDdBF3Eoluoogja4JzNZ9eQbfmfXh+x7Bh4GCLDR6FOlRfCrZwVVSLEVHFP
	SjGTVeXzpXVPuUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D738134B2;
	Thu, 25 May 2023 12:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id asXNFkxSb2TTMAAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 25 May 2023 12:19:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CD528A075C; Thu, 25 May 2023 14:19:23 +0200 (CEST)
Date: Thu, 25 May 2023 14:19:23 +0200
From: Jan Kara <jack@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <20230525121923.ckj7hkaqonuyq447@quack3>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230508011717.4034511-3-mcgrof@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_051925_867804_10D5B806 
X-CRM114-Status: GOOD (  12.86  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Sun 07-05-23 18:17:13, Luis Chamberlain wrote:
> Provide helpers so that we can check a superblock frozen state.
> This will make subsequent changes easier to read. This makes
> no functional changes.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Just noticed one nit...

> diff --git a/fs/super.c b/fs/super.c
> index 0e9d48846684..46c6475fc765 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -905,7 +905,7 @@ int reconfigure_super(struct fs_context *fc)
>  
>  	if (fc->sb_flags_mask & ~MS_RMT_MASK)
>  		return -EINVAL;
> -	if (sb->s_writers.frozen != SB_UNFROZEN)
> +	if (!(sb_is_unfrozen(sb)))
             ^ unneeded parenthesis here

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
