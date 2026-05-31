Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4563BCD5BD1
	for <kexec@archiver.kernel.org>; Sun, 31 May 2026 12:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OnMQ970O/37FDrK1Y36am7zIeSijQMUukVCUSJ3uyGk=; b=lfsPqKwFlYOq20T+W9YR8hpFXa
	TLT/GJdjf2QVke31mP6biqBlKlzOi7VJK3fWnbZHEcSS1d5GA7gmnoV/vjlcN7CGR3x6VWwwyXKRE
	tg0MRWZWmgSBB3i8/RiIQSNYZLPhStf8BVrY//utLN7t4ziCAXWdoQS6zqiNguskinVVWyTjtlG7d
	AmPHSCWxhUub8A8G0HtmKUFXJYJWHC8BjAN5c8DuvQ63AggPUODvAHZ+ADH7asTnbBJRjchHHO7H7
	7++NeHBf4pPHTTiTjj7Khrw7x8KqLZNxhcV0C9NS7HmOMqvWKVEHIrzsUj3j+M0PYdTix2/6DsFfY
	csy9a0Yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTfen-00000009bf5-1cyW;
	Sun, 31 May 2026 12:52:45 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTfek-00000009bek-41N1
	for kexec@lists.infradead.org;
	Sun, 31 May 2026 12:52:44 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-91550eced6bso69758785a.1
        for <kexec@lists.infradead.org>; Sun, 31 May 2026 05:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1780231961; x=1780836761; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OnMQ970O/37FDrK1Y36am7zIeSijQMUukVCUSJ3uyGk=;
        b=VCg/o2YdtKdPUNKrVna+Eip2fxHjLqpYCnmJPrsMQsF2J2SPo162xD1OX62nXCRGvd
         fG+OE5KcmVii9O+g1Dmejni/pxUYMlTuDlSffE9dajRwpL6Zy6Psga/nlo1VceGgbvDL
         jgPYIAaPncjpKugTIXLsxaNq8TOJ+J8ud9073raCLOOxG5fCRdTIbSJIzcgnS9wiS2Kn
         2Fqsl8tc5GBDDzpcw2lHZK0ikHGcCOvr7EJxIpv6+L83tSolpU9kyXOC+qX5dDUoAgln
         +PqS4BqfyOK0hgq0Wj0CFHu+IWRU2guSi8Fc1kxItwrXA7Ow5PCMQLROZ1P8MN1zn+Kd
         e36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780231961; x=1780836761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OnMQ970O/37FDrK1Y36am7zIeSijQMUukVCUSJ3uyGk=;
        b=XqeNdelOEo0Qf/LHfD3icxbHwWQ0o4XEfA2euuCs8cUsNbKXIiMXBfa6TtNLbLNdzx
         Z3Wht2Mm5rXGyf2RiVnsWOEENSy3C2/j6OjR2CwT2gV5cCghhGb+czVEU2knk7X/RAo7
         BNIzHLiNX7MzvewqeGdf/U4hplaoFrBflgXz+i/wbYP15yqzZyoL9rIkJ9eDvrVumkCm
         R+Dd8VyBI+VhWF1PArhb9/NDT/VpPVujQN73bapisiMMl5AUsFFpLd83k5pAtulsEg9R
         ZU40I6kCLBTwXxL1xIxIQpOF1SzXVKy7BuE/R7yC0EpUt605fW0TiFjWFKYH8CpsCc9j
         bjUA==
X-Forwarded-Encrypted: i=1; AFNElJ+Acy65YO7lLc3d5m/6SM1oAL8gjou7VkLZhdgmzEBvRNf8qYV2Jr1xrrpOnRmljCI55IjHCQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxZTD4tSPcv8DKkrO4rx5vHyR/DlKgaGU8YVPoxrjSTeRRc8s6u
	JwAic/ObBkgvi3vx8Zgp7svLEWbtSijBOium11WtgARx1S3WGY97yG/lYIFTFJMF0w0=
