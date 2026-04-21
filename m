Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27113F89254
	for <kexec@archiver.kernel.org>; Tue, 21 Apr 2026 10:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1Bc2Fsz7ZQWWEshUgp2lyvHER+93je+FBGx0DEVx90=; b=i8lusQmJvme5ZYofN2qnLtMaA1
	vbkWy6xn2Aq8eHFhJnxNKQlQ2O5E8t2LMVu2Vu99aaaU1aPVaha+yOjJyViJJBv33xdS8e+2SFMLT
	ACAzORWCbAYGQuIlb9CRLToxJK5REamkalGDhZkcrmKULKE4Lt7uByv1amPdjV+gLt2PkMNZmlCDg
	P+t/XkSbGB0LyfbiIy/W9cLaHu6duWGfWHCSlRBQee2B+b0yA4SZG35aF+ZFBIl1VNZznkvHmwJr3
	X0tF2QxbzBCA1WH9uuUs6yLOUyC50Cu0utW1jGnt9GTz3ecPJbbBUZKdgxoOMgfsNimgZSgmRnXze
	NqTXKZbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Rg-00000008S4N-1FzR;
	Tue, 21 Apr 2026 10:35:08 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wF8Re-00000008S3s-0LqN
	for kexec@lists.infradead.org;
	Tue, 21 Apr 2026 10:35:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 896946013B;
	Tue, 21 Apr 2026 10:35:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F2BC2BCB0;
	Tue, 21 Apr 2026 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776767705;
	bh=Otx4/28D/avzJk9j+GmtzEbJr9JeUGnkNqWUvmAkEB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fxFNhT5oIpf/DoArdi5DWsQl/Vw0cITuuGLY+OnDTbqapl+Vvr902bX2oA/Sqved1
	 JheUmnmd3Z/zvhKAPmOxliqyx/4oQTv+Mx+U1LXTbe/e4fB4GISVVU5UJnpqqRVycQ
	 gLpAz9t8O2jMQsYimjLHYAUozjs5iggt3NmSuZOXOhgA3qrxyR1uZ3xOdi2o6H1r1E
	 WviXL2QVS3PvUx139LohMrlhOFBvyK26mOutl65/ME2Mb9ccNedXgXfNNizBLWRf/+
	 +GmYVYlfI6Qf57qGBzB2lFtiE1dZYWNROXKR8RwCZ1DUtAgLUfPQID2yZ3RoF7iSAZ
	 l3M2lsNKCK/9g==
Date: Tue, 21 Apr 2026 13:34:58 +0300
From: Mike Rapoport <rppt@kernel.org>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com,
	pasha.tatashin@soleen.com, pratyush@kernel.org, brauner@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 6/6] selftests/liveupdate: add test cases for
 LIVEUPDATE_SESSION_GET_NAME
Message-ID: <aedS0ioK-ab9UB1O@kernel.org>
References: <20260420141741.2688371-1-luca.boccassi@gmail.com>
 <20260420141741.2688371-7-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420141741.2688371-7-luca.boccassi@gmail.com>
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

On Mon, Apr 20, 2026 at 03:15:14PM +0100, luca.boccassi@gmail.com wrote:
> From: Luca Boccassi <luca.boccassi@gmail.com>
> 
> Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
> as expected via new test cases in the existing liveupdate selftest.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  .../testing/selftests/liveupdate/liveupdate.c | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index 5e99af0cc6e9..c21354dc9b93 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
> @@ -105,6 +105,22 @@ static int create_session(int lu_fd, const char *name)
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
> @@ -427,4 +443,59 @@ TEST_F(liveupdate_device, session_fstat)
>  	ASSERT_EQ(close(session_fd2), 0);
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

-- 
Sincerely yours,
Mike.

