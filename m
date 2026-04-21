Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52E2F8924C
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JEnbnARUnGYOzvOOAfD7bDEij7ZoYspS5aLmbpnF/ZE=; b=CPmb9BweSys1wIKT89FeJyOaTT
	ZWrmAdKDZiibXrfSsi75PMbVB3okGW0IP+thzc7gkjL/6ib6tsllG6DkM4iKawK0bH2o3Apa9mezS
	Xhb/M0ohKaw3QVOMF8UB4ZnV8NA1UVCK98HjYMEh6z2BSSERzYYpU5pELEYdK7YC2qD2AbkIS31Bb
	+SYJGFj3FYp92btHZPEAGdQXv1YfXIt/SUYF/mrPV3eqTPhlIfV3fObRMnyomOy8G/v0DICT105Im
	U4JsKoQbMeTv5fuA6rChPdDbnQRcpvV4xRBHEaXQry1voDjsuDYXanfN9drrkTolUhK49AgQMQdhZ
	8Bhb+Mcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Ip-00000008Q83-3Ura;
	Tue, 21 Apr 2026 10:25:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8In-00000008Q7d-1CEC
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:25:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E7701403D3;
	Tue, 21 Apr 2026 10:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D91BC2BCB0;
	Tue, 21 Apr 2026 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767156;
	bh=4loqqwmVByZydFOLKx4Df/CNcWTPfKogyfRe2H/uC1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3h4oYPqihpDwu5jSY38mVpZvUnUftD4h+6bma3bEJMXePM1uyAyqvqpKcJrwoX44
	 KFvKUNwjb6SdyFGKEnZVVEQeGNKrAicp+kuBGrEk50YddCWx0cx1Ikf0+EldqBmVq2
	 y4DfQf3+KDm0FgFPMk9pXTsiublJYe4zkXGKBuybI9Z1zprMIyWL2DRXsSJXjztf65
	 +JJTUzxIrKJ9ZtkqOkBAP8rQEU5aNZijRMUEg4CkYuyDYdXTXnNySYoOTjPIiFnxAq
	 hmLPaS3U/0RNf+6kxU+Dr1CBJi2hjiHDfRjEKSFa03BAxuMGnWNGMxbq1UlamIGsgc
	 36Wgw6s5N+4tw==
Date: Tue, 21 Apr 2026 13:25:50 +0300
From: Mike Rapoport <rppt@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/6] selftests/liveupdate: add test cases for
 LIVEUPDATE_IOCTL_CREATE_SESSION calls with invalid length
Message-ID: <aedQrhEYmgsSvNuB@kernel.org>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-3-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-3-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260421_032557_497122_FE2387C2 
X-CRM114-Status: GOOD (  17.51  )
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

On Mon, Apr 20, 2026 at 03:15:10PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that LIVEUPDATE_IOCTL_CREATE_SESSION ioctl which provide a name
> that is an empty string or too long are not allowed.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index c2878e3d5ef9..f0a8e600c154 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -345,4 +345,46 @@ TEST_F(liveupdate_device, preserve_unsupported_fd)
>  	ASSERT_EQ(close(session_fd), 0);
>  }
>  
> +/*
> + * Test Case: Create Session with No Null Termination
> + *
> + * Verifies that filling the entire 64-byte name field with non-null characters
> + * (no '\0' terminator) is rejected by the kernel with EINVAL.
> + */
> +TEST_F(liveupdate_device, create_session_no_null_termination)
> +{
> +	struct liveupdate_ioctl_create_session args = {};
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	/* Fill entire name field with 'X', no null terminator */
> +	args.size = sizeof(args);
> +	memset(args.name, 'X', sizeof(args.name));
> +
> +	EXPECT_LT(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
> +	EXPECT_EQ(errno, EINVAL);
> +}
> +
> +/*
> + * Test Case: Create Session with Empty Name
> + *
> + * Verifies that creating a session with an empty string name fails
> + * with EINVAL.
> + */
> +TEST_F(liveupdate_device, create_session_empty_name)
> +{
> +	int session_fd;
> +
> +	self->fd1 = open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno == ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd = create_session(self->fd1, "");
> +	EXPECT_EQ(session_fd, -EINVAL);
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

