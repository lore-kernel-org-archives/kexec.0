Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D37BC3600C
	for <kexec@archiver.kernel.org>; Tue,  1 Apr 2025 03:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aroUGdwU4xpeXLsKcHF4FVUWWdtkoPVVPUhYaAz+RWs=; b=QQEmpduo9/zip0B0OE9XKhGQqW
	g1if1qC1R8VSgEm31dN99U209qCjrlpiBk5FNSyQfFjpPmPhPEPChK+QN5k3a7Y/jhihvEw+m8+h2
	b+spdOlnB5b5e7tq8URXfvMVPFj9w29cRA5Xa26d3mUbJT4aNQLuGcHLv7DxsZuoPVfctlr0u0VEU
	B94KLMPQRn7XX83eiumq9JTR9H8g0VMMlx2yHgH4pBpJuMKHp6GGMjxbebaOu7kMDSICizCRoc92b
	o22gUfymxdiVFWKXu0QQD0CG7xmFzvj3UDIJkOk79ISb1csvwU0+sF8ZFIxCoXEsxb67F9KgirOMs
	HATwXc3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRrb-00000001pOl-2DoJ;
	Tue, 01 Apr 2025 03:00:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzRrX-00000001pMo-3kZX
	for kexec@lists.infradead.org;
	Tue, 01 Apr 2025 03:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743476425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aroUGdwU4xpeXLsKcHF4FVUWWdtkoPVVPUhYaAz+RWs=;
	b=FVkNamyTNWwfX3SWUfbh5JDzw3q3NDMT2hIBtBrTdzd+ssRJaX0FuHkviNhkFgB4xMsXiI
	xVG2Dc8LEEC0W6RMuqpQ//RcJpi1HDYdR3kOahibybrEyXUxp+VvPIuQkwlrLGuLWdsRjt
	DZxMEHMu1KMp9JdkpK5aozS5zQ5rb6s=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-eYIZhTTyPS6WKnE9rDZDXw-1; Mon, 31 Mar 2025 23:00:24 -0400
X-MC-Unique: eYIZhTTyPS6WKnE9rDZDXw-1
X-Mimecast-MFC-AGG-ID: eYIZhTTyPS6WKnE9rDZDXw_1743476423
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-85dad56a6cbso861551639f.3
        for <kexec@lists.infradead.org>; Mon, 31 Mar 2025 20:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743476423; x=1744081223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aroUGdwU4xpeXLsKcHF4FVUWWdtkoPVVPUhYaAz+RWs=;
        b=oELb0o1gzvC92ZqdMgnDvph6PDWnoqnO82aikihTcs9h33IHJWp5z3RakMKwoLJYMm
         zXMb9j8/3KGz0gLdM/O8Q9jUQt9/WO4VnEwpzlsOHSfF+4v7LuidVbbmNkDEbRGNshmK
         2FEVcpJMtq6VC242ndWMRnGvJ8nS83wWyLnp5/t6819hC/1gfS6a4bTV3CNzxIbFzWWh
         IhYvVeIz3daGtiPlJMZVL4T4I95SFXy7jmkfpcUOwsBz8lNStaQwzZ8UZNOuvpNysgVg
         3++wCBneaR4n7HK1w9lFUUonA4LaH9I8MSlV29Mgp4RzQrNtX0ZXb52b45ofoDz93jYZ
         8mJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG2yGOgk2x7rtMh16/8JUPkAIhDSA3mex827Sc5y4hlZABTVeFV1um0+ES8ZhTEJxPaJ2sFA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyzadVeDoapn0cTC4MTBm5O2YpNMAahSPvoJgSWFv3/fiznA+MY
	dNMNMgW0Jdefm9amJPjBZDHY8HZryMiU5nh6SGDpbFwL9cVLcjWL6zrC16lPt0pEADPB+CWIM1B
	E8gBSiIWGIxUfKplko4h47QlJtaXKMn5se9XZhy1OiJNDc+k01baTV6sA96tPLSRmrmFDqABlEP
	CNhwDuuT9lF82ctv7gu7G3IY3dxfjTosU8
X-Gm-Gg: ASbGnctUcRMLO5tY0aJ9eDtPIErIBaH7t9s2ihExUSDEbS72W6xCirxL7ZQw6eLWYnr
	19Y1ZBdZOsNV9QdHkhsUN06/qBomvpf6joK31ay/4wAxFeK1UkPhd0nV6YEQghh4Cuh/e0OHk1w
	==
X-Received: by 2002:a05:6e02:3285:b0:3d5:8923:faa5 with SMTP id e9e14a558f8ab-3d5e090f7e6mr118352665ab.10.1743476423299;
        Mon, 31 Mar 2025 20:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqWisOvxvQyImEwx+1aYoC1TaIsC6PX8WuutYBp511BcIS/FBmgXr9e9Mj6eRsS5cj4YhR0mkcARILpmj39hI=
X-Received: by 2002:a05:6e02:3285:b0:3d5:8923:faa5 with SMTP id
 e9e14a558f8ab-3d5e090f7e6mr118352465ab.10.1743476423012; Mon, 31 Mar 2025
 20:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250328104402.16826-1-bhe@redhat.com>
In-Reply-To: <20250328104402.16826-1-bhe@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 1 Apr 2025 11:00:46 +0800
X-Gm-Features: AQ5f1JoqAn9iPAyjr_GvdfMkThfZw_LYmEgZlBYfGH4o5b4Gkh_jQWN4JzDzdHk
Message-ID: <CALu+AoTVZKfzfg609wDQEOQUYOkrYZ7nMmZ_1Gu6E5iFh1QroQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Andrew and myself as kexec maintainer
To: Baoquan He <bhe@redhat.com>
Cc: akpm@linux-foundation.org, simon.horman@redhat.com, ebiederm@xmission.com, 
	kexec@lists.infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ts2JINvaPWIw3PtSNkHmU6xIsSFHii8-2sX_MC2dzwY_1743476423
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_200028_086827_0448D2FD 
X-CRM114-Status: GOOD (  14.72  )
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

On Fri, 28 Mar 2025 at 18:44, Baoquan He <bhe@redhat.com> wrote:
>
> Add Andrew as kexec/kdump maintainer because he has been helping review
> and merge ready kexec/kdump patches.
>
> And I would like to nominate myself as kexec maintainer because I always
> try to review generic kexec codes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e94bec401e..4bfe9babcaff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12528,6 +12528,7 @@ F:      lib/Kconfig.kcsan
>  F:     scripts/Makefile.kcsan
>
>  KDUMP
> +M:     Andrew Morton <akpm@linux-foundation.org>
>  M:     Baoquan He <bhe@redhat.com>
>  R:     Vivek Goyal <vgoyal@redhat.com>
>  R:     Dave Young <dyoung@redhat.com>
> @@ -12826,6 +12827,8 @@ F:      fs/kernfs/
>  F:     include/linux/kernfs.h
>
>  KEXEC
> +M:     Andrew Morton <akpm@linux-foundation.org>
> +M:     Baoquan He <bhe@redhat.com>
>  L:     kexec@lists.infradead.org
>  W:     http://kernel.org/pub/linux/utils/kernel/kexec/
>  F:     include/linux/kexec.h
> --
> 2.41.0
>

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave


