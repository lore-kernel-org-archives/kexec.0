Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F6606A33E
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 14:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mML4x7rs;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gt+MBOJ9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rhOyoytlnDVzUE3pO2YswTduW+qVAkiRX4Xy+qDagYo=; b=mML4x7rsGrBrwbal+beglQZsd+
	Ec2UlI/pcN/I08Yu03BUAAcDgB698NhWPE43lQHHKPtsfyzQrTKT8/xlsl+6ECznJieUP7Dzx5tHl
	b5n7aYfxdlxqjGGf8Wd9GBJuWeI/aPrB2bTqyjo+jhpRkLuTsyUOb0MExCjr2UhQx46+YOdCfEuVF
	ABzu38pi1CbULhNaylLH5SlLrtn2bukL7/cYkiRjcUCw+qqjtb+0f66kPGDZH/63mB5U4bEd7/fqS
	0QwCPccPwTFCRClrzZxisr0dffLYacyAHxIZP9rWbQn7oZlKri5slufcX23MVJsIhmIwV8xAYwWMe
	Cn2a14aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPcG-0000000FFhi-03xQ;
	Fri, 20 Nov 2026 14:29:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUPcE-0000000FFhA-3mfZ
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 14:29:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 429386159A;
	Fri, 20 Nov 2026 14:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EB61F000C0;
	Fri, 20 Nov 2026 14:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184965;
	bh=rhOyoytlnDVzUE3pO2YswTduW+qVAkiRX4Xy+qDagYo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Gt+MBOJ99ecdCoik/DrDTQPtJz5L/ZTUyz/EegTnM9kepvs1tpxlCXOv1QgdhAHCu
	 Rmea41jfXufLIE9H7uiBcy5CTMLzjfkcfLsQwgixDcr/U+q3RoZbmZZMqNU1OAuVv/
	 aJL0k0omtXBWH1QfEfPodlrJd6YnP4ktpCjHBX2T/Fj/2sJEv9VCS9VsIA1i/Liuxu
	 mjSFcrKqc8hvKpD9cZWD9ytUtBRRiNqbPEoe3oRte2J3A84utdWKl3hIvZBKhIlmeu
	 KXKHkErlt1fr1FyS1G4E4e0/dmYnunLescQcyb+4VQwLXaMDFM8m3apbWo/ePA8e0j
	 9v3XLNMi3UdSw==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org,  linux-doc@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-mm@kvack.org,  Alexander Graf <graf@amazon.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Baolin Wang <baolin.wang@linux.alibaba.com>,
  Christian Brauner <brauner@kernel.org>,  David Hildenbrand
 <david@kernel.org>,  Hugh Dickins <hughd@google.com>,  Jonathan Corbet
 <corbet@lwn.net>,  "Liam R. Howlett" <liam@infradead.org>,  Lorenzo
 Stoakes <ljs@kernel.org>,  Michal Hocko <mhocko@suse.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 14/19] selftests/liveupdate: Test which tmpfs files
 can be preserved
In-Reply-To: <20261111002358.1842967-15-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:52 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-15-dmatlack@google.com>
Date: Fri, 20 Nov 2026 14:29:19 +0000
Message-ID: <2vxzh5hb1sqo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11 2026, David Matlack wrote:

> Add tests to liveupdate.c for the checks done when preserving a tmpfs
> file: A file can be preserved through a read-only fd, but not a
> write-only fd. Preserving it requires permission to write to it, except
> for the owner of an immutable file or of a file on a read-only
> superblock. Append-only files can't be preserved, and files can be
> preserved through a read-only mount. Also check that the size of a
> preserved file is frozen until the file is unpreserved.
>
> These checks don't need a kexec, so they run as part of the regular
> liveupdate selftest.
>
> Enable CONFIG_TMPFS_XATTR for FS_IOC_SETFLAGS. The test cases that use
> it are skipped without it.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  tools/testing/selftests/liveupdate/config     |   1 +
>  .../testing/selftests/liveupdate/liveupdate.c | 303 ++++++++++++++++++
>  2 files changed, 304 insertions(+)
>
[...]
> +/*
> + * Test Case: Frozen Size of a Preserved File
> + *
> + * While a file is preserved, its size can't change and no holes can be punched
> + * into it. Writes within the file still work. Closing the session unpreserves
> + * the file, after which its size can change again.
> + */
> +TEST_F(preserve_tmpfs, frozen_size)

Nit: This test isn't really for "frozen size", it makes sure a preserved
file behaves as we expect it to. So perhaps call it "preserved_ops" and
update the comment?

> +{
> +	long page_size = getpagesize();
> +	struct stat st;
> +	char c;
> +	int fd;
> +
> +	fd = create_file("file", 0644);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(ftruncate(fd, 2 * page_size), 0);
> +	ASSERT_EQ(luo_session_preserve_fd(self->session_fd, fd, 1), 0);
> +
> +	EXPECT_EQ(ftruncate(fd, page_size), -1);
> +	EXPECT_EQ(errno, EPERM);
> +	EXPECT_EQ(ftruncate(fd, 4 * page_size), -1);
> +	EXPECT_EQ(errno, EPERM);
> +	EXPECT_EQ(fallocate(fd, 0, 0, 4 * page_size), -1);
> +	EXPECT_EQ(errno, EPERM);
> +	EXPECT_EQ(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
> +			    page_size), -1);
> +	EXPECT_EQ(errno, EPERM);
> +	EXPECT_EQ(pwrite(fd, "x", 1, 2 * page_size), -1);
> +	EXPECT_EQ(errno, EPERM);

Nit: Is there any point in matching the exact error code? Wouldn't
checking for a failed syscall be enough?

> +
> +	/* The size didn't change, but writes within the file work. */
> +	ASSERT_EQ(fstat(fd, &st), 0);
> +	EXPECT_EQ(st.st_size, 2 * page_size);
> +	EXPECT_EQ(pwrite(fd, "x", 1, page_size), 1);
> +	EXPECT_EQ(pread(fd, &c, 1, page_size), 1);
> +	EXPECT_EQ(c, 'x');
> +
> +	ASSERT_EQ(close(self->session_fd), 0);
> +	self->session_fd = -1;
> +	EXPECT_EQ(ftruncate(fd, page_size), 0);
> +
> +	close(fd);
> +}
> +
>  TEST_HARNESS_MAIN

-- 
Regards,
Pratyush Yadav

