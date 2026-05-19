Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50183CD4F3C
	for <kexec@archiver.kernel.org>; Tue, 19 May 2026 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LyJqfMx5Ks1exoptQvYh/tS2q82SfLe8ov3UKKxLEwc=; b=c473TjbtGzfchVfOJygR/TB9KA
	s2nRtyqlG+0MgMn+HJpVRRg4IRsamlZvjF/55Y/XX+SqMh9QqwBpzpe9NKU2e1Akszw+g2ffWPM7Z
	KpOPP4cr2Gu5LsMEoQsE9p6/8iru3zg4gDBjeN0nDOAxxuJI7Cr+4qbvOWUKVNb2ogan2u3+naMUc
	56gWhznIOrQfAZu1uR5Ium+DeMg6cthXgzqWq2Rit7TYYTPgEVOQE7cpxNRL64FNtapBaNbXn5iWS
	aoFUfNe88w2Z20C/Ce7CE6RGleV7RCkuxaqUBmfKAqGqU2gUvS/PnzKaCv8/OX9jBYPxVLZCLCONV
	zPqCt40g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLAR-00000001mG1-0fJ0;
	Tue, 19 May 2026 14:11:31 +0000
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPLAO-00000001mEv-3YYy
	for kexec@lists.infradead.org;
	Tue, 19 May 2026 14:11:29 +0000
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso43883551cf.1
        for <kexec@lists.infradead.org>; Tue, 19 May 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1779199887; x=1779804687; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyJqfMx5Ks1exoptQvYh/tS2q82SfLe8ov3UKKxLEwc=;
        b=i68Q7xyE0t2jXebAaSjq4Plia0Pd8YG7a/Zu0ZRry1qeuV3EtCutIH0AY7Xv2bBfB0
         HQ8TpQj1gV0WxwwLJIFhfX2fn5jj+XB+M5fcKSlXzgmXBS6jN+KD650ukFyiQq4Cej4X
         Y5i5rf5mvOojerIuV9Nv3DdWeMytp5QjP92pUygLzDyjARcrTA8B4RDEQ3H6hgie0h4Q
         M+s0e1QKkGYpuHQl3vr9oqwaFUjAt0iM9SntJiBrpCBnpWNC+tadBJmPOJIpgPbNiPEC
         l63DjLXXuy/M1CSmba/SW4A3iLDSdL24gflLbqeZF7UD2QWxFVkBn7eslZEVyPjVFzMQ
         ZvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199887; x=1779804687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyJqfMx5Ks1exoptQvYh/tS2q82SfLe8ov3UKKxLEwc=;
        b=A4jbb8mVXf03jQ978um6Kj9yYjz+ITs4CMPaXxCR28PilAsHkIyIw1/Ygj8JJ629x5
         UKrpyTqKg44LFj923GfpoxlejGyvVrmS2hiGoNybzmq2/TQmYbM/WuTn3sZLzEdBvJGO
         PJU2g1JhhTmfqiE3ZcRB43yJP5kSfk7NzlU3OOD7W9SiiU9OUbDPDQuQu6GzXdY8tozQ
         08d5ooKAzkkhNGLeGgOMycEn1f/1pmuyT3IEwGT36K+LLPRr+nVMx9m/qlXXS94aSgQ1
         BXHjvK3OJW7V0nEIFtMcD97r8F71tbFQpBgNqfyGrRVeb814Q/VIwB258OkR8x0Jg9PS
         y7iA==
X-Forwarded-Encrypted: i=1; AFNElJ+q/EVVq+V5GYdJ1+2I5XCv2rPbgtL+bgE1t8Lyzoy+c7S8myjJ0CsbIim0azKC8Ig79/xCcg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCsPt6A355J41e8+uLdY0tTN7rpftOfem79ovFwF4EJiM30veF
	x2rRd0dB/bSnS7MVhwKZ0Dc1vZcqUTja+Su5wrEe01SuAoAGJ3fDK40f0A3iQULvLhU=
