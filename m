Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DDF606A31C
	for <kexec@archiver.kernel.org>; Thu, 12 Nov 2026 00:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DfJ5vWoh;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwSxaQ/o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FurFPSzwc0egprFnhFtYfPmavub2m/6Uyid/nz3wO00=; b=DfJ5vWohLPWjV3s0kQbJngL4ny
	6xLdhwq73UYeT3am2eLDhW1t0Q8CQfQnnYkC6BH/4DJ/ASI7udYZNRf81WIZYVWTrziqYTkeE1YGr
	ohJEpHWlpk39stMVOTUqubfZykCRUurtmi4MM37FyFFoGWtQQ0Ag1wpF+TFAyredEpEDyeVjknKpj
	qlaGFFZhyVQbcjOC4EaJL0gBVv3vUWvT/bW3PLU7WlY6P0feesMRsNFVKlo2nQnnmH0RRzIJFZDHd
	RKJaa2DXdQbYAByz7RrjyaP/UZ2qMBqg/vfH5wtLB0yZ/uygMj41CyclfQtDCmQ7sKUBAmz8e+/V6
	mmLHp0Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIix-00000008FVa-3IgY;
	Thu, 12 Nov 2026 00:31:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRIiu-00000008FSC-44P2
	for kexec@lists.infradead.org;
	Thu, 12 Nov 2026 00:31:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B075F41AB0;
	Thu, 12 Nov 2026 00:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9390D1F00A05;
	Thu, 12 Nov 2026 00:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794443488;
	bh=FurFPSzwc0egprFnhFtYfPmavub2m/6Uyid/nz3wO00=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NwSxaQ/oJ9DbDzdZV+/IcVPuula2/1J+b2taj5ynnpwvfJsu4dz8WeeOGJLlbLimh
	 Yl7YESJ+FEfYgWxfbBShQvzu6lCGeSTZbu3tbOwnsCZ1baH2f4/FK0nXVdvkFiKkJ4
	 DP4UzXACxa+j7GyOtPtqrmk7DKVKC8CzPmpEaQRxJQdCFIEnzyDPmp9hD1pKyEmkfv
	 7pYrSgAIoARu4C62yYocoFEioUb8Bk+wO0nKFIY16GVyoylcT1cHZqcjmelyMm0dRC
	 OQAnMfIEqKAXzHsmyRkPBqLBR/TgRLKWYU3HGKsqk4wD9OZeomZnSRLE/RSqHmkpc5
	 Txwf4v224PGfg==
Message-ID: <sashiko-outbox-209947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/19] selftests/liveupdate: Add a test for
 retrieving tmpfs files
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
In-Reply-To: <20261111002358.1842967-16-dmatlack@google.com>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-16-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:31:27 +0000
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
- [Low] selftests/liveupdate: do_fcntl() breaks build on 32-bit generic
  unistd archs
--

commit 0645310fa3a030d5078797e4ea9657a80cb11ec5
Author: David Matlack <dmatlack@google.com>

selftests/liveupdate: Add a test for retrieving tmpfs files

This commit adds luo_tmpfs, a kexec test for preserving tmpfs files and
retrieving them into a file on a tmpfs mount.

> diff --git a/tools/testing/selftests/liveupdate/luo_tmpfs.c b/tools/testi=
ng/selftests/liveupdate/luo_tmpfs.c
> new file mode 100644
> index 0000000000000..4e6e035e84339
> --- /dev/null
> +++ b/tools/testing/selftests/liveupdate/luo_tmpfs.c
> @@ -0,0 +1,728 @@

[ ... ]

> +/* nolibc doesn't have these, so use syscall() where needed. */
> +static int do_fcntl(int fd, int cmd, long arg)
> +{
> +	return syscall(__NR_fcntl, fd, cmd, arg);
> +}
> +
> +static int do_mount(const char *source, const char *target, const char *=
type,
> +		    unsigned long flags, const char *data)
> +{
> +	return syscall(__NR_mount, source, target, type, flags, data);
> +}
> +
> +static int do_statfs(const char *path, struct statfs *buf)
> +{
> +#ifdef NOLIBC
> +	return syscall(__NR_statfs, path, buf);
> +#else
> +	return statfs(path, buf);
> +#endif
> +}

[Severity: Low]
Does calling syscall(__NR_fcntl, ...) unconditionally in do_fcntl() break
kselftest builds on 32-bit architectures that use
include/uapi/asm-generic/unistd.h (such as 32-bit RISC-V)?

Those architectures only define __NR_fcntl64 and __NR_statfs64, not
__NR_fcntl or __NR_statfs.  Should do_fcntl() guard the raw syscall with
#ifdef NOLIBC and call libc fcntl() otherwise, matching do_statfs() right
below it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111002358.1842=
967-1-dmatlack@google.com?part=3D15

