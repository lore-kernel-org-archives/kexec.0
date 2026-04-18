Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE35F99C78
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 04:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q+mY7WPrjBt0/ShGgutDaSnhgXo0yyza7SyHVmsYfX4=; b=uCGbzKwsOTpJnifgwAuBtY4hVF
	RkBWKRHd5IBcZHu4SwK3uzW3cVhyb+48YAGlhzh8tAa7wliQstDuuLBk2v6MgEiHSRrWH1BTJb9VR
	100Xt2nyqwPtBaumUC8Op4BPRxVvNT2dhFXLG/CuPJ4zseT3kd89SLtpikJmJq+nB/3IZaa7cboEg
	oLxk0Y40n8iZUFzuitYJU+RBk4Ln6CGeza0qJdsg0k/ITj8ZjiSqZ4PNx8ia9d+vwUmLUdteKdbj8
	yfFH/OiKCBSFClZBZ0g8VTpxYii9Wpv6PqMvsY7Ou3iRZSfX9Ckp1MRp6aiKIH0y4I3N6NmQb50xV
	RSdoOyhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDwzl-00000004ioH-1XWl;
	Sat, 18 Apr 2026 04:09:25 +0000
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDwzf-00000004inw-0E0x
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 04:09:20 +0000
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-8d6d5e45c43so164249585a.3
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 21:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776485357; x=1777090157; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+mY7WPrjBt0/ShGgutDaSnhgXo0yyza7SyHVmsYfX4=;
        b=RN68rvXkt9k+uXKEqD9vEKa9CIhX91Q8vuAvURICg5eRlur3GKq2YThQW+4WYi8Urp
         So8M9om/NvTWEJV2Y5AK7mTPwjQlEPUthkIMgA9nOpKy+yrPugC+eNxX6pX0JNiJb4cO
         C0/XQazUaW/i+Gb6liLEA9EXpQt2V7GjKCrmztaIDbKtUvE5BnEhS+DEYWa9f/5HbLXh
         mwXLaYnmF54ybsYRrWymJLoHcP0Ys6mdyd8u3pp7wfWifkQKKkW1vCOUvUPJRUKIPVi8
         XGyo82stz27t7UbRn8HbprG0NbjIPVvrL1CSqT668I/mot7pqOQROvnPqcb+ZD3Rv+EM
         CJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776485357; x=1777090157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+mY7WPrjBt0/ShGgutDaSnhgXo0yyza7SyHVmsYfX4=;
        b=gcZDRWwQnUCtAiITOXKPcsM8HC9ZpUXXnOQDLHNOkWx6amqNSRRjZX+1vhy34s3iDq
         3Fs9YXKSWnpngxyRTbI1oZHYsikWk4Lv9yqVDHTJNlfl3t1eNaS6k6id4Vrq1YR45zF1
         9WN2m4HtM2XcEZzjwO8bRCYGGJsyCpinyWM64KXvMLJRmObsPt/ynB8zsT+GQGKNCFzJ
         tf8cN/tVIiLntnp85tj4BMRlys8aGJ2IL8/T2+PmO1BlJBD7t6jht+3rVcq9amCbmMwK
         BFFiyQFMICXTF28XtJ9DqtDX04WiWDapVkIADZ7SacgnMwz+mpvULMc6VAAXPsZmQrL2
         WEYQ==
X-Gm-Message-State: AOJu0YxkZzqK9okGHEJDr2o6b1sGRZNzPCAGo58RW85IvWLyrmze1J2h
	Zh+8hNhk09thGxrRQQ+b82TY3xNlOl+VKgk/0nr2S4KlVa5YgeCKOEycuNMkHewERL4=
X-Gm-Gg: AeBDiescc3aVSGD+8/2AmMaJk8mYz6ulocS686t+z8q2vD7X+P7GM9bzKmVlOO7ZOOM
	8WH3qHW42zGeyNHReXI4bEeuNpNvhHd7v3sPpUVNdFO10Y4vkXopAkBi9CNXw4yOm0AFuOJe9WG
	H7qwEnObGWPayBOnRhzhdrCa2XZFGDYatdSEvpctc5OQHmC0ZkSnX+KjvCdpDGsNwvwsRMC8+2j
	HqVkEdwr4Dh66sJm1MzQG/Cl5e3k0Kp806KhNCJOl+hjHXh+cmest5iLcirrjnmZ1W3MeS16Jln
	5WTacH6Ni7iWi7iRAJJhsvZOhVNeZoZZzfvP3VXcyytg8lCJMEA2nbqQVxcGVvdEvqn7s+Yzs/c
	S0InEN8CaxN4Sy2aL7z58aMwWmaOaukLeW+Ev+SMZVeVErhuQyRqwpr0GR3/okmIW1wVWXKfgi9
	w+2Z7ApsJeLhpVj9lWz102VxcJmM3QDS57T0EYwph8ZffsOfw636ObzPKhs1XY
X-Received: by 2002:a05:620a:2944:b0:8d7:e7f4:7e9d with SMTP id af79cd13be357-8e792f44c37mr787915285a.59.1776485357527;
        Fri, 17 Apr 2026 21:09:17 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64cbbdbsm288756285a.12.2026.04.17.21.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:09:16 -0700 (PDT)
Date: Sat, 18 Apr 2026 04:09:13 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Message-ID: <ntukp7nk6emz3twpcxn6abdwzbd2fxn5c2udb5scrmnjyvsvua@7272xkwt55qh>
References: <20260417220831.1934945-1-luca.boccassi@gmail.com>
 <20260417220831.1934945-3-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417220831.1934945-3-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_210919_177157_309DF700 
X-CRM114-Status: GOOD (  25.49  )
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

On 04-17 23:05, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Userspace when requesting a session via the ioctl specifies a name and
> gets a FD, but then there is no ioctl to go back the other way and get
> the name given a LUO session FD. This is problematic especially when
> there is a userspace orchestrator that wants to check what FDs it is
> handling for clients without having to do manual string scraping of
> procfs, or without procfs at all.
> 
> Add a ioctl to simply get the name from an FD.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> v5: merge with LUO_SESSION_MAGIC series as they both change the same
>     unit test file, to avoid merge conflicts
>     add '__u32 reserved' to the UAPI struct
> 
>  include/uapi/linux/liveupdate.h | 20 ++++++++++++++++++++
>  kernel/liveupdate/luo_session.c | 13 +++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index 30bc66ee9436a..079ee6afb15a7 100644
> --- a/include/uapi/linux/liveupdate.h
> +++ b/include/uapi/linux/liveupdate.h
> @@ -59,6 +59,7 @@ enum {
>  	LIVEUPDATE_CMD_SESSION_PRESERVE_FD = LIVEUPDATE_CMD_SESSION_BASE,
>  	LIVEUPDATE_CMD_SESSION_RETRIEVE_FD = 0x41,
>  	LIVEUPDATE_CMD_SESSION_FINISH = 0x42,
> +	LIVEUPDATE_CMD_SESSION_GET_NAME = 0x43,
>  };
>  
>  /**
> @@ -213,4 +214,23 @@ struct liveupdate_session_finish {
>  #define LIVEUPDATE_SESSION_FINISH					\
>  	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
>  
> +/**
> + * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
> + * @size:  Input; sizeof(struct liveupdate_session_get_name)

The kernel=doc comment needs to be updated to avoid errors. Add 
something like this:

 * @reserved: Input; Must be zero. Reserved for future use.

> + * @name:  Output; A null-terminated string with the full session name.

> + *
> + * Retrieves the full name of the session associated with this file descriptor.
> + * This is useful because the kernel may truncate the name shown in /proc.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +struct liveupdate_session_get_name {
> +	__u32		size;
> +	__u32		reserved;
> +	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +};
> +
> +#define LIVEUPDATE_SESSION_GET_NAME					\
> +	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
> +
>  #endif /* _UAPI_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 5e315cc0dfd52..f30151c37bd43 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -291,10 +291,21 @@ static int luo_session_finish(struct luo_session *session,
>  	return luo_ucmd_respond(ucmd, sizeof(*argp));
>  }
>  
> +static int luo_session_get_name(struct luo_session *session,
> +				struct luo_ucmd *ucmd)
> +{
> +	struct liveupdate_session_get_name *argp = ucmd->cmd;
> +
> +	strscpy((char *)argp->name, session->name, sizeof(argp->name));
> +
> +	return luo_ucmd_respond(ucmd, sizeof(*argp));
> +}
> +
>  union ucmd_buffer {
>  	struct liveupdate_session_finish finish;
>  	struct liveupdate_session_preserve_fd preserve;
>  	struct liveupdate_session_retrieve_fd retrieve;
> +	struct liveupdate_session_get_name get_name;
>  };
>  
>  struct luo_ioctl_op {
> @@ -321,6 +332,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
>  		 struct liveupdate_session_preserve_fd, token),
>  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>  		 struct liveupdate_session_retrieve_fd, token),
> +	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
> +		 struct liveupdate_session_get_name, name),
>  };
>  
>  static long luo_session_ioctl(struct file *filep, unsigned int cmd,
> -- 
> 2.47.3
> 

