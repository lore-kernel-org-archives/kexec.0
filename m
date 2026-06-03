Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9321ACD6E56
	for <kexec@archiver.kernel.org>; Wed,  3 Jun 2026 03:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=19g1dGk4BTOikWiMQOoz6k+1dj4ui8RGk7l8PldXTJ8=; b=AvWSRh45vOa31dHM1LGc2tvQ1l
	hqi+oUKIFi+78y600BJaFmT54ywkHNUAKwXqufYkh4oJi3/Y7u6TfYHDqD3lf9bL3msmwQ8UeqRK3
	BrcKeQI5JWkOiGZM8BHTpJLQSZ9oYx/dScLgvXbTVXLxW3TETJmeCbHYRfSsprEsVHKlzGTmIzekf
	je5WYwuxyVcMh04ca/HDC5u+xJo5lRTdtnWirCz6fZf4rmv8/DVQdoGS/Zg4yLTlHpGqH5pDMWjTa
	Md7pmYkBqZ/04/tswiwotwMNdO7GnDBN4GM7ceNo+yRaPnut8LelcWypNuhLlL8PFwH33nuxSblJe
	8mWCWQ1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcPP-0000000EBwH-2TDH;
	Wed, 03 Jun 2026 03:36:47 +0000
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUcPN-0000000EBuT-07XR
	for kexec@lists.infradead.org;
	Wed, 03 Jun 2026 03:36:46 +0000
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-5176ca6bab1so2895211cf.0
        for <kexec@lists.infradead.org>; Tue, 02 Jun 2026 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780457804; x=1781062604; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=19g1dGk4BTOikWiMQOoz6k+1dj4ui8RGk7l8PldXTJ8=;
        b=UIhNZYQ/5OnPnCx5tR32fj7H8zePKDp/s9AZY5dgB/3U2UuFwD2I+NYd5+Fi0NfIMw
         K5SEbQ5JhavBFTfWHFASxYMB/Fo7pn0cknsvOODU7H1mQPE4F6e6IcAiHGzVLH0BAt3D
         txiSeGqMnFOBamxt88p7vXaZACnAfQk4WpsbYJ9ml4B8TQBI2vztW7/K9KNRhMyPE27r
         iVDN8jdW1ezWZpnK+cVbVbv5UCu/kjShMax4MEhiYujgzbFm2JpF+O/rPj6rXehtAl64
         4kNIooCVamXeqb7tmR+g0LG61SK6O50hyxfIc1Y4WIByulppAvzNMQGTwzXAvYq1OKgv
         xoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780457804; x=1781062604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=19g1dGk4BTOikWiMQOoz6k+1dj4ui8RGk7l8PldXTJ8=;
        b=SMlmcjkdcdPq0teeUieYm4Fum6Tne8pX+D0W40infD3xe1hhhVT7HxxAsQ65qhr0g1
         d4B2OQPNZ9PESorcMfpFLFu3jyRaAHBSPuHEHpl6Mx/EdPmZ0aG0Qf6qOqMkQ71DcVpJ
         NNRVtotaISjlXYlux+LLUc7djx6dC6CRvzpz1KK1JMCSKcVQKgqao02saVfSI6+6Fanp
         drTua+bCjYkKzU66tbSpf2GUEWy/VUZL3GNIFf0/5nOwYiImBGcaPbxA8P/slQB7BFrJ
         JlrrjzFwOOLDQ9fQ/J8dSK9xcPO1Dek2SExVQoYE9xZqa0SZl9FARxLMSlWQOnF4BXAR
         Ef3A==
X-Gm-Message-State: AOJu0Yy4+AaOARgnOSkRDDW5fg+ZhCxHBLnVs67jbX6GFTdKeWrh7QyX
	5wPSb0RI/rFNCgOcmH894klai7qq93ugf3gErtbenNReE/VeWCqb9AjZ3Y0JR0/n6/I=
X-Gm-Gg: Acq92OH83gvaT19piJs/AMWuRQ2KqQIJwxXUzrmp9yR/E64DfP7nkuGG4Hoimm7cdc4
	9iWM6n0Z7/iJcOCTcR9NWo4URhua5VUblLbzXL3gBWeuWxaeihMcp5/NXuVnMBWWAaQHPg7hS28
	aqrRollcpNo/l9B4qwFDCO5P2iBAsT51JqFyHzjA37f39MT7BPTtgLjrTT1dIZC5f2Yk/j66UFE
	dK4rO5f54pOvJ4C8hN3HVCZ8SPDj2G4H/BTBN2JABQlLO8iScoT9GUZic06Zz6dyrGQBroEDvOa
	miaKsUYGyDrowdX+JAjyRVit6LRB0lunHrUfcNeRhgRNMDufveSgpuxhey+wz/4ASSmExy8ZLl/
	742rv38OF4jkYuDNlF0kCLlEr5SaKgteMI8OZqIaLHmpwBMtyizwB6ve1t7tCAWb5mQPuxxvSoP
	dQ6MU/8pcDqFxfyNn1c11cgJVKfIC8LwlTzWtcjFciJc2tQkP8MJaUYs8F0QgFgw==
