Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10B5C369AB
	for <kexec@archiver.kernel.org>; Fri, 18 Apr 2025 07:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QABA+4fTDSXQvJf458msUaFwdO5SGKVJYc6eOdgU/eg=; b=Kqqjm4wwfTiRMD1FAnU00bN+/A
	onk2iVRAubZM51AmMunnCpx+iw1Jt+vhItfff1ZYhGu1N/1QsYfWPSWFEh9LdTrFJ8FKXlCvqrb8o
	TAjR8P+IwjKu2GhLDJqpmtEZlz0otVPZ3vj3D15xDxMLSakJy7JKabY2KlOw/Qnpb3WB2TTgd3GW1
	7KWMUu8VaFn7INIeSuVoNvUHmGppxwePgbp+CpjSzvP2mrvS85uEX6+XxSS40ZlL/beMctxeahykh
	WSqhLzQ969UW6/FEWxft+ObyxDajymd8TVNWqgsg3Eb5pa11iF7UGyyrbbUW+UxrgmCIBpjwGLNLd
	RPFJt6Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5gdU-0000000FXpc-0DNM;
	Fri, 18 Apr 2025 07:59:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5gHv-0000000FUdJ-281t
	for kexec@lists.infradead.org;
	Fri, 18 Apr 2025 07:37:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744961846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QABA+4fTDSXQvJf458msUaFwdO5SGKVJYc6eOdgU/eg=;
	b=BkItQCCsGPGRhu75guSDOyeBBwTULk2+4TlbP1lzPT5eiZIMUoNJSPYvbLdn0nAbkgjNxR
	acaCapyzH4ZwJxMJoS+bU5EgqJ7oL3ejXeMsC7MsRE6UhXpL4a83sBbQVj+hrCUMzRLy2K
	2xjlXIRHCcLHCpmhK4XcFMq6cQhvQdo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-IWoL9Hl0OVOTip_iF6TP0Q-1; Fri,
 18 Apr 2025 03:37:21 -0400
X-MC-Unique: IWoL9Hl0OVOTip_iF6TP0Q-1
X-Mimecast-MFC-AGG-ID: IWoL9Hl0OVOTip_iF6TP0Q_1744961839
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 57FA11955DC5;
	Fri, 18 Apr 2025 07:37:18 +0000 (UTC)
Received: from localhost (unknown [10.72.112.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6B8741956095;
	Fri, 18 Apr 2025 07:37:15 +0000 (UTC)
Date: Fri, 18 Apr 2025 15:37:11 +0800
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
Subject: Re: [PATCH v12 4/9] ima: kexec: skip IMA segment validation after
 kexec soft reboot
Message-ID: <aAH9rGzumUIMMR7R@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-5-chenste@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-5-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_003727_675598_B71E90BA 
X-CRM114-Status: GOOD (  31.72  )
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

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> Currently, the function kexec_calculate_store_digests() calculates and
> stores the digest of the segment during the kexec_file_load syscall,
> where the  IMA segment is also allocated.
> 
> Later, the IMA segment will be updated with the measurement log at the
> kexec execute stage when a kexec reboot is initiated. Therefore, the
> digests should be updated for the IMA segment in the  normal case. The
> problem is that the content of memory segments carried over to the new
> kernel during the kexec systemcall can be changed at kexec 'execute'
> stage, but the size and the location of the memory segments cannot be
> changed at kexec 'execute' stage.
> 
> To address this, skip the calculation and storage of the digest for the
> IMA segment in kexec_calculate_store_digests() so that it is not added 
> to the purgatory_sha_regions.
> 
> With this change, the IMA segment is not included in the digest
> calculation, storage, and verification.
> 
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>

You may need to set tags as below for this patch:

Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>

=======Quoted from Documentation/process/5.Posting.rst=====
 - Co-developed-by: states that the patch was co-created by several developers;
   it is a used to give attribution to co-authors (in addition to the author
   attributed by the From: tag) when multiple people work on a single patch.
   Every Co-developed-by: must be immediately followed by a Signed-off-by: of
   the associated co-author.  Details and examples can be found in
   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`.
========

Other than this nit, this looks good to me:

Acked-by: Baoquan He <bhe@redhat.com>

> ---
>  include/linux/kexec.h              |  3 +++
>  kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>  security/integrity/ima/ima_kexec.c |  3 +++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 7d6b12f8b8d0..107e726f2ef3 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -362,6 +362,9 @@ struct kimage {
>  
>  	phys_addr_t ima_buffer_addr;
>  	size_t ima_buffer_size;
> +
> +	unsigned long ima_segment_index;
> +	bool is_ima_segment_index_set;
>  #endif
>  
>  	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..606132253c79 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
> +		return true;
> +	else
> +		return false;
> +}
> +#else
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int kexec_calculate_store_digests(struct kimage *image);
>  
>  /* Maximum size in bytes for kernel/initrd files. */
> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		if (ksegment->kbuf == pi->purgatory_buf)
>  			continue;
>  
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (check_ima_segment_index(image, i))
> +			continue;
> +
>  		ret = crypto_shash_update(desc, ksegment->kbuf,
>  					  ksegment->bufsz);
>  		if (ret)
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index b12ac3619b8f..7e0a19c3483f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -145,6 +145,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -155,6 +156,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_addr = kbuf.mem;
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
> +	image->ima_segment_index = image->nr_segments - 1;
> +	image->is_ima_segment_index_set = true;
>  
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		      kbuf.mem);
> -- 
> 2.43.0
> 


