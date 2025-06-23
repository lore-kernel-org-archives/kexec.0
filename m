Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0942C77B7C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 18:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FoUo8AFa374U8mDLmsqMuBlqEBkyH8ANfZ6omhJKFpo=; b=GGbWo4wPrAbQOnIfnfPPkzLcS+
	vbtfX6AGcDl2LL9g5GtWs1aDyDG7EN1g1NskX+dBlB/c01Yg6sSi2c5eZarzr1Shyb1BzNVNjiaNc
	lHi7lHpATbHpgBs6w+o5dhtpfGH24o8sG6RIMLwI6VNt+Wrc4CBG50as+sElAyL2g5IQ1XgVzPTUp
	rBhd42XII3YGig3WZ7go5Gs32eIF5LvKjnbXTy/YsMNAUJBDVWUhqTBRE9pr85ctlBvM43f4sown1
	MU9rsTNrmEZgk1oGRiDkKuQgwZL23TuEGgB5edLzIiGFhueqtD1t3lSP+b38m4hQ1LZ2cA1M2Ub6Z
	WGv/ZdnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTlVY-00000003dYC-3kvI;
	Mon, 23 Jun 2025 18:03:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTiI4-000000034lb-1l1H
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 14:36:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750689414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FoUo8AFa374U8mDLmsqMuBlqEBkyH8ANfZ6omhJKFpo=;
	b=IS4NlR2Y3LrT0Tygq6TK2Rxrwk9ola9kf2G7H8YLGT/Z8+drrbfWW1o8MR0sQL7ER8ZPcB
	JTBtXjKhFxmEDKfeE2TD4EILTjRz0GkDhhG4W7TS8ovCBK1DBgoQ4avUM/MdJovDNba12u
	rPMQrcZtjGYTiEnHE4Ds3REU6bmHTeA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-7UR_P_yuPEaNfeJvmmCHwg-1; Mon,
 23 Jun 2025 10:36:53 -0400
X-MC-Unique: 7UR_P_yuPEaNfeJvmmCHwg-1
X-Mimecast-MFC-AGG-ID: 7UR_P_yuPEaNfeJvmmCHwg_1750689412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 112A7195608A;
	Mon, 23 Jun 2025 14:36:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B3CC30001A1;
	Mon, 23 Jun 2025 14:36:49 +0000 (UTC)
Date: Mon, 23 Jun 2025 22:36:45 +0800
From: Baoquan He <bhe@redhat.com>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, vgoyal@redhat.com, dyoung@redhat.com,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>
References: <20250623104704.3489471-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623104704.3489471-1-suhui@nfschina.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_073656_528893_0837BB5F 
X-CRM114-Status: GOOD (  21.04  )
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

On 06/23/25 at 06:47pm, Su Hui wrote:
> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> type from 'size_t' to 'unsigned int' for the consistency of data->size.

It's unclear to me why size_t is not suggested here. Isn't it assigned
a 'sizeof() + data->size' in which size_t should be used?

The rest two looks good to me, thanks.

> Return -ENOMEM directly rather than goto the label to simplify the code.
> Using scoped_guard() to simplify the lock/unlock code.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/proc/vmcore.c | 33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 10d01eb09c43..9ac2863c68d8 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1477,7 +1477,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  {
>  	struct vmcoredd_node *dump;
>  	void *buf = NULL;
> -	size_t data_size;
> +	unsigned int data_size;
>  	int ret;
>  
>  	if (vmcoredd_disabled) {
> @@ -1490,10 +1490,8 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		return -EINVAL;
>  
>  	dump = vzalloc(sizeof(*dump));
> -	if (!dump) {
> -		ret = -ENOMEM;
> -		goto out_err;
> -	}
> +	if (!dump)
> +		return -ENOMEM;
>  
>  	/* Keep size of the buffer page aligned so that it can be mmaped */
>  	data_size = roundup(sizeof(struct vmcoredd_header) + data->size,
> @@ -1519,21 +1517,18 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	dump->size = data_size;
>  
>  	/* Add the dump to driver sysfs list and update the elfcore hdr */
> -	mutex_lock(&vmcore_mutex);
> -	if (vmcore_opened)
> -		pr_warn_once("Unexpected adding of device dump\n");
> -	if (vmcore_open) {
> -		ret = -EBUSY;
> -		goto unlock;
> -	}
> -
> -	list_add_tail(&dump->list, &vmcoredd_list);
> -	vmcoredd_update_size(data_size);
> -	mutex_unlock(&vmcore_mutex);
> -	return 0;
> +	scoped_guard(mutex, &vmcore_mutex) {
> +		if (vmcore_opened)
> +			pr_warn_once("Unexpected adding of device dump\n");
> +		if (vmcore_open) {
> +			ret = -EBUSY;
> +			goto out_err;
> +		}
>  
> -unlock:
> -	mutex_unlock(&vmcore_mutex);
> +		list_add_tail(&dump->list, &vmcoredd_list);
> +		vmcoredd_update_size(data_size);
> +		return 0;
> +	}
>  
>  out_err:
>  	vfree(buf);
> -- 
> 2.30.2
> 


