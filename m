Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DF606A329
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gd8WNHIb;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZiZxI9G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=RDov0eoVo/jXZsEH8waw4PclHfxr4UeOoI1jJZ0wFVU=; b=gd8WNHIbEVzQ8YzymlFSprNnth
	ky/yJVF7R/exx82eRSq/a2ZkDyfGxofkyB0Nfaj9QhwvhjhlO454bgm7Xv3VAx7nrmCn6Z8EQERvU
	A2GIpAxlfaxw6Qq4M9/mKB9HJM4a6NhtEBrrAiL87I8Yt77FwT50UUMCiperRanxcZebAhWHqa4gr
	7d+oC3NhTbJCiQZLYgEOsQdBzyBgbrHLiuZqU0yhK976lATn1OGjBXqbFqZ9Ak94NwQRglbe6vULb
	m7aZo85mJSGYUKvo7OfHxFO+LeD8FR1uMJVV0MSzbj3mZe91O8ZrqDed7YU7CK0BZdFftyRVtzKco
	6SQwMxlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKiD-0000000CcK1-0JK9;
	Fri, 06 Nov 2026 14:14:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKiB-0000000CcJa-1FWR
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:14:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BAC4860204;
	Fri,  6 Nov 2026 14:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9485A1F0089F;
	Fri,  6 Nov 2026 14:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974474;
	bh=RDov0eoVo/jXZsEH8waw4PclHfxr4UeOoI1jJZ0wFVU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QZiZxI9GAjrir92IAFfKGitZXVtY1jvK5zvkVio451cKaNQy+4alLSBiO8n4IXk5a
	 FeU8B/aZpr2kFUdrrLErUTcJxOy0VJSqfsasS4uw81KAuNjyZAdjxKj1wiOj7JAxBR
	 mbCHQFfN6Q4wIrn+IpBW0KIgDBUhwENIZc64nO3QfIl87WE6M+kj1UTV6sgxuXYxMn
	 NBH9mBHcgEDIzbAvb8xyON+HXQ/hi5v/jPOplklBmwp+o7m+ZKVqOoBmQIYtXJQb1s
	 3Or4fuYh0VQ6PHIfJzhif/V26peoD/pmRt4Txg9M2arpzKsXqRwdmfeKOE1qfqnC9v
	 wxbaO2Ww9a69A==
From: Pratyush Yadav <pratyush@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-mm@kvack.org,  Alexander Graf
 <graf@amazon.com>,  Andrew Morton <akpm@linux-foundation.org>,  Baolin
 Wang <baolin.wang@linux.alibaba.com>,  Christian Brauner
 <brauner@kernel.org>,  David Hildenbrand <david@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Jonathan Corbet <corbet@lwn.net>,  "Liam R. Howlett"
 <liam@infradead.org>,  Lorenzo Stoakes <ljs@kernel.org>,  Michal Hocko
 <mhocko@suse.com>,  Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Randy Dunlap <rdunlap@infradead.org>,
  Samiullah Khawaja <skhawaja@google.com>,  Shuah Khan
 <skhan@linuxfoundation.org>,  Suren Baghdasaryan <surenb@google.com>,
  Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v3 06/10] mm/shmem_luo: Don't make early retrieve
 failures permanent
In-Reply-To: <auuxi10mmCQrq-y2@google.com> (David Matlack's message of "Wed, 4
	Nov 2026 22:28:27 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-7-dmatlack@google.com>
	<2vxzik2ck5dp.fsf@kernel.org> <auuxi10mmCQrq-y2@google.com>
Date: Fri, 06 Nov 2026 15:14:29 +0100
Message-ID: <2vxzo6c2hwsa.fsf@kernel.org>
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

On Wed, Nov 04 2026, David Matlack wrote:

> On 2026-11-04 04:01 PM, Pratyush Yadav wrote:
>> On Tue, Nov 03 2026, David Matlack wrote:
>> 
>> > Mark failures in shmem_luo_retrieve() before it starts restoring the
>> > folios as retryable, and return the error without freeing the serialized
>> > state. If no retrieve succeeds, finish() frees the preserved folios,
>> > like it does for a file that was never retrieved.
>> >
>> > Nothing has consumed the preserved state before the folios are
>> > restored, so the retrieve can be tried again.
>> >
>> > This also fixes leaking the preserved folios when one of these early
>> > steps fails, e.g. because the file has seals that this kernel doesn't
>> > support. The retrieve freed the serialized state but not the folios, and
>> > finish() then skipped the file because its retrieve had failed. There is
>> > no Fixes tag, since the fix relies on args->retryable, which was only
>> > added earlier in this series.
>> 
>> If the seals don't match, the retrieve is not retryable. It will always
>> fail.
>> 
>> I think the only retriable part is memfd_alloc_file(), although even
>> that is quite unlikely to fail. But I think that also fits pretty well
>> with the most important type of error you want to retry on, which is bad
>> arguments. In later patches, you check the argument on
>> shmem_luo_create_tmpfs_file() or shmem_luo_create_memfd(), so perhaps
>> set retriable in those functions?
>
> When retryable is set, LUO leaves the file unretrieved and finish()
> frees the preserved folios. If the seal failure did not set retryable,
> finish() would skip the file and the folios would leak.

Yes, but in that case you free the folios on the error path of
retrieve().

>
> In v4 I can move the seal checks into shmem_luo_create_memfd() and
> shmem_luo_create_tmpfs_file(), since the valid seals differ between the
> two, and reword the commit message so it doesn't suggest that a bad seal
> can be fixed by retrying.

I think it is important to signal to _userspace_ too that bad seals
aren't retriable either. So I would really suggest doing some sort of
non-retriable errors for bad payloads.

-- 
Regards,
Pratyush Yadav

