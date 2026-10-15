Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECA2CC6B33
	for <kexec@archiver.kernel.org>; Thu, 15 Oct 2026 09:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:To:Subject:From
	:Message-ID:Cc:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47NskKdauNoquauqxDOjGcWM104N9Vqi+OvXXK30120=; b=zJvrD4xjQ05dYenAGqicaaAoZU
	tX5qUHfiAZrhXldm+DS2WvIE4oXyFVKLSHDZH62fft06zCSBop2QsuYb8Qk2oo6TYrOuOjJ6hxsdb
	D/2joq/8pCaX5fO0DE8/hnoXZTlefvpZ4ZrkK7+2aiZjwPMd0PxvqnX9U6SmLVeKkaNKgctAWfxqJ
	GjQhGHDzy9StOf++2e3Tgf/rT0hOELBqQv7AHpl7jlMKlufzr2sMdCcSdOnwqNrh5Qzo+HChCs1k/
	ow99r9aNyismUBwKMSc+m7iun43qhw4ol98Qd0VLR9Ig3xtUbJVbJTGu4T/kb39xjSSexbq3iDWzL
	wpSweNlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI3K-0000000HKAS-3lUU;
	Thu, 15 Oct 2026 09:47:10 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHI3K-0000000HK9r-0cVa
	for kexec@lists.infradead.org;
	Thu, 15 Oct 2026 09:47:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E20EE42AAC;
	Thu, 15 Oct 2026 09:47:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3611F000C4;
	Thu, 15 Oct 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057629;
	bh=47NskKdauNoquauqxDOjGcWM104N9Vqi+OvXXK30120=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=IlaFUYYnLU7R84ZRpG4BkcInAI4Yn2JsMIF5Izkacr4jk8Kd4+zv/z2Gs6y20FKCw
	 K4BFKjpd0TCJgmkZSCWguOl7nQf6KVpLdYix5h2IsdsafUfZ/lvBmtghPL6PXb0xWB
	 HsQzG4Wg4p+IccUdI8KJkD/E7zJXyZsdJZdXc4K3P1Cxj7GwwTXQXjolBiebL8M7lF
	 zlB9y4COrbe39vvS6zhqRirn0NycIgWpmjPTH1a55PMYgv9pz1d0618eYv1iOH72W6
	 Ix5JZ+5KvADjzWBTjSi3HKzMH7hMjwD5ize6yHId9naEn5tbDhGvDUBiEzT3bzGbx1
	 sXV/Gr7/Z8tww==
Message-ID: <sashiko-outbox-172595@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/7] selftests: liveupdate: Add test coverage for
 tmpfs preservation and retrieval
To: "Pasha Tatashin" <pasha.tatashin@soleen.com>, rppt@kernel.org, shuah@kernel.org, akpm@linux-foundation.org, vipinsh@google.com, dmatlack@google.com, kexec@lists.infradead.org, pratyush@kernel.org, graf@amazon.com
In-Reply-To: <20261015093816.2438942-8-pasha.tatashin@soleen.com>
References: <20261015093816.2438942-1-pasha.tatashin@soleen.com>
 <20261015093816.2438942-8-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 09:47:08 +0000
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
- [Low] selftests: out-of-bounds read in ksft_print_msg format string
--

commit 6c97b421e43a12b89a960f6a03326dbad1153339
Author: David Matlack <dmatlack@google.com>

selftests: liveupdate: Add test coverage for tmpfs preservation and retriev=
al

This extends the multi-session live update test to verify preserving a
path-backed tmpfs file and retrieving its contents post-kexec. It also
verifies that retrieve argument validation errors are retryable and allow
a subsequent valid retrieve call to succeed.

> diff --git a/tools/testing/selftests/liveupdate/lib/lu_utils.c b/tools/te=
sting/selftests/liveupdate/lib/lu_utils.c
> index 5c6f8bf80b297..1b1a556287d3a 100644
> --- a/tools/testing/selftests/liveupdate/lib/lu_utils.c
> +++ b/tools/testing/selftests/liveupdate/lib/lu_utils.c

[ ... ]

> +int restore_and_verify_tmpfs(int session_fd, int token, int fd,
> +			     const char *expected_data)
> +{

[ ... ]

> +	map =3D mmap(NULL, page_size, PROT_READ, MAP_SHARED, fd, 0);
> +	if (map =3D=3D MAP_FAILED)
> +		return -errno;
> +
> +	if (expected_data && strcmp(expected_data, map) !=3D 0) {
> +		ksft_print_msg("Data mismatch! Expected '%s', Got '%s'\n",
> +			       expected_data, (char *)map);

[Severity: Low]
Does this risk an out-of-bounds read when reporting a data mismatch?

The memory mapped at map is strictly bounded by page_size and not guaranteed
to be null-terminated. If the restored file contents lack a null terminator
due to corruption or a failed restore, the %s format specifier could read
past the page boundary and cause a crash.

Could this be printed with a length limit to ensure it safely prints only
what is mapped?

> +		munmap(map, page_size);
> +		return -EINVAL;
> +	}
> +
> +	munmap(map, page_size);
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015093816.2438=
942-1-pasha.tatashin@soleen.com?part=3D7