X-Gm-Gg: Acq92OFjSQYICW0jFP2skFcV/FcBru/VkyCbsAoAZgcjcnf10jMFBANm0zXyNKgrsD+
	1tTiaS06w0oPhPbeVNhB1ikJodUpMO1k7yjzT831/ciPQv5v0XFHzQ3pQMjwVBEcTbOlwo58kAf
	cc6EdeMbHGMIsG+stfEm1q4CD6Fjrs890w6r5uiG7vLf911kYTpdNVoGXW95RE8zetpjqkFOejb
	mkoSl61e/mo+pWYeq0ePbp2hKoXsGoa9GuS0mYRxZfdPXdDS5T4uxzKxyTZTkD/oiYKNoVToEVk
	1Vqo8mMP6SApTwRbFvJRaTtBQbI+CdCb1THxeMF2KWggFh/YfsQgYnV0de/B2aWrWKnzFY/inTl
	L9NTctpaAAfgfpQp9SnHHVMfIbQXxacSnz9m6DdY0jFKxUbYK01Z0N3LOn6f39EUhponjNFy1UQ
	R1e+UtaXhXV7hFC2Sq188wLP2dUPxkrnRuItOSF3uiE+YdSJNoMpfEhEm09BH4/w==
X-Received: by 2002:a05:620a:1792:b0:914:ca5f:bc59 with SMTP id af79cd13be357-9153db8be70mr1156444585a.62.1780231961592;
        Sun, 31 May 2026 05:52:41 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9153247515esm743332185a.13.2026.05.31.05.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:52:40 -0700 (PDT)
Date: Sun, 31 May 2026 12:52:39 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: linux-kselftest@vger.kernel.org, rppt@kernel.org, shuah@kernel.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	pasha.tatashin@soleen.com, dmatlack@google.com, kexec@lists.infradead.org, 
	pratyush@kernel.org, skhawaja@google.com, graf@amazon.com
Subject: Re: [PATCH v4 02/13] liveupdate: avoid mixing cleanup guards with
 goto in luo_session_retrieve_fd
Message-ID: <ahwuA1tYmM0LZt0d@plex>
References: <20260530221938.115978-1-pasha.tatashin@soleen.com>
 <20260530221938.115978-3-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530221938.115978-3-pasha.tatashin@soleen.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_055243_028741_FD834D22 
X-CRM114-Status: GOOD (  18.27  )
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

On 05-30 22:19, Pasha Tatashin wrote:
> Refactoring luo_session_retrieve_fd() to avoid mixing automated
> cleanup-style guards with goto-based resource release, which is not
> recommended under the Linux kernel coding style.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  kernel/liveupdate/luo_session.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 146414933977..8d9201c25412 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -291,25 +291,24 @@ static int luo_session_retrieve_fd(struct luo_session *session,
>  	if (argp->fd < 0)
>  		return argp->fd;
>  
> -	guard(mutex)(&session->mutex);
> -	err = luo_retrieve_file(&session->file_set, argp->token, &file);
> -	if (err < 0)
> -		goto  err_put_fd;
> +	scoped_guard(mutex, &session->mutex) {
> +		err = luo_retrieve_file(&session->file_set, argp->token, &file);
> +		if (err < 0) {
> +			put_unused_fd(argp->fd);
> +			return err;
> +		}
> +	}
>  
>  	err = luo_ucmd_respond(ucmd, sizeof(*argp));
> -	if (err)
> -		goto err_put_file;
> +	if (err) {
> +		fput(file);
> +		put_unused_fd(argp->fd);
> +		return err;
> +	}
>  
>  	fd_install(argp->fd, file);

From Sashiko:
This is a pre-existing issue, but could this error path allow userspace
to hijack a recycled file descriptor?
...

Answer: No.

get_unused_fd_flags allocates an unused file descriptor (FD) that 
initially points to NULL. It is not associated with any "struct file"; 
this association occurs only during fd_install(), which is the final 
function called before returning to userspace.

>  
>  	return 0;
> -
> -err_put_file:
> -	fput(file);
> -err_put_fd:
> -	put_unused_fd(argp->fd);
> -
> -	return err;
>  }
>  
>  static int luo_session_finish(struct luo_session *session,
> -- 
> 2.53.0
> 

