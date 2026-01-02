Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D26FA374F
	for <kexec@archiver.kernel.org>; Fri,  2 Jan 2026 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1eJCz3IMCVzaPFR9n+LpYQ3cFp/Gh9wDP5j0bwatno=; b=O9souxMUmRvbCcBY0Ce5seMdPu
	1j/lVLEZXF1JrJcWyk8YliLVkyoB5V6DEVmQY6BMAQG3OEyJw/NhuC6usXa6HJY1sYYdKNYMJ6yy8
	3Qio4Ht3hhPTIp5/iWCSlStMiOdPFYTHgR7UnZbs1ZMt3kvkXzx9VRv1gYnKfj8rBLvybaztU9TpD
	9MvssFJWVQFr1FBSgXPbMGoSA4xgCXOn2CXwfghrYkHjt1JK/kVTI33cwQD7bY9142QelsLP2rwXj
	fKYyXjNwyPgYs2b7Rzhpah5+uQQG+YsONJJWIViX0hCJ9PRKAxEWSet1Qbp+oC0liiqNoBgrnG/Oa
	FeJ1ex+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgn2-00000008Pe1-33oO;
	Fri, 02 Jan 2026 15:10:08 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbgmx-00000008Pcl-05Br
	for kexec@lists.infradead.org;
	Fri, 02 Jan 2026 15:10:04 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4775895d69cso51545415e9.0
        for <kexec@lists.infradead.org>; Fri, 02 Jan 2026 07:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767366601; x=1767971401; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1eJCz3IMCVzaPFR9n+LpYQ3cFp/Gh9wDP5j0bwatno=;
        b=JGuF0EMwhXmIEAa++k2BM0o/RLgsN8qnUtD26C0A7uX8z2zeA7JYTBoJWwminSVV7c
         crNjeaAJpueL8/WBt4o2EQllMCHX4+sRuv+cFJWiyqxku6YoiLz9Pc5pyoesG5tY0qsP
         6j6NUzZEXeiz1BX+JwZcV0wki53S420CK4CAkxQ6Zs/jMJ0dn8EeeeLCuGoiPWIACNx0
         zMmyGgya6bt+O+F1Dz6QOSoExqeDzCpMS0FJes++1mxHwHmMRhzK7gVP4/lOnuKANIUQ
         ffA3k9ai5Pb/z3H+YNRhkC1CfmhEkM2k40XfLVTyx8QmDhj8Rrw34zAcIT/0ABQ0Q4a3
         4J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767366601; x=1767971401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1eJCz3IMCVzaPFR9n+LpYQ3cFp/Gh9wDP5j0bwatno=;
        b=guhNz5NSxOKmHdi0FBHyQMO95oH8pE24RcCjzZEtPVJqq2eFU/EuA4RhaIIS0lee3m
         oq/GQd7UcO2RKyDwXKEfEOCgzmkz+e12k3TGnSCSHPY41x8T29IQKhcJFZf5TPAPVKQV
         mLPadC5I4bqJuYEjSrfRxcPX9ljGVdXJyHjuA7lRUNlPWHo6h2/untF/I8B6ADjhHVOF
         07hNT74BTHIa2fqyvQiq3cQ35o3bGd90e821zt9BYUgiRDOX4M/yEmn8YPrJ9mVr9QFL
         wYHEY2V6WXZ7CkZm/Nh3EsKQP3aYXcpJ6Zl7TDwvuJcXMLkN427nGrFwRjxqG+z0Q91l
         cRWg==
X-Forwarded-Encrypted: i=1; AJvYcCXom3yCKQ/PWWsDRxwAAXCDX1NZNiHYhdPtiQ6gZni1J+fghpEDgS5y9bcfTYSXrE6JlouHFQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyurEZEBqiIHHIgRu3+3Ev+sj9YNoOCabpxvbS+9RQYj+UobtX7
	zy6nS/rNau+zGvpYWYwIpkCsbQDcpxX/Kf6FXVT9SE2u3mi4dg/ue77F
X-Gm-Gg: AY/fxX65UdWFbjDbISPvdm1Hq0toqXAA/5twYDbqYi2NKEB0A9wYFPBgn0hgEqqA5ds
	89uvkwLVSA9FgnMfKztarx77SSUyxQT6wzkZniFrwPolycpqNs9CfMMsGEVEhK7y26fFNoQmzWD
	2+ErUnRkZmytuJIGAsFA9NpMxWpdQlU+1y2F/7m0rBX3rRtY3JTj6/IKgX0TSe9ZhDdVRswyiKX
	7rK5pHeDF40K/W9TkT0nN2X/3irMJFI8DohiFUsqhPqY1iqOgWhTepzUivsQevpBhtWjbhWqRGf
	neScZHHq8hQMf0ffpW3nEvnnBYG+5BrLLovMT5VZ+6ELUlkAgGbzUFZxmf5PBJ2fhtjTcPt3O0u
	RPlaffrNgv/kWPz8u6/xwh7+3pNL0JOsoBIgVMN0eoDE8jddcZtXsZ2Ow2da+57Ju8or0gzr1kt
	m7pTUktRl4ilnJXtSqaCQvOUrxyIrDkuKuD8+5Ylxbp3WAUQGgNpnXAJ4zyPcFtot/ueTho6MeN
	cB9WvJLNMD4
X-Google-Smtp-Source: AGHT+IH3RpKWczLY+gkhjq2AtrhL06nZ1EdBricEWM1SCBl/FAK+3Z835dNOj1erlKquHw/1w2TN/Q==
X-Received: by 2002:a05:600c:4f4f:b0:46f:d682:3c3d with SMTP id 5b1f17b1804b1-47d1955187fmr636047545e9.13.1767366600834;
        Fri, 02 Jan 2026 07:10:00 -0800 (PST)
