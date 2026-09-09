Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B669C79FB6
	for <kexec@archiver.kernel.org>; Wed,  9 Sep 2026 14:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARyHcdAb0HLmyx/eDFN86Rb81gJGVIXThCIEa265DUA=; b=qcjBa5dlcBkX6REffbrdxOmiMs
	1NTV+yDswyed+SfhjlW3SLu2FCw4cZtW6NjtPWy+QEHLH8R2JM/5evUvbHiQxzXZPQcuT544zbJ1C
	oSVP+goNLq3f/dGAEWiaZrr9amCPq+OQLmxSag2CmbOTL0qGF8EPKWH2A6KRifiE+5InJpcTu7BNb
	jSQdMIvx3gknaDEMqKbVszr5euVJTFLV2KwIAEvROZu2wBoSTI7GzVPi5PdngKTfgFQaM3+x+16+d
	SBBe8Y8ShZ/kERZT4m1IE82jKZj9A7GxEDSYIbhFOPB4UyjgLNGSj4GvggwseozWHaSxgnRcUCMUr
	nPkId/PA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Iwu-0000000BtaU-2a5c;
	Wed, 09 Sep 2026 14:06:52 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Iwr-0000000BtZb-3Ik6
	for kexec@lists.infradead.org;
	Wed, 09 Sep 2026 14:06:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ARyHcdAb0HLmyx/eDFN86Rb81gJGVIXThCIEa265DUA=; b=rcsC1nVJ458PkGkasholnKxN6Y
	8410oN/kuEDXUbOFmM+71oC19ElLRGi06Vt5lELxPN2NRrvCvoeFrsuLjkPROFDyV4u3NzsHyF0Dw
	4EQKOZ0A4I5dZd4/wWWTiaK8hrAjVAFqM33pEkIiQi5D4RBK54/6Ywa0Ltduv+4JyaWasZgqS3bhm
	pPivoqW8OISS6nImyYN3ZxQ2g6tRDXdHf0LegFyAOOcbpFXay9V6Q3b6/OKIBV7i4y9Kf93r21acK
	b5ht4rH+nV412qx7B1mw5ATercq3FkeW0Sku5yJAxhNUuXQRReH+Ypx4/wZnjMY5NPNXqRIGMa9Ru
	AE5xkGuw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x4Iw9-0036hX-08;
	Wed, 09 Sep 2026 14:06:05 +0000
Date: Wed, 9 Sep 2026 07:05:57 -0700
From: Breno Leitao <leitao@debian.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Michal Hocko <mhocko@suse.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kas@kernel.org, Vlastimil Babka <vbabka@kernel.org>, 
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Borislav Petkov <bp@alien8.de>, Suren Baghdasaryan <surenb@google.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Zi Yan <ziy@nvidia.com>, Thomas Gleixner <tglx@kernel.org>, kernel-team@meta.com, 
	rmikey@meta.com, harry@kernel.org, linux-efi@vger.kernel.org, riel@surriel.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kexec@lists.infradead.org
Subject: Re: [PATCH v4 3/5] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
Message-ID: <aqFm1ep0mIlJpA-d@gmail.com>
References: <20260909-hwpoison-kho-v4-0-359313564495@debian.org>
 <20260909-hwpoison-kho-v4-3-359313564495@debian.org>
 <20260909132128.AD4D01F00A3A@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909132128.AD4D01F00A3A@smtp.kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_070649_825969_00D7276E 
X-CRM114-Status: GOOD (  12.75  )
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

On Wed, Sep 09, 2026 at 01:21:28PM +0000, sashiko-bot@kernel.org wrote:
> > --- /dev/null
> > +++ b/drivers/firmware/efi/poison.c
> >
> > +	/* Whole words, and a bit count that can be taken without wrapping. */
> > +	if (!pm->size || !IS_ALIGNED(pm->size, sizeof(unsigned long)) ||
> > +	    check_mul_overflow(pm->size, (u64)BITS_PER_BYTE, &nbits))
> > +		return false;
> 
> [Severity: High]
> Does this validation fully protect against an excessively large pm->size?

I was clamping the table before, but we decided to drop it in the last
revision. See the discusion in here:

https://lore.kernel.org/all/apGWUWi5-RbhFHpe@thinkstation/

> > +	start = PAGE_ALIGN_DOWN(efi.poisoned_memory);
> > +	end = PAGE_ALIGN(efi.poisoned_memory + sizeof(*pm) + pm->size);
> 
> [Severity: High]
> Can this computation wrap around if pm->size is maliciously large?

Yes, but that means that someone was able to write to EFI memory to
update size?

I can definitely BUG_ON() on "large"  pm->size, but, I don't think this
is what we want here.

