Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36474CD6E4A
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FAC+XywUjSvRcC/lmO2OhZjlflNjORbFaO72oWGwvQo=; b=cc0Yvx9+ifmi22sHMskAghHSAy
	QMLyG3rrghJIOCptbdR3qttmYcgs+JADb7FEYNhjK91G5Q1FKq7VBoZoYBgOdnrIJdZkcAkE8iCN1
	IS1B2azaf85hLhKTK0tzfmcvCP3ooDZiSv7G2WZarkjYsnffm6evS36A3GYhq+DGEivHZjudonrBw
	POPmErBl0VUVhyZKATiLhxOOz5iWBG4mqylroJNVnlUNfkvmmdWxXRo7+gaRnGCUstvrw5lYg7XhJ
	9eV66No4XRgW7IEao7Tz1OZbFJ++QuUpFh133b2IFA+AH+OHzhDdW/adIwBXEtEOWCwGCb/IQEay2
	U5TtBa8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcP1-0000000EBqH-0Y3j;
	Wed, 03 Jun 2026 03:36:23 +0000
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcOy-0000000EBpe-0Xk5
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:36:21 +0000
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-8ccce57762cso70467336d6.3
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457779; x=1781062579; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAC+XywUjSvRcC/lmO2OhZjlflNjORbFaO72oWGwvQo=;
        b=Dnqeg4R1ZadX5JHjkDkPQFnN6Rf8dj9ytr+0SSVDvpB6Q8bcAoMJIgEK9yLLy/CZVd
         CYuQBG6T+8HpE68IB76Z7v4GF86j4xiKDgGaiSLRJAyMqfDzBqL9ayMricph+EoWQc86
         OArdfOJrbzFAcLrSyLDxZcz5Ycj3zMFwZuT5peMlxfTXFzUZtfaDKqb60brLxNzSTkj8
         RCvdkRT6OlrB4iP3rZiHryXAycXnR9ckcqDbCwFucFs5egY7OMxmOZcb2U/Y5318P9sO
         XseiGQpQNMiNBOeg9wVsrytdeC5J1jq2jwB5cXTXXN1AtfM4qo8TSLAHXLpSr1DE1D0B
         sk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457779; x=1781062579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAC+XywUjSvRcC/lmO2OhZjlflNjORbFaO72oWGwvQo=;
        b=Gu27z4KN1q36t146KV5LkHrhLwPndGuPBsmWP4xnnAvNbr0WYMMm/KFETLtpCbjxT9
         GFRMb/4+5hGGJx8RyoKKOqIXWWRGu2KrFwLcz1+ygiJZyNkKm1wETrL232D0is9wwudF
         /1hgBtbK6FVe/e3c0jz+Cz53ghe5jM0Kc+RCFYl3izl+2LF8ImyyOQxaa1KbT5/jqUA3
         5EKhoMbv7tgS8T9CqpluzmUaZYuuDqijGWJ9RnF/chvR+lzWnjNwwORxROfQ8OUeHdv6
         5YND99vLU2nh+HTjeIH+0fMJHoWffrmlqj6F1hPc2pqVmyN6ydqz3yxEZ/0JaNVvtRrp
         +YQw==
X-Gm-Message-State: AOJu0YxnYZvgDsSKBEg6krGoj91QVM55l94z7S0BUDhOaOZow4A40C7y
	5jUarywu1nQy+7rT3Ykomi4aCpOOFwJiRFjUTSRIVHCXdvcah8B+aJLuZx1m1MrQ2M8=
X-Gm-Gg: Acq92OHZfWe45eQy7mv2xKKoRMRPa8Zdp3vw+R3a+Jn15BNCOrvqbA8QlW2+0dEz5K7
	5XBUqJuD6F94DXHQwAaKKVSeRNR8sWqzRGARGUjdttTCW4B9S8OkBWY9/LGHP7+brXHPbVmTE6q
	1vMkvmclAwNOVZYv4NYgSlcwSeBnQvoo4XasRB6Za2oD5qndw2opDXdqd9+F301PZ8jEnJPiGzI
	sR8N1JoIYkPJFB843a7MFONPUh45ZEuy8gwTo6w80JilBp+yBRpfTJnrs/LLn3f0L6NQCOG1gym
	jqZtv7bHhVtWtB1dlQPdwWIB+Ddr/bZr34mzF5dsH4owrqBFOyVj16+ro7QUsGg5h58TbCf/jAS
	sXI+f/zC5MNIDRd7303zKqIwFpcCoCXbRleBUd2nxINlcrX9AbtdJVemHGRRQQcp8Jc3VTzxDss
	/2TierilZfIYNc16rJcRFTFvVGpBXK17Fv6MYEArEYXSMHpStS00DLaZn3S5olIIKhRc6IRFlT
