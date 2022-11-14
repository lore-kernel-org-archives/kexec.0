Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F13C433FE
	for <kexec@archiver.kernel.org>; Mon, 14 Nov 2022 15:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xa97AGKYO8Gwg5eU651xYPoCQNdJVYrVmmp+OBKw3pU=; b=KRFum+l+LzjuY8
	fIEkuy14E17mzQkX2JY+DcCkTODJIcH+pdaG6CmEqExpNdQ9t1nhWvmmnW9vHunlBsEFeSswolGum
	4GeTaR+Av4hVnpwjJLhhMhrIFkE0aNZcedcY7wK2johWBHaALhgAbTIfWLcLG49idF5APZBdSRyWw
	VianQZ65wbmEho70bjmHelFUz1dxcxZOKaSss74yBfqj6E4MtTpSdPWgCP7W9c39shM2SJ1nonxWF
	cLtnQA1EUHNpWB8DCmR1Rlbu/16BVXJXIw83QyPBetB4MGIsfcYwNpABMA4dSBA+Tcq4KmcZTi2XY
	M8eX6JUB3Q3kSCugqv6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oubZU-002JJv-4n; Mon, 14 Nov 2022 15:40:28 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oubYL-002JHz-RZ
	for kexec@lists.infradead.org; Mon, 14 Nov 2022 15:39:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id EC66BB8105D
	for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 15:39:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58813C433D6
	for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 15:39:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YHHbSmZo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1668440352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBkBwgBykfqQ+4RPvWRXFPq/+cbRK38RBj18B1Nl6wU=;
	b=YHHbSmZo/3BdFo568MdWAj2gmQ42bBjTZvl1L8wiqz6rLBKIFCvMeOUrSpTEwlzgiwDsFz
	oZbds3kxlnXSjugugiPFLy2uSjMhaZTatDw9tJQKix8GsBEhkmeH/fQbVJ+G7dsaJeYiWE
	TSRQgqCeG+LI+OK+3dYshynmYVcq80s=
Received: 	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6c0f76d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <kexec@lists.infradead.org>;
	Mon, 14 Nov 2022 15:39:12 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id j24so2906217vkk.0
        for <kexec@lists.infradead.org>; Mon, 14 Nov 2022 07:39:12 -0800 (PST)
X-Gm-Message-State: ANoB5pkrsScvYL1a9Ld3KlCA3pDfqQquf1bGOE3rmvbD/ic/LAEVM864
	vcKW8uP6eGkqimuXtc6deCUEgoZv/RxsplHX2A0=
X-Google-Smtp-Source: AA0mqf6b242IuCLyVvk1QI6aNfNb5cnEIoGsxTd/ieKi8H9nGnGpfbZoB1b6bsqXRs9BhDATBsV+d5zB3uaR2RY16Vw=
X-Received: by 2002:a05:6122:18a5:b0:3ab:2f01:7f0e with SMTP id
 bi37-20020a05612218a500b003ab2f017f0emr6659220vkb.37.1668440351836; Mon, 14
 Nov 2022 07:39:11 -0800 (PST)
MIME-Version: 1.0
References: <20221111013532.494463-1-Jason@zx2c4.com> <Y3Jfb5fUnX3skm3+@vergenet.net>
In-Reply-To: <Y3Jfb5fUnX3skm3+@vergenet.net>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 14 Nov 2022 16:39:00 +0100
X-Gmail-Original-Message-ID: <CAHmME9oMiDixKuC==sEHk3O5vfEV_67ouLjtUYQOnfSp9decxA@mail.gmail.com>
Message-ID: <CAHmME9oMiDixKuC==sEHk3O5vfEV_67ouLjtUYQOnfSp9decxA@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND kexec-tools] m68k: pass rng seed via BI_RNG_SEED
To: horms@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	kexec@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_073918_267401_A9B38FAD 
X-CRM114-Status: UNSURE (   8.71  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi Simon,

Sorry about that. Not sure why my toolchain missed it. v3 coming up.

Jason

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
