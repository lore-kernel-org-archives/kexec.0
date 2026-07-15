Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F69C44508
	for <kexec@archiver.kernel.org>; Wed, 15 Jul 2026 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FvQ7Bwb19/MehXNbI1HvzJhFzDtGWMFoiAaxxAEONa0=; b=L7ASTX44L8uAHw0Oeo59eU9hCQ
	j8v7fWbYtfLqNMgFX/Y22EcrPyWA1pI2WXgAjlorFB9wIbO4xRKnAO7penKkQPDDe6IVO5fdjKfvq
	hRjXSaiMjthyJ7xWOLmJD7ZYLP+bJx1CCFUK2Z9TJk6A+x3w4l6pYXvycFly31iWMI6Dy80Mfk/Ho
	kqLPYVOcxtcp7In7A//+A8Bcg+AeXnrrE7Ht0c4LCLBW5oTCjDqIeannVKG+vjpNfDDfZiE1iDRvY
	5BuYzdACQ6lzOCrJKC6IwYdXLXiJnn5ivDgIwoQFejNhMJSmAx4xQDi2KPr+YjGWTGuLcGjn8Izaw
	wrpEgJwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0JP-0000000F4RF-1TE2;
	Wed, 15 Jul 2026 14:10:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk0JO-0000000F4Qj-18Fc
	for kexec@lists.infradead.org;
	Wed, 15 Jul 2026 14:10:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B8226136E;
	Wed, 15 Jul 2026 14:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C4E1F000E9;
	Wed, 15 Jul 2026 14:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784124609;
	bh=FvQ7Bwb19/MehXNbI1HvzJhFzDtGWMFoiAaxxAEONa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bVlBKmy94UulTcM34alLdc+iajgfzqNEbkVtS3FQnpawkmVJ1bOMSHRwTnJSp08AG
	 gwCgiOkzfoAeMNtI3Tbk48u+GrOpIics+qCXsZ6HjLVOhOXTz96HuQQqYW3WUrMuX4
	 0kdcx+CQlzr3t8pDZ8xXxH6Game4n/WZ15ADxgUeEBoykS7bEYtDT+v+4xP70GMipo
	 DV4MFaob9+EtLJOwo+8vyt7nIk8dGr6R+4+3ftsvNvLRd0YYYaErJdZfN4JXRUiWbq
	 8HCQ0E87hzy4kBIqDr+9zKqVzR4BdN8B/h7xluNRHF7p/O03z3cgPOI6/cE5eWnByK
	 FZBDf3Ju1WFpw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Jackie Liu <liu.yun@linux.dev>
Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] liveupdate: fix GET_NAME ioctl argument validation
In-Reply-To: <20260715060613.19272-1-liu.yun@linux.dev> (Jackie Liu's message
	of "Wed, 15 Jul 2026 14:06:12 +0800")
References: <20260715060613.19272-1-liu.yun@linux.dev>
Date: Wed, 15 Jul 2026 16:10:06 +0200
Message-ID: <2vxztsq0ibsx.fsf@kernel.org>
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

Hi,

> Cc: pasha.tatashin@soleen.com,  rppt@kernel.org,  kexec@lists.infradead.org

Please run ./scripts/get_maintainer.pl *.patch to get the full list of
people to Cc on the patch. You missed me and linux-kernel@.

On Wed, Jul 15 2026, Jackie Liu wrote:

> From: Jackie Liu <liuyun01@kylinos.cn>
>
> LIVEUPDATE_SESSION_GET_NAME was developed in the liveupdate/next branch
> while the session type validation change was carried in liveupdate-fixes.
> When the conflict between the two branches was resolved, the GET_NAME
> operation descriptor picked up the structure and last member from
> RETRIEVE_FD.
>
> This makes both its known size and minimum size 16 bytes rather than 72.
> Consequently, copy_struct_from_user() treats most of a normal GET_NAME
> argument as unknown trailing data and rejects it with -E2BIG when any of
> those bytes are nonzero. It also accepts a 16-byte argument and returns
> success after copying only a truncated session name.

Nit: The second line doesn't seem to be true. The get_session_name
selftest tries to create a session with 21 byte name and it passes. I
think it works because luo_session_get_name assumes ucmd->cmd is struct
liveupdate_session_get_name and so it tries to copy the whole thing via
luo_ucmd_respond(), and if the user buffer it large enough, it will
work.

But yeah, the -E2BIG seems like a real problem.

And anyway, that's a tricky bug and I missed it completely when I
reviewed the final rebased version. So thanks for fixing it.

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

>
> Use the GET_NAME structure and its name field in the descriptor.
>
> Link: https://lore.kernel.org/all/ahWlYXNjGUbkKoHy@sirena.org.uk/
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>  kernel/liveupdate/luo_session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index b79b2a488974..f38b5b18f3f8 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -378,7 +378,7 @@ static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
>  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
>  		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
>  	IOCTL_OP(LIVEUPDATE_SESSION_GET_NAME, luo_session_get_name,
> -		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_ALL),
> +		 struct liveupdate_session_get_name, name, LUO_IOCTL_ALL),
>  };
>  
>  static bool luo_ioctl_type_valid(struct luo_session *session,

-- 
Regards,
Pratyush Yadav

