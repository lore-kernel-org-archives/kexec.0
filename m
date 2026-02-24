Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78F4F4BB6F
	for <kexec@archiver.kernel.org>; Tue, 24 Feb 2026 18:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=94dHBgPUUePVak/rdKND5FHtTqnQ1dk37LGw+ZurhKA=; b=W+s1lIp0arPMBcJPfN0XPKXKmy
	2fX/ChrfdvJwKaWhtwU1uIXE8heP0f1dYlxS0oh6EJlXNRl6chhuYgL5Ij3L3Wa1NJsC26ZeP87j4
	2gxgtjr8ELD+xL+7VxjXKjCZIMexvy8wW9v/YQ1zF7MtjDH0Em67SvadfbsVCBy1lTcsr+ds1I+da
	pSYCAB2xl6Rso+kMeCumdlEGl+M0nSqPecHhxO/5IKsdQzUnh4khC+4/ONwPVrhzlLjooHY3U/aTS
	+MB+WPe9vnkqmEHGQnf3Sb/pP4btAkV5r+w1Mzzn9pz5akbdhQ7gOtG0upio2pUn42U/lq4SEoI6E
	Qs7m6O0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxAw-00000002ddW-2yKc;
	Tue, 24 Feb 2026 18:30:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuxAu-00000002dbr-2SDu
	for kexec@lists.infradead.org;
	Tue, 24 Feb 2026 18:30:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4DB5A405CB;
	Tue, 24 Feb 2026 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60B9C116D0;
	Tue, 24 Feb 2026 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1771957823;
	bh=03PWhkdD8XDT0HwrAZ3Kruf1L2fD8kllDVsuQ4ULThU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QzewLFPnkpX7XAGPNb46J/oYeLhg5Sbv+ZU8d9yddomnEJo9fjEr5oS+/uBoPGdbY
	 Lj49QjcIUmAeMDTIvDm/o5GnhotGNYBku3on7Y6MDic3ueaVl+AzkGOgdckoqtM/Hl
	 0/vSzVPpaatfu/u2upS2JH4WXD2WWiBfogTyTue0=
Date: Tue, 24 Feb 2026 10:30:22 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Michal Clapinski <mclapinski@google.com>
Cc: Evangelos Petrongonas <epetron@amazon.de>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, Pratyush
 Yadav <pratyush@kernel.org>, Alexander Graf <graf@amazon.com>,
 kexec@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] kho: make preserved pages compatible with
 deferred struct page init
Message-Id: <20260224103022.37b8b6d1cd11e11aef192c87@linux-foundation.org>
In-Reply-To: <20260220165203.3213375-3-mclapinski@google.com>
References: <20260220165203.3213375-1-mclapinski@google.com>
	<20260220165203.3213375-3-mclapinski@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_103024_672944_87617EBB 
X-CRM114-Status: GOOD (  13.92  )
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

On Fri, 20 Feb 2026 17:52:03 +0100 Michal Clapinski <mclapinski@google.com> wrote:

> From: Evangelos Petrongonas <epetron@amazon.de>
> 
> When CONFIG_DEFERRED_STRUCT_PAGE_INIT is enabled, struct page
> initialization is deferred to parallel kthreads that run later
> in the boot process.
> 
> During KHO restoration, deserialize_bitmap() writes metadata for
> each preserved memory region. However, if the struct page has not been
> initialized, this write targets uninitialized memory, potentially
> leading to errors like:
> BUG: unable to handle page fault for address: ...
> 
> Fix this by introducing kho_get_preserved_page(),  which ensures
> all struct pages in a preserved region are initialized by calling
> init_deferred_page() which is a no-op when deferred init is disabled
> or when the struct page is already initialized.
> 
> ...
>
>  static void __init deserialize_bitmap(unsigned int order,
>  				      struct khoser_mem_bitmap_ptr *elm)
>  {

Doesn't exist any more!

Can you please rework, retest and resend against mm.git's mm-new
branch?

	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Thanks.

