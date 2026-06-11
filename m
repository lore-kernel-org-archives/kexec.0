Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B1CD98CF
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 18:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GOgajm4rEsS0uuxJzvMIbIsIc3zZLl8o5hVXXScM5mw=; b=m/J/974+O4Nm9p7n3JSVmuq4tO
	bUb4cp7EaQDj0ipDrupx/RSo/QQf54bZll4pVE1vEelbuXKKheN/8BmCDcAB8vCfwBax3Dcmqm6x1
	O0LSbvOL/7zoZnZN+sP/dtEybyrlUEHB4P3i4e4o6W46/7nbuxZBJW9s+19zdL+K4yvBNKlsCrj+B
	uOPow/ID5Hf2+16oY8irJuxRQQqxLJCZs9fuO4LjUE7n6+o9Mu/i3EF/Z3j1goFivfnwsRG5+OBKk
	6Vs89TTQuBXxFUu1zJHGvcMh0Op0D1H41LX+74NjMZ0VYCZftE3d6yc8UhvrCvlsdgXsoDmkjxHX3
	waqKqEeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjsQ-00000009sBL-2a1w;
	Thu, 11 Jun 2026 18:11:38 +0000
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXjsO-00000009sAy-0WGj
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 18:11:37 +0000
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-6cfd9f4d6f5so30386137.3
        for <kexec@lists.infradead.org>; Thu, 11 Jun 2026 11:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1781201494; x=1781806294; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GOgajm4rEsS0uuxJzvMIbIsIc3zZLl8o5hVXXScM5mw=;
        b=cpQI1tnlhQVIWYKMblHhaWCneu7i1OHMrDGgGetPp6PfFVpuxN3v0r6NOTbg2fjdBD
         RcBUxULHQvbfISiC5vlQtaY4BNBpH2ood/eSnI+bu9ZwmpV7Ydjee1SLzyBFjFDzQEcd
         UHzLRO9ankOucekejAryFv7gudolpLWcunMPkVauxwwxEewhn4bEo7JbduszpKXY3uHr
         9EKaxxnQg7zXxaptj5P2t45AXGa56ZOS+RrAmW0lL7hK5VNF5yHfdLG2QoaDzrCQTW1G
         fKWJIDxMxAOVU065OVMiG36/CUV2fSvxHiSUIq2Wo4Uj6B6DodBIEruxzCOsmkH8bxMq
         /z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781201494; x=1781806294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOgajm4rEsS0uuxJzvMIbIsIc3zZLl8o5hVXXScM5mw=;
        b=piLTb/Tawey6bvcLEHEEp86MQGOnubzz0HJdEhS0Ct0S1kPq8YT//aKjuvdLmpDCFK
         XCOmS34Cj0k0YVCYxeeI7W8p2WVfaMLZB75YmzocDSQszbKqIgHPLtIuJKizyjd8KkWq
         +AEa3Nx5YoviGsPJ09mmiyRWkcu+tTNHLWMF7mWiXc4MB68+5SWAfo9EjRBrkja6PCZ4
         h5WPpHnZ/pC+X9te1gcJUvcqjfK37Q871zgVOq/n9Cuvp35wRSpvN9tsP44FKeQRX3vX
         iUWvT3WRB+I5aUHbrKKpNdPLjQ09Mw3Pnu5UQLmREj1BUmosBrwTQWHNzjYaHgskNbUz
         bfSg==
X-Forwarded-Encrypted: i=1; AFNElJ8KjhFt8Ro1UxjkKhkDNy5YlWnnSLemScqnX69BtRxQxs9uNZkSM+BRR3C54p7ctQOOOEOf8w==@lists.infradead.org
X-Gm-Message-State: AOJu0YyaM9g/+hvBNdubn8gUVb+GeAzMB+CIsAIYeNrurCyNSqJ8z6Tj
	dy1zfhe+/ayt1OCCXJvSRWhzSwZHzcVJE29ZDyC33UFvuL3d66eykafpk46uYzoICEnZpvC8CVa
	fx+5i
