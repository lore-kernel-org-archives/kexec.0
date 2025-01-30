Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE59DC0218A
	for <kexec@archiver.kernel.org>; Thu, 30 Jan 2025 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8rFIImBxyaGje4BDC514vfFtI9P0pAWScJySKgkJyQg=; b=mhd2n/LCV+jDFiM/B1DveIZyJs
	a6D5fzTh1cmni9GK53V/1DnvfYu6Nb5umh1y+OdzTDhB6ceqBub1WB5kyEixTrrVMiCi4CwO45RKF
	RqzhSEQ/rkdej4VCbgAqfXAhnz0pmcKWXFLNwV6D6mNH3ZcwD0lVzRnlFMx8DY/zqyo5nwY8ViLin
	84ZMKRijEc4UZUoBmZtFIX7S5kptOqaGwJNzqJuIUS/VNUCw2t68yr+nh0U+D/zlmmvxlbxShPufe
	ICj7YlgK69ynt9wSjvuB8Twl4TrmjDygGlBYNepjGvNvRluwNM+AgJ/v32gaxMcELLc/5gf+l7Yjo
	4cikmNLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdROL-00000008Zbf-2BzI;
	Thu, 30 Jan 2025 10:03:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdRNp-00000008ZTI-3jJf
	for kexec@lists.infradead.org;
	Thu, 30 Jan 2025 10:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738231367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8rFIImBxyaGje4BDC514vfFtI9P0pAWScJySKgkJyQg=;
	b=corL4egafFseB6aWvOQU339fYh/R5GnaEOG+nIQUmSnMXEpV3dbyRcdiMsHht2quvse06j
	i2+hbtOwZatEvfJ22aPt6pWmNVXu5XRVn2QMUS3GPF7Fx/4xuUDh/6JwXUSu/Sw9c0AxvR
	ck3TtK3fd7AkajhJuR9xmeSC8GxQPik=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-WOzzoCpBNLSBb03TD2LX_A-1; Thu, 30 Jan 2025 05:02:45 -0500
X-MC-Unique: WOzzoCpBNLSBb03TD2LX_A-1
X-Mimecast-MFC-AGG-ID: WOzzoCpBNLSBb03TD2LX_A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385d52591d6so236444f8f.1
        for <kexec@lists.infradead.org>; Thu, 30 Jan 2025 02:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738231364; x=1738836164;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8rFIImBxyaGje4BDC514vfFtI9P0pAWScJySKgkJyQg=;
        b=vOmRG6CxOjTmbkOV/+t4KP4RnqCcL6VvYFRGI2nJVj777PVKKblM7/wU527wrtDNgw
         065Fd5Z1J81FdbNmSkYSfR/nv6oPx1884zDN+KLLDyzwApiyDTxa1/uGf2XT5ZucsDvL
         WsPozXYhn/GdCXiP5j9DF9MhPWc+CoTUjEaxSCkFBFd5rEsCWGTP1lC8hG3+MLyeNCP5
         lXXPpQdd1oJ5hzgAhRllyAXpNddq/W4kuy8xQPxpgL+De4IpaRI1ql/LMsB+dWp69vYs
         Qh8tQSgKSiWeSLOIT2nVjSvdrvYKHUIA57jGWo/p2C5OTNu//RbLdPWnmAbYbyTEvMnG
         yy+w==
X-Gm-Message-State: AOJu0YzQOA5/mxWm2Ojl/ttJc3quUAEhzN2ZOz+P5/69A41UdaSxbOMU
	6PaFfMAmT04BSyXx4vpGtnHObKwmJpV5nh6aQCOdihHCuKN5NCAJ2giZ3vy40xl7qHx+orxTgbv
	MsbSI+CDF98JZ2GZ/AQjgyL4qaUdy4bcXRqJpGUNvWPdmTBqwb11AgE7N3g==
X-Gm-Gg: ASbGncsLZAV4ahR0+fy3EzIiPS4zIuIKMWjtM814G11U35e1reSBYRTIwWWcNyFwrCT
	TPibWlMo07J8mGWYCUIHP1aqhUI8IZr0IBeqDmab56a4i70ifU7XUMFSmQSOzikKtgLXSXtEXoF
	mTlsmDWEfZe4229z9DKt1ge2QWZhfIY1TRtSII8L/G+oW+RMsL/qs0FhOiWW+tc2Z4jQc3xdF5M
	uB86QRa103Obq4t87+KI36XCLW7otQS9NMfhxiuBJ7ZGJBmnCOPnA6RsO4XU6dqRc6IhOud1Iyw
	31JSm5pDa9A8Q9StztyhCf2VaHK33HpJKPBpu13xYKJJ
X-Received: by 2002:a5d:6d08:0:b0:388:c61d:4415 with SMTP id ffacd0b85a97d-38c5a99037emr1937640f8f.18.1738231364641;
        Thu, 30 Jan 2025 02:02:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOUpN16aDhsRfrZ804p5paP1T1TDcJ+I2ckujQIryi58sa3Lzj5XhcXCuCzQJNuucLS7Myew==
X-Received: by 2002:a5d:6d08:0:b0:388:c61d:4415 with SMTP id ffacd0b85a97d-38c5a99037emr1937626f8f.18.1738231364332;
        Thu, 30 Jan 2025 02:02:44 -0800 (PST)
Received: from ?IPV6:2a01:599:904:96e0:a245:aa9f:6c57:eb41? ([2a01:599:904:96e0:a245:aa9f:6c57:eb41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec7aasm1502159f8f.5.2025.01.30.02.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 02:02:43 -0800 (PST)
Message-ID: <eae70e0f-0688-48cd-a6a8-43102a9268f4@redhat.com>
Date: Thu, 30 Jan 2025 11:02:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
To: Bart Van Assche <bvanassche@acm.org>, Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250129222003.1495713-1-bvanassche@acm.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250129222003.1495713-1-bvanassche@acm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SxHy0E-qbDa6QybR9Gfs12C6cp09R13qJGaioNDmN6w_1738231365
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250130_020250_002385_4DABE6C5 
X-CRM114-Status: GOOD (  15.80  )
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

On 29.01.25 23:20, Bart Van Assche wrote:
> Unlock vmcore_mutex when returning -EBUSY.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   fs/proc/vmcore.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a00120a3c099..10d01eb09c43 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.cfs/proc/vmcore.c
> @@ -1524,7 +1524,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>   		pr_warn_once("Unexpected adding of device dump\n");
>   	if (vmcore_open) {
>   		ret = -EBUSY;
> -		goto out_err;
> +		goto unlock;


Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


