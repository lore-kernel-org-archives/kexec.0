Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87A9E77188
	for <kexec@archiver.kernel.org>; Fri,  3 Jan 2025 07:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wi86+2kTzGm+UWgBKKeQnfRT6OIpNbhdwyaufkMNEXg=; b=2npwwapnOrfd+t3D7nVfdzoXsY
	jnbTsmHeu6v4foACsd5Gwlynf1+IW+4brDeouJnwNoipGQfpp18N6JJQ8dbbsvX6HkMJZ7ETKxapO
	t++LnVGpooss6RSf0q5Xg65U/ruZqB4kkOSks4yke1UV4DgkXsqIhW17CLiXfRCLj+3c4HGA83kGC
	2i1HkdALzgi4yg7DyRnrsWXLy37Pblk3FmEnKulk7YSqBCP/xd97NBt0pgj7GHWOOyEcLqrBv143z
	UDbAtbCB/FGEGw9g3TZ5nuDTGHSlBHZ0BWOnRNVTkY1Mu7vw7fyxjwtJ5l9mM6yEGO1NWWyCx8x2l
	/nsHhIJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbxD-0000000CJjV-2Aps;
	Fri, 03 Jan 2025 07:18:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbxB-0000000CJiz-00jo
	for kexec@lists.infradead.org;
	Fri, 03 Jan 2025 07:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735888718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wi86+2kTzGm+UWgBKKeQnfRT6OIpNbhdwyaufkMNEXg=;
	b=NhyXMxlC8Mo2X4qAeKXulWZCVlKVKU7Oiczz27K1nZxR7yFGGlLhjyINv9Py6jhdDxkgmO
	Plnnm67KLD8VT1wY9wIZxR/J1HaVngf5dm/Z3ao8it/OHpF9aQ/JuIa5bfWtaK7m5WpveA
	KKBtvWBCuLrTN4Ah8StZq22qxDTOlP0=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-rKDG4hcZNpW2V8CO8dIogQ-1; Fri, 03 Jan 2025 02:18:36 -0500
X-MC-Unique: rKDG4hcZNpW2V8CO8dIogQ-1
X-Mimecast-MFC-AGG-ID: rKDG4hcZNpW2V8CO8dIogQ
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a812f562bbso258451575ab.1
        for <kexec@lists.infradead.org>; Thu, 02 Jan 2025 23:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735888716; x=1736493516;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wi86+2kTzGm+UWgBKKeQnfRT6OIpNbhdwyaufkMNEXg=;
        b=dnei0FLg0uuv8pwk/sfBlzzE6+r4eY9lT3gmSk1zTI92MGdKGYQlWM7TECobj3m6Ut
         xEoSttDE3oEfghJn0B8eVE89qR/6Qy87UIueEAEFalouEFr11NCInGwAobSpVbJtKKLm
         6mHONUTgQh1GT3KxR9AnpUz+yOg/a1zvsu7+W17iVloeMCMAaXdTRbwRtq8A7mmbNEZa
         aMbufe59DjRNXr7kqtXBIXuxSSB31uVaCBjLFVKOTr7kGUaH+VOy4nRerb9rwchtGyRc
         IccfBHO40aHSVr4tVGwND7WT95LqqMu0Jwnu5BR8xcP+AN+MITJpdn4isrebnWyhyr5z
         nJqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC3jTrSXLVg3b2BSNWHcMkCp+oFt1EJI4+s3swLN8GHVQVqQP4K93gVv8BvvzdjkJ0AVMmEw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyn/DkgZYERgqbMLyxjQC59kwZu6p7S3ICBTnba87gfTAVQlEQd
	l0XyG2d1m1APVzLFvhQmOJGGcBIwgdLG/PnwOi/yePbO0pd8t/1hwRTSKtKy6z72rIMU+waUFzs
	hAPVL241dRLWYkzwCB/2ZFxhuXHCdEj1h1qA//YCdcQNatCKWMbarRxjdWTAcEjepNrvJadhtOK
	wi0FuEmmcqDuwrgGvmLi4Xt5zEkJqjA2iZ
