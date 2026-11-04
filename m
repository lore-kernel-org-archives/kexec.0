Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9509606A31B
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lVqp9RbH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OwJnxig3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6YxOPHeBFVzKRVOWsijIHFAGxsh3bvwNNvRfegWSMFo=; b=lVqp9RbHM8zA/EQOGC0Pnubi+b
	8cYqScG6lszv8Dbj2iq/KA5vo1evPpWCHKV0bAdzHanGyaAJyD8YlvJ/qPgZhZdMeXyobcxNaY5Sa
	9s7dOxtPDfbcjSsTTtAxR4TSEEMzjOJ4GcTIRjmABXokS1wNNaxZWkNcULDqX36jQ9YbySv7q5Ngm
	XPxBEpSnRdqaP2gOrue1tHe5TYNq7g3Zg67dJAjurdvvnPPwv2b8vDIv8W2NC7DkX/CNiyXWabkI1
	oA2jbnNQ73qYfmJa6VLj1VHXcwMGDiLmBuvTpT1E141ty8ljDBCuKqQ6dgYcz79Npyp+6712OPM28
	PCxSzcqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcUU-00000005iWc-1Mb7;
	Wed, 04 Nov 2026 15:01:30 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOcUS-00000005iWR-2nvF
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 15:01:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E7AE760546;
	Wed,  4 Nov 2026 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76AF1F0093A;
	Wed,  4 Nov 2026 15:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804487;
	bh=6YxOPHeBFVzKRVOWsijIHFAGxsh3bvwNNvRfegWSMFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=OwJnxig3rfoGKDzHfgnzBO3NMi8sr2bi7nZPcIXsVfqDqD2ml4RCvESVjw64EXsZy
	 0Iq0Rveie9/lMNePvdQHltK6+H2sKsmqZo/VM8NHEF1vn0ybRJsZeSpdeNVHnfYK9I
	 9JSalFL53Wpknx1cYHqboIWo9jjPjXzonHiRjCgG23CusXijz7xRveiT4cnAjU9Yc6
	 0GnKo5RyD3TENvFcCjOcQWx53fWl25tXPxDWbTew6D7VkfDMp+7jSrhY5l+qRtjJJ7
	 eMAeeBXN2mLzMiJ8zChNdFZCpdrJH2V2dbL3LkaeTJ4ePFuK4SZctGZZtlmPPCnOTn
	 aEEiOhq83RuYQ==
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
Subject: Re: [PATCH v3 06/10] mm/shmem_luo: Don't make early retrieve
 failures permanent
In-Reply-To: <20261103010216.3447716-7-dmatlack@google.com> (David Matlack's
	message of "Tue, 3 Nov 2026 01:02:12 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-7-dmatlack@google.com>
Date: Wed, 04 Nov 2026 16:01:22 +0100
Message-ID: <2vxzik2ck5dp.fsf@kernel.org>
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03 2026, David Matlack wrote:

> Mark failures in shmem_luo_retrieve() before it starts restoring the
> folios as retryable, and return the error without freeing the serialized
> state. If no retrieve succeeds, finish() frees the preserved folios,
> like it does for a file that was never retrieved.
>
> Nothing has consumed the preserved state before the folios are
> restored, so the retrieve can be tried again.
>
> This also fixes leaking the preserved folios when one of these early
> steps fails, e.g. because the file has seals that this kernel doesn't
> support. The retrieve freed the serialized state but not the folios, and
> finish() then skipped the file because its retrieve had failed. There is
> no Fixes tag, since the fix relies on args->retryable, which was only
> added earlier in this series.

If the seals don't match, the retrieve is not retryable. It will always
fail.

I think the only retriable part is memfd_alloc_file(), although even
that is quite unlikely to fail. But I think that also fits pretty well
with the most important type of error you want to retry on, which is bad
arguments. In later patches, you check the argument on
shmem_luo_create_tmpfs_file() or shmem_luo_create_memfd(), so perhaps
set retriable in those functions?

[...]

-- 
Regards,
Pratyush Yadav

