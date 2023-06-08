Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F07C7EE25
	for <kexec@archiver.kernel.org>; Thu,  8 Jun 2023 15:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b0ZWyrZkK4rkmda782Zdry4gmyfTVw2YnOjeN8PmHoQ=; b=HF3Or7+6NgVqHI
	2aaNWJEeka0jonDG7c6PDoM3WxqnKfkleNZbeb+viJwp4i0s89cn6xfCVm90Dk6E+7/mJc8sgB5Fg
	bVTshFNHqJqAWiNjBlHk1h7qhwu7Koy6EhgKKsMXGUnjxg1xwKlq7yNx8KIR6PvBPnJGgVcr2Ep0v
	lnct+dMTEVerqOXPPvaJAgVR5zrAZ/s2FNb4SR1+CtXnSfAfjk6pzoO5wMpkCiG/L0P94OZdFg4EU
	lBYS3R5DOq8ZFL86QhvzgE1uTg8biBGQbrq7vshwI18roFzepUUR/TaU6hrhAfNJA10KRk90iT6ki
	RK6vc3++DtvOjSl56zTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7HCa-009hHy-2V;
	Thu, 08 Jun 2023 15:05:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q7HCV-009hGC-2y
	for kexec@lists.infradead.org;
	Thu, 08 Jun 2023 15:05:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC7764E58;
	Thu,  8 Jun 2023 15:05:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE35C433EF;
	Thu,  8 Jun 2023 15:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686236722;
	bh=Y/EIWGouVnlbKpC9XYTbmAdqBuIsdYRVusOwsLVQBYw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f735D9hCJ8h4t/Ej4s3fHyaVbj1J9OMDZMGWYjX0QHr2axT3FlkjlOpWwF1hHnU54
	 s1VFWP11DFwUGv621HfcPwcnnRfm+3kG4FzipGCP6tvtmrrcujAvOKsirmN5sEh94G
	 q/YfFBjv/8IBXorg7dmTTz7jqIs0RAKRgWznx8bZ4ngtdHIJan0tcN1ZypA8A/iROD
	 X7lVwXyDJX2kUF20EKbsVxSiycqL5w+2K1aXltZnpYOvGxt11XfsU0RRNwEYXB1FUP
	 9PBJgg17K4EGc/Bja2ZmOy9cdapnq55pqQNZ8Q9rdpgvypIePFXQCVggl5pLwPEasU
	 aTSTVje1en/GA==
Date: Thu, 8 Jun 2023 08:05:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, sandeen@sandeen.net,
	song@kernel.org, rafael@kernel.org, gregkh@linuxfoundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jikos@kernel.org,
	bvanassche@acm.org, ebiederm@xmission.com, mchehab@kernel.org,
	keescook@chromium.org, p.raghav@samsung.com, da.gomez@samsung.com,
	linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] fs: add frozen sb state helpers
Message-ID: <20230608150522.GD72224@frogsfrogsfrogs>
References: <20230508011717.4034511-1-mcgrof@kernel.org>
 <20230508011717.4034511-3-mcgrof@kernel.org>
 <ZIFhqk6VElD6qXBU@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZIFhqk6VElD6qXBU@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230608_080524_041513_29F362FC 
X-CRM114-Status: GOOD (  14.05  )
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

On Wed, Jun 07, 2023 at 10:05:46PM -0700, Christoph Hellwig wrote:
> On Sun, May 07, 2023 at 06:17:13PM -0700, Luis Chamberlain wrote:
> > Provide helpers so that we can check a superblock frozen state.
> > This will make subsequent changes easier to read. This makes
> > no functional changes.
> 
> I'll look at the further changes, but having frozen/unfrozen helpers
> that sound binary while we have 4 shades of gray seems rather confusing
> to me.

That was my first reaction too.

Then it occurred to me that *some* people might still be clued into that
subtlety if they happened to ask themselves why there are predicates for
_is_frozen and _is_unfrozen.

But in the end I think I decided that an enum isn't subtle like that at
all and clearly forgot to reply with that.

--D

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
