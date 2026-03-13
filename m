Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D8106FD9A
	for <kexec@archiver.kernel.org>; Fri, 13 Mar 2026 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5JrLlrz1R0ux6eyWaXBOi4F+LeobsZhvq0nXftAHdHg=; b=BAB5abtG/WqmKgbnZOLM5tie6L
	Icm5RGzgtaiqejanpHKp/tBmlphhWs791iE/GERNwOD6Xk7NxaIbI4cprE7KJ/sdueDGWiqaKHmkn
	XnK77KY+vt7AzGMq87unuMsCabZrOzkVulJsbYdu84Z/7f/iMkTBYXoh7qFd0B5l3bDcV5IDMYc7d
	vTJE4Cqyob4r3K1QeEzJ5Gr6y9K5n+IIlkpPMIWLatG+IbZh10OyLDQPSpBdefd1WXbQUJPHXKSW9
	nUMh1U+cjp9xhg3aJibx0w9ewLpw0WILI5yW2Vss/cg7PM6eBWAztzG3TMKQfVnWVeq9C8ItSNoEO
	jpgA6Mvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yEc-0000000HJSm-3m4H;
	Fri, 13 Mar 2026 08:51:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0yEa-0000000HJSV-3fkl
	for kexec@lists.infradead.org;
	Fri, 13 Mar 2026 08:51:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ED8FB6012B;
	Fri, 13 Mar 2026 08:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E97C19421;
	Fri, 13 Mar 2026 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773391863;
	bh=1KUT9Tf25ZS6VrZia7+QDLQFs4SKqyhZvqzfc04vw8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fMXnoAOQU0/G+r8DPkq+oydoGE9H6DUf2wvwyh8xC86fVKVeEY1g+IxpVxEv8j4oL
	 Pyaz4iO+lYWCVz7h2biCk/IsklGMvlM6pN/y4sChyv5iDLimiyDysTb61GeN6DEeFS
	 j+J/NpSNz4VfxUAVWqep5mkYXV20jsikdgIjsCuLjCnEqG0GEVqz74Z4ZhFRL0bSX5
	 luExGUclhVGwdQrap00cRrbE+JD9QH9QQcylpQDIsiG7/7SJfdRTk8J9q8cs9DaP8l
	 eKeyMbspFRUlBy+3KMqU5qFIq4AdAzXd0dprSkae8RoYDJyix3r2Z9CB26YOHnGzY3
	 DTpw12xM5T4WA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,  usamaarif642@gmail.com,
  SeongJae Park <sj@kernel.org>,  kernel-team@meta.com
Subject: Re: [PATCH v8 1/6] kho: add size parameter to kho_add_subtree()
In-Reply-To: <20260309-kho-v8-1-c3abcf4ac750@debian.org> (Breno Leitao's
	message of "Mon, 09 Mar 2026 06:41:44 -0700")
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
	<20260309-kho-v8-1-c3abcf4ac750@debian.org>
Date: Fri, 13 Mar 2026 08:50:59 +0000
Message-ID: <2vxzms0cgljg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: kexec@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Mar 09 2026, Breno Leitao wrote:

> kho_add_subtree() assumes the fdt argument is always an FDT and calls
> fdt_totalsize() on it in the debugfs code path. This assumption will
> break if a caller passes arbitrary data instead of an FDT.
>
> When CONFIG_KEXEC_HANDOVER_DEBUGFS is enabled, kho_debugfs_fdt_add()
> calls __kho_debugfs_fdt_add(), which executes:
>
>     f->wrapper.size = fdt_totalsize(fdt);
>
> Fix this by adding an explicit size parameter to kho_add_subtree() so
> callers specify the blob size. This allows subtrees to contain
> arbitrary data formats, not just FDTs. Update all callers:
>
>   - memblock.c: use fdt_totalsize(fdt)
>   - luo_core.c: use fdt_totalsize(fdt_out)
>   - test_kho.c: use fdt_totalsize()
>   - kexec_handover.c (root fdt): use fdt_totalsize(kho_out.fdt)
>
> Also update __kho_debugfs_fdt_add() to receive the size explicitly
> instead of computing it internally via fdt_totalsize(). In
> kho_in_debugfs_init(), pass fdt_totalsize() for the root FDT and
> sub-blobs since all current users are FDTs. A subsequent patch will
> persist the size in the KHO FDT so the incoming side can handle
> non-FDT blobs correctly.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

