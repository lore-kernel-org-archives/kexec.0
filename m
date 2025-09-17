Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC87CAC598
	for <kexec@archiver.kernel.org>; Wed, 17 Sep 2025 21:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TSvjqxRlECFwDqET9N8+cBdQWS5NnTu3eZ3l+17+1P4=; b=RtJ5vEWKFCnuXwz47Oi0hyl6zS
	qQ+EVrl8TjlLe3neXppfQCE0ZFMkP+QxGIMiXeQtld4P5AQa4jbfzOVo1qqHH7qkILF+X6q0o9D11
	9mdIHxxq0+uqWf9GaT9Ha0J7G/+5+DueXEjyVVK5rYy/KxoOgdF9wL9wDYijSw2rErw0Rj3jDT1If
	7klUtXkqLfSZ/0uDlqeI6824c7rZgVTZAFE8WWESPZy3IfycNMA35iU4jvH92TB0yM4zZ4Bne9BIP
	HWlOJc3ZLCmpoX/gWPZcxVOWJBQ2B5MzbxVymmuMMryjIH/o+vLxXgVXBeLEAkQvvWpJy+Iw/WCI4
	cffHppOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzUz-0000000Ep7w-1YxK;
	Wed, 17 Sep 2025 21:15:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzUv-0000000Ep65-3x4O
	for kexec@lists.infradead.org;
	Wed, 17 Sep 2025 21:15:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 89D8244B83;
	Wed, 17 Sep 2025 21:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA83BC4CEE7;
	Wed, 17 Sep 2025 21:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758143729;
	bh=DcxYPaU/C9Z8kxq2ijoz5I5wq5YK+7WzAtenGXmcCw8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rUbvzeb6lTZ+Whs/55k7lgnRyrOb9pGJ8yrG1X4a738PSNve1uqUlZcQLNspuugE5
	 igqRsR7m7ZGW7YhWZbOsdqHura7PFNCHH12FdrnOJlBb9p1LgYcJsXXfuvBQcK1aBL
	 Zpue6/TV2+E0fX526TLpn03YIXhPqX3qMwZoVtXo=
Date: Wed, 17 Sep 2025 14:15:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Changyuan
 Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>, Jason Gunthorpe
 <jgg@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush
 Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250917141528.cd619a95a19a33d71dcc4b1c@linux-foundation.org>
In-Reply-To: <20250917174033.3810435-4-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-4-rppt@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_141530_003359_28C66B0F 
X-CRM114-Status: GOOD (  14.47  )
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

On Wed, 17 Sep 2025 20:40:32 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
> 
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
> 
> ...
>
> --- a/include/linux/kexec_handover.h
> +++ b/include/linux/kexec_handover.h
> @@ -39,12 +39,22 @@ struct page;
>  
>  struct kho_serialization;
>  
> +struct kho_vmalloc_chunk;
> +struct kho_vmalloc {
> +        DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);

offtopic nit: DECLARE_KHOSER_PTR() *defines* a union named "first".  It
doesn't declare one.  A better name for this would have been DEFINE_...

And the world would be a better place if those three macros had a bit
of documentation ;)

The code looks nice though.

