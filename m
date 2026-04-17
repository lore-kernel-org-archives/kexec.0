Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFA9F99C61
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9mDgag3heI0Xq6cOwTzAN2kLoPD+3ToO9Xg13RSbuGo=; b=kCbbjIUJs54+s51xemKQWckw46
	oItewxaqDySSnAKTDHq6b2m8EophXOKV5ecgLB5zqLgDrCZD0iy9X8XE1JVJJSfEcVCrUgSaRQ5BH
	AhJ8fV5WYF9UAlcBFMh7l54z9EKcmSKzcg0WJGTtDXwQ5FngAhDcYC17a+AJO6PDInAnG+QXBPaYH
	VqghnGodg4IKKo9jQoIoJL7ObTOrYutkOTe1RJDOSoqFAHXmi4tyFEeRlvjDxLI5zcHXARxDVMj+J
	A/S4UvELoAu22fD+d7uyphMM7DlClHuCWngj3Yn7EJFY/OcaGye1ty9LhCBtKlCvR9Dp0FVcCxZ0y
	1ywaii2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDpt9-00000004SHr-1QxC;
	Fri, 17 Apr 2026 20:34:07 +0000
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDpt6-00000004SHV-2Puy
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 20:34:06 +0000
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-8a093c784b0so14860026d6.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776458042; x=1777062842; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9mDgag3heI0Xq6cOwTzAN2kLoPD+3ToO9Xg13RSbuGo=;
        b=gRgc+m25M3CyWmYCOmPUcUfzHsOOHlXheiSkIXhA4K+gKsQCXI8omEZCj/gKFGlBQB
         vvdix+f3ztux2y3shTWl47ObTVyNeaHnsYYyJy9VaPf93+Wc/B55zg1ST+WRkzl+5Em6
         neHAOqINk8m0bSZNTI2BLL85fAzAgjRoIS9R4REowI70cIfaKr124zgHqfefMnN1cKzz
         WOlEGGhxEYCeWC1fvwrkGl7M5LjpQhYsApTA460WLWI9/w0A4Pmj4oYHzXUBU8z1x08H
         TR1Up+o0BHgI4UyIhHCT0Wm+AKY2nyactRsmlA8ZfzPsG00gXS8pxhzFB+F2P0ag8hqH
         FPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776458042; x=1777062842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mDgag3heI0Xq6cOwTzAN2kLoPD+3ToO9Xg13RSbuGo=;
        b=Mg4DXzqw0dCWVm+f59+Hyst2MfETJ/Av5xKUg5Ayd1kPcFnmU/88dgijVXo6+Gesdz
         KioBX95ZVaJsDiwLugfHhm45z6vu6Oudq6s36nCKHnbg0hoXC/1cZViwKPa0UOFJRAmW
         si+orXrTk5lHsRS8K2bkODRLB3XxEsORPEW74xdPvPopUOlr7nxE8hwuSDzKsA/iX9uo
         W3/iAV6Zd38aOjrkoKXPLZvK9jvRMOkyvUHV0vBI+6oUYasseuAMyRKkR+DAT2YOFKvU
         VfHg7nx2huyC/Ut4GFp7954Ou11jPu5POwVO7dlFS4xyqkqrMBiKG/sHUjAwSP4UrEfQ
         ULmg==
X-Gm-Message-State: AOJu0Yx2uNAM1V3V27b2SfgKXhnuQfmTu5e68KQZOxSUv88CrQkcKqIT
	sh1JNuRtuuEzEQvfJ3YvtpFphea0eoD+bTljQCgHensy0Oq7T/RExGcKS78ntTGCxbE=
X-Gm-Gg: AeBDiesl3eIUPP8GAz5zsA4s8W7ibZMUUhLEwUgRM+mLpZMTqR/mBrmCvhtiEnK+Bb2
	g7IgwyUYFEf7WeDN58PpCps/Dvb2z8xk98mRokEj4ntVpuQTV8NAEJdD/lhQWUWgXxeo2bqtNPZ
	zYvvzbg0sdhufsVsp6GtbNQEwJ+SL30A1uVF31kIesq3as/d6dzCiJREYnB2TPuHWm29v7MpysW
	UUc4Brr1hPHe/t2k94fAvC/GhzIRRdGyO65PMqp7UjbWg7BlBqZfHiejn2TJCUpIS3kWdXK4Jbn
	QmxGBtoNZ2uR7uEmKCWH4R1nuA99axoRWrHzWGnVP0ZULJBdokHm7s+lxnJMuZhSz8hTQ+m5RbU
	WrDkZ/9C3OAQ1DE2sWodRLHi5gsmYyV3mLMvXUGksEzGFmam2pkeCEXl3DpRuMByJ5zYrvAOZt1
	zT5+bgDVYh5wvrEGm/kaUFU6XFiZZeoYHZADtUPegmkP2eyB/ECd8W5OKsQAt5R2IfRK3Zqcg=
X-Received: by 2002:a05:6214:41a0:b0:89c:c2e7:97ad with SMTP id 6a1803df08f44-8b028160e4cmr75574666d6.43.1776458042456;
        Fri, 17 Apr 2026 13:34:02 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aea639fsm17884176d6.45.2026.04.17.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 13:34:02 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:34:00 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pratyush@kernel.org, brauner@kernel.org
Subject: Re: [PATCH v2] liveupdate: add LUO_SESSION_MAGIC magic inode type
Message-ID: <3rtwn7lkj5icexyammer5limslchbkm4xdgynp5llbt3wwybnp@ikjv5si2xodg>
References: <20260417094426.1556849-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417094426.1556849-1-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_133404_677214_5C5DB990 
X-CRM114-Status: GOOD (  11.57  )
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

On 04-17 10:44, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> In userspace when managing LUO sessions we want to be able to identify
> a FD as a LUO session, in order to be able to do the special handling
> that they require in order to function as intended on kexec.
> 
> Currently this requires scraping procfs and doing string matching on
> the prefix of the dname, which is not an ideal interface.
> 
> Add a singleton inode type with a magic value, so that we can
> programmatically identify a fd as a LUO session via fstat().

Hi Luca,

The patch looks good to me, but please add a self-test to 
selftests/liveupdate/liveupdate.c to verify that the fstat interface works 
as expected.

Pasha

