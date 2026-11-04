Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7AE606A326
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=BvkxpjRy;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=jgdm78Gz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9is/N8s+P77nIizr4iOPWVN8ElLFZtGDMyfkjPVV7ok=; b=BvkxpjRytPrTGzcerMtJPIeXys
	Azv5eWVu9H8P6PEaAL0wYt8D0GWkl8GyLMc2E9fq5BfPMuoXhZc7T6I9dzE95820oVMmWT4T45yr3
	VVI5FtDJ3xN6KfpiNja8Klr4p8OywlMtTsW6y9SdxBq0ISq69E22EuGxghJ2WMKfjEcCqIDn3rQZF
	qq2h5QAadd9Rw2s8f4AmzBhNDzLqAXj9UD46FA9f+90VE4wMiJbGo/Nom9SgTgS3eqgiocgM+/jTK
	H0a/LtMm/lJ583hwB0x8BjeyiRDDoi2h0AGMcaW9Nfx4tqRrPIPAnPPRgMGt9Xf5Hgb14d0FKuh1R
	m3VWBZJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZAj-000000059rl-32kP;
	Wed, 04 Nov 2026 11:28:53 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZAh-000000059qp-2sLh;
	Wed, 04 Nov 2026 11:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9is/N8s+P77nIizr4iOPWVN8ElLFZtGDMyfkjPVV7ok=; b=jgdm78Gz9UGB9lEHqxYvlou0CF
	KutGa9kqLufeOHXyPksfalr8TGDd7Qjd3tQH2L7oBQHupX+kTlaaKzW1afMCyCYUaiJJ2iGGB70oX
	yUwrmnE7OVoMMYHZNTAmgbJKDUS5vKef2pVnD0LoEXB9jvIDd7ptVKguMRqbrtt0cXmhCr/XvjZAb
	7Gy6NMigdFntWPLB7BRi98TVcjr6fDcS6ocN6VGuh0+C8sJnMrobb1gCe0+zouonWA3lnpu1nkE8h
	RQ+Voe4lQl/aCzyPhyOrVaick563cL76U22efAn/kPb650EoOY0iEXzUm6cLk6F9GHhuBZQp4RtUI
	ZHYjfeYQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xOZA6-007g5u-2T;
	Wed, 04 Nov 2026 11:28:15 +0000
Date: Wed, 4 Nov 2026 03:28:06 -0800
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, kas@kernel.org, 
	kexec@lists.infradead.org, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, shakeel.butt@linux.dev, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, rmikey@meta.com, riel@surriel.com, harry@kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v6 3/7] mm/memory-failure: add hwpoison_boot_page() to
 flag an inherited frame
Message-ID: <ausWvcPv20yznl_8@gmail.com>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-3-f304255147da@debian.org>
 <aumt-4kfGGtoXuh-@kernel.org>
 <aumvVjoHo4KeuyEp@gmail.com>
 <auovL7i1rEcXCeGS@kernel.org>
 <auo3ScXy6dk0Gr3-@gmail.com>
 <ausLkNhb8ZPz0ra_@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausLkNhb8ZPz0ra_@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_032851_743490_3030A247 
X-CRM114-Status: GOOD (  23.04  )
X-Spam-Score: -4.4 (----)
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

On Wed, Nov 04, 2026 at 12:40:16PM +0200, Mike Rapoport wrote:
> On Tue, Nov 03, 2026 at 11:49:44AM -0800, Breno Leitao wrote:
> > On Tue, Nov 03, 2026 at 08:59:59PM +0200, Mike Rapoport wrote:
> > > On Tue, Nov 03, 2026 at 02:06:17AM -0800, Breno Leitao wrote:
> > > > On Tue, Nov 03, 2026 at 11:48:43AM +0200, Mike Rapoport wrote:
> > > > > > --- a/mm/internal.h
> > > > > > +++ b/mm/internal.h
> > > > > 
> > > > > We've been splitting internal.h to smaller headers, maybe it's time to add
> > > > > "memory-faulure.h"?
> > > > 
> > > > Ack. I'm happy to move the "mm/memory-failure.c" section out of
> > > > mm/internal.h into a new mm/memory-failure.h, as preparation for this
> > > > patch.
> > > > 
> > > > Since this patchset is moving slowly, I'll start the header split in
> > > > parallel as a separate series, and rebase this patchset on top of it
> > > > when I respin. Is it this ok?
> > > 
> > > Sounds good to me.
> > > 
> > > Just be aware that MM folks are knee deep into fixes this cycle, so both
> > > sets could be moving slowly :)
> > 
> > Appreciate the heads up. In that case, should I hold off on the header
> > split until the next cycle instead of starting it now?
> 
> I believe one header split patch is small enough and not controversial to
> have it this cycle.

Ack, on it!

Thanks,
--breno

