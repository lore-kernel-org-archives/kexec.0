Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 122FFCD6E5D
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 02:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y3awZDWC/0BEHXSInI6v/h4g63e1F9fJCkxQA7vD56Q=; b=4CxFKVMr6tZEDUcWk86tuZe9Fx
	NMqsOzbXJWd/UoPaSPf9tNsJLHD08BmjR8cegFXZ+JIRYHPqv6oPVzVtmqYmbZszVBCQwGIyvqrcd
	ceWNp1NwzCShTSPI4/MXz7+ToKiiPfxU8b/7TPs4zMHciMFB1JINp48MH7+kclxoj3tC01fhynJP0
	Vq4L0g0HNlDNtNzSWOoFmSbiiOLqhzE8naE/aM1UgiTxqTtavdBzeMiByCXxLG8AhiyRmNzeBn1aS
	AygaVtuNgS8jmbHDSlHrhNgbOQRL65PYCBFtGle+Rme3fiXnjYWXFFcb4tDGDU100gjTw0STLTb21
	TXCHX4pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbnJ-0000000E8cu-363f;
	Wed, 03 Jun 2026 02:57:25 +0000
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUbnH-0000000E8ca-23w7
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 02:57:24 +0000
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-91562bf6c12so267778485a.2
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 19:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780455442; x=1781060242; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y3awZDWC/0BEHXSInI6v/h4g63e1F9fJCkxQA7vD56Q=;
        b=RFJlQt62IY55W9c1vGxNv8gdiOc/R+Peq8UuGgQOoPYcy/3UNDR0M8ljk5VbZMDFtd
         9YPqtG13QJ+AjU3SCR1YSDqw8VaVp4AiMWiz2pLI0u2f3uWTF389b7n7wbyEGhxQfRUc
         aYdx0WlzsouSSOnWr/YD+LPJBjpOmFs/SV2Kjt4LwbVneUrcHZWPxq4VFRVfdsbKx7g3
         x58YCinK4wt4OIsusJ/mx4JJmUuX3itKCH+wcCe8I5uCWsNj5/zBJLo16MY1EJsZKXog
         ZX/YbH/UUP1M6n4GJ8a6nmxPt//6ecA1VdDDHFF4EeB3lz7qMD+ByuruOgT00X38YSWh
         8HnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780455442; x=1781060242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3awZDWC/0BEHXSInI6v/h4g63e1F9fJCkxQA7vD56Q=;
        b=KbfKEF61DY9E5yspGuSDlhGlZ1mmh0ilHL0A2vD7H0kpr+PJdIBxlHf/elphU79vaQ
         AI8FMQaxekFYsGO7mFxLvPxr8j2O02FsasvHX6bImzqwQGgc5Ng16L1Ie9hNZfYUE2gG
         doqj3OAEfz1zDedr9Vz4u58CPuKntwnLow0cXJj7H0pXdDhe3639W9Jb6/a5foUqSh0k
         jX9cHzE1kry9btnGYepf3rebLWurEI9Z/Qt7GD+Lptgjh9+HTPfxB9jcZ32AlUmuhNse
         7J2mDCCsRs8Xit2e2qqMe7A4WkNVNctuUp4TCQYhozjlNfKcCULf5T1z59kWgpo54Oxy
         pI8g==
X-Forwarded-Encrypted: i=1; AFNElJ8SOkL7Y5a3xCf5Cn2cX+L4wScFVC5mmgNFyWNsuIGKbYbHotcqxwn0Eb0kegLYtattQ0c61Q==@lists.infradead.org
X-Gm-Message-State: AOJu0YytG1G2eO3ewTMBRIWSl82AjQC2Mb+YcIM3Y8L/2iLG6GHKAkuz
	pGbgtyRtfL5sk9O94rSODSyuX2Rn4yrb+D0xtAV20s5dVelfB7EYgaB/vcQhEEgxQy0=
