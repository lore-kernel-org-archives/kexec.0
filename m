Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC3EC0218A
	for <kexec@archiver.kernel.org>; Thu, 30 Jan 2025 07:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBHchwpzoXFVWH9+U8GKRfXZYJzHwkRxryZqoSOeTIo=; b=L2y3FU9UGdJme0AYA4VJ9wSvt3
	exjZ3TmldrBFsP64uxVNk9+61Wdmen/otDSDVSruDW8BIXp8YgPZX+9UAYwvhemPHgJTBlTjaIqOR
	NORJWRag7yD9oxZZ3Yy1Ko57eO4jUl7jsCFyYkv83+ZOG8OY1qWJYMLFMAgEqtwf/PDWZK75WdaxQ
	+qFmo+TsjFOjXlA+pZ184Sc4ablQLM5opicfoy9UtPI6gr+IHQoOZHjzCDXaoFVtyTfJKtjgC4Evt
	KkVq5Y2HSLxRtTtUNPCTfJb+u/gFhYpS9RhBZ6QIgFZH8oCe5wFVs3YjcPba2SWXGqD+K0c+mlibf
	b08XT17Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdOZe-00000008L5u-0yx7;
	Thu, 30 Jan 2025 07:02:50 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdOZb-00000008L5Y-3ZxS
	for kexec@lists.infradead.org;
	Thu, 30 Jan 2025 07:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738220565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GBHchwpzoXFVWH9+U8GKRfXZYJzHwkRxryZqoSOeTIo=;
	b=CnmncM9RCujlW1RR1dhi8+V3bwQw3hF3caRVmqJemDzIcR0K1smQLGNH/nrmKCtjXxzv0R
	rq8czo+uFFOMrrxu4x36bK//uC9hRnPfAs331LlcZoRoJVc0vByKSA1aj+lox3FkTpE5iN
	+UyNpMDSEFTurSOWSHVgIBfMiLWOa8o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-XeTGX7VdPcqiGTMjOekRlA-1; Thu, 30 Jan 2025 02:02:43 -0500
X-MC-Unique: XeTGX7VdPcqiGTMjOekRlA-1
X-Mimecast-MFC-AGG-ID: XeTGX7VdPcqiGTMjOekRlA
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361fc2b2d6so1719505e9.3
        for <kexec@lists.infradead.org>; Wed, 29 Jan 2025 23:02:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738220562; x=1738825362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GBHchwpzoXFVWH9+U8GKRfXZYJzHwkRxryZqoSOeTIo=;
        b=S7f66WyUtp9/MANuwEKtFDPrmEnhSQF/xnd1TXeT72ls7mBAELxu+jc1uFkv0prH9n
         CMpynSoyAjePzea1IV/Xe7/x4e5LaVABsbNIbw/FKD8G4X/14otEYKJm47htcJU7cJVV
         PfwgZfekBNYmDnhNswBu8EkGTXUZOa2EGbJrDcvns14ZL0MG8x1qGvK3oPtzEXCzqT2E
         kmM/mu7LpIQm9Xxt1fUh7VR9erYo3D2eFubKDyOhRpXgJQXFxoVHAe0iqITQQ13J2+dB
         AqlIY7MOPpRojZr0rezKErT51+HUCLu5vf9zlWsdEBnG4Nv9ExDDNeZsjHcIy7HG5cpj
         rPnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/gWI/+eah/Sd5q4aSUwb/r9F4Rh/nRI8QXd64XZq9Bofxtidt5v04wxWHubpaKVYArkE8NQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YyNN5VwO/vxLajulExPPDIscmkWQqIG0rx5c4LUKWsno/9ymild
	fLYgogU8UYApg6mMWbzDe/MIPJP1weV8jZEPWhU5H8Z1iX4bN0Tuz+9BJ0gFuZtRFGKP/+0+Ova
	ZzBNaVNSBcSqd8dFYfbM99mmluwPCUGsqCWZeylfs1ZkXgvweFJuh8LNtXQ==
X-Gm-Gg: ASbGncus7TKDqzaWmtcIo9KQZAg71x5OmAxGJGVHMatgfXV8nyVUq5qhynjV3kLYOEN
	4v9HnKPa9lU5Ydj6cUBGuPbRW3/Y+wVnb3GjyP3brR7qmRfz9mz5QtseaWdf76aMy+rHZ6FQBwx
	DHXkWbSVgcyz59iwH2Fn6J5cKvUO1+hJz5A3oKE+k3azV/+LY+nIX8rZOEVpmB3izArf5Ldb1dB
	Ko0IL1FJaGWTQA7ZHNU/X+uiPwnWpJGMxKGhmN7wJ37fOcpwheWV7sYSKbjuVYNQzmw+M5BJ7M=
X-Received: by 2002:a05:600c:1d07:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-438dc40ff6fmr48608355e9.24.1738220562053;
        Wed, 29 Jan 2025 23:02:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6Mcs/bJuK6gTZqxg41xeTkIuf1je1BmEUvK4lLsQK+r6qXBCcm7FoE9dwBa+qEjLoTv6uLg==
X-Received: by 2002:a05:600c:1d07:b0:434:f219:6b28 with SMTP id 5b1f17b1804b1-438dc40ff6fmr48607995e9.24.1738220561646;
        Wed, 29 Jan 2025 23:02:41 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ed:4e79:3ac6:1235:d75f:eced])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d7aa605asm52419125e9.1.2025.01.29.23.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 23:02:40 -0800 (PST)
Date: Thu, 30 Jan 2025 02:02:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] procfs: Fix a locking bug in a vmcore_add_device_dump()
 error path
Message-ID: <20250130020209-mutt-send-email-mst@kernel.org>
References: <20250129222003.1495713-1-bvanassche@acm.org>
MIME-Version: 1.0
In-Reply-To: <20250129222003.1495713-1-bvanassche@acm.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nixwpn1KXyYezLaBZUSjlyM2PRIDJqsHt5W0TXjMXEA_1738220562
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_230247_962045_C610220C 
X-CRM114-Status: GOOD (  17.32  )
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

On Wed, Jan 29, 2025 at 02:20:03PM -0800, Bart Van Assche wrote:
> Unlock vmcore_mutex when returning -EBUSY.
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Fixes: 0f3b1c40c652 ("fs/proc/vmcore: disallow vmcore modifications while the vmcore is open")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  fs/proc/vmcore.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index a00120a3c099..10d01eb09c43 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -1524,7 +1524,7 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  		pr_warn_once("Unexpected adding of device dump\n");
>  	if (vmcore_open) {
>  		ret = -EBUSY;
> -		goto out_err;
> +		goto unlock;
>  	}
>  
>  	list_add_tail(&dump->list, &vmcoredd_list);
> @@ -1532,6 +1532,9 @@ int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	mutex_unlock(&vmcore_mutex);
>  	return 0;
>  
> +unlock:
> +	mutex_unlock(&vmcore_mutex);
> +
>  out_err:
>  	vfree(buf);
>  	vfree(dump);


