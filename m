Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB40606A331
	for <kexec@archiver.kernel.org>; Fri,  6 Nov 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bmqdzxB6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyQX4xrL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3BGm6++pKtOncS4lRKnJP40WFpWtCJnoqlazLALAmUQ=; b=bmqdzxB6BMUdsDMjMJ/lAxSVFz
	+iNEFd42CaFbKZTfdwu5wnjvp71HvRIAu5IukiAYbkpXd6KMCRz1UiP/K5k8JP4Sku1vju7fETm4I
	W5+9tU+cDUeuTNlJBSG0N0zv4GXA9UmzQ5gLe6SSq9XT77HcJr1q5M+WEbh7qtZHgk8tHq10eUMb1
	rtnNd0j5m7aDiYPzc6OBGfIbBU0JtbOlayL69grkgW54I0uoz2BmQvEm/m85fABdvv+k589QC7N8a
	4zunuq0gqN3OiqeGLGNETQ+yhB1QJpZQaH8PqTDqEC/0gVYsuSfUw6e5RnsUT4RovYTt1i+ZTum5n
	lnEjyz1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKoG-0000000CdPK-32kB;
	Fri, 06 Nov 2026 14:20:52 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPKoE-0000000CdNG-3eyN
	for kexec@lists.infradead.org;
	Fri, 06 Nov 2026 14:20:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4FBD6602D4;
	Fri,  6 Nov 2026 14:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212391F0089F;
	Fri,  6 Nov 2026 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974850;
	bh=3BGm6++pKtOncS4lRKnJP40WFpWtCJnoqlazLALAmUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gyQX4xrLrx1BFfFkKUZiu5XvGClGl9PbeRhj0kyNOSTxMLNyElhN6ErH+KHOL2n4r
	 BnkL587QN1a+6hBSF3cSgTzMR/sZ9xpPH6aorLKPvcO/nm/M60cQhz6fzdrag4gGFE
	 LQRH1tLBNlwv4RFQ6dElUrV2xanXCvtgwrfHJaWzZu/nFdnND+k8WE3H38bKL5Dczz
	 jLnriyrw/uSRafnQN8JItgZR9AQPLLiX9qhd+c6N0S7jB2sJKZvr/iWgZCLdRHEi0S
	 I71Ra4+finmIVHXOLTmF2NXyTNBYc6bLqwzm0sC5Gaz6IXN0bJUIStZvJ3mb5W6CSR
	 GGSOTjrfYdTLw==
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
Subject: Re: [PATCH v3 07/10] mm/shmem_luo: Retrieve tmpfs files onto a
 tmpfs mount chosen by userspace
In-Reply-To: <auuyAseOISaOWwbO@google.com> (David Matlack's message of "Wed, 4
	Nov 2026 22:30:26 +0000")
References: <20261103010216.3447716-1-dmatlack@google.com>
	<20261103010216.3447716-8-dmatlack@google.com>
	<2vxzecd0k1dg.fsf@kernel.org> <auuyAseOISaOWwbO@google.com>
Date: Fri, 06 Nov 2026 15:20:44 +0100
Message-ID: <2vxzfqxehwhv.fsf@kernel.org>
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

> On 2026-11-04 05:27 PM, Pratyush Yadav wrote:
>
>> > + * If @flags contains unknown flags or O_PATH, if @mode contains unknown mode
>> > + * bits, or if @dirfd is not on a tmpfs mount, the retrieve fails with -EINVAL.
>> > + * If the file can't be created, the retrieve fails with the same errors as
>> > + * open(). A retrieve that fails before the preserved contents are restored can
>> > + * be retried.
>> 
>> How is userspace supposed to tell if preserved contents were restored?
>
> Through the error code, like Pasha said on patch 3. I'll reword this in
> v4 in terms of errors instead of kernel internals: errors from checking
> the argument and creating the file, e.g. -EINVAL, -EBADF and the errors
> that open() returns, can be retried after fixing the argument. Errors
> while restoring the contents, e.g. -ENOMEM, or -ENOSPC when the contents
> don't fit on the mount, are permanent, and retrieving the token again
> returns the same error.

I wonder if we should document per-file type error codes and what they
mean. Perhaps some time in the future...

>
> Thanks for the review. I'll address the rest in v4.

-- 
Regards,
Pratyush Yadav

