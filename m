Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB341CAC5A5
	for <kexec@archiver.kernel.org>; Thu, 25 Sep 2025 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U5QyJ8jjxxZrmMUXWyCErSijaNy4q2ViNCLkEOGHiYY=; b=1RRrqA2t167DXZcyZyuN7HT1tc
	jAO/eqkIpkuPxD9JjGXRXfkoJ5l1DiaR0A6UTcY+d4+spqin30NdNbEbLSPzmXVR63zQPbvZl/yfF
	fQESQbgSn6V7rJWx6rcJWuRhT908WyVMKo82jguZTq81OxVWh59MtArz2dcZb+PORMu5k4m9RfcJO
	ku8QVUo00RUBUAEZGEDnwSfoxsQp4DLL6ctJ0qKRDoI99NgIoVJkl0cWcGOMGapG7PblhV28YN3eC
	FW6py+F7HEwiBoCAOc9xRlgXRBYI2mvnR1kx4cdb7MduMLkzHYMzi1cLSyuIS+ngHTUuC3ZTbGGi0
	PeQFnG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1i1J-00000007Sag-0rPo;
	Thu, 25 Sep 2025 09:12:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1i1F-00000007SZH-40Ht
	for kexec@lists.infradead.org;
	Thu, 25 Sep 2025 09:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758791523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U5QyJ8jjxxZrmMUXWyCErSijaNy4q2ViNCLkEOGHiYY=;
	b=TwckJYMnaCErNb3r1+5d+o7Ez9N7YeiPBZJfKGJPWflnq1AG3vZ1AdOVKNFBD3Ys7ouf5E
	dnXUVC+iFpMKS3GSmGs4mi5bTfbdsDQyAPLhpmu1oDJVFGMqdt1u9YLTMPaBVdfmKQ1dF4
	g/LgXBdwvOVCcuRuPaoK30MoPTgYJCM=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-lu8YY9EUN6CbR3qIOVmPPg-1; Thu, 25 Sep 2025 05:12:02 -0400
X-MC-Unique: lu8YY9EUN6CbR3qIOVmPPg-1
X-Mimecast-MFC-AGG-ID: lu8YY9EUN6CbR3qIOVmPPg_1758791521
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-57b3cffbbdcso632296e87.1
        for <kexec@lists.infradead.org>; Thu, 25 Sep 2025 02:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758791520; x=1759396320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5QyJ8jjxxZrmMUXWyCErSijaNy4q2ViNCLkEOGHiYY=;
        b=Y/1qS4f5QEvRYEm0ksbb7D5qKWn1PCuf8YhTAopftohpdxfEUwhYOQN4FAkXKuQkxk
         tq8EeA1PP9Ue1n6mIMXmxhwh9DXA1qdoV90bAC6TFZ1wUTdOQiUZASu5XPBFlc0CA96x
         iu0FUM5oa9owqw97A/BbAyfWPQzIPJzFizwMT+s7fzJQRlbz1iIgjNM+82OHHEjy0daF
         sQaYOdavTW67/3xSk0gB+b2IQsS/VlQzFugL7Az0m91WGlFFOFhk2FSYVbfCF0pCioMS
         xnyFZUIvmxRMTJnrhtK5oxqjkRKbt8k6iTWNj4RVZ8xE+YWCqdBs1ejr5nbWXGGXxOc9
         mViA==
X-Forwarded-Encrypted: i=1; AJvYcCXcdfyzdGvehZ3QQ3MnDCNtaKhMAgYWC+iMNjDRWU7IVjP5rP7Mea0A/nB4p5uWQZeKGQfMvg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOGuHcEMqarSTubt4lzjakUbEXR6IQZki28yFO7sgeza51NfLY
	9JkF7asGX+AmOKawhIAAjHbk9/UJkvZBujVfiBxf1+t6mDM02jB8ZjPdik/DR0E6ywmMfSauKFq
	Eqobh3qdG8GQyzp/4+7MBehVO87udSiTyo13Ntu9snR6M9YU8MYH1NNx49mXnn+qGNIvCwAFiFH
	w4KQR1EGf9wc75NfinCjq0B/Cdu4hixd+fuTbu
X-Gm-Gg: ASbGnctN2D5vhBRzBF9JPxL/aE55UdWDfPvQRa7bdGrdkxwyel0a+pd6FTl5Za5W/MI
	rqRPWvnJD/BUn82aX97wdVCY6c6KKTG+0HRjcNt45HuCKIm6KDhn2rw0yFGwsmj9rqrT+2n9lX+
	umJJLMkxQcC3E6po3gQdHjMQ==
X-Received: by 2002:a05:6512:1189:b0:55f:6b4d:85d8 with SMTP id 2adb3069b0e04-582d2b4cbfdmr712281e87.28.1758791520504;
        Thu, 25 Sep 2025 02:12:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENVSoOc3Pq3ICAUt5E0JcjNxN+pKiePc3zVYHWq0utFvRc9eJ26bZc0AoAsHSWH75V1ov2or8iEgZrHLuOQu4=
X-Received: by 2002:a05:6512:1189:b0:55f:6b4d:85d8 with SMTP id
 2adb3069b0e04-582d2b4cbfdmr712269e87.28.1758791520052; Thu, 25 Sep 2025
 02:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250925063241.337897-1-youling.tang@linux.dev>
In-Reply-To: <20250925063241.337897-1-youling.tang@linux.dev>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 25 Sep 2025 17:11:50 +0800
X-Gm-Features: AS18NWAhlIIM9v_4iQ4mTMVcgoxeYOjwkB3mMq9RoQW70kAxOdzMlYbHWrw3348
Message-ID: <CALu+AoTauqunUunsnpSX6_pn08PAcr=tpkzWiNJ1cOTR9-8vVA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Remove the "mem=" parameter when using the
 --reuse-cmdline option in kdump operation
To: Youling Tang <youling.tang@linux.dev>
Cc: Simon Horman <horms@kernel.org>, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, 
	Huacai Chen <chenhuacai@kernel.org>, Youling Tang <tangyouling@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NumdJsaNRrfz2RcYO-y6mkgY7Lw3dPEmrdLqMdG7Ytc_1758791521
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_021206_060391_7D179C83 
X-CRM114-Status: GOOD (  20.51  )
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

Hi Youling,

On Thu, 25 Sept 2025 at 14:33, Youling Tang <youling.tang@linux.dev> wrote:
>
> From: Youling Tang <tangyouling@kylinos.cn>
>
> During kdump operations, the capture kernel cannot reuse the "mem="
> parameter from the production kernel. The "mem=" parameter is used
> to specify the available memory range for the kernel. Reusing the
> "mem=" memory range may destroy the production environment.
>
> Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
> ---
>  kexec/kexec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index c9e4bcb..fadf986 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1256,8 +1256,10 @@ char *get_command_line(void)
>                 *p = '\0';
>
>         remove_parameter(line, "BOOT_IMAGE");
> -       if (kexec_flags & KEXEC_ON_CRASH)
> +       if (kexec_flags & KEXEC_ON_CRASH) {
>                 remove_parameter(line, "crashkernel");
> +               remove_parameter(line, "mem=");
> +       }

People can remove it from the kdump load scripts instead if it is not
useful. I do not suggest removing other cmdline in c code.  The
crashkernel is a special one which is fine.

>
>         return line;
>  }
> --
> 2.48.1
>
>

Thanks
Dave


