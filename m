Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F344C35FFC
	for <kexec@archiver.kernel.org>; Thu, 20 Mar 2025 02:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llxsDGyF5OTS0kLxtrZq1xxBUU0ow8OofIklAK3fpNU=; b=bdY9YmJa3bade85pThYkiuPv2S
	G7qpOw5gSySxRPReb2RiSD8kc1jFlTOLKDTWPM29MyKw6tNbvDY+9Ph7DNSHgvtTMQ3RuNbjsAGj4
	f9rHWVW46CJ8cxLdL89ecrwNwLqcNAbshcjvdDxfE0MerHGe3guSMiIbN4ntRu6NJ/VXIJ9DVIf0F
	+C7ZPq1sQw0/qJsVHVy1BXAQoQkL16roFL5EYPS3FRsBNSLEyCa8d4NWooysbNc2U2bo+C+uyh1uH
	/Pc11jRBi1L3cisDv/3JMI1YnX4OZ7MtOsS2AhQBQdIjnxcD8/Thho+Uz+kLR+8qXOA66CUersCmc
	0X5VoTmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv61h-0000000AwII-2tNN;
	Thu, 20 Mar 2025 02:52:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv61f-0000000AwHu-0aCv
	for kexec@lists.infradead.org;
	Thu, 20 Mar 2025 02:52:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742439172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llxsDGyF5OTS0kLxtrZq1xxBUU0ow8OofIklAK3fpNU=;
	b=KS0n7N12zQjHu9FwMVsjXLGXj//d/lM+XPVYlUc5XIWwJYQgvnvua/eQ8a8emJfKGtXLsn
	7gWKieTCksEQPKmfOkMtvp9d6/JZxdzrMiQSEyNRFoYNsnZd0SL5cVIxuIKww0WVih3O9m
	jH9DhYTB66uDf8zdkPePnRwJnARJuvw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-BuMgurEROi-9O3Ip2yolXw-1; Wed,
 19 Mar 2025 22:52:49 -0400
X-MC-Unique: BuMgurEROi-9O3Ip2yolXw-1
X-Mimecast-MFC-AGG-ID: BuMgurEROi-9O3Ip2yolXw_1742439167
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74EC41800875;
	Thu, 20 Mar 2025 02:52:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66BA180174E;
	Thu, 20 Mar 2025 02:52:42 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:52:38 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v10 7/8] ima: make the kexec extra memory configurable
Message-ID: <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-8-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-8-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_195255_259375_1B708815 
X-CRM114-Status: GOOD (  25.60  )
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

On 03/17/25 at 06:04pm, steven chen wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.  Make it configurable.
> 
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.  Ensure the default value of the option is set such
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
> 
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
> 
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/Kconfig     | 10 ++++++++++
>  security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 475c32615006..d73c96c3c1c9 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>  	help
>  	   This option disables htable to allow measurement of duplicate records.
>  
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int "Extra memory for IMA measurements added during kexec soft reboot"
> +	depends on IMA_KEXEC
> +	default 0

Is there range for this memory, e.g [0, max] and max will be a value
according to our current perception?

> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value of 0, an extra half page of memory for those
> +	  additional measurements will be allocated.
> +
>  endif
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index c390c745f882..0f214e41dd33 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -131,6 +131,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  				  .buf_min = 0, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	unsigned long binary_runtime_size;
> +	unsigned long extra_memory;
>  
>  	/* use more understandable variable names than defined in kbuf */
>  	size_t kexec_buffer_size = 0;
> @@ -138,15 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_memory = PAGE_SIZE / 2;
> +	else
> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
> +
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>  		pr_err("Binary measurement list too large.\n");
> -- 
> 2.25.1
> 
> 


