Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CD6606D80B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=yvm8stEf;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bABADEyK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tZW6BR9vwrayTNKI8W7w9kReBz4l5H0o0D9sCFw8bAc=; b=yvm8stEfMfRFaZ+xXoD8U9qrms
	/mIygDUJLfwQE7Kx4lGLmnF2VUG63QkRy9U/biAEfuFQwctgphEY98smcxzLpwkzenkA+d3J3lMLW
	iKQv4lB4izEQ3/+xF2KpjxIhBqvMMMZpQpbcSJAoSmuFCaYaAVQmn5e7Ac9kvw6qJDfZnZcgzXc0F
	1Ox0ZrOrNzJ6UyaMbQLgXPkmLCrivnyAL18QlSMUz8CdQUf5DYbuUGhvORwl66+WCFxeE1TOGFKrf
	/caFyolNxu+JK/D7fVSkaANpStj43xMUM1dskW1221p2C6ehUgDh1tGIZZXdzhozBveHxJeVR7iW3
	MoZ83FYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvP-00000005cnn-0dEu;
	Wed, 04 Nov 2026 14:25:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvN-00000005cnT-3Ieg
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 58D0C43C9D;
	Wed,  4 Nov 2026 14:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94BA41F00A16;
	Wed,  4 Nov 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793802313;
	bh=tZW6BR9vwrayTNKI8W7w9kReBz4l5H0o0D9sCFw8bAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=bABADEyKkYq/reQcFV5A5OykrD/wWoqqHZBgx0Szo9PbBI5tzJy/dZXWQvg2Znfqm
	 cflloeK9kR25Chxa9tAsmFgj+p+k0cCGvh3/9RCbOAIRfiMoBg7EGjsH3X9JOYfr0+
	 yB+9+dDSJ1ZQI3jInQk7zdTkXpXVaU8vJWJe0H7ejwtozZVFoDQhacUZ4b493LVl7I
	 xURyeQf86+6Ec2VztQ7g4gywOAqevw/7/AmnYzAf7L6+eI8HtmQldkvLL1NwOMI1l4
	 47C2WZk92rcr8F55j+CCG0lHXt8qLf0kk/seS/g7cjgwDMFgFgN/hka9xRHjt8LFvK
	 6ctdlGadIMgMA==
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
Subject: Re: [PATCH v3 04/10] mm: Rename memfd_luo to shmem_luo
In-Reply-To: <20261103010216.3447716-5-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:10 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-5-dmatlack@google.com>
Date: Wed, 04 Nov 2026 15:25:08 +0100
Message-ID: <2vxzqzh0k723.fsf@kernel.org>
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

On Tue, Nov 03 2026, David Matlack wrote:

> Rename the memfd Live Update file handler from memfd_luo to shmem_luo,
> including the source file, its KHO ABI header, its documentation and its
> Kconfig option (CONFIG_LIVEUPDATE_MEMFD to CONFIG_LIVEUPDATE_SHMEM).
>
> The handler preserves shmem files. Today those are memfds, but following
> commits extend it to other files on tmpfs mounts, for which the memfd
> name is confusing. Preserving memfds created with MFD_HUGETLB, which are
> hugetlbfs files, will need a separate handler, so naming the handler
> after the filesystem that backs the files also avoids having to rename
> it again then.
>
> Don't change the compatible string of the handler, "memfd-v2". It is
> matched against the preserved state from the previous kernel, so
> changing it would break live updates from kernels that use the old
> name. The serialized format doesn't change either.
>
> Also clarify in the documentation that memfd means a memfd created
> without MFD_HUGETLB, and name the ABI documentation after the handler.
>
> No functional change intended.
>
[...]
> diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
> index f50daee8eff0..9a1c49e2e0c4 100644
> --- a/kernel/liveupdate/Kconfig
> +++ b/kernel/liveupdate/Kconfig
> @@ -69,7 +69,7 @@ config LIVEUPDATE
>  
>  	  If unsure, say N.
>  
> -config LIVEUPDATE_MEMFD
> +config LIVEUPDATE_SHMEM

Update the description too?

LGTM otherwise.

Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>

>  	bool "Live update support for memfd"
>  	depends on LIVEUPDATE
>  	depends on MEMFD_CREATE
[...]

-- 
Regards,
Pratyush Yadav