X-Gm-Gg: Acq92OGrCHdaZ1kodmDIrjZ3/dO1gDWMb313GjUFF57bOQdvEL75ODwNGgzqqxgMszp
	zDpPlyv5CssZrH7MkZCpAuknIDkkATswxIXOh6nlzSKX4MNNB744ZNdM0tV8OJhSCYw8/9Cvu9d
	tgVpL+B6KnunSlUc+DAIhL4DdvCicWVXjHFCRDW0hkMa6aJAFXjmK8Us4a12Pj58oMyOKU9ILTz
	o+Ne5889mKVyDWgnOdVf93IyZvrZbg706fHMorDhIb/WvVy0Rh2xOTfXsN5QkqtMN3HdFSNNsMY
	VgY5yS1DN1h+C5EVTvcIAE4P5u+KHRUlsrJ+RRiU621gdOJxg7ziMPrZ3D20LMuJpKR1xTKtnvO
	Xd6v9inLey1RzgxNOM7t6ClPOR0v2ljS70xxuWjOkp5RXZkymLJ9+zj6Kzo9K/YOgc1/7Cuj2Gz
	aQGDWbVNqjUS5b4dJJg/39n00fHmUtrMxo2JOf9yvStvXj3wrijmo=
X-Received: by 2002:a05:622a:90e:b0:50e:635b:5579 with SMTP id d75a77b69052e-5165a00702cmr265768101cf.19.1779199887300;
        Tue, 19 May 2026 07:11:27 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5164585fa0asm177729321cf.31.2026.05.19.07.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:11:26 -0700 (PDT)
Date: Tue, 19 May 2026 14:11:26 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: validate session type before performing
 operation
Message-ID: <agxuNavjtB8T_xRO@plex>
References: <20260519122428.2378446-1-pratyush@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519122428.2378446-1-pratyush@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_071128_902515_18201E16 
X-CRM114-Status: GOOD (  36.90  )
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

On 05-19 14:24, Pratyush Yadav wrote:
> From: "Pratyush Yadav (Google)" <pratyush@kernel.org>
> 
> The sessions ioctls are not applicable to all session types. PRESERVE_FD
> is only applicable to outgoing sessions. RETRIEVE_FD and FINISH are only
> valid for incoming session. Calling a incoming ioctl on an outgoing
> session is invalid and can cause file handlers to run into unexpected
> errors.
> 
> For example, a user can create a (outgoing) session, preserve a memfd,
> and then immediately do a retrieve without doing a kexec in between.

Please add a self-test tools/testing/selftests/liveupdate/liveupdate.c
to verify that outgoing sessions do not accept retrieve_fd ioctl.
Option, you could also add to luo_multi_session.c a test to verifying 
that incoming does not accept preserve_fd

