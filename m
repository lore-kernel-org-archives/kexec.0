Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98B606A33E
	for <kexec@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gKyj+rWx;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c7xComwZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5TEXBm2KFRNPqnQrkYBN59qrTw89JkXgXnSB3fFl4n0=; b=gKyj+rWxIU/iD0
	SVXn5TVuLcy11BxT9Q8Qgcc9T3KyoElV+XjvWGKQ9W+J7rDRwLTOeVqLc77QhvmmOXK+kzcGj7J8d
	aM2AAO2ZKbu0eBKvHSk+wGJ+R01ZRZmjhS8fdzv6a0Zf/6QbUYJj0OgsmYDItXTGhOqRxxeZ7g/IZ
	Lpx6SsVIT7/TlNkQHYcZhN7NwGGtkbWLzjZRO2I1Kaa/bzPtuf6cBC8pN0RHf+4iHZaOdDiZi81Fb
	g63DMtt/H6jOo7tpsqE3hQY2g++EgEorH4qPEHYFH+e3bkRHTf6oJw3JTHviOfT3IFk8selRtIe5U
	GMUxQw86aeSe7hcJ1YSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe94-0000000EaIr-42ID;
	Sat, 07 Nov 2026 10:59:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPe93-0000000EaI1-3uhy
	for kexec@lists.infradead.org;
	Sat, 07 Nov 2026 10:59:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C22340405;
	Sat,  7 Nov 2026 10:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A221F008A1;
	Sat,  7 Nov 2026 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049177;
	bh=5TEXBm2KFRNPqnQrkYBN59qrTw89JkXgXnSB3fFl4n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c7xComwZV6OF+So9zXFZTdI+3vnCbG6eJ02qEHBFKMB/0xcNNz25SjkLniWK32Ww+
	 Gxok6L4yb8fAp8Z/t86AOFgsE6gc7GYgn0M09D7vhEcM7apVz7tvLFH4DO4cHIkKXP
	 Erog5oZcms0xVIcPEa7MNQ/KYWD703jWQS25S+Vyh/RN0R11GXKjT/0IdumYg2qyRs
	 EcPCiZkJwM8nfpq34pQUotRGCBdmZ/hDY0tSxtMjirY2KUC5G7JdELheqAwgHSkgVX
	 TzguZpPybfcyrP/mHimdx7klbJtiQGnK4yfvag6xbybvpLSRfclwpKLaWCK9CdR/J2
	 PCN4aSo7QqZZA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Dave Young <ruirui.yang@linux.dev>,
	Jiri Bohac <jbohac@suse.cz>,
	David Hildenbrand <david@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kdump: Give crashkernel CMA areas unique names
Date: Sat,  7 Nov 2026 12:59:23 +0200
Message-ID: <179404912276.1474561.4441607077586218375.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106104309.3669583-1-zaslonko@linux.ibm.com>
References: <20261106104309.3669583-1-zaslonko@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Fri, 06 Nov 2026 11:43:09 +0100, Mikhail Zaslonko wrote:
> reserve_crashkernel_cma() names every CMA area it reserves
> "crashkernel". If the requested size can't be reserved in one piece,
> it falls back to several smaller areas, all with the same name.
> With CONFIG_CMA_SYSFS, cma_sysfs_init() then fails to create the second
> directory:
> 
>   sysfs: cannot create duplicate filename '/kernel/mm/cma/crashkernel'
> 
> [...]

Applied to kexec-next branch of liveupdate/linux.git tree, thanks!

[1/1] kdump: Give crashkernel CMA areas unique names
      commit: 941aef93e9e1df74f0ef0fa8653c435613131243

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kexec-next

--
Sincerely yours,
Mike.


