Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6AD5C79FA0
	for <kexec@archiver.kernel.org>; Mon,  7 Sep 2026 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6c435i0Ybwx2SpPArP3T09GV23HR1EORsj2zutcyrsA=; b=s1yT8TjQO2cOAms06mMqJmYZFs
	YcoYUxc85i14tRtokajCS4RwsuJiPRGY7EvQ9xZL5f5MyyLiQo/Ndq6HGoC/Qnn+tIx1hzxpF3WCH
	envVRnlKn5r+D/riJheIy+iRiXZ4eLAizT98P8qeUYj2ufjJg47CVBmGRreqOlat2EJe4qPUPMjCe
	zHN6oZYmM3lRgiwOFi7RY6Md2aM5OoyPHCQBbOICKFrrmcAe5Ald3UzEz4SVBYr/nbM7mjNp2p0Xh
	lEZM/p9j5BC54y6PUlgOv8PFAiPHOzLsMsQCenCz22WUbvrgfx2uDCJjT4Xh8OW1ABrtq2ah+X6X6
	PMXFKAvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3bCW-000000079ER-2zBT;
	Mon, 07 Sep 2026 15:24:04 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3bCU-000000079Dy-1Cvn
	for kexec@lists.infradead.org;
	Mon, 07 Sep 2026 15:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6c435i0Ybwx2SpPArP3T09GV23HR1EORsj2zutcyrsA=; b=TwhS7pT7b6MrSEMKFQfGDeSRIA
	mv6TiijYkOzV3ljABhwcKRIImezX6VdLF59YDNzKwVu9XJSBnGJI+8bj+Zieec2dbmSX+dI64ObiU
	C6HdX1Joy5LOL3lb5qIr5LcgDoacSanCjFIsu3Kvf6RuotHWPs8FxHINv1Mo6Jw8NyZsEJZmyioRK
	Ei8ZzeJcwumibhpITvX9zwoCt14QChw+J8HOtulb9LVA4kEShJ+v6nO0XqbRUzgWQ7L1V+pSaiCHT
	tbHwZpkOABgvU1Qwurrtp391g+wt6DKKAT7yXWR5gRPtkmNkPLKZHrevAIYTNDGTBgmBkr3mc7fuO
	e3n1TF0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x3bCK-001bGs-0M;
	Mon, 07 Sep 2026 15:23:52 +0000
Date: Mon, 7 Sep 2026 08:23:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	kexec@lists.infradead.org, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, rmikey@meta.com, riel@surriel.com, 
	kernel-team@meta.com
Subject: Re: [PATCH v3 3/5] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
Message-ID: <ap7Tup6mahjIljVF@gmail.com>
References: <20260826-hwpoison-kho-v3-0-6f79c4b605bc@debian.org>
 <20260826-hwpoison-kho-v3-3-6f79c4b605bc@debian.org>
 <apGWUWi5-RbhFHpe@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apGWUWi5-RbhFHpe@thinkstation>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_082402_329636_3EF35F83 
X-CRM114-Status: GOOD (  13.54  )
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

On Fri, Aug 28, 2026 at 03:11:10PM +0100, Kiryl Shutsemau wrote:
> On Wed, Aug 26, 2026 at 05:03:54AM -0700, Breno Leitao wrote:
> > +#include <linux/memblock.h>
> 
> Is it leftover? I don't see any memblock usage.

Yes, good catch, I will remove.
> > +#include <linux/mm.h>
> > +#include <linux/overflow.h>
> > +
> > +static struct linux_efi_poisoned_memory *efi_poison __ro_after_init;
> > +static u64 efi_poison_nbits __ro_after_init;
> > +
> > +static u64 __init
> > +efi_poison_usable_size(const struct linux_efi_poisoned_memory *pm)
> > +{
> > +	u64 nr_units = DIV_ROUND_UP(PFN_PHYS(max_pfn), pm->unit_size);
> > +	u64 bytes = DIV_ROUND_UP(nr_units, BITS_PER_BYTE);
> > +
> > +	/* Whole words: the bitmap is reached an unsigned long at a time. */
> > +	return min(round_up(bytes, sizeof(unsigned long)), pm->size);
> 
> Hm. Why bother to clamp to max_pfn? What's what's wrong with just using
> pm->size directly?

The clamp is a min(), so it can only ever make the kernel use less of
the table than the table claims, just a silly and cheap optimization.

That said, pm->size is more than enought for now, and we optimize later.

I will drop efi_poison_usable_size() completely and replace it by
pm->size.

Thanks,
--breno

