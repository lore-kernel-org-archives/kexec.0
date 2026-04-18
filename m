Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2078DF99C88
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MkRRlcAhUS32PwzsCXImISgP21H+dIYMB9rbdJES7eo=; b=0kIKXLt4VVAoMj1g/KNTIU5Xax
	yetRfpUb/FAEXou+GGnEUgY7JYp/tCDztbJ2EJzXBG7bW+yBy6GJxPGv9UMoDX6HnWRvOislrIo5u
	nEIGQZq6tO4SljM1luj91zwRz2lCK6RFrR99SZ28MbHs2YNIvUE4qYpp39YBlxPFdlExW1yMyToHb
	IHvpf2rKKaFzEoIwiB/PotIkpH4AofxX8aXS/P5oZbDUpmMBJ82SmM5fQ3756srTuqDLBdM/yC2/b
	saBM4J9/omVNddLR3Gpdo7io6T/P10dhZExI1Kq2OZHhuWNsX3mmAnsF2gpXzML15MC0sc9q3xHaM
	KiLzclgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE7xa-000000054YM-0shM;
	Sat, 18 Apr 2026 15:51:54 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE7xU-000000054Y0-1oVI
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 15:51:52 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-899a5db525cso12751466d6.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776527507; x=1777132307; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkRRlcAhUS32PwzsCXImISgP21H+dIYMB9rbdJES7eo=;
        b=VqB5Uo9Y1fGgA0KNketxCF57GvNKsVknAGd2vVSy/YsHkJACS4TwXHYY5KbWY22wty
         C9qeWUzkmxyT7E1J6IrgiqEI0n6w0AEO69hY7An0sUYh7O+lLRNbUN4fu6kzmwoAgG/f
         QzKXTr/ghOlhGI2wdt33DJNeZ4Pi2Bf4TUxuQQFgQ65ohLE25XghaFMCuGtvt4vj2mDm
         yxZia/5UXR04SrlXc2kd7NxaLaqQ+3n1Y4ponXHWG6hvhrRms3sTmMo5TlxfBKRBQHf6
         a7zrL2u5JKazhjbBWtrAT/PMPYuE8xvRVFtDJI6+QYQMD29B4HFamRlsx5gEt4t1Pd1o
         2vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776527507; x=1777132307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkRRlcAhUS32PwzsCXImISgP21H+dIYMB9rbdJES7eo=;
        b=EhdD87qwifun5K+upIruHMmtHhCqqkr089vLirOVULGY4ec1DjrOqnz0gAuirve4Ao
         S5PKnSp3reZOBGEiyj2NCGV6f2bjPI02A2GXKDJxk4pOuWDeTnLnegTh4odVA4uQPG6g
         9oAtb2Ysu7hb1+W7WCQ0zlp/EvJ6N2vZp6v2Pg3gY17ZQdj88ssOFqs3ewapLx+Kghte
         VLxweCxbHBEl6F1OkgnG0s+LfB0tUXjo4wGpQmX5fcJb28WFq8iwBsDt3ubjA9eNqJn5
         rENIppySKIyqAgCLlA6Z2L34lBFpVxe0XURtvT8LoBSfFf6nZVudMvVn3IVG54BgL1jA
         wTuQ==
X-Gm-Message-State: AOJu0YznKC8rwJosR9v8I7GVAKg1wyVIKSawhA5jd7k7YfJYD3v3+TC/
	pfQQ4qYA8Bhgw09ClyNZwye2NV+rWs3h1XkXZ8lynON4K7GDfGazbAwAYJay35ZueiY=
X-Gm-Gg: AeBDiesEVw9xn+7bv8DodwGUCv1tuNqiGdUPnhSoNNGBg0l+wsxvTcGWnjC392A7sgG
	icVC+YbA6Si3LIa2lSBN457E042v8QbiV9jddV0SpD0Y6uREmszjhLe6Zln6RFBuXeVYdAObAfQ
	wGk01AW0/o+bsa8Bvm/wwGrSNuNvCpgfeO0PNcl7BJBkVv+Chza6KDPIwd/taaNHmR9LuE+J6nr
	j+rroLGFBRS6L95sQv/Auf03DZfZgA428CCND3xX6ScoemuyfrCu+DnRrXQ8ltON+X5c4lotS6k
	YzNh5lwkuEhmYw+Gvgs9+JoLRQC4gHdaVF28ASjLsjwzWnPe9USWZYJV18XAotF7ECQBEKa1eNf
	6NryW461FCZX8P8tkFHBBeXh0FTBgCdZITebHH3czTUCrzz4Y6Md7QW7H0HY9p+IeCFzqJGkcxb
	y1KGaL/IaBt8UyHH/j6gWtVysoSzgjsZo+EYIBHxHRFmEVcAw4LL5JnEGFbvuC
X-Received: by 2002:ad4:5ae9:0:b0:8a1:42f5:2c8 with SMTP id 6a1803df08f44-8b028065e21mr114871586d6.16.1776527506951;
        Sat, 18 Apr 2026 08:51:46 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc655sm34782646d6.48.2026.04.18.08.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:51:46 -0700 (PDT)
Date: Sat, 18 Apr 2026 15:51:43 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Message-ID: <tiwltvdzwsm2c44xkzo5lbwkdv3vp3wsus6gbyin4caggwriro@lx6s6e6vrqla>
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
 <20260418141123.2193917-3-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418141123.2193917-3-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_085148_719209_B813B77F 
X-CRM114-Status: GOOD (  25.39  )
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

On 04-18 15:09, luca.boccassi@gmail.com wrote:
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
> v6: fix docstring
> 
>  include/uapi/linux/liveupdate.h | 21 +++++++++++++++++++++
>  kernel/liveupdate/luo_session.c | 13 +++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index 30bc66ee9436..3a9ff53b02e0 100644
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
> @@ -213,4 +214,24 @@ struct liveupdate_session_finish {
>  #define LIVEUPDATE_SESSION_FINISH					\
>  	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
>  
> +/**
> + * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
> + * @size:  Input; sizeof(struct liveupdate_session_get_name)
> + * @reserved: Input; Must be zero. Reserved for future use.
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
> index 1d35379e4e52..9b434470982c 100644
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

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

