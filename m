Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C052606A330
	for <kexec@archiver.kernel.org>; Fri, 20 Nov 2026 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nxThTdQS;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpxwFu+d
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UHW4M+q/Xhm54NFX+3u4JQAN1oFui+zkbZJdU7S2zo4=; b=nxThTdQSLHINZWQAkKmHlcwHfG
	RYNmJNlWBPhBQShBAks7MUroT8ke11dzPe/iYGh4tfvqc3EMTMMPyai1fMfgWHXDGuqS7BgqGTSXp
	nXMVJMudSDpd8u8rrEPNOA/34xSqKdEUM+JU3a6Xnqu0prPkh6ev89VBusoepxloO3GeecabSGPLQ
	N7N5WlHV003sasb90islmFJ9nYDnzOHBnO7MYrxfnADP8mGTTJeSc6v4iip7SWUHTjjSYC1MZ0VIm
	SJCjXTHdtvJHumjLd7baf5OBaG25yHhpcJGLGe71oftrXY2VEt5r18GteVPgdHkTBuCwjqPxo1r7A
	ziWd0eQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKqI-0000000ES2F-3oMe;
	Fri, 20 Nov 2026 09:23:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUKqH-0000000ES28-0hTI
	for kexec@lists.infradead.org;
	Fri, 20 Nov 2026 09:23:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E57654377A;
	Fri, 20 Nov 2026 09:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456E71F000C6;
	Fri, 20 Nov 2026 09:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795166616;
	bh=UHW4M+q/Xhm54NFX+3u4JQAN1oFui+zkbZJdU7S2zo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WpxwFu+dBnk7TT+TAVvOCeGZiO/i95AKNUlvowfDJHUSAgOn1AMEi1CBG2K2tfp/Y
	 kRb4JmuT6xjrixrvoFrF3oQ1dT0X7AGsHkqw9WO6W/M14RzpjVe4aYupuKsArGkDRl
	 PcbsYr6xFO+th1S+LgcDKGkvCqZSIpB6SvOhYiq2nHQ7gXfsN4d+TzFutAxgThIqwj
	 CcXL9FpFXNqxgNeYqb5bWnsyL/0tp089iVZpGhFBSTPltZGX7jgip7ZzjQSuFF/UlC
	 ixURzNPzCCy5x7y4QtCO7KfNLHpovSsxg+f7b/rGq0BoQQVR7Fym73XF20qh+v5oS/
	 UlZ3cr8g877iw==
Date: Fri, 20 Nov 2026 10:23:28 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Matlack <dmatlack@google.com>, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Cc: Alexander Graf <graf@amazon.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH v4 08/19] liveupdate: Let file handlers retrieve into an
 existing file
Message-ID: <20261120-gedulden-rausgeflogen-spruch-cea76174d5e2@brauner>
References: <20261111002358.1842967-1-dmatlack@google.com>
 <20261111002358.1842967-9-dmatlack@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261111002358.1842967-9-dmatlack@google.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 11, 2026 at 12:23:46AM +0000, David Matlack wrote:
> A file that is restored into an existing file is already open in the
> caller, so installing a new file descriptor for it would just leave
> userspace with two file descriptors for the same open file. Retrieving
> the token again later still returns a new file descriptor, like for any
> other file that was already retrieved.

Thanks, this looks way better.

One thing: Please just install a new fd like for every other retrieve.
I think it's pretty meaningless to return the fd number the userspace
just passed to the ioctl.

The fd number is also not useful as it's not tied to anything. The shmem
handler looks the fd up once and LUO keeps a reference to the struct
file:

	CLASS(fd, target)(arg->fd);
	[...]
	args->file = get_file(file);
	args->fd = arg->fd;

Which means, another thread can close() that fd or dup2() something else
over it before the ioctl returns and the fd you hand back refers to a
different file fucking over the caller (shared fdtable etc pp).

That also gets rid of @fd in struct liveupdate_file_op_args and the
special case in luo_session_retrieve_fd(). And a retrieve into an
existing file then behaves exactly like retrieving the token again.

