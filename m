Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC682C77B7C
	for <kexec@archiver.kernel.org>; Mon, 23 Jun 2025 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/j2ABvQkeCCIY5OdnUsm4f6l2yn5EMgYcd1gCoSvvo=; b=p89I7WnwfNp1XtEszwlrWHe281
	zvjLUhyWQ4wy/CocveveB1s8142Cf2hzQeYW+zPLZv4u5npwneM6La8PGCAkqSXwTcCFEyxZa1N7C
	twnZKl8DYxPphcASSU7XUtV38FPk8BmJ7SRmTNRhzSiJg8W4wZFI/8lrd15MHNXR1cAEeE5HJ8wBV
	GEYIkkVaKCeS/LVSeR3uHqxfwrxZWb+CJKkOvNbqqhxH42tNdi0ntZsI+1Bs5uijd9sEc9lI75jNt
	eFCS9PSX8cM/2WKuG2VegfQlE2+oSYtK5hDj8z6+2DEW+tVsxd8mi3z9Xu2CxW2RVXEWhXEfLKicr
	RIpJNJaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTm5W-00000003ilE-01mG;
	Mon, 23 Jun 2025 18:40:14 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTiku-00000003A6j-1H05
	for kexec@lists.infradead.org;
	Mon, 23 Jun 2025 15:06:45 +0000
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-4067106dd56so2857689b6e.3
        for <kexec@lists.infradead.org>; Mon, 23 Jun 2025 08:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750691203; x=1751296003; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/j2ABvQkeCCIY5OdnUsm4f6l2yn5EMgYcd1gCoSvvo=;
        b=q/V+0CwdGPgCZ3fDUbrHoDhABMb7CBxlMtzJUGbQWMEB1bPLOnZjUUZhke6OGNWzPx
         Hn7xnigRLySR1d8IawTZtX0LGI2YbUnQNNNgixGSTBAQ2TVgXGMHIN+JMnK8EybJZ7OK
         U1B7MVh4DHJD9dN+UjAnrhVZswUQU0uDPWcDSLxvTnFjq4TSp1832MbUXldvtL1Qclpk
         txq0rY4g9DASiaeWSelrrkSV7lLEC8JCeBaHHEI42xsd/R9fenJCdW4OV2UKh3LmCMT0
         MC46olTebb2eBkFubu8roj/QT0ECDRo4EGRRfKckM1d7DXfsM6/1TavsSZwbSrzOszsv
         NxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750691203; x=1751296003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/j2ABvQkeCCIY5OdnUsm4f6l2yn5EMgYcd1gCoSvvo=;
        b=qYisjgC+380S3DW1cf5LBw6AIu9iO3Ht+scajEjJNnnlHlcUXP+N9A6zb70nUAaYot
         XCdM9XNd9T45vSbiMCrzhsTn+cIlQuqXhW1Ksy6f/jkFpg3vc2dcKcnSOGo33w4uOGg5
         iRSO3/cvfL7Aq5PMEpD5UNJIHII8sQDfARkA3dYn35Sjtwcbulsz1nCEDWecPPfJHFO+
         lmpmPaaRAqCXHYlYnLEELKnEqCm6UIuCoRDugGA8CD4DHPOqOCaZ6dKBJS4w4BwBt+X2
         ntSTrEctBEKCFf1YwJ94Ir4teJRJ5uMJtIIBd3IOETEk/OMNtCRxf1sS6bYm2dBJO77e
         N7Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXd4N6qYztgIQIaD84H6kOL4G0rfzUHICpOzcWxZ3s5bw9/IBfJjQrB0rxe8T64PIcr6sjfbg==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx6FT6RosBCEetJ3twMWLU38lvvrwv0rJKNX/uvc2CVv3+TYoNU
	moFnUs519nVIWZllgGPDVq4kO1ypf9gdprZCNocFk02gS4QRGVbYdRlt9aBfkS/Xmhs=
X-Gm-Gg: ASbGnctLYxJnQAVdr1/Wyr8txtwgkJzB2Bv4A3k0atGoCP/b6n3CcMWy8c6OnOLzRkk
	LyEeBlUKCIbqxAEDmkY9Vftk5X/HaiW16JvCWxY2NJyDznYvZTYkua/BBLp6QjxYqFfGWbOLs0W
	hgSRupe5eZPBBtnHQ6U4X7Bo5C8AqZkdSZmHAEFWud0tjzFhPSsopXIJFn9oH/RDUBg2W+UraEt
	mKQl5YUptRrIJMU2hpNPhgqzrZs9h5rCJfLM6yN6C1sZAGExzfT3i970XABzgP7SLuqE0K78Sam
	/ivx/xGf/GtJOnoZR0Rx7W7d3pWEEOUfFjgcM2BHhg1/dKRCNkIcMmwHelW9bl5PhktXLw==
X-Google-Smtp-Source: AGHT+IFnVBRfIjftIm0z+2nD3hcauMaTIzLigckSJhjmKqki1siCULVluA8fvloI9HOD+FViAKSc5g==
X-Received: by 2002:a05:6808:1890:b0:406:7704:b2e9 with SMTP id 5614622812f47-40ac6fe36d7mr9778035b6e.9.1750691202870;
        Mon, 23 Jun 2025 08:06:42 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8c3f:8b5f:5c74:76a9])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40ac6d394dfsm1419658b6e.43.2025.06.23.08.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:06:42 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:06:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Su Hui <suhui@nfschina.com>
Cc: akpm@linux-foundation.org, bhe@redhat.com, vgoyal@redhat.com,
	dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <33a9a2a5-a725-4ab0-865c-1d26e941e054@suswa.mountain>
References: <20250623104704.3489471-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623104704.3489471-1-suhui@nfschina.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250623_080644_343638_7F547041 
X-CRM114-Status: GOOD (  21.45  )
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

On Mon, Jun 23, 2025 at 06:47:05PM +0800, Su Hui wrote:
> There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> type from 'size_t' to 'unsigned int' for the consistency of data->size.
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

This was in reverse Christmas tree order before.  Move the data_size
declaration up a line.

	long long_variable_name;
	medium variable_name;
	short name;

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

Please, move this "return 0;" out of the scoped_guard().  Otherwise
it's not obvious that we return zero on the success path.

regards,
dan carpenter

> +	}
>  
>  out_err:
>  	vfree(buf);
> -- 
> 2.30.2
> 

