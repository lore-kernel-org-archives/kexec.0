Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA71EB64D9
	for <kexec@archiver.kernel.org>; Fri,  7 Jul 2023 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+nkaW8gkFfYfPXXSa7c5ftsVcWvYAA8fm5B9bqlw6LM=; b=DOZyx4jWVmrDDJ
	NLdES+/NdzuxokavZlvaXJEAzLiROgTBi+sL43Xz+2YH6I9IqbUG+XP4JSBo86GieV2SXKC8HD3qj
	FbWVORqYo9dDpGVaYAReKlCr+U+CrEYor3t4DBg4eMQl1N3XKsqEI4mnjrGfDQWsKGpNSXQX7ek4l
	8Zen+LY7QYH9+GKEd512EBzL7cLPzo+OKsa582QJ8B5evUWOL5r0GaiulJzLU7udvfrtOi46B3jta
	ZgIU3J3R4riMwjf1u0zDNi/EKycri5LQcSNygGdDD2jQE/wN35D11HSZxancHwXkk9Ew+kLgGtc5t
	DAwRgB5ABCBDR7MKUFVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHggL-003xnL-14;
	Fri, 07 Jul 2023 08:19:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHggI-003xmS-0e
	for kexec@lists.infradead.org;
	Fri, 07 Jul 2023 08:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688717949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDsBTISbzBTDLjmus2cmCAKpmg00PLgnL3XexDug1Tk=;
	b=DnGwFFdeFuzZJk3IreCUbSzEzyp1WTNbNnbB5bVhmnj9Fo2YjCxlC+RdKPUlqSh98l9hnK
	t16CA1pV5HcpUiczh6puWwzPMtP6k+fKYswDvVvlwdBVBm/nv81ZjMEDSgMo3jP+5s8IuS
	viqK2sLJSARoLux5R2dX10n18FNO3+s=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-IK2aoRr7MUerX7ULYnjMAQ-1; Fri, 07 Jul 2023 04:19:08 -0400
X-MC-Unique: IK2aoRr7MUerX7ULYnjMAQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7864d24d5dfso26610139f.1
        for <kexec@lists.infradead.org>; Fri, 07 Jul 2023 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688717947; x=1691309947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LDsBTISbzBTDLjmus2cmCAKpmg00PLgnL3XexDug1Tk=;
        b=ZBGRpKubtIQ9+L6ukLf1uFZamEUgWNFe1hoiaAxsp8OTMASNxeyaSJ5CHbaN1pPSec
         wB2NK8csMfTsV3HynIZ+83apRGQBGqcJIepKIGLlLHYsctYivwLSMEyK2nmzrngAXX9T
         GVTTJkyIjcXhr4V8vLfb1DT06FoO4cYEkK7tmrcO8Am6St/cLbW1jex3TKSWdbD2xa8q
         qZEtY+daWNH/SxuAbvipMhJT3TOYCq+alBUpUY/zTUK5OGhnC82RgZeGSVKRuM4WW47g
         zHCvPVA3fhgKOiWKX/N/6bRMQSE0JL3oH9rLNLPz42B+73qtd32g+SSPVgQIBTLX0Ygb
         m+ww==
X-Gm-Message-State: ABy/qLY+s0t/COj7HtTf3aoD/+++J7Xccal/WfA6u53JPe1nfaU22/Xx
	9A0WAQ8Kd3OEWcAwBYCjiQOJynJFxz6MhwE0wWnUAJlMeiQP64hgUUucxYRrxIyPSkXK+SrOrHM
	BrCs/OV9ev8VUe93o7uVITRikLrNup1f/vAms
X-Received: by 2002:a05:6e02:e04:b0:345:e438:7381 with SMTP id a4-20020a056e020e0400b00345e4387381mr4590735ilk.2.1688717947620;
        Fri, 07 Jul 2023 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmmO9KnWk1OmpKCwnkO7ACUqSxF9xZ4r8DsWs9KsNMtByt1/3EtUImi4KmVM+CqLQ/jkRSYBt6LhkIH/6JgZ0=
X-Received: by 2002:a05:6e02:e04:b0:345:e438:7381 with SMTP id
 a4-20020a056e020e0400b00345e4387381mr4590728ilk.2.1688717947397; Fri, 07 Jul
 2023 01:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230703215709.1195644-1-tusharsu@linux.microsoft.com> <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
In-Reply-To: <20230703215709.1195644-11-tusharsu@linux.microsoft.com>
From: RuiRui Yang <ruyang@redhat.com>
Date: Fri, 7 Jul 2023 16:20:33 +0800
Message-ID: <CALu+AoQC101fcbJjLdJHD7QtqeXzt5uOZDgNYvob0U_NGyaqCQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] kexec: update kexec_file_load syscall to call ima_kexec_post_load
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc: zohar@linux.ibm.com, noodles@fb.com, bauermann@kolabnow.com, 
	kexec@lists.infradead.org, linux-integrity@vger.kernel.org, code@tyhicks.com, 
	nramas@linux.microsoft.com, paul@paul-moore.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230707_011910_314761_C131CCBF 
X-CRM114-Status: GOOD (  26.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Tue, 4 Jul 2023 at 05:58, Tushar Sugandhi
<tusharsu@linux.microsoft.com> wrote:
>
> The kexec_file_load syscall is used to load a new kernel for kexec.
> The syscall needs to update its function to call ima_kexec_post_load, which
> was implemented in a previous patch.  ima_kexec_post_load takes care of
> mapping the measurement list for the next kernel and registering a reboot
> notifier if it's not already registered.
>
> Modify the kexec_file_load syscall to call ima_kexec_post_load after the
> image has been loaded and prepared for kexec.  This ensures that the IMA
> measurement list will be available to the next kernel after a kexec reboot.
> This also ensures the measurements taken in the window between kexec load
> and execute are captured and passed to the next kernel.
>
> Declare the kimage_file_post_load function in the kernel/kexec_internal.h,
> so it can be properly used in the syscall.
>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> ---
>  kernel/kexec_file.c     | 7 +++++++
>  kernel/kexec_internal.h | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f989f5f1933b..efe28e77280c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -184,6 +184,11 @@ kimage_validate_signature(struct kimage *image)
>  }
>  #endif
>
> +void kimage_file_post_load(struct kimage *image)
> +{
> +       ima_kexec_post_load(image);
> +}
> +
>  /*
>   * In file mode list of segments is prepared by kernel. Copy relevant
>   * data from user space, do error checking, prepare segment list
> @@ -399,6 +404,8 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>
>         kimage_terminate(image);
>
> +       kimage_file_post_load(image);

I think it should be only done for the reboot case,  please just
exclude the kdump case here..

> +
>         ret = machine_kexec_post_load(image);
>         if (ret)
>                 goto out;
> diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
> index 74da1409cd14..98dd5fcafaf0 100644
> --- a/kernel/kexec_internal.h
> +++ b/kernel/kexec_internal.h
> @@ -30,6 +30,7 @@ static inline void kexec_unlock(void)
>
>  #ifdef CONFIG_KEXEC_FILE
>  #include <linux/purgatory.h>
> +void kimage_file_post_load(struct kimage *image);
>  void kimage_file_post_load_cleanup(struct kimage *image);
>  extern char kexec_purgatory[];
>  extern size_t kexec_purgatory_size;
> --
> 2.25.1
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
