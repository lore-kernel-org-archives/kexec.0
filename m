Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0F5606A333
	for <kexec@archiver.kernel.org>; Fri, 13 Nov 2026 17:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sPbVamzF;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=e2gHZ26b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TmmnV/ymSMAI2Dol5zCaEFZv43vlX+d7yneKTBH5aJI=; b=sPbVamzFHkoMPh
	qXamAr2yZYeBWiYAsgMrw6oYzsIuKT+uVqZJOD6m5PW9yWZUYP6xhKJHpEJNDMbzjHjMqXDgdyt6h
	ocXpHfReAWK/sC3uMICnYZpg1Np0/XymhZah2A4ZHmSW1YDbiTUkgfcob6TAg/3SZmtin5rFidUd0
	TjfXkYcffl4WIWhszbV+uDkw4xB0l8+iqcGdoNv3Z5fjzGW2T13LybnumpgRxM+Bsh8midq+WNF0T
	SSRZKDGs5Kpssw7bc4XQ9glWLGVqg8Dd4lj2EkkAT6KOhdBxadtlxK5EIcJL08MPV6S+vsv8mM2Hq
	Z+4khFd6y94oFILga+oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRujc-0000000Dh0R-2CnD;
	Fri, 13 Nov 2026 17:06:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRujZ-0000000DgzW-2cn3
	for kexec@lists.infradead.org;
	Fri, 13 Nov 2026 17:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794589600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmmnV/ymSMAI2Dol5zCaEFZv43vlX+d7yneKTBH5aJI=;
	b=e2gHZ26bDcZVmjNnP5itMSUk0JgsqlVoufhv6xY8lYsxY1w3opJu7NVXsJL0AvdpI63mfY
	ABeRWr3Z5VBwI85EXuKBY+LG3gX0iEyduiduJrFtDNQWcOkXykG9mnQavh7414TxRav0Te
	t7zj0wuaEfaVh0tk0jA8CP6k7naMr3E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-jajO78T_Ps6MtBd7p-C2Qw-1; Fri, 13 Nov 2026 12:06:39 -0500
X-MC-Unique: jajO78T_Ps6MtBd7p-C2Qw-1
X-Mimecast-MFC-AGG-ID: jajO78T_Ps6MtBd7p-C2Qw_1794589598
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b15e47e57fso721779a91.3
        for <kexec@lists.infradead.org>; Fri, 13 Nov 2026 09:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589598; x=1795194398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TmmnV/ymSMAI2Dol5zCaEFZv43vlX+d7yneKTBH5aJI=;
        b=Q9Q77g+l6VIw/Xuo2X3PaR6csGLJ0D9aSvxQ5qK3wvL/9wjbgwX1DqVqXoS/bxnkON
         vg/cuZAtsC6QXjsCXv8BAdeneTwnj3HqiYMa0NH735ZhNUN+Y8xYv0kBYv+vxklI+5Oi
         /6alqnafM8N3oggJ4l0h5iF8OY875fsk/Ahn7q8WqE0zv9JVvXUUJaKIAm0ONW5kp+lM
         fyUGL2TkrgEIUYrU8utOdJiRF1/Wb/mqEUQKpKKERcrYJWgWEdFh6TyVZ3R1iS0OQW65
         bwbMfDiVrI1nYQRuj3wt+e+604ihBDJVHmDPho0NqMr095UrR9Zq7+gllwxm+IBQ+6hW
         1lEw==
X-Forwarded-Encrypted: i=1; AL+hErHNlxhqkuoqehm9JlR7XFjRyqvtxspQG5c2wa7GXWGxl3zezFqZXZ5uLY9hv8ZZmeRsOa6X8g==@lists.infradead.org
X-Gm-Message-State: APuU4Z9IWrWdDibcLlNJIsJx06UvHwUK+Y0JIuPur5yqK6Ndk20TXl7J
	ApWgNNzrnNOSXA5bD42KyiX9YIuma3vFx15Hehejcv5rVyXhF3vLkCd2VTH9ogYJNxlt1SzaI+E
	iaJhNQW2+RydoH2Hcbjc3O/1cv4ucDxUAx9hxN8ez7aG/Dce3HlkPMtjlT41GRg==