X-Gm-Gg: ASbGncuUX9jKcGQytngy0Vvfyy4I4J/rQ3+TcGWytZu1FT+7CHPgxgFDD8QQeBvOvqC
	hz5Vl+8TJocSlDnUktQU4dkQIKSvDSppxMck4oTk=
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:c60b:ad90 with SMTP id e9e14a558f8ab-3c2d1e7df4cmr514780995ab.3.1735888715739;
        Thu, 02 Jan 2025 23:18:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtwELeFB4elE3zB5D19zOKaAlQciyF05zD09XsCwurR9WJ8OZveGqrOV3LWxYeJACj/xMNgojtHyBEpS+y5vc=
X-Received: by 2002:a05:6e02:1b0e:b0:3a7:c60b:ad90 with SMTP id
 e9e14a558f8ab-3c2d1e7df4cmr514780565ab.3.1735888714751; Thu, 02 Jan 2025
 23:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20250103074941.3651765-1-zhiquan1.li@intel.com>
In-Reply-To: <20250103074941.3651765-1-zhiquan1.li@intel.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 3 Jan 2025 15:18:37 +0800
Message-ID: <CALu+AoSNhhjxcKp2S0ERkOyezyrxcf87qxKh8isVgwehqOgbfA@mail.gmail.com>
Subject: Re: [PATCH] crash: Export PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo
To: Zhiquan Li <zhiquan1.li@intel.com>
Cc: bhe@redhat.com, vgoyal@redhat.com, kirill.shutemov@linux.intel.com, 
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3TkJWUiAV1k5xbUQCiFvKeSXWk_xe5--FuCfOzEgb5g_1735888716
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_231841_110948_95635E6A 
X-CRM114-Status: GOOD (  19.82  )
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

On Fri, 3 Jan 2025 at 15:13, Zhiquan Li <zhiquan1.li@intel.com> wrote:
>
> On Intel TDX guest, unaccepted memory is unusable free memory which is
> not managed by buddy, until it's accepted by guest.  Before that, it
> cannot be accessed by the first kernel as well as the kexec'ed kernel.
> The kexec'ed kernel will skip these pages and fill in zero data for the
> reader of vmcore.
>
> The dump tool like makedumpfile creates a page descriptor (size 24
> bytes) for each non-free page, including zero data page, but it will not
> create descriptor for free pages.  If it is not able to distinguish
> these unaccepted pages with zero data pages, a certain amount of space
> will be wasted in proportion.  In fact, as a special kind of free page
> the unaccepted pages should be excluded, like the real free pages.
Hi,

>
> Export the page type PAGE_UNACCEPTED_MAPCOUNT_VALUE to vmcoreinfo, so
> that dump tool can identify whether a page is unaccepted.
>
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> ---
>  kernel/vmcore_info.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c

Please add into admin-guide/kdump/vmcoreinfo.rst if you add more vmcoreinfo.

> index 1fec61603ef3..e066d31d08f8 100644
> --- a/kernel/vmcore_info.c
> +++ b/kernel/vmcore_info.c
> @@ -210,6 +210,10 @@ static int __init crash_save_vmcoreinfo_init(void)
>         VMCOREINFO_NUMBER(PAGE_HUGETLB_MAPCOUNT_VALUE);
>  #define PAGE_OFFLINE_MAPCOUNT_VALUE    (PGTY_offline << 24)
>         VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
> +#ifdef CONFIG_UNACCEPTED_MEMORY
> +#define PAGE_UNACCEPTED_MAPCOUNT_VALUE (PGTY_unaccepted << 24)
> +       VMCOREINFO_NUMBER(PAGE_UNACCEPTED_MAPCOUNT_VALUE);
> +#endif
>
>  #ifdef CONFIG_KALLSYMS
>         VMCOREINFO_SYMBOL(kallsyms_names);
>
> base-commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> --
> 2.25.1
>
>


