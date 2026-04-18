Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D476EF99C8A
	for <kexec@archiver.kernel.org>; Sat, 18 Apr 2026 15:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/XzWNaaP6trt3AVnYC3KX+BGwZlVeHmz05lVckXapB0=; b=2v6a8kdyNNj/TtcivuJIxEE9Kh
	dRb3UtuspqhCE8QIo1GhYHgh3H0KsIPEOMscyOtRO4mn/tHsDjmV+wx3aLJrUPjPF96pOnYTNn3yt
	3bVaX1qXp4u2GxOl/dSwmus1MeB3epKFajvLDHFu1Eh7DAImduvrsdEOGWY6Lah5FjsjqYVpUJ9Dj
	QkuZFAHXwWTwzSywDwNn0d6uyhb0zIcVkHtjzjdln67v08s3fgqywnlI6ZIKgZXuy88LAzUbTALH/
	u9SYmma+1y7Q3CYpimEtjg+ivCJukOhTx7Td7ld56HNmkuKBRbaVRuO1EwWZ5RuCGzUEcD01QyKVK
	852Ptdyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE7wD-000000054SO-2yTF;
	Sat, 18 Apr 2026 15:50:29 +0000
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wE7wB-000000054S0-37dc
	for kexec@lists.infradead.org;
	Sat, 18 Apr 2026 15:50:28 +0000
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-50e42bf7b4cso6735601cf.3
        for <kexec@lists.infradead.org>; Sat, 18 Apr 2026 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1776527426; x=1777132226; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/XzWNaaP6trt3AVnYC3KX+BGwZlVeHmz05lVckXapB0=;
        b=MwadDPQyLG4Vs/zoHYhkUIKOMQS3gMQomnG0T6lCBFxZt/NVchWa1yFUrQbcMcHNdm
         v8L0tZdcnZHLnTLp5S7j8glAlxhRXcJjXaVRqtc4DOhCO1UKJ8+ZVO+K/mdONK46rZfQ
         js4r+iJxkBzcgE0kowVZw5avnNUhNIPbrhFv55vYggDmorV3cXUBu7yANySuALXugVYN
         m6xhfVGSZQv2MnL3WsB6L1uk9BBbBfo6OjkG52YmVGmKZIe6QGfcb66Uw9jLaIJqf+XN
         j/6j01gVlv543LO4RRrzXLYIZXsUF2/TE12ZWrDxqJwoGdqhq3+0Ab+wUbMwvnOE9C2B
         i56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776527426; x=1777132226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/XzWNaaP6trt3AVnYC3KX+BGwZlVeHmz05lVckXapB0=;
        b=jruYpO1dMAjbtAg50v5L0zqKTpJLEt3hzEcW2Q+bNmTauIYxeof5FeNRMRuiLUMM1a
         Yeqtn2h1vkGpxDuJxNJJ1kJ6tMTsguuLReBMC1LfUQn/sLBXkHrm9Q1KWEubBzMrH1zI
         3jhcDazFVN9q6djtQYd76Tc9wHd/eUIubc8sXeQc31qFKjno2hqhHCczsLbmkWw5SNWt
         ac+rn4pYwCFFhJIh9wIBMHgGdXSbdK5O6grqjbWYWkWRbUxke5QPpGCdmpwbAHa3BOlW
         idg/D3vDzM1s18atXRVFHTxjuw20VxU/gs999x4Krmc9BIh1g1FmY8zb7wSbAwz+Tywv
         Yu+g==
X-Gm-Message-State: AOJu0YxODBgG+7e1BImPvJVgqHyi8YTdrsryvxcf9IRQFh66ypDK9Xgj
	cX6aKJe5Hom3+alg0+a6LUep4CWq0nOQPXHxZXm8rRqdHQ0s/JZ9MVMmfpukXUJ+fWY=
X-Gm-Gg: AeBDieshURTd62xPS+ftBo+YVuinlMR6LQ5PVac2Sc5HJv2J8f8v/eN/wm8SsPD+HUt
	RXCQFO29MjZePOBN9VIeLfxLs+qIopM2tSwQlOClrOLC/jkq2P9MtG35Xj2cl/QbAjCSE8qDqDH
	o5ScfC2IsgNS2f163++PC/lztMUP/vQD999O6NSeJ7msWnZHQZMIoXpUouaIeKfcprdG/2WPXDG
	wCyYtdwkSN+mWkh5e1iICRhSNDF7a5oZKYPRXBgGA3H3NjN+T6l8hL4sxhI1KweGVc4F7bGbu+D
	yNW9Q+hT0jQBv4I6MO6oCRVTHHjtqn0Uuy4/jxv/RItbriLvbZyRSg5FA/K9/YNo6YxKyl5KUDb
	7eTcIlqNGVIdPtKz3PJOyDegoOBSI8haOlvsI8c3OG/O9TGPeZpr1JveHgtEevardJ3BfunCcDL
	Pg+cMQnux3pNscrVfrUKqBgl1+W9QQSRMyS/OPGRePXWFNGGysX/2WbmJCkLnk
