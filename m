Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BF9606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 01:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nTlvUjrW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUpFOJ4e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=se8T7YveofbWh8YkjlpsY7Miv4OL+LoXEnC8W24eXlw=; b=nTlvUjrWpkplKS320bH+jsg6wv
	bRp6dSu88Q2Y2cnWDYTKsl6kF5HEVetgHuq9nHIteQp2QBYdIB8qPvgz2vSGIzItam+ATiPGvUZcf
	v4LI/6Zud70iHa6c3fThNlL5UhrrDpiHRrDn7PTcl+UgvmC/w+p25WYM48U9z6V5cm9/S5l8SDQoN
	ZOn0Q4Oii6c90j3le0GQDluJ8uRjwYFXGUh5UpYT0T1IPGkuyMowtUmalVVkUR2Hb9jshDDW9c2Hs
	830KiZQimrDQHSAfQywEqL1DtNMzy69vNMmHB8vGlcgZkuZEyDBrW/LeRPP+zoKBH0fJ3gWMtM6aS
	wtXHdyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPS-000000042JF-2E8n;
	Wed, 04 Nov 2026 01:03:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOPPR-000000042It-1ph8
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 01:03:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DC59060D82;
	Wed,  4 Nov 2026 01:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00C41F000C1;
	Wed,  4 Nov 2026 01:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793754204;
	bh=se8T7YveofbWh8YkjlpsY7Miv4OL+LoXEnC8W24eXlw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LUpFOJ4emoT0ugAgjuLIAruMWlysV/hjODIua2aAw3UkUTCSEgQARjRkSs39Tbw6f
	 nrLGWrRejD2l7AUAaQveaz2azAo0yCIcFx4kZFaeEgR4+pnChg5uTggnApS/I3nEhc
	 8Xvtrb6TGqyyjm+3Tilf0BEX1g47h2Hq1J4PbaQb4U0Y7YsHuZei5CA9CPaNa8jtRa
	 GyTAxcGQFa5YoWbermHnSoxl+3LdpA7sNFYhAeP4PgtWOhZFgisSVtLJOER4khVK9g
	 moQp4Ifkz0FHYBm96xs1+HFKHuWOxJluK4AP1d63WbXgGVFEKK1HV3P42Y6xrK8/pC
	 GqskQ2EfsFyEA==
Message-ID: <sashiko-outbox-196333@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] selftests: liveupdate: Add tests for preserve
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
In-Reply-To: <20261103010216.3447716-3-dmatlack@google.com>
References: <20261103010216.3447716-1-dmatlack@google.com>
 <20261103010216.3447716-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 01:03:23 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] selftests/liveupdate: zero min_arg.arg in preserve_memfd_with_arg()
--

commit 0eae9757b9fca17ee60f5d085e6dce0d9304a977
Author: Pasha Tatashin <pasha.tatashin@soleen.com>

selftests: liveupdate: Add tests for preserve and retrieve user argument

This commit adds libliveupdate helpers for passing user arguments to
LIVEUPDATE_SESSION_PRESERVE_FD and LIVEUPDATE_SESSION_RETRIEVE_FD, and adds
the preserve_memfd_with_arg test case to verify memfd argument validation a=
nd
legacy struct size handling.

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
In preserve_memfd_with_arg, min_arg is zero-initialized at declaration:

	struct liveupdate_session_preserve_fd min_arg =3D {};

Because min_arg.arg is already 0 in userspace memory when ioctl() is called
with LIVEUPDATE_SESSION_PRESERVE_FD, the call would still see min_arg.arg =
=3D=3D 0
even if the kernel read the entire struct from userspace instead of truncat=
ing
at min_arg.size and zero-filling the trailing arg field.

Should min_arg.arg be set to a non-zero value before the ioctl() call so th=
at
this subtest verifies the kernel ignores bytes beyond min_arg.size and
zero-fills arg?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103010216.3447=
716-1-dmatlack@google.com?part=3D2