X-Gm-Gg: AYBFou23E0BjLriurWYqPEFPkhjv3HF1LRmaEokvarBg3UbUETHg50S+1Kjg4RB3vx/
	IeT1xlgTeL3b7uHTlRdfI/4LVqKEzulTgS/reQG4OnLcf92juAu7gfaSpsApUphtj3TN/MQJcsQ
	MS1nXhvVmHS1B/3kuzhbbfwZ6Y2JmmHuHWxtYmHOZe1QABZYYY01lOdpy9IWsMKswuG1ynukUgK
	jbXDC3lnaL+oMz3TEcW0K1gJ/OlGuyzXrt6hkNsmIoCJcW5wFyK9GNzWVV8QRoFpob8wNOsjiLs
	rq1ON/tjwAXEeXixSLkewHO4C6VZAEfvjcTalmTEes1ql1NYyBdxLXD6vfN8yprVFlzCkg1TkgW
	gz1FLCMl8HtaD3iQ9kL0EZkT/FqBqjf4r8nDllSI/qfa1/gJtJqI6QeSGQS4VQAggHLextAU=
X-Received: by 2002:a17:90a:dfcf:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b1b0a1b56fmr2668130a91.26.1794589598110;
        Fri, 13 Nov 2026 09:06:38 -0800 (PST)
X-Received: by 2002:a17:90a:dfcf:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3b1b0a1b56fmr2668105a91.26.1794589597671;
        Fri, 13 Nov 2026 09:06:37 -0800 (PST)
Received: from [192.168.1.102] ([117.245.168.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b3b110c0sm2247977a91.3.2026.11.13.09.06.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:06:37 -0800 (PST)
Message-ID: <2bae83be-bb44-4541-bf1c-5861f73a7394@redhat.com>
Date: Fri, 13 Nov 2026 22:36:30 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] kho: reject zero bootmem scale
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Pei <cp0613@linux.alibaba.com>, George Guo <guodongtai@kylinos.cn>,
 Kexin Liu <liukexin@kylinos.cn>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Sourabh Jain <sourabhjain@linux.ibm.com>, kexec@lists.infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20261112-kho-bootmem-sizing-v3-0-f0c8d00295d5@kernel.org>
 <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261112-kho-bootmem-sizing-v3-1-f0c8d00295d5@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Aj1_-a7epFsesZE9vVRVBmLXZZM1StFNYt34H47Kn9I_1794589598
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_090641_749871_A191DD9E 
X-CRM114-Status: GOOD (  16.05  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 12/11/26 4:08 pm, Mike Rapoport (Microsoft) wrote:
> kho_bootmem=0% sets bootmem_scale to 0, and then the bootmem areas are
> sized using the explicit sizes that default to 0. KHO remains enabled,
> but there is no usable bootmem to load the next kernel.
> 
> Reject zero scale the same way zero explicit sizes are rejected.
> 
> Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  kernel/liveupdate/kexec_handover.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 6f1f55fe31819..b30ba686cb301 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -703,16 +703,22 @@ static int __init kho_parse_bootmem_size(char *p)
>  	if (p[len - 1] == '%') {
>  		/* unsigned int max is 4,294,967,295, 10 chars */
>  		char s_scale[11] = {};
> +		unsigned int scale;
>  		int ret = 0;
>  
>  		if (len > ARRAY_SIZE(s_scale))
>  			return -EINVAL;
>  
>  		memcpy(s_scale, p, len - 1);
> -		ret = kstrtouint(s_scale, 10, &bootmem_scale);
> -		if (!ret)
> -			pr_notice("bootmem scale is %d%%\n", bootmem_scale);
> -		return ret;
> +		ret = kstrtouint(s_scale, 10, &scale);
> +		if (ret)
> +			return ret;
> +		if (!scale)
> +			return -EINVAL;
Reviewed-by: Mukesh Pilaniya <mpilaniy@redhat.com>

> +
> +		bootmem_scale = scale;
> +		pr_notice("bootmem scale is %d%%\n", bootmem_scale);
> +		return 0;
>  	}
>  
>  	/* parse ll[KMG],mm[KMG],nn[KMG] */
> 

-- 
Regards,
Mukesh Pilaniya


