Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F02C001B0
	for <kexec@archiver.kernel.org>; Fri, 11 Aug 2023 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=14RMr+bdCuQ/j4JhkSeSMN+OIOg7wDJ3f0PJgOhhYU4=; b=UhzsiCXJ2IkoTp
	dOi5T5YZouIy92nMCFs46X/HPV9D973P4xdw0rdr4OdRddzb4zEFbKsa/X8nK+9aOtAcXTw7mLMgo
	A7oHYVnO22ltRPUiptGoVzZtMr1cXagqH1AQmUUzErC3ZkmqasttO5U8qSC6R+/zvV0e+VQkHoCGd
	GqCL9OY1d6155K0/vbWj7GflhtTuJoIyqmMz1wo0zfwd0VNolmD16Qtr+BPQWREfFzYuBsEsLb9qW
	Mjm+Bl81s+p04sAX0sZ2iL2fO/jDrrhmwcNDktu6/1Dt7Poxcp121GiWnqLLMohMNtxDV+1o4Z3aF
	jNe4uy6bl+AqtHjb/LkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGq0-0093NQ-1Y;
	Fri, 11 Aug 2023 01:21:12 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUGpx-0093Ma-02
	for kexec@lists.infradead.org;
	Fri, 11 Aug 2023 01:21:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691716867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xvjjrb8mpK7IEK2rk2L1hv91W8MwxoCOZKSklAv65Fg=;
	b=BoYb/mjOS12eAEaea9wcZ0zUhtrYmhIbWaU+AsVKxYCpdOyqdSmkuSTx68ixkOEOZPcyE9
	EZkNZhejlOBAuJGZ1lWSK6GgdbsbCvlX+Glf8Qyh7m0rAgQzny5ARACLILf4J3H2pita5D
	hfcnb72qhPuLmcArPAF3RspOGXPRoqw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-uV45O-IlOG-UlklD4rXRWQ-1; Thu, 10 Aug 2023 21:21:05 -0400
X-MC-Unique: uV45O-IlOG-UlklD4rXRWQ-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-790c67e9ea8so40464439f.0
        for <kexec@lists.infradead.org>; Thu, 10 Aug 2023 18:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691716864; x=1692321664;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xvjjrb8mpK7IEK2rk2L1hv91W8MwxoCOZKSklAv65Fg=;
        b=LC87Pro91jtdFl/2rX/5QKSRIxzF/NughtWPLrRarG7fsajAr/C4xdfQHkLVX/Y9+9
         Sy+Zo2BQZRJv1mJKrSKWfe+8RvG4498wFwW/5z1RNvlxPchCFQsPxDK+KiXzWpfuoIER
         R9jfOs2GAK7tI8y8c+HlTyiFAHerCrWJdhvvSORinolT4CrGTC23ZPJ+PdV5DqbgRbUH
         V1VzV30Q4ZXi/b4pf8wGVVS9AVBP+s5fK5z7HeAtQIQ5Ry6cwvIQhd6ZKJ6VkGK9E/Ra
         mtNfJBz3GqJT7f3rGA5Ap7Ydo23i9WZ1b7bCcF4q/UbqJbE2mVAfiylS6m/38fVY3ocx
         2vMA==
X-Gm-Message-State: AOJu0Yx8Aiu27x5bP9lWMwjGaKVOtDrDeZ9w5domDmtaGawZhp3TWe9b
	vvaML4nWHSxFJ2tQSqbX0V0rAuNmTMv84sMyKhLfBhMZpeRQke1m0mpDMPvLQBTPTSzAJ3WcRVf
	0urRqhUPvJBn+xrlaP7cl2IxlJGRMs7rtn3qiWfIHWfgebEx4lQ==
X-Received: by 2002:a92:d4cf:0:b0:349:4e1f:e9a0 with SMTP id o15-20020a92d4cf000000b003494e1fe9a0mr495339ilm.2.1691716864428;
        Thu, 10 Aug 2023 18:21:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1bXASTWlmmiYZLcaN5miHjXqlHR+qV0OzLOj5cAjKD/8yHuqvQ3Mi2iYrNKRmL3G5AOX1vMCVviBJg3i0wqw=
X-Received: by 2002:a92:d4cf:0:b0:349:4e1f:e9a0 with SMTP id
 o15-20020a92d4cf000000b003494e1fe9a0mr495333ilm.2.1691716864189; Thu, 10 Aug
 2023 18:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230803024152.11663-1-piliu@redhat.com> <20230803024152.11663-3-piliu@redhat.com>
In-Reply-To: <20230803024152.11663-3-piliu@redhat.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 11 Aug 2023 09:23:05 +0800
Message-ID: <CALu+AoSj+cc4zrWYcwNHBV__FYfH+bST+D_BOdCix2RCq80REQ@mail.gmail.com>
Subject: Re: [PATCHv7 2/5] kexec: Introduce a member kernel_fd in kexec_info
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, horms@verge.net.au, ardb@kernel.org, 
	jeremy.linton@arm.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230810_182109_164724_A7F14D43 
X-CRM114-Status: GOOD (  20.22  )
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

Hi,

On Thu, 3 Aug 2023 at 10:42, Pingfan Liu <piliu@redhat.com> wrote:
>
> Utilize the image load interface to export the kernel fd, which points
> to the uncompressed kernel and will be passed to kexec_file_load.
>
> The credit goes to the Dave Young, who contributes the original code.
>
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Co-authored-by: Dave Young <dyoung@redhat.com>

Signed-off-by: Dave Young <dyoung@redhat.com>

> To: kexec@lists.infradead.org
> Cc: horms@verge.net.au
> Cc: ardb@kernel.org
> Cc: jeremy.linton@arm.com
> ---
>  kexec/kexec.c | 8 ++++++++
>  kexec/kexec.h | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/kexec/kexec.c b/kexec/kexec.c
> index d132eb5..c3b182e 100644
> --- a/kexec/kexec.c
> +++ b/kexec/kexec.c
> @@ -1292,6 +1292,7 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>         info.kexec_flags = flags;
>
>         info.file_mode = 1;
> +       info.kernel_fd = -1;
>         info.initrd_fd = -1;
>
>         if (!is_kexec_file_load_implemented())
> @@ -1337,6 +1338,13 @@ static int do_kexec_file_load(int fileind, int argc, char **argv,
>                 return ret;
>         }
>
> +       /*
> +       * image type specific load functioin detect the capsule kernel type
> +       * and create another fd for file load. For example the zboot kernel.
> +       */
> +       if (info.kernel_fd != -1)
> +               kernel_fd = info.kernel_fd;
> +
>         /*
>          * If there is no initramfs, set KEXEC_FILE_NO_INITRAMFS flag so that
>          * kernel does not return error with negative initrd_fd.
> diff --git a/kexec/kexec.h b/kexec/kexec.h
> index 0d820ad..ed3b499 100644
> --- a/kexec/kexec.h
> +++ b/kexec/kexec.h
> @@ -164,6 +164,7 @@ struct kexec_info {
>         unsigned long file_mode :1;
>
>         /* Filled by kernel image processing code */
> +       int kernel_fd;
>         int initrd_fd;
>         char *command_line;
>         int command_line_len;
> --
> 2.31.1
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
