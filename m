Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0BC60A2604
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lEf63Ss6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWKv2sBp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=a5J72X3HPA+7mSwk7L/JqiNlhfSlr+OpvNLs81RwtBM=; b=lEf63Ss6yrEJl5jzsYcDQdDLag
	38CrX0kMiLPh8PLq3e6YNOqPdGWnf0UY/dyRTca0keDndFUtSmbqnK9oC0AVnZDJiphiCQlglHYcU
	KnkgvhntjdidPoKMzYFSo2/dcG1e1gsrh4a0gGPoepHWoBRNtQQBb2MBQsd4s3dz8ZR1BfCQBX1St
	cbEEralHRicbR472CNcuvKQ4SFSjhNj80auA0BIZWHve+ydisaflTfQxKetut87/jRkJOEgGFV3wX
	MPGylpczB7MOIbvKPmPotBb5Dy+xJiGjkrm9LAOK7IyEDM+Unn1+6R+jzp1F6hHNWSZmiYksSkT/W
	T5qmOVUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNKV-0000000EuH6-12b4;
	Fri, 20 Nov 2026 12:02:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNKU-0000000EuH0-14eZ
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 12:02:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AA92341075;
	Fri, 20 Nov 2026 12:02:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EEF1F000C0;
	Fri, 20 Nov 2026 12:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795176177;
	bh=a5J72X3HPA+7mSwk7L/JqiNlhfSlr+OpvNLs81RwtBM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mWKv2sBppmiUSdyRqTHoLy0JiF4sgo0VjISutNKO+L9E1A83mmNl7o4OwDh61EuPA
	 pkCfeqgSsgrgpvW/wxbM5oLmX/qWpfSJ7NynQQUHRGPa3Q9jhYW57wuSAfo34EBEMH
	 BFj7Y0k92tluEyBqvMQkOh67LrqF5B1Nf3Enowz7pr9aLKaU8TYe76sGIE0FQUN+YA
	 qlAUT2yUVqmA2bJkml2+T686GxMFtvjN1hiizEyW3szH9eADb4nM1pUvd3H2vK1uNf
	 xb5gzP2YsZBAP82sRRbl9wKGk0mrFqfR1C5SzEUC0tu7o6LCIY3d7PNaa30kWXRK5n
	 Yd1rQsvYo08eQ==
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
Subject: Re: [PATCH v4 10/19] mm/shmem_luo: Don't make early retrieve
 failures permanent
In-Reply-To: <20261111002358.1842967-11-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:48 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-11-dmatlack@google.com>
Date: Fri, 20 Nov 2026 12:02:51 +0000
Message-ID: <2vxzy0an1zis.fsf@kernel.org>
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

On Wed, Nov 11 2026, David Matlack wrote:

> Mark failures in shmem_luo_retrieve() before it starts restoring the
> folios as retryable. If no retrieve succeeds, finish() frees the
> preserved state, like it does for a file that was never retrieved.
>
> Until the folios are restored, nothing has consumed the preserved state.
> Leave it for another retrieve, which may succeed, e.g. if
> memfd_alloc_file() failed with -ENOMEM.
>
> The exception is a preserved file that this kernel can't restore, e.g.
> because it has seals that this kernel doesn't support. Retrying can't
> help, so keep that failure permanent, so that every later retrieve
> returns the same error.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

