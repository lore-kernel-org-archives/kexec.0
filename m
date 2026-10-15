Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FACCCC6B3A
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JHpOQUwcshXHQzYFZ3aS1sTp+0yRpUSjY6QCjCddSm4=; b=uMw3rjQPMnyjLhFo/nmwiugZi2
	IRLwuInbvaYsHpHJK0jsJlZ558thp6+fTfCmzhlF6HIwz1GtxwcTo5/xcf1yi68of2a/4KqB4XPLf
	+DIn72HuG5wLHxFijhk332WI6aqQcyZWSz5gM6Pm7pb3zH/dqNCRfPh5dg6wEYGUh18XohR0ndQXL
	z/H7nzzuoEbzOeK13vcyvpHAofIwn2D0e4UXoYBql/V60DZE/W2Fa5QVfRwqsaECxEs+MLATTYEf1
	PHwtIWr6yyUTGr3fWUqrxqRhZF6pQWGgCe3LbOvCaretUWf5Nc+oyJuG6boC/8BIgn0JlUzCI5rpv
	0yCY/cWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI1Z-0000000HJ5P-08Uz;
	Thu, 15 Oct 2026 09:45:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI1W-0000000HJ4k-0e7O
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:45:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B300A42B7D;
	Thu, 15 Oct 2026 09:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC821F000C4;
	Thu, 15 Oct 2026 09:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057515;
	bh=JHpOQUwcshXHQzYFZ3aS1sTp+0yRpUSjY6QCjCddSm4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EMySdnX1GzekOA+bd2GpLzsQHV29fr9vGRxTZ8ewy6JCcJGE67jAL0Am4LH+HYAVu
	 Vl8QqhyCdqI3G/RLs4eO7ZaLLahN8pPNFRDfv1SE7Nmndde6g58OWZPQY3rd5r1Fei
	 29L/MaEioAvJFTU5Wilcy3lp3mB7N5czyJEb6qLUdr+DOicIvvXYf97RuReFGmN6AZ
	 Mq6U+YV68T8LismovTCFpAJGLYTSLnIBv4Q+uI3vRRXZ0Vnt18fmfpnhiYXJX6kGSd
	 YPRzxFwkgY/h5UH4WIDGR+CP7tlm29B7DKda2GNehFiUeHXWQHA6uL+v2Dzbd9L9tx
	 rr1I08RSIa4Mw==
Message-ID: <sashiko-outbox-172591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/7] selftests: liveupdate: Add tests for preserve
 and retrieve user argument
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-5-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:45:14 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: missing retrieve user arg test case
--

commit 420b1c3465899a231e547b85211758efc34277b8
Author: Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Thu Oct 15 09:38:13 2026 +0000

selftests: liveupdate: Add tests for preserve and retrieve user argument

This commit adds luo_session_preserve_fd_arg() and=20
luo_session_retrieve_fd_arg() helpers to libliveupdate to pass handler-spec=
ific=20
arguments. It also introduces a preserve_memfd_with_arg test case to verify=
=20
memfd preservation behavior with different user arguments.

> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/test=
ing/selftests/liveupdate/liveupdate.c
> index 9de068f31c3ec..83e0978f3818d 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c

[ ... ]

> @@ -570,4 +571,47 @@ TEST_F(liveupdate_device, session_freeze)
>  	ASSERT_EQ(close(mem_fd2), 0);
>  }
> =20
> +/*
> + * Test Case: Preserve MemFD with User Argument
> + *
> + * Verifies that passing a non-zero user argument to memfd preservation =
fails
> + * with -EOPNOTSUPP, while passing a zero argument or using the minimum =
struct
> + * size without the arg field succeeds.
> + */
> +TEST_F(liveupdate_device, preserve_memfd_with_arg)
> +{
> +	struct liveupdate_session_preserve_fd min_arg =3D {};
> +	int session_fd, mem_fd1, mem_fd2;
> +
> +	self->fd1 =3D open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->fd1 < 0 && errno =3D=3D ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->fd1, 0);
> +
> +	session_fd =3D luo_create_session(self->fd1, "preserve-arg-test");
> +	ASSERT_GE(session_fd, 0);
> +
> +	mem_fd1 =3D memfd_create("arg-memfd-1", 0);
> +	ASSERT_GE(mem_fd1, 0);
> +
> +	/* Non-zero arg is not supported by memfd handler */
> +	EXPECT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd1, 0x1111, 1),
> +		  -EOPNOTSUPP);
> +
> +	/* Legacy struct size (up to token) should zero-fill arg and succeed */
> +	min_arg.size =3D offsetof(struct liveupdate_session_preserve_fd, arg);
> +	min_arg.fd =3D mem_fd1;
> +	min_arg.token =3D 0x1111;
> +	ASSERT_EQ(ioctl(session_fd, LIVEUPDATE_SESSION_PRESERVE_FD, &min_arg), =
0);
> +
> +	/* Explicit zero arg with full struct size should also succeed */
> +	mem_fd2 =3D memfd_create("arg-memfd-2", 0);
> +	ASSERT_GE(mem_fd2, 0);
> +	ASSERT_EQ(luo_session_preserve_fd_arg(session_fd, mem_fd2, 0x2222, 0), =
0);
> +
> +	ASSERT_EQ(close(session_fd), 0);
> +	ASSERT_EQ(close(mem_fd1), 0);
> +	ASSERT_EQ(close(mem_fd2), 0);
> +}

[Severity: Medium]
The commit title and message explicitly claim to add tests for both preserve
and retrieve user argument, stating it verifies support in both
LIVEUPDATE_SESSION_PRESERVE_FD and LIVEUPDATE_SESSION_RETRIEVE_FD.

However, only the preserve_memfd_with_arg test case is implemented. No
corresponding test for the retrieve path is provided here.

Was the retrieve test case accidentally omitted from this patch?

> +
>  TEST_HARNESS_MAIN

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D4