X-Gm-Gg: Acq92OEmO/O3ousEIe+NNwJocpGng9dMlSGvGCDNHt4JJSbtazGXxsicm1SLsOsjqWC
	8kjZly364Qmw4Kler8P7422Q6gcY9KzFUVmXZqBBVqNAiFb1f1pL6arWFlmiCmJkEDDuInX4SA/
	TzXXW9x01p1kENfgryFMH75xQZ6BuCiIc1c+RO55ZRbxHcCz9P58jJqM3bO2Y4JTlqARnpq8AFm
	CCDauezTJrHynGYaPMXZdBnRGWI/52AfeZA4uMTy86jFFJWakN2gW7HLbAGQsqGjFn1EmxTbgfe
	wWMpPJSeEoWW3MQYHFy7uhX8CrfZGg9iBYMtZnx6NWRGpJljKrZTcrKSz/OflNg6JTBtP/eCtNK
	O0Y1/vGbJYdAbSDGogWwiNwrvb5eB34CbNvuvwjnRihiaiurc6fGsNSIHNC/WiuE4eOzxoVg/J/
	1UJwbNSB2Co4Eb14r0cPqknBR8rXutMfbowIdeDISuoYUQkQH6I6o3yLsEHby5yg==
X-Received: by 2002:a05:620a:3199:b0:915:86c6:8432 with SMTP id af79cd13be357-9158a6979f0mr317963585a.14.1780455442182;
        Tue, 02 Jun 2026 19:57:22 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a37bae6sm118824085a.31.2026.06.02.19.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 19:57:21 -0700 (PDT)
Date: Wed, 3 Jun 2026 02:57:19 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 03/13] liveupdate: centralize state management into
 struct luo_ser
Message-ID: <ah-Wov2fvjYbpjHX@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-4-pasha.tatashin@soleen.com>
 <178038801487.119771.6308607614059754603.b4-review@b4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178038801487.119771.6308607614059754603.b4-review@b4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_195723_538658_039226A7 
X-CRM114-Status: GOOD (  14.09  )
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

On 06-02 11:13, Mike Rapoport wrote:
> On Sat, 30 May 2026 22:19:28 +0000, Pasha Tatashin <pasha.tatashin@soleen.com> wrote:
> > diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> > index 8f5c5dd01cd0..c8dd30b41238 100644
> > --- a/kernel/liveupdate/luo_flb.c
> > +++ b/kernel/liveupdate/luo_flb.c
> > @@ -579,53 +565,18 @@ int __init luo_flb_setup_outgoing(void *fdt_out)
> > [ ... skip 18 lines ... ]
> > -	offset = fdt_subnode_offset(fdt_in, 0, LUO_FDT_FLB_NODE_NAME);
> > -	if (offset < 0) {
> > -		pr_err("Unable to get FLB node [%s]\n", LUO_FDT_FLB_NODE_NAME);
> > -
> > -		return -ENOENT;
> > +	if (flbs_pa) {
> 
> I like 
> 
> 	if (!flbs_pa)
> 		return;
> 
> more

Ok.

> 
> >
> > diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> > index 8d9201c25412..3b760fefa7b9 100644
> > --- a/kernel/liveupdate/luo_session.c
> > +++ b/kernel/liveupdate/luo_session.c
> > @@ -497,75 +494,34 @@ int luo_session_retrieve(const char *name, struct file **filep)
> > [ ... skip 58 lines ... ]
> > +	if (sessions_pa) {
> > +		header_ser = phys_to_virt(sessions_pa);
> > +		luo_session_global.incoming.header_ser = header_ser;
> > +		luo_session_global.incoming.ser = (void *)(header_ser + 1);
> > +		luo_session_global.incoming.active = true;
> >  	}
> 
> Ditto

This functions get's re-written with early return later in the serires.

> 
> -- 
> Sincerely yours,
> Mike.
> 

