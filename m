Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BFECD4F47
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 18:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lirFWsJ5C0bTd/R7aKsYhvTxoj04iUNEXEllFWQcIOE=; b=X9JHgEWp/tRlZ84NT7Zmxp9gEU
	QocOvjToevs2tdkOxKG/wknVREC9MEIRAsZWXgxcKkPoaab/P+HXhajGRRJNjOKxpkutar30pCE1T
	URyYuhvPdteGSsuUJaDXWQulJ0U1Ycs9CaF+cr2Zia4LCny29opvkxZYc/Hp2S36iEGgPwOOU4mOE
	Z7rfi993pos/uoSNoAF55ZJQwQNRW0roNqv8gxJkQr/Vcrt3Vh/qDwXibyhVjO88/ZlCfi91zy2nn
	Sbjn6VO9cXd0dRmLXk6q1JFuq7hZrEyaBiNQcTMrrixOuK7MgWiZcGg9mMhyto65OaNzT1rfPcoxG
	vBY4tybw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgLy-0000000DF2H-093h;
	Sun, 17 May 2026 18:36:42 +0000
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOgLw-0000000DF1m-1DZA
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 18:36:41 +0000
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-91080895355so200445585a.3
        for <kexec@lists.infradead.org>; Sun, 17 May 2026 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779042998; x=1779647798; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lirFWsJ5C0bTd/R7aKsYhvTxoj04iUNEXEllFWQcIOE=;
        b=Ckhgs0frdLrW9ek6gtA++x/pr8wYjJVktirDd0jlrjoMhAtU026DpR9/aj5nZjecnR
         z0PzQMp/obuzVD6paoBQ877Q7ueZ8v8q/e2ZXwJ9JWE7PiJ3MmxEAU+oTFFRKmBKZfEZ
         8YXHUvPG4/MSWx1q42NCT5F6pLl63huU+uSqpsEboFeFdF4C0wxgWB6iU7HKUQqBR/3c
         nBadSTIjZCOoWTce2Ka1To0XKfr26hvLGxSuH3M0EI+GLnLp3kqIjDwgdW24CN2xiskn
         QMPFnWA53mW+/kYZ2B95gXwbggdUNMGJJOFMDEs8SCcsVf2lKzYQBrH2lkS9B5sRhZbX
         wp3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779042998; x=1779647798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lirFWsJ5C0bTd/R7aKsYhvTxoj04iUNEXEllFWQcIOE=;
        b=rqmUX11xH7zpkG4QGrcGKhHOvof0CJJKjY5vNxvtV802/VIHXF9MD7OgMHG9ezCZlE
         JzafPD03nKY0vJfJwJplua9rvKvZ+AFd66lMZmI74RdLIbe3Pxe5iJSS4mpqIqgcN3pw
         R3emFyWxZKeH57LQAvA+my+EmpPD7nTGqXrrEtrJwaucMsMJk5KOmD1FdvYCVdprEOld
         ZjTipZRW+QsC7mrVgYS61rH23+uTwekYulYi+HQv2yR+ijYMdfMj30DJAzDrnaTAIQNR
         Hc/s+Gj/+/FIHCiDe3+YXogXitl9i+BLyR2dzS+cai7yhFp5pQguj7vhZ2NiE2RrykJG
         qMbw==
X-Forwarded-Encrypted: i=1; AFNElJ/cyNXfS4+S67DWhs0WXPV9oh6fP9F7Pgt3ly3EcNjZFbZzCWjW/hT4LwyP11J+Pmlfb6WK2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YxY9lKWPTALnrrKg+iQDc6OvNEjdGz0J8fosRKftHvZcJbNYrok
	X0D8y4YRdwKJAggiioR4iZLqC3dnqFaHU9euGSUPrhY+q6ufZtuQPGSLOxK/vAm1edk=
