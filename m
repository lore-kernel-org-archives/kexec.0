Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC75CAC5A8
	for <kexec@archiver.kernel.org>; Mon, 22 Sep 2025 13:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CGnFKhP56ksvTbt87RMDe3QMyAKJwKabBNpwTSWZp1Q=; b=HiDnhp8t1ize8ldXD3ruHY7jJK
	5HD03x9vTyiX7g+9sAoxxVKzqOJ/P9ywM7rm/QH/5vYjmjlv5o1N3dEkvTN6k7vWrTDKYgTtnz7sP
	tcaCfL+/UIQftudP8vpeFfRzxhpvqgAKT7eq/ZW8J/STk9J5bNac+F9YokizH7GLsYe1E17A++W84
	cCtdE7LT4D/Bnpjfo0I4iQmyapPCFlz3n/5NAMgt1M2xqMtl3yFrTEKXBWjf47o1NoIwjML+/uolZ
	U+WGZp2mbx4bfTmiIDTqQY2iKrYR2DsZm1U+Ynqf03tpF0C/GqdyrUxd9M3KyN3/jQsE9E3APrSPq
	TZKyRA7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gvq-0000000AZfg-2ca1;
	Mon, 22 Sep 2025 13:50:18 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0gvo-0000000AZfM-0gFY
	for kexec@lists.infradead.org;
	Mon, 22 Sep 2025 13:50:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 67C3F44283;
	Mon, 22 Sep 2025 13:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F0AC4CEF0;
	Mon, 22 Sep 2025 13:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758549015;
	bh=KUdvoa11waaL9VuET18T94f4qWSxyLfuRY+uFrUSlbc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a0gkXo+7nkOQjnfZoRnPryocuqfZjQyryU+hLaAMYZUqw6iC1azA7St+vnNuoVRTh
	 nNkh68Ro9p2RrHDyKGqPnT73vcBHi+RqgC+3AKVPNaQve8wgwDMUFVQP6i0bkwuyR7
	 N9dWi040fV2IjhU7VJw2lW7933JwoNscuXyevLoGxbgWMi5OaBVieTstCKHqaj9Cji
	 kL84/+J0ryNnwsfKSYoFZqW3DYPyLLWM2S8UY8W4aVKacDIN3c9zwcAHElgdPNmfHw
	 IDWLQQcOEjB88Apb8ReEL/jIX60v8tlUChs4T64rSXK5TqNuYDwtTgXtkZgA2arBtb
	 jYvB4xyJi6a6A==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] kho: replace kho_preserve_phys() with
 kho_preserve_pages()
In-Reply-To: <20250921054458.4043761-3-rppt@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-3-rppt@kernel.org>
Date: Mon, 22 Sep 2025 15:50:12 +0200
Message-ID: <mafs0y0q6fvfv.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_065016_224457_D9768885 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
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

On Sun, Sep 21 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> to make it clear that KHO operates on pages rather than on a random
> physical address.
>
> The kho_preserve_pages() will be also used in upcoming support for
> vmalloc preservation.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

