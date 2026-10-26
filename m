Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC32B606A323
	for <kexec@archiver.kernel.org>; Mon, 26 Oct 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jqdoVQ9L;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KjtDe1t4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=lWHuPq3gJvZ2ihDSpoBRgh47aIyJRN+4g8u5gBqxv6Y=; b=jqdoVQ9LtlbOtv
	VYEVrKJJ/3hEO0ku6QP4yj5QVEsLK0jkuMUJU3S/pGF6ra4y+t6BmgqLZ9SXHYeP18x/+MkhPYWSr
	fKOr32ciJeTXxbhePCOdhhVxVjzDg7IubJj03l7lxE/0X3pRpLWPtk+hUSXwF6WvF1rabIpszeE1G
	YgD7YHWkxKNJVo2sl/lvhRM5mEGYnbU1MirVZ0shpTE20MEKNgIzf3oZ79D69qoNJrWwPC7319rvL
	Fp0y3vZtMmRBK/75VB1DVexxonskPWIm5oVVb4TABEiUaMZpIo8bi/yskDGagrMHDZ8bV1ZimDAeK
	9UpLlnncDrBt7scYXalw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHr6-00000002G96-2Z8A;
	Mon, 26 Oct 2026 10:23:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLHr3-00000002G8l-3bcp
	for kexec@lists.infradead.org;
	Mon, 26 Oct 2026 10:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793010180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWHuPq3gJvZ2ihDSpoBRgh47aIyJRN+4g8u5gBqxv6Y=;
	b=KjtDe1t4hEOUxI/xtTK8bHJLqV1gI5jp+ZqaXF3SzECjTlTgfM32SiOLQ15HPnrA45OMJB
	UOLsGJAKmb0dAdyT6mU4CB+wnZn7ndWt0MkQJXKeQeA1EDFpGu/CukhIqRj7z4zt7skRVD
	dOHpwA5nelXIRCkKhwlZRLQFHxsJKc4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-tsFZwUYYMHaz0gC6SWxx-Q-1; Mon, 26 Oct 2026 06:21:19 -0400
X-MC-Unique: tsFZwUYYMHaz0gC6SWxx-Q-1
X-Mimecast-MFC-AGG-ID: tsFZwUYYMHaz0gC6SWxx-Q_1793010078
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ac6795617aso2524516a91.1
        for <kexec@lists.infradead.org>; Mon, 26 Oct 2026 03:21:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010078; x=1793614878;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lWHuPq3gJvZ2ihDSpoBRgh47aIyJRN+4g8u5gBqxv6Y=;
        b=iZj/mY+Wkr5Lmq+xDDG53QDWihBRYqj0P2/jRHs4l3PDxb0KISQysoL+i7uXOdUFHY
         eo4V8dR2E3DX5ORoYJhnXTasO8MfZ+62/RKLoIlCzRcd766n+1E60K22+JCjjIqReK3V
         o+sIu/Ni68qF0h5PjDHx74rMpzmfgdVHvvl3V9JKr4FAvp55mJemDPMI/ngehnhm+WtF
         E7SHygcGgeP2XaGoRgzAKW2wD8aRrD/pPxq0Oha3fZSHXbHQ3YYIp/z8MEcS102RUpBE
         VqF0TqNJRGvbbwZ1bDJsuAifKkkNKDYC1N5fXLMoLQSOojCYkP73yvIDF6TaV8q7yiES
         aNfQ==
X-Gm-Message-State: AFq9FYLaPLTgJIVzZpEwGjYb4dOhGuiIgXqJNWaGKxnABoz+UhWiyaaa
	d6eAy0Ek0L5izEnU++J1bcMnbbEoc6/F8aZs9Zmq9Ip5sKNqKhW4IW/MEt9QkBJQu5nS2i9nXz/
	fKnJKsbaK9wBN4hSIN1Q03YeoFOErHk9q5mpbvb3lqah9EvFT4Lpv2EMo8UvWt5/gGVuQZ3QFWb
	5gfOo2b2QbcP7X1xeFyoJuX22Eh3o5EMcDctZ/0kEcmvfv8g==
X-Gm-Gg: AYBFou0l1OrKjZ9UKPlAuyhdi2rJHoBRTmWuhEBzykxA4/SzDt56d604oTnvaGn4CBn
	in0A1z1Pd4DDH3zUXi/tMtONxhySDhxJXkPBUeWsl2PTexto9LQmvgE8K++tuxGlWTdlP947E96
	eQf0d1TDhofJfuVFbZJ0EyBTpNfTqCDsyh9adcIkUAjSGJRP6M/LaR1XqZUJDxlOnwWlu5ePu1G
	GDHed8BuNHrwpfpFTqnaOa7jK7Y5iyAZnz64lb86IK2nC90apByq7B8SLl48nXvkfsthLQ/CxY0
	rpRd45C8/ZaRWKJB62cEhkRf0oN3GlWlK2ZPAGvf1rFy63zyxXIUn1TBbumQavGfqwnKF9mjJqK
	rvQiWsQJCmWKpdjt273c=
X-Received: by 2002:a17:90b:4d02:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3adea89669cmr5263744a91.15.1793010077643;
        Mon, 26 Oct 2026 03:21:17 -0700 (PDT)
X-Received: by 2002:a17:90b:4d02:b0:3a8:545a:9e87 with SMTP id 98e67ed59e1d1-3adea89669cmr5263720a91.15.1793010076808;
        Mon, 26 Oct 2026 03:21:16 -0700 (PDT)
Received: from [10.76.99.237] ([115.110.236.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebaca7casm8050366a91.4.2026.10.26.03.21.15
        for <kexec@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 03:21:16 -0700 (PDT)
Message-ID: <d16113de-090d-4ec6-8790-4413f8214f50@redhat.com>
Date: Mon, 26 Oct 2026 15:51:13 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] kexec: Add helper to report an active kexec reboot
To: kexec@lists.infradead.org
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
 <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
From: Mukesh Pilaniya <mpilaniy@redhat.com>
In-Reply-To: <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4zbr-IKE88dvfkT_M9Qls5-V8AZ5Wgc1PUFXihRwHac_1793010078
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_032301_981422_6AEA0EA6 
X-CRM114-Status: GOOD (  20.21  )
X-Spam-Score: -2.8 (--)
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Shradha,

On 09/10/26 3:52 pm, Shradha Gupta wrote:
> A shutdown callback in a loadable module may need to distinguish a
> kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
> VMBus driver needs this distinction when moving its kexec cleanup into
> a common syscore shutdown callback.
> 
> Add kexec_is_in_progress() and export it to GPL modules so the callback
> can remain guarded when VMBus is built as a module. Provide a false
> inline implementation when CONFIG_KEXEC_CORE is disabled.
> 
> The helper reports only the normal kexec reboot path. Crash kexec and
> preserve-context kexec do not set this state.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  include/linux/kexec.h | 2 ++
>  kernel/kexec_core.c   | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 8a22bc9b8c6c..827a5311d97a 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -468,6 +468,7 @@ bool kexec_load_permitted(int kexec_image_type);
>  
>  /* flag to track if kexec reboot is in progress */
>  extern bool kexec_in_progress;
> +bool kexec_is_in_progress(void);
>  
>  #ifndef page_to_boot_pfn
>  static inline unsigned long page_to_boot_pfn(struct page *page)
> @@ -544,6 +545,7 @@ static inline void *kimage_map_segment(struct kimage *image, int idx)
>  { return NULL; }
>  static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
> +static inline bool kexec_is_in_progress(void) { return false; }
>  #endif /* CONFIG_KEXEC_CORE */
>  
>  #ifdef CONFIG_KEXEC_SIG
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index dc770b9a6d05..282c7b3c6c35 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -23,6 +23,7 @@
>  #include <linux/hardirq.h>
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
> +#include <linux/export.h>
>  #include <linux/utsname.h>
>  #include <linux/numa.h>
>  #include <linux/suspend.h>
> @@ -54,6 +55,12 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> +bool kexec_is_in_progress(void)
> +{
> +	return kexec_in_progress;
> +}
> +EXPORT_SYMBOL_GPL(kexec_is_in_progress);
> +
kexec_is_in_progress() is exported via EXPORT_SYMBOL_GPL but has no
kernel-doc. Could you use a proper kernel-doc block above the function?

>  bool kexec_file_dbg_print;
>  
>  /*

-- 
Regards,
Mukesh Pilaniya