X-Received: by 2002:ac8:594c:0:b0:50d:8727:b1da with SMTP id d75a77b69052e-50e36c48accmr112628991cf.39.1776527426038;
        Sat, 18 Apr 2026 08:50:26 -0700 (PDT)
Received: from plex ([71.181.43.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e394addfcsm45648821cf.29.2026.04.18.08.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 08:50:25 -0700 (PDT)
Date: Sat, 18 Apr 2026 15:50:22 +0000
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: luca.boccassi@gmail.com
Cc: kexec@lists.infradead.org, linux-mm@kvack.org, graf@amazon.com, 
	rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
	brauner@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] selftests/liveupdate: add test cases for
 LIVEUPDATE_SESSION_GET_NAME
Message-ID: <a4jd64pkvamnwuwzu5k762rgn6sgzp6ldcoknkwhuddsrwcbyv@vxwdpp66x7bl>
References: <20260418141123.2193917-1-luca.boccassi@gmail.com>
 <20260418141123.2193917-4-luca.boccassi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418141123.2193917-4-luca.boccassi@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260418_085027_804323_28FF2CFD 
X-CRM114-Status: GOOD (  25.68  )
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
> Verify that the new LIVEUPDATE_SESSION_GET_NAME ioctl works
> as expected via new test cases in the existing liveupdate selftest.
> 
> Signed-off-by: Luca Boccassi <luca.boccassi@gmail.com>
> ---
> v5: merge with LUO_SESSION_MAGIC series as they both change the same
>     unit test file, to avoid merge conflicts
>     split into separate patch
> v6: add more test cases as suggested
>     more verbose commit message
> 
>  .../testing/selftests/liveupdate/liveupdate.c | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
> 
> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/testing/selftests/liveupdate/liveupdate.c
> index d132b4685f76..ffbcbd465c9b 100644
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
> @@ -385,4 +401,126 @@ TEST_F(liveupdate_device, session_fstat)
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
> +/*
> + * Test Case: Create Session with No Null Termination
> + *
> + * Verifies that filling the entire 64-byte name field with non-null characters
> + * (no '\0' terminator) is handled safely by the kernel. The kernel's strscpy
> + * truncates to 63 characters, which we verify via get_session_name.

[...]

> + */
> +TEST_F(liveupdate_device, create_session_no_null_termination)
> +{
> +	struct liveupdate_ioctl_create_session args = {};
> +	char expected_name[LIVEUPDATE_SESSION_NAME_LENGTH];
> +	char name_buf[LIVEUPDATE_SESSION_NAME_LENGTH] = {};
> +	int session_fd;
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
> +	ASSERT_EQ(ioctl(self->fd1, LIVEUPDATE_IOCTL_CREATE_SESSION, &args), 0);
> +	session_fd = args.fd;
> +	ASSERT_GE(session_fd, 0);
> +
> +	/* Kernel should have truncated to 63 chars + '\0' */
> +	memset(expected_name, 'X', sizeof(expected_name) - 1);
> +	expected_name[sizeof(expected_name) - 1] = '\0';
> +
> +	ASSERT_EQ(get_session_name(session_fd, name_buf, sizeof(name_buf)), 0);
> +	ASSERT_STREQ(name_buf, expected_name);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +}
> +
> +/*
> + * Test Case: Create Session with Empty Name
> + *
> + * Verifies that creating a session with an empty string name succeeds,
> + * and that creating a second session with the same empty name fails
> + * with EEXIST.
> + */

For the two cases mentioned above, we should implement a fix in the 
kernel:

In luo_session_create(), we should verify that the name is at least 1 
character long and at most LIVEUPDATE_SESSION_NAME_LENGTH - 1.

size_t len = strnlen(name, LIVEUPDATE_SESSION_NAME_LENGTH);

if (!len || len > LIVEUPDATE_SESSION_NAME_LENGTH - 1)
   return -EINVAL;

This change should be submitted as a separate patch in your series.

Additionally, please include a cover letter in the next version 
explaining the overall series. Once the cover letter is included, you 
can remove the individual patch versions from the stat areas.

Pasha