X-Received: by 2002:a05:6214:dce:b0:8cc:ead5:f377 with SMTP id 6a1803df08f44-8cece16781emr20800526d6.38.1780457779010;
        Tue, 02 Jun 2026 20:36:19 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccda2601sm9573956d6.6.2026.06.02.20.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:36:18 -0700 (PDT)
Date: Wed, 3 Jun 2026 03:36:17 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH 2/2] liveupdate: Remember FLB retrieve() status
Message-ID: <ah-hG1TObQ3PCtd-@plex>
References: <20260528174140.1921129-1-dmatlack@google.com>
 <20260528174140.1921129-3-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528174140.1921129-3-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_203620_184699_E3C39933 
X-CRM114-Status: GOOD (  33.50  )
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

On 05-28 17:41, David Matlack wrote:
> LUO keeps track of successful retrieve attempts on an FLB. It does so
> to avoid multiple retrievals of the same FLB. Multiple retrievals cause
> problems because once the FLB is retrieved, the serialized data
> structures are likely freed and the FLB is likely in a very different
> state from what the code expects.
> 
> All this works well when retrieve succeeds. When it fails,
> luo_flb_retrieve_one() returns the error immediately, without ever
> storing anywhere that a retrieve was attempted or what its error code
> was. If the user attempts to retrieve another file registered with the
> same FLB, LUO will attempt to call the FLB's retrieve() callback again.
> 
> The retry is problematic for much of the same reasons listed above. The
> FLB is likely in a very different state than what the retrieve logic
> normally expects (e.g. some KHO pages may have already been restored and
> freed).
> 
> There is no sane way of attempting the retrieve again. Remember the
> error retrieve returned and directly return it on a retry.
> 
> This is done by changing the retrieved bool to a retrieve_status
> integer. A value of 0 means retrieve was never attempted, a positive
> value means it succeeded, and a negative value means it failed and the
> error code is the value.
> 
> This is similar to commit f85b1c6af5bc ("liveupdate: luo_file: remember
> retrieve() status") which did the same for LUO files.
> 
> Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> Assisted-by: Gemini:gemini-3-pro-preview
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  include/linux/liveupdate.h  |  6 ++++--
>  kernel/liveupdate/luo_flb.c | 10 +++++++---
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index c344bf987b63..63ea5417de84 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -173,7 +173,9 @@ struct liveupdate_flb_ops {
>   * @lock:      A mutex that protects all fields within this structure, providing
>   *             the synchronization service for the FLB's ops.
>   * @finished:  True once the FLB's finish() callback has run.
> - * @retrieved: True once the FLB's retrieve() callback has run.
> + * @retrieve_status: Status code indicating whether retrieve() has been
> + *                   attempted. 0 means not attempted, 1 means successful,
> + *                   and negative value means it failed with that error code.
>   */
>  struct luo_flb_private_state {
>  	refcount_t count;
> @@ -181,7 +183,7 @@ struct luo_flb_private_state {
>  	void *obj;
>  	struct mutex lock;
>  	bool finished;
> -	bool retrieved;
> +	int retrieve_status;
>  };
>  
>  /*
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 7ddef552ff6b..f8852f7e62e5 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -170,7 +170,10 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
>  	if (private->incoming.finished)
>  		return -ENODATA;
>  
> -	if (private->incoming.retrieved)
> +	if (private->incoming.retrieve_status < 0)
> +		return private->incoming.retrieve_status;
> +
> +	if (private->incoming.retrieve_status > 0)
>  		return 0;
>  
>  	if (!fh->active)
> @@ -196,12 +199,13 @@ static int luo_flb_retrieve_one(struct liveupdate_flb *flb)
>  
>  	err = flb->ops->retrieve(&args);
>  	if (err) {
> +		private->incoming.retrieve_status = err;
>  		module_put(flb->ops->owner);
>  		return err;
>  	}
>  
>  	private->incoming.obj = args.obj;
> -	private->incoming.retrieved = true;
> +	private->incoming.retrieve_status = 1;
>  
>  	return 0;
>  }
> @@ -215,7 +219,7 @@ void liveupdate_flb_put_incoming(struct liveupdate_flb *flb)
>  		if (!refcount_dec_and_test(&private->incoming.count))
>  			return;
>  
> -		if (!private->incoming.retrieved) {
> +		if (private->incoming.retrieve_status <= 0) {
>  			int err = luo_flb_retrieve_one(flb);
>  
>  			if (WARN_ON(err))
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 

