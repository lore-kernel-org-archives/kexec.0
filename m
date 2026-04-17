Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B246F99C63
	for <kexec@archiver.kernel.org>; Fri, 17 Apr 2026 21:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHdL1Ocg1KAYUcmdB/M7wkvLdiK2qMWc0+wVJsX3Xkk=; b=De8SrAWHq4sW6Nb20Cf1R7aAas
	Pfl+AZ+hinWEouYjQaMk2B+f6a8u7M8ldVfnazdQKuwq6Xpj5BtMGpu/wvFNNnrHaaovuLIEOAnCW
	nQGw5VQQC8QQumowvq3Kvk5rlRTVlOCObZTK4JqiL6WJ7rgtAXgIAhfgTpDokGChmjLA8QTayp9ZB
	aDqzwnAZS2Cia8fqjQ0cpsPYmr6dn8pYDPOooAs/NoMTXqq+2/gzuEzrijcYF9w58/4fBXQBzvGuZ
	M123e2ld9akEOh0ON4sKDzCD68CYgCOFG+MeMiSJ6G9UWxrTLc0yOQBI0LTMm58U5ODniHELTbKHA
	uBwOVzsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDr34-00000004VE5-0KDF;
	Fri, 17 Apr 2026 21:48:26 +0000
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDr31-00000004VDj-1640
	for kexec@lists.infradead.org;
	Fri, 17 Apr 2026 21:48:24 +0000
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-8a5800772f3so8144256d6.2
        for <kexec@lists.infradead.org>; Fri, 17 Apr 2026 14:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776462502; x=1777067302; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nHdL1Ocg1KAYUcmdB/M7wkvLdiK2qMWc0+wVJsX3Xkk=;
        b=gXPXeOKidk3B/4Fa/Rq/UnNvJjaR0igFYlBK3+7esEE64vjy4Vhm6TyD+6kubu04gT
         DkvJjswb9yIWKK6BYBpyCqsLSoNFG67PgbFuUvwu3zg+xKvh0AtUHW4ohPLumfvKeUdK
         pvETpb3jGzegxs4VSCq40GPL0y+RUwSXbb0/B2XcbCi+lwhBIM3f9PBP3pb4ctcn69zK
         vUVFaSNUht1YTz+wB8ayphiULkXzb8lDyLbVWRkz1Dc8IfyURWDO3vFml/854Y1t6UDP
         Crs29WRnq9GN6oO8HeY3U46t4gC8ZKXw1C0k5UCeFITYmN0gIxlAsk8TFegnnDn1tRIU
         0I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462502; x=1777067302;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHdL1Ocg1KAYUcmdB/M7wkvLdiK2qMWc0+wVJsX3Xkk=;
        b=YFzJY2REadKZQYXlc+bPc0P4OdVQQ3LOk7XiLVK0SnOO9OpwIc2aU/qr3w1/TbDAF9
         x38a07fiEFO47hr6lSUXhvYvi/GR6Qbk/rWvIudco+XLJxheAb06y+iZ7yiveXWI2JbK
         cbkbpuIEyUPjtXVBESAdpjPWaguocaTkFNqTcCK8bu4n893l/QoZmYU+Qu3N0utGPiqG
         Jw0i6BUw20alIAHhyTLa3sAbXYrDBhkrEaSQ8ns+biS3b1FWB+Yr8A9jJskyzqMsJYVo
         g0u8lUclghHN8Octy14RWG2uRabnfndDqvP7cSUwZc76HHQY4cruWXyeJ2tSlhagKX4F
         b+ig==
X-Gm-Message-State: AOJu0YyybRCivWzV25aTIKg7e59F70MrhaPsZzwBqS6PQOx8CIV6Ky9z
	FhnPKFnc4XBr+XYLDBrWq9vPIq5cgD1dDY4k31g1I58/Q7UEUMuUR8TcxspB1UWzTZs=
X-Gm-Gg: AeBDiesNEBKN1WmsnPIwm8UkQpXl1aRbspCyy/EYcYNAwjjQYQpzk9iHT0tbR3UvAVy
	H1hs66Mfp4KLo5dZrLYZJUZ3IV/Qr5ivU0olCoh68i2t8opoFE2P6K2aTaVfph5tcy9ropNDckx
	SF40LpBpf/OmkM6/6NSz75XaSWlTBrEKmiTf2b6VGbn3CjnFLU4LQI1mhkRWuF24dVcxmEW1tWU
	uTIiryK04X6zGKRrIla4jgkNZZb3MfXnjUIN1hSGz/o8jrekGslEHWfSMsZM0EwzFJP+KuBjMHy
	vc2xbvZhoy+/g4IX8/vCUnwp3NiSSUekvfxgPajVNh0qOPEkBedxhfkbMQn8g+Pc+dGBdGnxlpk
	BA1YDF82+unLrXjTD8mXjwegxCUWlZphLJhboRuhEhY8Ygz0cTRV3Y5TjwXWG08vj/bZ3HbFIYD
	bZJI/oK0LKrcCkEtZd/yTp3s3jaJqWMvA22BWU6ntwUPF55FOjL2tjs6NGaNbuNR4qgqmbIE8=
