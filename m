Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB9606A324
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=JFD3kz47;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dU6Qomvo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9QsDcs9BukL2agpXizeKuZOTHpSFdpbs8oTRRuetMCI=; b=JFD3kz47y30ZA//0o1Ob6bxG5M
	FU+2dGk+hxnODtUBdrWIUAAV+YPjawyhw294p8w9FuqK6dMZKC3MeziziA66V3je9lwMuHiE6E4Ht
	jW5Rfy2uqAVFW+bHGWFIImu98tW6/p/0F9HR0axdKiIDBP8l0guRay6E+KJIBbcvqAcK6j+H0pB7A
	mpOCEe5vlqonhK+15KMN+207VZfb1kyyXesKiZET9SfST5EoGPTAxC6kgAkWbye3BWgBWwKX028Yn
	FKIefSH0BvEb4U+eWMaue4eJklmqBBB+qGt6NWHFsryIIOaFT24wnQ2i1epk/PaOVJwW+0Rur/Z6U
	8zlMWFOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIjC-00000008Ffz-3sPr;
	Thu, 12 Nov 2026 00:31:46 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiy-00000008FVt-042n
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C20C440C4C;
	Thu, 12 Nov 2026 00:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF94E1F00A06;
	Thu, 12 Nov 2026 00:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443491;
	bh=9QsDcs9BukL2agpXizeKuZOTHpSFdpbs8oTRRuetMCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dU6QomvoRuz71qdgtA3fqLSG2EJ9ncBowqwUeNlG4AuYl65gUTUTL0RCNX/lmKNYx
	 e4Ltxu4XICbO6T9AZdmlzAPY/jnUoY6PfwjPzEPQ7J1dNrc0MlCuas5dDjRIthP7WP
	 SsNfcpaJ61U+HNO9ZosDiOom6XrL2v7LxgKJ+z0jd3irr2AVwBAxjoDoDMsQDoLbFX
	 2Fc8F+43IMYlXFayO3QTAspotMUYzJDbw1X1Hzu++l9jHye5VJBl4gaDCeBRo++LMR
	 sqWLgOWKkM9nc/BgQi/rCTD/2VJR4bP9uH+wxpgx74rDUIG1Yu3mdJLKjcWSNfYSJj
	 S++NLWFF7lqYg==
Message-ID: <sashiko-outbox-209949@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 17/19] selftests/liveupdate: Test the targets of
 retrieved tmpfs files
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
In-Reply-To: <20261111002358.1842967-18-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-18-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:30 +0000
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
- [Low] selftests/liveupdate: fd leak in start_exe() if second pipe2()
  fails
--

commit 98f191f06f9c7f70ee35d49607af5263f3c0db2b
Author: David Matlack <dmatlack@google.com>

selftests/liveupdate: Test the targets of retrieved tmpfs files

This commit adds test cases to luo_tmpfs verifying the requirements on the
target file into which a preserved tmpfs file is retrieved, including open
modes, file emptiness, filesystem type, immutability, unprivileged access,
and running binaries.

> diff --git a/tools/testing/selftests/liveupdate/luo_tmpfs.c b/tools/testi=
ng/selftests/liveupdate/luo_tmpfs.c
> index 91a607752ee28..2d6dd8f0e138a 100644
> --- a/tools/testing/selftests/liveupdate/luo_tmpfs.c
> +++ b/tools/testing/selftests/liveupdate/luo_tmpfs.c

[ ... ]

> +static int start_exe(const char *path, pid_t *pid)
> +{
> +	char *const argv[] =3D { (char *)path, EXEC_ARG, NULL };
> +	char *const envp[] =3D { NULL };
> +	unsigned char err =3D EIO;
> +	int in[2], out[2], status;
> +
> +	if (pipe2(in, O_CLOEXEC) || pipe2(out, O_CLOEXEC))
> +		return -errno;

[Severity: Low]
Does start_exe() leak in[0] and in[1] if pipe2(in, O_CLOEXEC) succeeds and
pipe2(out, O_CLOEXEC) fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D17

