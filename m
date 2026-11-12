Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E7F606A321
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=iwrfUfkV;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrWiPdJh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9S+6EWuhGnazR//mbqE63p2Ta/W9cmMlZEk741JVhmw=; b=iwrfUfkVumpRQv/hIPNWfY2tGs
	a12woOM6jVc/iGJSJhpa+lfda5v7aht/8UhD11/Q3YcUmmtR+4nv7YEGvAUAjm9MRiImapy5DnUKK
	vk2r7A3KWo5/rv4DIiEnwtDKzChDR4k2+JIZqBgc4lnLaokGtVqdHD2r3DRs8YMHECTKqq8oRYit6
	qNI62nKmOMqo5dSE4yfIaoIiR7r4bZXeEtV3MrzjShv92I/pP1zM8Lb9pHPyWDw3WJsfaMF47n8x+
	ohyCPhv+1Qs4eDiIq9XJgNDQOmGrQS6vOH+uu4zQz4QpsDghHZrwaFa6FJrA+UKLCNfKflRX2a2lM
	VGS+LPpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIix-00000008FV2-2cmV;
	Thu, 12 Nov 2026 00:31:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiu-00000008FQV-05xn
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 636D160052;
	Thu, 12 Nov 2026 00:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743251F00A06;
	Thu, 12 Nov 2026 00:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443487;
	bh=9S+6EWuhGnazR//mbqE63p2Ta/W9cmMlZEk741JVhmw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrWiPdJhaqCza1/1sKjJRctS+Tx+RhPrix0WaN4ThJJcTOzoUJZSgZX/nmuNOiPl1
	 Rm+YK4M01c7VW9nPXRbkuyJpLPf/fjUiMSQGvvEyBacPpZPvAHxDlR/4TDcd0UYp0n
	 MN5p5MRBcWsheu4s7K25e1ysEAJGbBoV9nf28d13GRGrKwq9drszEJcbe2aGo/L/OE
	 2IYAQQLuhQTFVnH92SJAOGmWJwd6fT9AEXIO9fa+hopZjGq3Idw/mzk6uXKawKOLUr
	 UgbOXn1GWghuYdLYjVYcLrhkAN2jCXtMBKvMPh8fx8opFoNTAXPDGCu57CCEB5uh6N
	 96vfOyPb1GIHA==
Message-ID: <sashiko-outbox-209946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/19] selftests/liveupdate: Test which tmpfs files
 can be preserved
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
In-Reply-To: <20261111002358.1842967-15-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-15-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:23 +0000
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
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] selftests/liveupdate: leak of mkdtemp() directory in
  preserve_tmpfs_setup()
--

commit a1db86a2ad704903057c01aec8aee9743875c417
Author: David Matlack <dmatlack@google.com>

selftests/liveupdate: Test which tmpfs files can be preserved

This commit adds selftests verifying which tmpfs files can be preserved by
liveupdate and checking that a preserved file's size remains frozen until it
is unpreserved.

> diff --git a/tools/testing/selftests/liveupdate/liveupdate.c b/tools/test=
ing/selftests/liveupdate/liveupdate.c
> index 4c4272167635b..3d943b5672e6b 100644
> --- a/tools/testing/selftests/liveupdate/liveupdate.c
> +++ b/tools/testing/selftests/liveupdate/liveupdate.c
[ ... ]
> @@ -574,4 +583,298 @@ TEST_F(liveupdate_device, preserve_memfd_with_arg)
>  	ASSERT_EQ(close(mem_fd2), 0);
>  }
> =20
> +#define NOBODY 65534
> +
> +FIXTURE(preserve_tmpfs) {
> +	char dir[32];
> +	int luo_fd;
> +	int session_fd;
> +	bool mounted;
> +};
> +
> +FIXTURE_SETUP(preserve_tmpfs)
> +{
> +	self->luo_fd =3D -1;
> +	self->session_fd =3D -1;
> +	self->mounted =3D false;
> +
> +	self->luo_fd =3D open(LIVEUPDATE_DEV, O_RDWR);
> +	if (self->luo_fd < 0 && errno =3D=3D ENOENT)
> +		SKIP(return, "%s does not exist", LIVEUPDATE_DEV);
> +	ASSERT_GE(self->luo_fd, 0);
> +
> +	self->session_fd =3D luo_create_session(self->luo_fd, "preserve-tmpfs");
> +	ASSERT_GE(self->session_fd, 0);
> +
> +	strcpy(self->dir, "/tmp/luo-tmpfs-XXXXXX");
> +	ASSERT_NE(mkdtemp(self->dir), NULL);
> +	if (mount("tmpfs", self->dir, "tmpfs", 0, "size=3D1M"))
> +		SKIP(return, "Failed to mount tmpfs: %s", strerror(errno));
> +	self->mounted =3D true;
> +	ASSERT_EQ(chdir(self->dir), 0);
> +}
> +
> +FIXTURE_TEARDOWN(preserve_tmpfs)
> +{
> +	if (self->session_fd >=3D 0)
> +		close(self->session_fd);
> +	if (self->luo_fd >=3D 0)
> +		close(self->luo_fd);
> +	if (chdir("/"))
> +		return;
> +	if (self->mounted)
> +		umount2(self->dir, MNT_DETACH);
> +	rmdir(self->dir);
> +}

[Severity: Low]
Does FIXTURE_SETUP(preserve_tmpfs) leak the self->dir directory in /tmp when
mount() fails?

When FIXTURE_SETUP() exits via SKIP(), kselftest_harness terminates the test
child before clearing *_metadata->no_teardown, so FIXTURE_TEARDOWN() does n=
ot
run:

tools/testing/selftests/kselftest_harness.h:__TEST_F_IMPL() {
    ...
			fixture_name##_setup(_metadata, self, variant->data); \
			/* Let setup failure terminate early. */ \
			if (_metadata->exit_code) \
				_exit(0); \
			*_metadata->no_teardown =3D false;
    ...
}

Calling rmdir(self->dir) before SKIP() when mount() fails avoids leaving the
temporary directories behind in /tmp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D14

