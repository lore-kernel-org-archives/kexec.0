Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB5CCD37AC
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 13:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwmcDFyZkGZV4b74fZllhwzC8fV4uJFXqCHKJqBwYe0=; b=kyhOAFJyikVPzXAQxOsj7bbqtL
	XMoLY7IAcTdRol9jjcyldLyOimcu9B8DU4f1XFInQE+vci9ErNUKPICmFpLVoy2bpiyFyjqmtsNWn
	Asj3RUhxRUKjBrBu7qa47oEeMr2E45u0KSAWU/n2j+GNcDCutcdsY9bwkV6EuuLuSDUTHrIEDgEEX
	MflwM/ms1K1ErB5WbRoNgBP+8q+xBPAuEE1rDX6FNmz6QbITjCtp9xbowuI0FMaGMUQdk3o1O8pqP
	2oJyelFCHK+Dq6O/a8gA46LJJNgaupD7PFccPWQvtdGK7ewUqkczW0Jk/bupWliQVeVaLfEXmXKgt
	J3dy5Riw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQQJ-0000000DgSh-1azY;
	Mon, 11 May 2026 13:11:51 +0000
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMQQF-0000000DgRH-449L
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 13:11:49 +0000
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-7bd5c773ef3so42246327b3.1
        for <kexec@lists.infradead.org>; Mon, 11 May 2026 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1778505105; x=1779109905; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DwmcDFyZkGZV4b74fZllhwzC8fV4uJFXqCHKJqBwYe0=;
        b=R+4pFNEIqQVxt7H9g1fs7qK/j+cxzXU3ua+6aTrx3zs55rvASzqUChsjTkbQu88Wv2
         3y3xOvAGKZjOsEmnJzojahNXxJJwAI5tx+uGOPiUzD8n8C+GIqIwcxQLfjckjikdFPLC
         WcdngOg8FgjJyGUl7juG281QlT6rUp5Bg9gxnP9aG5OUyPj4LrB7rPUZP2jpFG8VM1Zo
         j9uJ4gNE6E4JHGFqUQagioWR71661do1YLAt+s8XipcjtetTNUvh5UwjGEFJTSnIlhVc
         UC6NrmjccOgw/jDCFjALw1w+/3b4+4ljH3LSaU0HHSo49pH0cnQHVGfP8mH+nGYK+E14
         MZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778505105; x=1779109905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwmcDFyZkGZV4b74fZllhwzC8fV4uJFXqCHKJqBwYe0=;
        b=TtmtUy40KwZDEBJJUygREscdtxM/VofreJfpUQLBKQtGCBGP//MElIGw78w3FUj9DQ
         mhUiPxxLyUIcHrC/MyN4GIJeI4XiX4NwQVZ/V33kA+5Lkk+htObBHXwaVyaJ4+NZ/7SS
         wIo2LChk8qLFCfbHrl0UNZ8YPfvzepqsgNoWE2cgPigPLRyvMwQSdRxsEepQQvvvhMHP
         lyU/S53OX8KtRxEkULUV8XqEgMHScCSJ3KNBdgpeWR1szV7g+BugJwPZAd6ZFhcMLeJJ
         4OouXsj3cvW7SD71AnkNiXNF0HHRBHvn6NGinT4cFlx2su84ecqULR4sfm0trvWkxkd7
         9keQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M3uaLOfuM76pZCyC3NjRVevaTGfGmxhPRfq8lEIbHENy8K4i169XuJ1UoeRks7VT0KSYWig==@lists.infradead.org
X-Gm-Message-State: AOJu0YyP5yyvacUrIYen6HY5eRsnQSCuFXB1SlREfPIp5pNo1uGDxqiM
	YpxWFnZLNb6zUOBca3KvEWjYb97vemwN7GFm4ppFrSuP8yaqOZrkBY8r4chNQjucXVA=