X-Received: by 2002:a05:622a:1911:b0:50f:bd19:657b with SMTP id d75a77b69052e-517796cbe0bmr19101691cf.10.1780457803843;
        Tue, 02 Jun 2026 20:36:43 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775c07c29sm14969661cf.1.2026.06.02.20.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:36:38 -0700 (PDT)
Date: Wed, 3 Jun 2026 03:36:37 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [PATCH 1/2] liveupdate: Reference count outgoing FLB data
Message-ID: <ah-hOvBR7QcTshoc@plex>
References: <20260528174140.1921129-1-dmatlack@google.com>
 <20260528174140.1921129-2-dmatlack@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528174140.1921129-2-dmatlack@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_203645_079790_29E83F95 
X-CRM114-Status: GOOD (  25.36  )
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
> Increment the outgoing FLB refcount in liveupdate_flb_get_outgoing() so
> that the FLB structure cannot be freed while the caller is actively
> using it. Add an additional liveupdate_flb_put_outgoing() function so
> the caller can explicitly indicate when it is done using the outgoing
> FLB.
> 
> During a Live Update, the kernel may need to fetch the outgoing FLB
> outside of the scope of a file handler's preserve() and unpreserve()
> callbacks. In that situation there is no way for the caller to protect
> itself against the outgoing FLB from being freed while it is using it.
> Incrementing the reference count in liveupdate_flb_get_outgoing()
> ensures it cannot be freed.
> 
> This change also aligns the outgoing FLB lifecycle management with the
> incoming FLB, since the latter uses the same get/put semantics.
> 
> Fixes: cab056f2aae7 ("liveupdate: luo_flb: introduce File-Lifecycle-Bound global state")
> Assisted-by: Gemini:gemini-3-pro-preview
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com> 

> ---
>  include/linux/liveupdate.h  |  5 +++++
>  kernel/liveupdate/luo_flb.c | 10 +++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/liveupdate.h b/include/linux/liveupdate.h
> index 88722e5caf02..c344bf987b63 100644
> --- a/include/linux/liveupdate.h
> +++ b/include/linux/liveupdate.h
> @@ -243,6 +243,7 @@ int liveupdate_flb_get_incoming(struct liveupdate_flb *flb, void **objp);
>  void liveupdate_flb_put_incoming(struct liveupdate_flb *flb);
>  
>  int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp);
> +void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb);
>  
>  #else /* CONFIG_LIVEUPDATE */
>  
> @@ -292,5 +293,9 @@ static inline int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb,
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb)
> +{
> +}
> +
>  #endif /* CONFIG_LIVEUPDATE */
>  #endif /* _LINUX_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_flb.c b/kernel/liveupdate/luo_flb.c
> index 8f5c5dd01cd0..7ddef552ff6b 100644
> --- a/kernel/liveupdate/luo_flb.c
> +++ b/kernel/liveupdate/luo_flb.c
> @@ -135,7 +135,7 @@ static int luo_flb_file_preserve_one(struct liveupdate_flb *flb)
>  	return 0;
>  }
>  
> -static void luo_flb_file_unpreserve_one(struct liveupdate_flb *flb)
> +void liveupdate_flb_put_outgoing(struct liveupdate_flb *flb)
>  {
>  	struct luo_flb_private *private = luo_flb_get_private(flb);
>  
> @@ -266,7 +266,7 @@ int luo_flb_file_preserve(struct liveupdate_file_handler *fh)
>  
>  exit_err:
>  	list_for_each_entry_continue_reverse(iter, flb_list, list)
> -		luo_flb_file_unpreserve_one(iter->flb);
> +		liveupdate_flb_put_outgoing(iter->flb);
>  	up_read(&luo_register_rwlock);
>  
>  	return err;
> @@ -291,7 +291,7 @@ void luo_flb_file_unpreserve(struct liveupdate_file_handler *fh)
>  
>  	guard(rwsem_read)(&luo_register_rwlock);
>  	list_for_each_entry_reverse(iter, flb_list, list)
> -		luo_flb_file_unpreserve_one(iter->flb);
> +		liveupdate_flb_put_outgoing(iter->flb);
>  }
>  
>  /**
> @@ -546,6 +546,10 @@ int liveupdate_flb_get_outgoing(struct liveupdate_flb *flb, void **objp)
>  		return -EOPNOTSUPP;
>  
>  	guard(mutex)(&private->outgoing.lock);
> +	if (!private->outgoing.obj)
> +		return -ENOENT;
> +
> +	refcount_inc(&private->outgoing.count);
>  	*objp = private->outgoing.obj;
>  
>  	return 0;
> -- 
> 2.54.0.823.g6e5bcc1fc9-goog
> 

