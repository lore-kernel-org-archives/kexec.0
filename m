Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54B4CD5BAC
	for <kexec@archiver.kernel.org>; Thu, 21 May 2026 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6X8QxT97XWDwxSQTOa9c7B5Uvcoz36bOQLLyn390AOA=; b=hsgNCAJ7Hl3tTbkb3msJCfoF4t
	Hd0QnvXeZouo6YFL8qh1atMPviDya9j80hNN3TjPjr4ND1qmbCamyV8qhftJ/AtM3QCzdjYbLberA
	mNgZbve3j7Zw/JuFLu8YwlWbZ3apbpphdgGOQrz/Sxk4F6NnOjSaOAOq968+FMyjE5qml+m7N6dZR
	T2yPwgY/kARTmV6SgGXz+Z9qrZaHVc0RJAJzHv3ADW0VGaNbKHRwH4kJDZT23vv+EyR9/jm7jiZmZ
	Wi4ynXjCSoGBpEYGmuhw6C+hJF8NxKLBLcOJvZwfH9Wk/BldWkko6g9cPsU0rzKB7Np0RMPJKxBiy
	LkqEGBmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8kK-00000008rra-01MS;
	Thu, 21 May 2026 19:07:52 +0000
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ8kI-00000008rqt-0Jp6
	for kexec@lists.infradead.org;
	Thu, 21 May 2026 19:07:51 +0000
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-8acb09ddbf6so116263006d6.2
        for <kexec@lists.infradead.org>; Thu, 21 May 2026 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779390468; x=1779995268; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6X8QxT97XWDwxSQTOa9c7B5Uvcoz36bOQLLyn390AOA=;
        b=O2ynjPFyF083J2CVg12bInGF906HKA8H9TicTFzcqgq3NAgO+kd5mrehED1S9wcrhT
         od4TubIxuH8LPkfWTptk7oSHt94JdUubRS5G4chH7Yh3mmuO9KO63q9tXvAZoRYhJvTu
         m/ryM5tpwUpxM/kbZJcFRxOrv8OEGzBnyG2iYuEVwNgfcaEcV+UKAYW2KMh9iigH+r4y
         YGEH+VPDpyEXF+aSenuzQak0rhlf4YbG8WBTHfV2lz9By6MBYNMM2CM+0VYcutynXnus
         ewPIQE6p66eCtX84jBEQRFgPNhUHmDukwscioj+hUwdAickVs4DZ4EarWEIia1SPSrZU
         MO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779390468; x=1779995268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6X8QxT97XWDwxSQTOa9c7B5Uvcoz36bOQLLyn390AOA=;
        b=XF3IotWQPS12+t5BpTPOCpguOaZkLx/kfLQGZrZjxPkBrPSK0EqkhXnmuBQ94uvCfO
         QInIPAG7MAGGu8BJOvxi8tKghwTL+7OcL3OmmwIoaWAol4xBTvL0L+IACLrlK6c48L+c
         PHLdcBjQ7SSM3b3MP+L/tvsGV2ofpQuP3WMD/BO+tUrvWKDqGCWFsY+zPp5sMuKaPB/P
         wsf9cx086Rxg977UNhmw23oku0/uro/tLbDw4IX4CO/eXqCFbyr704N5ny1J6pta8DCM
         Q/F62zrAICXsIEroXr1VgQXO76F153B3lLCjT1Eb9kfOVA0M28+OvpMj0uMj34T5uUkO
         UmKw==
X-Forwarded-Encrypted: i=1; AFNElJ+OskZUr4JYmSOJO02hagWPlMLqR+rIHjv5UgnOelQmI/VDcvqImvXvrD7zFspdlHfV+6zWMg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwwjupWh5dPmJdN/Oit1raTFhxlaIMzVhxL5ML/Mz1WhqePD+lC
	g9vp6mPVWP+Jr2XKmKl3Zw+/PKyoq8y9BkORbZUA3prVX+a+aDFwX3BPFFKyF8IiZ7A=