X-Gm-Gg: Acq92OE2YrHrS7uS0qMeqE8YlTKBQlUIPgyjujNaei++gppwp1lSRiY22+oxUIPuVRZ
	43bFj/Gum1wGoQLjvrersiDIYeQvDooRLrbCcUtxYpOLQFPt6Xt3wZ8pUvOOlAuzXXNeoJQZB0j
	had+e94cgQPX23m+7pkwqaVDbDcWU/YIyDZwQwP/DHY5P+HBEd2VKq4YTslmlUhsbyYpdqa4Os9
	4fYOK3QVfitoTAQg84ExqNdUO9rY2rVgv0AtqzJbnK39ZXj60WV5FgDZWU+ZLp0qsBF5ZjbbZIL
	k6KYiTmJhkvURYfwpA65YMFkkW/xHL+NEMWJS7CCJkzYKDsoZQzX8lLppveWV5tmD9pd0c+D6Re
	BMWbyuHGo674i9cBPdShHj+Mgd8Woyz9OEbGsbA/dS12+kQ6DdPfSSZSw7H6bCM0DlP+H+atgP4
	R0O3JzWdsDwpQ41Oh8leW3eaOUK1ouvyWQlv9AerHt+xX9jBlU8KwZoTqp27TMeaQ0y0Ih/N88V
	LFAzy4MXFINtOgPJbgFRG1to9VAGgAWovTFU3m370o=
X-Received: by 2002:a05:690c:dd3:b0:7ba:d5fb:b543 with SMTP id 00721157ae682-7bdf5dcc7b4mr239220107b3.13.1778505104887;
        Mon, 11 May 2026 06:11:44 -0700 (PDT)
Received: from google.com (138.200.150.34.bc.googleusercontent.com. [34.150.200.138])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6688c99bsm149750087b3.45.2026.05.11.06.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:11:44 -0700 (PDT)
Date: Mon, 11 May 2026 09:11:43 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, sourabhjain@linux.ibm.com, 
	jbouron@amazon.com, akpm@linux-foundation.org, linux-mm@kvack.org, bhe@redhat.com, 
	linux-kernel@vger.kernel.org, dan.carpenter@linaro.org, rafael.j.wysocki@intel.com, 
	piliu@redhat.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com, 
	changyuanl@google.com, mario.limonciello@amd.com
Subject: Re: [PATCH v2 1/3] kho: skip KHO data for context-preserving kexec
Message-ID: <agHU6q3N2URn8Sei@google.com>
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
 <20260506182039.2623553-6-pasha.tatashin@soleen.com>
 <agGxkHPx7W7P5AUS@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agGxkHPx7W7P5AUS@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_061148_077486_C2E1A482 
X-CRM114-Status: GOOD (  20.43  )
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

On 05-11 13:38, Mike Rapoport wrote:
> On Wed, May 06, 2026 at 02:20:41PM -0400, Pasha Tatashin wrote:
> > A preserve_context kexec returns to the current kernel, which means the
> > 2nd kernel does not use KHO data (and their memory spaces don't
> > overlap). Passing KHO data to the 2nd kernel via setup_data or
> > devicetree is unnecessary.
> > 
> > Add a check in kho_fill_kimage() and return early if preserve_context is
> > set, to avoid passing KHO state during context-preserving kexecs.
> > 
> > Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  kernel/liveupdate/kexec_handover.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> > index 4fde8325c49f..2eec2a169c83 100644
> > --- a/kernel/liveupdate/kexec_handover.c
> > +++ b/kernel/liveupdate/kexec_handover.c
> > @@ -1702,7 +1702,8 @@ int kho_fill_kimage(struct kimage *image)
> >  	int err = 0;
> >  	struct kexec_buf scratch;
> >  
> > -	if (!kho_enable || image->type == KEXEC_TYPE_CRASH)
> > +	if (!kho_enable || image->type == KEXEC_TYPE_CRASH ||
> > +	    image->preserve_context)
> >  		return 0;
> 
> Sashiko says it's unnecessary:
> 
> https://sashiko.dev/#/patchset/20260506182039.2623553-5-pasha.tatashin@soleen.com
> 
> I tend to agree :)

Awesome catch by Sashiko, I will drop this patch.

Pasha

>   
> >  	image->kho.fdt = virt_to_phys(kho_out.fdt);
> > -- 
> > 2.54.0.545.g6539524ca2-goog
> > 
> 
> -- 
> Sincerely yours,
> Mike.

