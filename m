Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D115E77188
	for <kexec@archiver.kernel.org>; Wed,  8 Jan 2025 12:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uA4of6RlcxZAbgA2Z8vduXo/qnfVApJjLKxtUFTyI38=; b=Qs9bNnGksmLCyYOtJ7YXx39u6W
	BenUqtrMpRH7CVB/KIOZYMjD1bQh5jGrrVNuxsONP0+x3Cxu4lhNmM927nAiqU/gWfXGhfQyScTJm
	4iptpzT93qu2yCKM4hhJTOs1RZJgINbnPMz3mOR3DnFlAZ4J8rUXV1gEx+auTWn6dZB0phqMz10vj
	VpI/C4ib0JglhJNljXcWM7cNxNUbnQAo7Ubsgs0NzUWLRnU02FgRPDHEJ+c4SG4JJIJAf9fH3qlKm
	ltHG0il6UM+18aafXL6JGhlFHVakdYwmluS87UAj8PYsZwbl9gcWJ8xXuay8lX2GJYOOYcTusiv9K
	tj1F35eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUx2-00000008NZL-074T;
	Wed, 08 Jan 2025 12:14:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVUPR-00000008FXh-0lrY
	for kexec@lists.infradead.org;
	Wed, 08 Jan 2025 11:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736336376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uA4of6RlcxZAbgA2Z8vduXo/qnfVApJjLKxtUFTyI38=;
	b=TNHr9Jma7KSJedYCgAa9ZT4JH2hPiQYnhSVzw+/s7Hhp+kSTUl+47hDXwBvYSfPzFi1eHx
	BSbd9JIyr6KRspsm8LGLenOPQ42phMX47wb1azvUlk2OdQD6jj58w9SJNdPzdimJr/Zmzk
	ZjWsIPHBRH2eGzU/pH4M9SNOz4nhUqE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-iWpE5GpyP-m3fwd1BjczMg-1; Wed,
 08 Jan 2025 06:39:32 -0500
X-MC-Unique: iWpE5GpyP-m3fwd1BjczMg-1
X-Mimecast-MFC-AGG-ID: iWpE5GpyP-m3fwd1BjczMg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACDA719560B4;
	Wed,  8 Jan 2025 11:39:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4E419560AA;
	Wed,  8 Jan 2025 11:39:11 +0000 (UTC)
Date: Wed, 8 Jan 2025 19:38:13 +0800
From: Baoquan he <bhe@redhat.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v1 5/5] crash: option to let arch decide mem range
 is usable
Message-ID: <Z35jpYq4GvCAXiII@MiWiFi-R3L-srv>
References: <20250108101458.406806-1-sourabhjain@linux.ibm.com>
 <20250108101458.406806-6-sourabhjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108101458.406806-6-sourabhjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_033937_294015_5A65490E 
X-CRM114-Status: GOOD (  14.84  )
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

On 01/08/25 at 03:44pm, Sourabh Jain wrote:
...snip...
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..407f8b0346aa 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -205,6 +205,15 @@ static inline int arch_kimage_file_post_load_cleanup(struct kimage *image)
>  }
>  #endif
>  
> +#ifndef arch_check_excluded_range
> +static inline int arch_check_excluded_range(struct kimage *image,
> +					    unsigned long start,
> +					    unsigned long end)
> +{
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_KEXEC_SIG
>  #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
>  int kexec_kernel_verify_pe_sig(const char *kernel, unsigned long kernel_len);
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..52e1480dbfa1 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -464,6 +464,12 @@ static int locate_mem_hole_top_down(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Make sure this does not conflict exclude range */
                                                   ^
                Make sure this doesn't conflict with excluded range?

> +		if (arch_check_excluded_range(image, temp_start, temp_end)) {
> +			temp_start = temp_start - PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> @@ -498,6 +504,12 @@ static int locate_mem_hole_bottom_up(unsigned long start, unsigned long end,
>  			continue;
>  		}
>  
> +		/* Make sure this does not conflict exclude range */
                                                   ^
                                                 Ditto.

> +		if (arch_check_excluded_range(image, temp_start, temp_end)) {
> +			temp_start = temp_start + PAGE_SIZE;
> +			continue;
> +		}
> +
>  		/* We found a suitable memory range */
>  		break;
>  	} while (1);
> -- 
> 2.47.1
> 