X-Gm-Gg: Acq92OGJ+bjeD3Quf3gKnGjM1/gqv7/ja+JpuNpM2OB8TtHMRCPuEwm+pXB4MP3j4f6
	A4hWOd2bKeS/hTMbxJ0c8gZ0gvhNkJqKwT4EyliT0nFjGB8c38CEmAcfF0uHf7AkHieukKmu7ZY
	bQJokaJxVxpDgDJT+gD1CXxXepRY3GkzGbB+HM0oJ86SdUoh4hpDzI2GaEX2AzH15XE9S6Dstpc
	E6q2vl5f3TKcP1JeZg/dwEMe815do7Faj7q65fPYI83FfalERp8n9dM7PS85yT3mBBJjHpvbsDJ
	oe8CeFEkds4kazqYeUkLnNM3lNwujdjOl+BPUJloTyUCIR670qX69K7pejTW9MtVzIWnf5Jri6L
	qDTbVrZZnMuY8mhOKrpOB7Hcy8GzKw2e/CIHvnYSKpJZqXmzQOlD4CtUFS2ORApMzL3+kKwXVUg
	zyQIX+4vPgGfTBqsTXY//811uWHpe+3nNAcsHN/2SHSeCryiCwycA=
X-Received: by 2002:a05:620a:6cc6:b0:911:a9e4:8b04 with SMTP id af79cd13be357-911d1042fc0mr1877269085a.62.1779042998343;
        Sun, 17 May 2026 11:36:38 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf3584esm1221812385a.34.2026.05.17.11.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 11:36:37 -0700 (PDT)
Date: Sun, 17 May 2026 18:36:36 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	corbet@lwn.net, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v2 01/10] liveupdate: centralize state management into
 struct luo_ser
Message-ID: <agoKAw9CQIVIhp2b@plex>
References: <20260514222628.931312-1-pasha.tatashin@soleen.com>
 <20260514222628.931312-2-pasha.tatashin@soleen.com>
 <agn4z5ZrFBi9AIGw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agn4z5ZrFBi9AIGw@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260517_113640_350807_7A07B01B 
X-CRM114-Status: GOOD (  24.57  )
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