X-Gm-Gg: Acq92OF/nKVHa87Ztl/8ZY4ZGFEjusz34NqMNGn7tIuAuu7uGd3XjiErncSjaYh/WF3
	i3tw2ZRN6pNffVsihMGeJKp6Erx871ywnQ9xbsy+Mef1E9UtvA20X52Cnd19mLl8kJvhoThsej8
	EBfoKK0BhkhGIUUvOnk8NqZxI2i0t0GxA95rPdaqY39f0+n21Fyu1JAs2JYlHINUfNkhvU3k9JN
	AcZpWjJor/aPWQeml+tcr0B/lM6MWLu1+ScI7i+Xzmgwb5SQ+5AuwClJ4KCkvkUTQQX13LsRa7x
	i1eJ0HysnMfLQ3fXUhjw/iZa0UFVDgh2kkdY3g1JatMDVBd+7Nj1NSoxWrmXTyVAP1pz/Tbgv7Z
	GYYYge8lvbfRh9nlEIYFHrdrJ78Hatz7Kh6Fsno/cq353AxcXcUiStIUa6IOXi0p+1Pf7DjSYfj
	9HEx8FexMQ/gH1QAuTHH9TD9bD3zIemIc78Q4eFtDNNLsWsa1zZFA=
X-Received: by 2002:a05:6102:5693:b0:6f0:3c5c:6ad with SMTP id ada2fe7eead31-71d5f2c31e9mr2569788137.21.1781201494610;
        Thu, 11 Jun 2026 11:11:34 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301c237e8sm562906d6.17.2026.06.11.11.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 11:11:34 -0700 (PDT)
Date: Thu, 11 Jun 2026 18:11:33 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
Message-ID: <air6StonoQPyaTEP@plex>
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260611_111136_170172_8C345A0C 
X-CRM114-Status: GOOD (  17.80  )
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

On 06-11 10:30, Tarun Sahu wrote:
> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> on args->serialized_data before checking if the physical address is valid.
> Since physical address 0 does not map to virtual NULL (due to direct
> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> catching a missing serialized_data, leading to unsafe dereferences later.
> 
> Validate that args->serialized_data is non-zero before calling
> phys_to_virt().
> 
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  mm/memfd_luo.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memfd_luo.c b/mm/memfd_luo.c
> index 59de210bee5f..10f3983b0060 100644
> --- a/mm/memfd_luo.c
> +++ b/mm/memfd_luo.c
> @@ -397,10 +397,11 @@ static void memfd_luo_finish(struct liveupdate_file_op_args *args)
>  	if (args->retrieve_status)
>  		return;
>  
> -	ser = phys_to_virt(args->serialized_data);
> -	if (!ser)
> +	if (!args->serialized_data)
>  		return;
>  
> +	ser = phys_to_virt(args->serialized_data);
> +
>  	if (ser->nr_folios) {
>  		folios_ser = kho_restore_vmalloc(&ser->folios);
>  		if (!folios_ser)
> @@ -522,10 +523,11 @@ static int memfd_luo_retrieve(struct liveupdate_file_op_args *args)
>  	struct file *file;
>  	int err;
>  
> -	ser = phys_to_virt(args->serialized_data);
> -	if (!ser)
> +	if (!args->serialized_data)
>  		return -EINVAL;
>  
> +	ser = phys_to_virt(args->serialized_data);
> +
>  	/* Make sure the file only has seals supported by this version. */
>  	if (ser->seals & ~MEMFD_LUO_ALL_SEALS) {
>  		err = -EOPNOTSUPP;
> 
> base-commit: 9716c086c8e8b141d35aa61f2e96a2e83de212a7
> -- 
> 2.54.0.1099.g489fc7bff1-goog
> 