X-Received: by 2002:a05:6214:4f18:b0:89c:4812:cc2 with SMTP id 6a1803df08f44-8b028065b51mr63135706d6.15.1776462501707;
        Fri, 17 Apr 2026 14:48:21 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aebc0f8sm19830736d6.47.2026.04.17.14.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:48:21 -0700 (PDT)
Date: Fri, 17 Apr 2026 21:48:19 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org
Subject: Re: [PATCH v2] liveupdate: add LIVEUPDATE_SESSION_GET_NAME ioctl
Message-ID: <huu6stumzw7ziu7i5qsbpo54hmvd4j4g6fge3acrulhwekw7ez@mjjf6psjty2g>
References: <20260417003856.1525287-1-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417003856.1525287-1-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260417_144823_410424_5F87B7F4 
X-CRM114-Status: GOOD (  32.07  )
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

On 04-17 01:36, luca.boccassi@gmail.com wrote:
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
> This was requested by Lennart and Christian when discussing integration
> with systemd for LUO management.
> 
> v2: apply one fix from bot review about cleanup on error path:
>     https://sashiko.dev/#/patchset/20260415184536.1155220-1-luca.boccassi%40gmail.com
>     the other comments are invalid: luo is not a kmod, and the write hooks are not set up

Please split into two patches, and also CC to kernel-linux.
> 
>  include/uapi/linux/liveupdate.h               | 19 +++++
>  kernel/liveupdate/luo_session.c               | 13 ++++
>  .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
>  3 files changed, 103 insertions(+)
> 
> diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> index 30bc66ee9436a..41dc44d239dde 100644
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
> @@ -213,4 +214,22 @@ struct liveupdate_session_finish {
>  #define LIVEUPDATE_SESSION_FINISH					\
>  	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_FINISH)
>  
> +/**
> + * struct liveupdate_session_get_name - ioctl(LIVEUPDATE_SESSION_GET_NAME)
> + * @size:  Input; sizeof(struct liveupdate_session_get_name)
> + * @name:  Output; A null-terminated string with the full session name.
> + *
> + * Retrieves the full name of the session associated with this file descriptor.
> + * This is useful because the kernel may truncate the name shown in /proc.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +struct liveupdate_session_get_name {
> +	__u32		size;
> +	__u8		name[LIVEUPDATE_SESSION_NAME_LENGTH];

Add __u32  reserved;

Thanks,
Pasha


> +};
> +
> +#define LIVEUPDATE_SESSION_GET_NAME					\
> +	_IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_NAME)
> +
>  #endif /* _UAPI_LIVEUPDATE_H */
> diff --git a/kernel/liveupdate/luo_session.c b/kernel/liveupdate/luo_session.c
> index 25ae704d77873..af9e498206d24 100644
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
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index c2878e3d5ef90..bdc1cedc4f944 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -102,6 +102,22 @@ static int create_session(int lu_fd, const char *name)
>  	return args.fd;
>  }
>  
> +/* Helper function to get a session name via ioctl. */
> +static int get_session_name(int session_fd, char *name, size_t name_len)
> +{
> +	struct liveupdate_session_get_name args = {};
> +
> +	args.size = sizeof(args);
> +
> +	if (ioctl(session_fd, LIVEUPDATE_SESSION_GET_NAME, &args))
> +		return -errno;
> +
> +	strncpy(name, (char *)args.name, name_len - 1);
> +	name[name_len - 1] = '\0';
> +
> +	return 0;
> +}
> +
>  /*
>   * Test Case: Create Duplicate Session
>   *
> @@ -345,4 +361,59 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
>  	ASSERT_EQ(close(session_fd), 0);
>  }
>  
> +/*
> + * Test Case: Get Session Name
> + *
> + * Verifies that the full session name can be retrieved from a session file
> + * descriptor via ioctl.
> + */
> +TEST_F(liveupdate_device, get_session_name)
> +{
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> +	const char *session_name = "get-name-test-session";
> +	int session_fd;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, session_name);
> +	ASSERT_GE(session_fd, 0);
> +
> +	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> +	ASSERT_STREQ(name_buf, session_name);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +}
> +
> +/*
> + * Test Case: Get Session Name at Maximum Length
> + *
> + * Verifies that a session name using the full LIVEUPDATE_SESSION_NAME_LENGTH
> + * (minus the null terminator) can be correctly retrieved.
> + */
> +TEST_F(liveupdate_device, get_session_name_max_length)
> +{
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> +	char long_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +	int session_fd;
> +
> +	memset(long_name, 'A', sizeof(long_name) - 1);
> +	long_name[sizeof(long_name) - 1] = '\0';
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, long_name);
> +	ASSERT_GE(session_fd, 0);
> +
> +	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> +	ASSERT_STREQ(name_buf, long_name);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