> This would result in memfd's retrieve handler to run. The handlers
> expects to be called from a post-kexec context, and will try to do a
> kho_restore_vmalloc() or kho_restore_folio() to try and restore memory.
> 
> KHO catches this (thanks to KHO_PAGE_MAGIC) and returns an error, but
> since this is considered an internal error and KHO throws out a bunch of
> WARN()s.
> 
> Associate a type with each ioctl op and validate the type in
> luo_session_ioctl() before dispatching the ioctl handler to make sure
> the op is being called for the right session type.
> 
> Fixes: 16cec0d26521 ("liveupdate: luo_session: add ioctls for file preservation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> ---
> 
> Notes:
>     I added LUO_IOCTL_ALL but there is no user in this patch. The type is
>     for LIVEUPDATE_SESSION_GET_NAME which is supported for both session
>     types. The support for GET_NAME is in next and this patch should go
>     through fixes.
>     
>     Alternatively, we can remove LUO_IOCTL_ALL from this patch and add it to
>     the LIVEUPDATE_SESSION_GET_NAME patch in next. But that would need us to
>     rebase to an rc that contains this fix.

Let's keep LUO_IOCTL_ALL change in this patch.

Please add tests, otherwise LGTM.

Pasha

> 
>  kernel/liveupdate/luo_session.c | 36 +++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index a3327a28fc1f..e84218e3cacb 100644
> --- a/kernel/liveupdate/luo_session.c
> +++ b/kernel/liveupdate/luo_session.c
> @@ -295,32 +295,58 @@ union ucmd_buffer {
>  	struct liveupdate_session_retrieve_fd retrieve;
>  };
>  
> +/* Type of sessions the ioctl applies to. */
> +enum luo_ioctl_type {
> +	LUO_IOCTL_INCOMING,
> +	LUO_IOCTL_OUTGOING,
> +	LUO_IOCTL_ALL,
> +};
> +
>  struct luo_ioctl_op {
>  	unsigned int size;
>  	unsigned int min_size;
>  	unsigned int ioctl_num;
> +	enum luo_ioctl_type type;
>  	int (*execute)(struct luo_session *session, struct luo_ucmd *ucmd);
>  };
>  
> -#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
> +#define IOCTL_OP(_ioctl, _fn, _struct, _last, _type)                           \
>  	[_IOC_NR(_ioctl) - LIVEUPDATE_CMD_SESSION_BASE] = {                    \
>  		.size = sizeof(_struct) +                                      \
>  			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
>  					  sizeof(_struct)),                    \
>  		.min_size = offsetofend(_struct, _last),                       \
>  		.ioctl_num = _ioctl,                                           \
> +		.type = _type,                                                 \
>  		.execute = _fn,                                                \
>  	}
>  
>  static const struct luo_ioctl_op luo_session_ioctl_ops[] = {
>  	IOCTL_OP(LIVEUPDATE_SESSION_FINISH, luo_session_finish,
> -		 struct liveupdate_session_finish, reserved),
> +		 struct liveupdate_session_finish, reserved, LUO_IOCTL_INCOMING),
>  	IOCTL_OP(LIVEUPDATE_SESSION_PRESERVE_FD, luo_session_preserve_fd,
> -		 struct liveupdate_session_preserve_fd, token),
> +		 struct liveupdate_session_preserve_fd, token, LUO_IOCTL_OUTGOING),
>  	IOCTL_OP(LIVEUPDATE_SESSION_RETRIEVE_FD, luo_session_retrieve_fd,
> -		 struct liveupdate_session_retrieve_fd, token),
> +		 struct liveupdate_session_retrieve_fd, token, LUO_IOCTL_INCOMING),
>  };
>  
> +static bool luo_ioctl_type_valid(struct luo_session *session,
> +				 const struct luo_ioctl_op *op)
> +{
> +	switch (op->type) {
> +	case LUO_IOCTL_INCOMING:
> +		/* Retrieved is only set on incoming sessions */
> +		return session->retrieved;
> +	case LUO_IOCTL_OUTGOING:
> +		return !session->retrieved;
> +	case LUO_IOCTL_ALL:
> +		return true;
> +	}
> +
> +	/* Catch-all. */
> +	return false;
> +}
> +
>  static long luo_session_ioctl(struct file *filep, unsigned int cmd,
>  			      unsigned long arg)
>  {
> @@ -345,6 +371,8 @@ static long luo_session_ioctl(struct file *filep, unsigned int cmd,
>  	op = &luo_session_ioctl_ops[nr - LIVEUPDATE_CMD_SESSION_BASE];
>  	if (op->ioctl_num != cmd)
>  		return -ENOIOCTLCMD;
> +	if (!luo_ioctl_type_valid(session, op))
> +		return -EINVAL;
>  	if (ucmd.user_size < op->min_size)
>  		return -EINVAL;
>  
> 
> base-commit: b1378127003b61930ce30064328640503ad3ef6d
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 