On 05-17 20:20, Mike Rapoport wrote:
> On Thu, May 14, 2026 at 10:26:19PM +0000, Pasha Tatashin wrote:
> > Transition the LUO to ABI v2, which centralizes state management into a
> > single struct luo_ser header.
> > 
> > Previously, LUO state was spread across multiple FDT properties and
> > subnodes. ABI v2 simplifies this by placing all core state, including
> > the liveupdate number and physical addresses for sessions and FLB
> > headers into a centralized struct luo_ser.
> > 
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  include/linux/kho/abi/luo.h      | 91 +++++++++++---------------------
> >  kernel/liveupdate/luo_core.c     | 59 ++++++++++++++-------
> >  kernel/liveupdate/luo_flb.c      | 65 ++++-------------------
> >  kernel/liveupdate/luo_internal.h |  8 +--
> >  kernel/liveupdate/luo_session.c  | 57 +++-----------------
> >  5 files changed, 93 insertions(+), 187 deletions(-)
> 
> This looks lovely :)
> 
> > @@ -115,27 +117,29 @@ static int __init luo_early_startup(void)
> >  		return -EINVAL;
> >  	}
> >  
> > -	ln_size = 0;
> > -	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_LIVEUPDATE_NUM,
> > -			  &ln_size);
> > -	if (!ptr || ln_size != sizeof(luo_global.liveupdate_num)) {
> > -		pr_err("Unable to get live update number '%s' [%d]\n",
> > -		       LUO_FDT_LIVEUPDATE_NUM, ln_size);
> > +	header_size = 0;
> > +	ptr = fdt_getprop(luo_global.fdt_in, 0, LUO_FDT_ABI_HEADER, &header_size);
> > +	if (!ptr || header_size != sizeof(u64)) {
> > +		pr_err("Unable to get ABI header '%s' [%d]\n",
> > +		       LUO_FDT_ABI_HEADER, header_size);
> >  
> >  		return -EINVAL;
> >  	}
> >  
> > -	luo_global.liveupdate_num = get_unaligned((u64 *)ptr);
> > +	luo_ser_pa = get_unaligned((u64 *)ptr);
> > +	luo_ser = phys_to_virt(luo_ser_pa);
> > +
> > +	luo_global.liveupdate_num = luo_ser->liveupdate_num;
> >  	pr_info("Retrieved live update data, liveupdate number: %lld\n",
> >  		luo_global.liveupdate_num);
> >  
> > -	err = luo_session_setup_incoming(luo_global.fdt_in);
> > +	err = luo_session_setup_incoming(luo_ser->sessions_pa);
> >  	if (err)
> >  		return err;
> >  
> > -	err = luo_flb_setup_incoming(luo_global.fdt_in);
> > +	luo_flb_setup_incoming(luo_ser->flbs_pa);
> 
> Sashiko asks: 
> 
>   Is there a leak of the preserved luo_ser memory here?
> 
>   The outgoing kernel allocates the header using kho_alloc_preserve(), but
>   luo_early_startup() returns without calling kho_restore_free() on the
>   luo_ser pointer once the fields have been processed. This results in an
>   unreleased memory reservation on every successful live update.
> 
> This seems preexisting, and we probably don't care enough, but still...

The freeing happen during finish, that was by design.

> 
> There were more comments by sashiko, didn't check them yet.

The other comment is stupid: yes, changing ABI prevents updating from 
older kernel.

>   
> > -	return err;
> > +	return 0;
> >  }
> >  
> >  static int __init liveupdate_early_init(void)
> > @@ -156,7 +160,8 @@ early_initcall(liveupdate_early_init);
> >  /* Called during boot to create outgoing LUO fdt tree */
> >  static int __init luo_fdt_setup(void)
> >  {
> > -	const u64 ln = luo_global.liveupdate_num + 1;
> > +	struct luo_ser *luo_ser;
> > +	u64 luo_ser_pa;
> >  	void *fdt_out;
> >  	int err;
> >  
> > @@ -166,27 +171,45 @@ static int __init luo_fdt_setup(void)
> >  		return PTR_ERR(fdt_out);
> >  	}
> >  
> > +	luo_ser = kho_alloc_preserve(sizeof(*luo_ser));
> > +	if (IS_ERR(luo_ser)) {
> > +		err = PTR_ERR(luo_ser);
> > +		goto exit_free_fdt;
> > +	}
> > +	luo_ser_pa = virt_to_phys(luo_ser);
> > +
> >  	err = fdt_create(fdt_out, LUO_FDT_SIZE);
> >  	err |= fdt_finish_reservemap(fdt_out);
> >  	err |= fdt_begin_node(fdt_out, "");
> >  	err |= fdt_property_string(fdt_out, "compatible", LUO_FDT_COMPATIBLE);
> > -	err |= fdt_property(fdt_out, LUO_FDT_LIVEUPDATE_NUM, &ln, sizeof(ln));
> > -	err |= luo_session_setup_outgoing(fdt_out);
> > -	err |= luo_flb_setup_outgoing(fdt_out);
> > +	err |= fdt_property(fdt_out, LUO_FDT_ABI_HEADER, &luo_ser_pa,
> > +			    sizeof(luo_ser_pa));
> >  	err |= fdt_end_node(fdt_out);
> >  	err |= fdt_finish(fdt_out);
> >  	if (err)
> > -		goto exit_free;
> > +		goto exit_free_luo_ser;
> > +
> > +	err = luo_session_setup_outgoing(&luo_ser->sessions_pa);
> > +	if (err)
> > +		goto exit_free_luo_ser;
> > +
> > +	err = luo_flb_setup_outgoing(&luo_ser->flbs_pa);
> > +	if (err)
> > +		goto exit_free_luo_ser;
> > +
> > +	luo_ser->liveupdate_num = luo_global.liveupdate_num + 1;
> >  
> >  	err = kho_add_subtree(LUO_FDT_KHO_ENTRY_NAME, fdt_out,
> >  			      fdt_totalsize(fdt_out));
> >  	if (err)
> > -		goto exit_free;
> > +		goto exit_free_luo_ser;
> 
> And here we also seem to leak memory allocated by sesttion/flb setup.
> 
> >  	luo_global.fdt_out = fdt_out;
> >  
> >  	return 0;
> >  
> > -exit_free:
> > +exit_free_luo_ser:
> > +	kho_unpreserve_free(luo_ser);
> > +exit_free_fdt:
> >  	kho_unpreserve_free(fdt_out);
> >  	pr_err("failed to prepare LUO FDT: %d\n", err);
> 
> -- 
> Sincerely yours,
> Mike.