Received: from ?IPV6:2001:16a2:c8d2:2b00:183a:1350:d3a4:d89? ([2001:16a2:c8d2:2b00:183a:1350:d3a4:d89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea226d1sm87195021f8f.13.2026.01.02.07.09.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jan 2026 07:10:00 -0800 (PST)
Message-ID: <fc542a5e-db54-4d7e-b363-42cc253b1a8c@gmail.com>
Date: Fri, 2 Jan 2026 18:09:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kexec: history: track kexec boot counter
Content-Language: en-GB
To: Breno Leitao <leitao@debian.org>, Alexander Graf <graf@amazon.com>,
 Mike Rapoport <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-mm@kvack.org, rmikey@meta.com, clm@fb.com, riel@surriel.com,
 kernel-team@meta.com
References: <20260102-kho-v2-0-1747b1a3a1d6@debian.org>
 <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20260102-kho-v2-2-1747b1a3a1d6@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260102_071003_089783_94DF940F 
X-CRM114-Status: GOOD (  24.32  )
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



On 02/01/2026 17:53, Breno Leitao wrote:
> Track and display the number of kexec boots since the last cold reboot
> when CONFIG_KEXEC_HISTORY is enabled.
> 
> This extends the previous kernel release tracking feature by adding
> a counter that increments with each kexec boot. The counter provides
> visibility into the kexec chain depth, which is useful for understanding
> boot history in production environments.
> 
> Add a new property, "kexec-count" in KHO FDT alongside the existing
> "previous-release" property. The counter is:
> 
>  - Initialized to 0 when kho_in is instantiated.
>  - Incremented by 1 on each subsequent kexec.
>  - Printed alongside the previous kernel release version.
> 
> The counter is stored as a 32-bit unsigned integer in FDT format and is
> only active when CONFIG_KEXEC_HISTORY is enabled.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Suggested-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/kexec_handover.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
> index 06d99627bb3c..fe5a2c5c4c86 100644
> --- a/kernel/liveupdate/kexec_handover.c
> +++ b/kernel/liveupdate/kexec_handover.c
> @@ -38,6 +38,7 @@
>  #define PROP_PRESERVED_MEMORY_MAP "preserved-memory-map"
>  #define PROP_SUB_FDT "fdt"
>  #define PROP_PREVIOUS_RELEASE "previous-release"
> +#define PROP_KEXEC_COUNT "kexec-count"
>  
>  #define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
>  
> @@ -1257,6 +1258,7 @@ struct kho_in {
>  	phys_addr_t scratch_phys;
>  #ifdef CONFIG_KEXEC_HISTORY
>  	char previous_release[__NEW_UTS_LEN + 1];
> +	u32 kexec_count;
>  #endif
>  	struct kho_debugfs dbg;
>  };
> @@ -1330,6 +1332,9 @@ static __init int kho_out_fdt_setup(void)
>  	void *root = kho_out.fdt;
>  	u64 empty_mem_map = 0;
>  	int err;
> +#ifdef CONFIG_KEXEC_HISTORY
> +	u32 kexec_count;
> +#endif
>  
>  	err = fdt_create(root, PAGE_SIZE);
>  	err |= fdt_finish_reservemap(root);
> @@ -1340,6 +1345,10 @@ static __init int kho_out_fdt_setup(void)
>  #ifdef CONFIG_KEXEC_HISTORY
>  	err |= fdt_property_string(root, PROP_PREVIOUS_RELEASE,
>  				   init_uts_ns.name.release);
> +	/* kho_in.kexec_count is set to 0 on cold boot */
> +	kexec_count = cpu_to_fdt32(kho_in.kexec_count + 1);

Should this be kexec_count = cpu_to_fdt32(kho_in.kexec_count) + 1; ?

> +	err |= fdt_property(root, PROP_KEXEC_COUNT, &kexec_count,
> +			    sizeof(kexec_count));
>  #endif
>  	err |= fdt_end_node(root);
>  	err |= fdt_finish(root);
> @@ -1468,6 +1477,7 @@ void __init kho_memory_init(void)
>  static void __init kho_print_previous_kernel(const void *fdt)
>  {
>  	const char *prev_release;
> +	const u32 *count_ptr;
>  	int len;
>  
>  	prev_release = fdt_getprop(fdt, 0, PROP_PREVIOUS_RELEASE, &len);
> @@ -1476,8 +1486,19 @@ static void __init kho_print_previous_kernel(const void *fdt)
>  
>  	strscpy(kho_in.previous_release, prev_release,
>  		sizeof(kho_in.previous_release));
> -	pr_info("This kernel was kexec'ed from kernel release: %s\n",
> -		kho_in.previous_release);
> +
> +	/* Read the kexec count from the previous kernel */
> +	count_ptr = fdt_getprop(fdt, 0, PROP_KEXEC_COUNT, &len);
> +	if (WARN_ON_ONCE(!count_ptr || len <= 0))
> +		/*
> +		 * PROP_KEXEC_COUNT should exist if PROP_PREVIOUS_RELEASE
> +		 * exists.
> +		 */
> +		return;
> +	kho_in.kexec_count = fdt32_to_cpu(*count_ptr);
> +
> +	pr_info("This kernel was kexec'ed from kernel release: %s (kexec count: %u)\n",
> +		kho_in.previous_release, kho_in.kexec_count);
>  }
>  #else
>  static void __init kho_print_previous_kernel(const void *fdt) { }
> 


