Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633E606A334
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 12:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=CLthM3T1;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R3tSaNjD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PQ7877NM0Z63f03vb+VlOqlB28yBZwRNNMB/tP7aaos=; b=CLthM3T1H3R99q0tEXwcSsncMI
	PY0dIIvF40/2rXOTQDK/Rm0SQ30tBNRcUnbqIyIFFOi2KGW5goRrV/6KDsOeHtDVoU26AWfKoOvhp
	l3Iwg5M7ch4vwzeu5QDXX9eQncT9QtABz5oNg5I6gHtRKQi4R7Bg1amxJJBRivqypM8FhPuDuKaPL
	n2qfWsETjn/5yw6cbobuodhsSly5wnlGwlsmo/L6kdLk6i0M1egnOATmctZjZFyEHw1TgpR7nJK1l
	0XiJl6wHwb/I7EKZgOyAfqcL//VTeYU/d3BqttLW+aT6eFcRGdSX5ZYpQ6mevg5wnqUB+45JtTEix
	jnAW6Q5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNZS-0000000Ew1n-1Xh2;
	Fri, 20 Nov 2026 12:18:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUNZQ-0000000Ew1P-408g
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 12:18:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3BF1E62334;
	Fri, 20 Nov 2026 12:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D9A1F00AD4;
	Fri, 20 Nov 2026 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177103;
	bh=PQ7877NM0Z63f03vb+VlOqlB28yBZwRNNMB/tP7aaos=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=R3tSaNjDrxS2buOBQuUnNft3p1BHdF0ka2s9xwRfQWYtaatHIYf/SIJftvDUBALXa
	 gnbmi74ZxRHOY8TDl38ZzpEYMermT6EUGtK8l3dyxnQK3T69h43DhYsDem5LunRyOO
	 dmZxC0Dj6rsbZRBqRW7NjwWYaBRddj6WAyj88uDgjTmtDybSyPfMn8ywSgvsPtmw4C
	 MLapjmkrXt6h0dWVWig53bBmuExExOROJrdvbwh99Z/zF6S9drRf2/N670iprfGybm
	 xXoX/u5l+pEqxFWpeS070GQxwIurW2WCDjb2Dl+S9+JV90SZJPceyVH5tBj+YKjaJX
	 KIbcGLf5t9ylQ==
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
Subject: Re: [PATCH v4 11/19] mm/shmem_luo: Require permission to preserve a
 file
In-Reply-To: <20261111002358.1842967-12-dmatlack@google.com> (David Matlack's
	message of "Wed, 11 Nov 2026 00:23:49 +0000")
References: <20261111002358.1842967-1-dmatlack@google.com>
	<20261111002358.1842967-12-dmatlack@google.com>
Date: Fri, 20 Nov 2026 12:18:17 +0000
Message-ID: <2vxztslb1yt2.fsf@kernel.org>
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

> Require the file to be opened for reading and the caller to have
> permission to write to it in order to preserve it. Also let the owner
> preserve a file that is immutable or on a read-only superblock, and
> reject append-only files.
>
> While a file is preserved, its size is frozen for all of its users:
> truncating it, fallocate() and writes past its end fail with -EPERM.
> Today any process with an fd for a memfd can do that, even one that was
> only given a read-only fd. Requiring write permission limits this to
> callers that could truncate the file themselves. A file descriptor
> opened for writing isn't required, since that would rule out preserving
> a running binary, which can't be opened for writing. Only the permission
> of the inode is checked, so the mount doesn't need to be writable
> either. The size of an immutable file or of a file on a read-only
> superblock can't change anyway, so its owner may also preserve it.
> Append-only files are rejected, since their writers can only append to
> them, and freezing the size would stop all writes.
>
> The retrieved file can be read, so also require the file to be opened
> for reading. Otherwise a caller with a write-only fd could preserve the
> file to read its contents.
>
> Document the frozen size and the permission requirements.
>
> Signed-off-by: David Matlack <dmatlack@google.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