X-Gm-Gg: Acq92OEL9dhf81J4QO8Izlhk4FcuX3LbXQE7fdwRjVNzUef9yhKScg8eR22+mgu2sRo
	4SftfvVAghU4Q3qylhDUq5W6USiYLO5XC5cfk5LsUespR/rQvFf0DSINcsZTLWCQ/1nashnHU1j
	EAlhbeTwAMRR1eBVaE5bCTs/ER2EVFzmvhxr3qshTetyZbtZUA5hKxqYTvqTICELS1wt/F8J0C/
	TJiimzRp1CUP9JqBNwhETHGhamTwU7ZK74GngnITjT6oGD7oiekam6KrFw4GUW1yI/vFJtwMGWp
	h4IqeFxAFlAArE/48ENwubNWLMiE7qlD0y10hxuwP/EKza35RgYXJ/rjnyqfMPhoxXR1aHsZiUB
	cXy6wZFlcZUsRaiQ8nh7ZMokPpWq2lMuFu3xEHLvnTwPlKfJWkXvJRFbSn+oNiz4dbdvXeUXSYt
	S6F0JBnZinsvCCmTIL06AVSvb5q7kobNS/lDumdsPGtyyH+b3pTLr6AFvCoERbNA==
X-Received: by 2002:a05:6214:3c89:b0:8cc:611f:197f with SMTP id 6a1803df08f44-8cc7b69fb91mr10772426d6.44.1779390468578;
        Thu, 21 May 2026 12:07:48 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc7680906bsm12968866d6.0.2026.05.21.12.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 12:07:48 -0700 (PDT)
Date: Thu, 21 May 2026 19:07:47 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Alexander Graf <graf@amazon.com>, kexec@lists.infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: always print scratch sizes
Message-ID: <ag9VrVW3E28UOsAt@plex>
References: <20260519155324.2692594-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260519155324.2692594-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_120750_132123_30DB75F4 
X-CRM114-Status: GOOD (  25.90  )
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

On 05-19 17:53, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> Currently, KHO only prints scratch sizes when the size is specified
> by the command line. It prints nothing when the size is calculated
> at runtime by counting RSRV_KERN.
> 
> These prints are completely useless. When the user specified the size on
> the command line, they already know how large the scratch areas are. And
> that information is readily available by looking at the command line. It
> is a lot more useful to know the sizes that are calculated at runtime
> since they can vary by kernel version. Plus, if KHO fails to allocate
> the scratch areas, the calculated scratch sizes are not available via
> debugfs.
> 
> Print the scratch sizes in kho_reserve_scratch(). Do it before making
> the allocations. The size can provide hints for the failure reason.
> 
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 33fcf848ef95..b030f53f2235 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -621,11 +621,6 @@ static int __init kho_parse_scratch_size(char *p)
>  	scratch_size_pernode = sizes[2];
>  	scratch_scale = 0;
>  
> -	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB pernode: %lldMiB\n",
> -		  (u64)(scratch_size_lowmem >> 20),
> -		  (u64)(scratch_size_global >> 20),
> -		  (u64)(scratch_size_pernode >> 20));
> -
>  	return 0;
>  }
>  early_param("kho_scratch", kho_parse_scratch_size);
> @@ -691,6 +686,10 @@ static void __init kho_reserve_scratch(void)
>  		goto err_disable_kho;
>  	}
>  
> +	pr_notice("scratch areas: lowmem: %lluMiB global: %lluMiB\n",
> +		  (u64)(scratch_size_lowmem >> 20),
> +		  (u64)(scratch_size_global >> 20));
> +
>  	/*
>  	 * reserve scratch area in low memory for lowmem allocations in the
>  	 * next kernel
> @@ -725,6 +724,9 @@ static void __init kho_reserve_scratch(void)
>  	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		size = scratch_size_node(nid);
> +
> +		pr_notice("scratch_areas: nid %d: %lluMiB\n", nid, size >> 20);

Please use a space instead of an underscore to match the other string: 
"scratch areas". Keeping the prefix identical makes log parsing and 
filtering much cleaner.

Unrelated to this patch—this is something I brought up to Pratyush off-list, 
but I really dislike the 'KHO scratch' terminology.

First, it isn't actually 'scratch' space, as the kernel relies on it to 
allocate crucial early boot memory, which it then uses permanently. 
Second, we cannot preserve anything within this specific region. 

Down the line, I'd like to rename this to something more descriptive that clearly 
conveys both its importance to early boot and its non-preservable nature. For 
now, the print adjustments themselves look good.

I do not know it should be, but something like kho_bootstrap area sounds 
better than kho_sratch area.

> +
>  		addr = memblock_alloc_range_nid(size, CMA_MIN_ALIGNMENT_BYTES,
>  						0, MEMBLOCK_ALLOC_ACCESSIBLE,
>  						nid, true);
> 
> base-commit: 34e8f02817e31826e76bb2ded48bf28fe921f20b
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

