Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD96CAC59A
	for <kexec@archiver.kernel.org>; Thu, 18 Sep 2025 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SP9Tkq781weXzJ71+Pgl2qUYzdvsA9gnTsj+eVn6UVU=; b=lYHg1jMEaVO4hnLCtkxWZgtpPe
	mbMEGgjdluX3a3vj0FWl5I+QIEI84col2d/zZwtCudNgElaMxawN6NjLf1BW9qaiVf+D/thwDU94j
	VbTSm9qhb9Y5hz9FmWjNseKJslymbSy8x0vntXvOLNRRdouSdkBslOmjKn0BtJN2HrZxuXWbt3/K7
	hPwSEVbu/Afxa5kN6BflKM1CIQKRXh4JASLreaeepAHnSD0cvu/lNYX4lJz+KjRRvYX0z2TyqPiUl
	pj5itmlbgRBwhPykg0MVEiQrqESRgweMKAHHJS/JxeDEmMglwa8OwV6MKSb7jNQhfatZTGlESCnKH
	TO7C0AtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBxi-0000000H5n6-0CLO;
	Thu, 18 Sep 2025 10:34:02 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzBxg-0000000H5mj-26BV
	for kexec@lists.infradead.org;
	Thu, 18 Sep 2025 10:34:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E790B60209;
	Thu, 18 Sep 2025 10:33:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3183C4CEEB;
	Thu, 18 Sep 2025 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758191639;
	bh=OD7Mw5ZrocAdW5s9yeVVSt6xbyWWtkvp2zc8JMWiBZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BNruJSl8/KBB4up6PyP7UWp7d2fZ5VU2Y7JJ1RtQGHBcbm77xK8Nfa5Lpq0oVgeZY
	 wpAOm0qMeB4ZWzHGR2SFWAEPXE1VE2c3StJdhOyfwfKSs/dSinzWr9/4pyQYgp+8Jp
	 inT9VKwXqiT20OdmMqpanrVonSLTSVvGE9c/QgevrkvFYrruo6hwR3F8j+9vkz3dvm
	 y7M/lBBSlTGAPU7sg78PK8tjzGhik4XUg5NzFqMXb9sRa4eAQMncVyvgbPhUH6sVKn
	 QQfiOzYZBOOG8LEYn0iBVCw7kH3ZFCC12NrIRjeg8RwNp56GSHhX26Xyrv235hMrBZ
	 XDSxHqb8lOjnA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Alexander Graf
 <graf@amazon.com>,  Baoquan He <bhe@redhat.com>,  Changyuan Lyu
 <changyuanl@google.com>,  Chris Li <chrisl@kernel.org>,  Jason Gunthorpe
 <jgg@nvidia.com>,  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush
 Yadav <pratyush@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] kho: add support for preserving vmalloc allocations
In-Reply-To: <20250917174033.3810435-4-rppt@kernel.org>
References: <20250917174033.3810435-1-rppt@kernel.org>
	<20250917174033.3810435-4-rppt@kernel.org>
Date: Thu, 18 Sep 2025 12:33:56 +0200
Message-ID: <mafs01po4gicr.fsf@kernel.org>
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

On Wed, Sep 17 2025, Mike Rapoport wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> A vmalloc allocation is preserved using binary structure similar to
> global KHO memory tracker. It's a linked list of pages where each page
> is an array of physical address of pages in vmalloc area.
>
> kho_preserve_vmalloc() hands out the physical address of the head page
> to the caller. This address is used as the argument to
> kho_vmalloc_restore() to restore the mapping in the vmalloc address
> space and populate it with the preserved pages.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

