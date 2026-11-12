Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63891606A326
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BCBrjvhK;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpMV8KKy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=1EWFO17EH5oEfTbKye5xe/8R6ziLPWTGMHOqE213Ii8=; b=BCBrjvhKD2nd0uE59a0pc93xeH
	4igP2mmTMzxbm6EQyEeTLw3N0C7akHWNR9pfVMrll3U1nMRlkjRII9CaDNWdFXrUGbWS/acYSyMxL
	0I8IDjXzgJCBtm80Ffy7Vt/X6251MqYXcPPzB9M49n0yTYFqz68i8pzSXsLQS0e8vAx6yTSlDZeHW
	cWAIOGAxX8dlF2G8n/1qKnmfgL4NcKq+XVOYSU6qlr+hU8a19uu4zUgR3+bwlKf//wlN/ki+g+kdN
	G4wiEWJAS3v/f5ohmTSkGEWS/f8UthPCTiOMxoeQ+8sBPkmDMcnuzpvGSFNXuaN9yL6MCRwBJ0CO0
	tDXxVMZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIib-00000008F2G-3hgm;
	Thu, 12 Nov 2026 00:31:10 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIia-00000008F1U-2zH9
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:08 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 790D0411D7;
	Thu, 12 Nov 2026 00:31:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5787E1F00A05;
	Thu, 12 Nov 2026 00:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443468;
	bh=1EWFO17EH5oEfTbKye5xe/8R6ziLPWTGMHOqE213Ii8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KpMV8KKy3ExuPz8BSRcFqJoM649LkHNNm3AjBPoHebwZhovEBnuWJv0kTsTkHLDPt
	 vmteyTfkrXtm7gQtzW0nprpYezjzRXmcoJp/7W+HVxZ0p3qx8N+vvES9mIF+t3kTt9
	 3NgLvzrfJHhu6PASnPCpUeoqW6XIo/2BUgyAllDb0lESL3i98DKBTxFuqQ8AU9FeEG
	 nkHBq+SB26NuHjl+kUi4dWxeSsMrKhagvsoYg7j4fDg7bgSYRriBxUw69krukYGmXb
	 Ho8Sp9u04yjdQrpa5iyFU7b0qpGUA9La0fcCLclGdZ5DF7Jn4udDnbrEsSEowW+DrP
	 5VGLKwjMR9tHQ==
Message-ID: <sashiko-outbox-209935@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/19] selftests/liveupdate: Add tests for preserve
 and retrieve user argument
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-mm@kvack.org
Cc: "Alexander Graf" <graf@amazon.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baolin
 Wang" <baolin.wang@linux.alibaba.com>, "Christian Brauner" <brauner@kernel.org>, "David
 Hildenbrand" <david@kernel.org>, "Hugh Dickins" <hughd@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Michal Hocko" <mhocko@suse.com>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil
 Babka" <vbabka@kernel.org>
In-Reply-To: <20261111002358.1842967-4-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:06 +0000
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/liveupdate: zero min_arg.arg in
  preserve_memfd_with_arg()
--

commit 1a8c90d14c1496a0314a67c567059709fa28b4ba
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

selftests/liveupdate: Add tests for preserve and retrieve user argument

This commit adds libliveupdate helpers for passing a user argument to
LIVEUPDATE_SESSION_PRESERVE_FD and LIVEUPDATE_SESSION_RETRIEVE_FD, along
with a preserve_memfd_with_arg test case covering memfd argument handling.

> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/test=
ing/selftests/liveupdate/liveupdate.c
> index 2dedd5fc2534f..4c4272167635b 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
[ ... ]
> @@ -530,4 +531,47 @@ TEST_F(liveupdate_device, preserve_many_files)
>  	ASSERT_EQ(close(session_fd), 0);
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

[Severity: Low]
Should min_arg.arg be set to a non-zero value before this ioctl() call?
Because min_arg is zero-initialized on the stack, min_arg.arg is already 0
in userspace, so this check would still pass even if the kernel ignored
min_arg.size and read the trailing arg field from userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D3

