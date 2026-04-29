Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A662CCFA13
	for <kexec@archiver.kernel.org>; Wed, 29 Apr 2026 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jSIY5dDrNGunAsVpp3zxMSKdhVEZ4kytC2UcFzQyNZE=; b=l6ojwLeCPDHc+pqEkJUT/UdnFc
	Mqd45Sdm+VLB08fvlMWSe6U7Yv74gM1NdIHABGh/Ww7WJ+D39YoiXfF/DO/LcQVjDPMzjcIp9LI7C
	pnMzaXGctRVGKHBtOzVv88K245IbAxiHxbASXW7HuLYhWDV0fl/d46GvDzsGOhstaoxdIoYx0y6k7
	QlegLiFph/GO3ON5LR4eSM9S9KIbFix+sEUeoOPdIE8kzBD600AcRZpYap+eTDXX+FsgBi/aOa9P6
	fcXeLdx0FZ0PS0iBft9C2eP1ISEb2GramLfR4+H9OqBDNBjENmwQ+cWpjXn5hCtDqg92f/ckJiSzt
	uF5lv7UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI60a-00000003m5k-3jYt;
	Wed, 29 Apr 2026 14:35:24 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI60Z-00000003m5T-2rT4
	for kexec@lists.infradead.org;
	Wed, 29 Apr 2026 14:35:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D5B0860138;
	Wed, 29 Apr 2026 14:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EDCC19425;
	Wed, 29 Apr 2026 14:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473322;
	bh=qSqiep8Qpof8Q5a2J7V96rrIhl2L0+YtBJVeAPkOgcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ptZVpwHzwAfEy8WKiAsauOLnmEzpAdjJx0/KDi6B4W9VvJ4Q+NzlGgJZndYsLxvqD
	 3svf7hwcYqKHXjPXzMw/Dd+1vaSQt2FpcA6vn+4bVIyWxH5YD8YfqLFdH9Cf9CgTev
	 YPNvRybNRUEE9y/QipyqO2ikeqckWgDnC3GXBRE4cJrmLN8AkseI4Ubq8P1TcjG4s6
	 EqPU8NJiv4LSz9hEX6ST01ofgYwSRGu1X1jRTUBuGEmURTTi4StlMN3VjVjpEBJBIv
	 WM88XgTcFERpvVgcB9V6Xyf4aHcYyijsO4pgGbWXFq5m/X8h7vVGys2IaGM+uogAgH
	 pEyxrW0/85VsA==
From: Pratyush Yadav <pratyush@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org,  linux-mm@kvack.org,  rppt@kernel.org,
  pasha.tatashin@soleen.com,  pratyush@kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/4] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
In-Reply-To: <20260423234753.3873095-4-luca.boccassi@gmail.com> (luca
	boccassi's message of "Fri, 24 Apr 2026 00:44:22 +0100")
References: <20260423234753.3873095-1-luca.boccassi@gmail.com>
	<20260423234753.3873095-4-luca.boccassi@gmail.com>
Date: Wed, 29 Apr 2026 16:35:19 +0200
Message-ID: <2vxz1pfx4yxk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Fri, Apr 24 2026, luca.boccassi@gmail.com wrote:

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
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
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

You need to enforce this in luo_session_get_name(). Otherwise some
userspace might try to get clever and stash some data here. Then if we
ever put something else here it will break that userspace.

With this fixed,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

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
> index 5e316a4c5d71..0bcf2def074e 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -289,10 +289,21 @@ static int luo_session_finish(struct luo_session *session,
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
> @@ -319,6 +330,8 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
>  		 struct liveupdate_session_preserve_fd, token),
>  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>  		 struct liveupdate_session_retrieve_fd, token),
> +	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
> +		 struct liveupdate_session_get_name, name),
>  };
>  
>  static long luo_session_ioctl(struct file *filep, unsigned int cmd,

-- 
Regards,
Pratyush Yadav

