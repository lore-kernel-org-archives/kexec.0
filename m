Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9544606A335
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1uWaRwtD;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAQeB94N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=pvQk7gkgjyECtllSEXxMYHx9i1xSAVAK6APJPPvCqm0=; b=1uWaRwtDt8ZDjyVtkiiUIA4364
	nXH5SDrXm7wXq8rZIfVVylk2MY2cQtRZBfVEPIeRD4NFN6Z3xE3/ZBE0o+qo9zzHaB2MJL6JRg4e0
	o0DrqL1o+7RU6rHiDqfzkgSuLBTn++pSbQCeg+iaVaT+cb6CkIgprWYK0aI/hzWG6EZP656A7Kvk2
	Ft2NNIU7MQypyd+st7b4uwXds0HMglkW3qlyQEgpg7UxxEzTAdUzAAzFa5GHcb3uyHNDDrdVCVUoO
	0XcFYJCS22k/MPkEH8dK/xUva04aXj7TjP+vGd6SQrdIFZzKvpkdeTTaV5m9EFtdOWzVsMxFSaFMG
	4zBekI9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOb0e-00000005Twk-1Jkw;
	Wed, 04 Nov 2026 13:26:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOb0c-00000005Twd-3pJM
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 13:26:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 92EDB40356;
	Wed,  4 Nov 2026 13:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9C61F000C1;
	Wed,  4 Nov 2026 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793798794;
	bh=pvQk7gkgjyECtllSEXxMYHx9i1xSAVAK6APJPPvCqm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=AAQeB94NpsdVxdbYF50v7JrxTJ1MLmAG6T5ILf5+I7BHKtmTQeMeLUsVdV9aAKJVb
	 F8aobQ2oDHgTUEkO+hLUrZO2Fs6BLUEX9y/S/oqQY7sF61wAP95BBkBCz+S2kZIm7M
	 2qygBxvGCen/9kY8WP5FXnqVn2NYpENQNyoFzj6xasHx04ktg3N7JTbponsO+FBA8O
	 MTq59fCOT+AWqw7PxNNGuzK5yvxfXmIt6oNkjBUWq3LDHFJtB9aJHmvFZQAf7pBYf5
	 Ai+VKaIUMG/mOwbCQu68+3iEQ7bkX8G/U0l1OHYMA92ntsVjriWAeYkIvkV0ZemmzI
	 mqKBfJJ0rQ/1g==
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
Subject: Re: [PATCH v3 02/10] selftests: liveupdate: Add tests for preserve
 and retrieve user argument
In-Reply-To: <20261103010216.3447716-3-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:08 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-3-dmatlack@google.com>
Date: Wed, 04 Nov 2026 14:26:29 +0100
Message-ID: <2vxzzevok9ru.fsf@kernel.org>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, David Matlack wrote:

> From: Pasha Tatashin <pasha.tatashin@soleen.com>
>
> Verify the user argument support in LIVEUPDATE_SESSION_PRESERVE_FD and
> LIVEUPDATE_SESSION_RETRIEVE_FD. Add luo_session_preserve_fd_arg() and
> luo_session_retrieve_fd_arg() helpers to libliveupdate so tests can pass
> a handler-specific argument.
>
> Add a preserve_memfd_with_arg test case to verify that memfd
> preservation rejects a non-zero argument with -EOPNOTSUPP, accepts an
> explicit zero argument, and remains compatible with callers passing the
> legacy struct size up to the token field.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

