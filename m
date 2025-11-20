Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58A1CF8840
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t1L78JWdnbTPwOev7eMJ4Yi1EfrBBlfXmTcOPyqNKVg=; b=u4hl7IOhDUf8Z0FK2QjJONv2mT
	So26DSz9DPtuJ0spCbdj08aWUcn0xkeIuE6Kax5quMiGFoq71+9j+8THQrg6L788/EYPjwNKZIDPe
	xmUHK7hW+ovUfka6nqIQO7S3qli7emTtkHsIF8OZJhBXLkztH7HjITB5z0DgFmK4Sk+D2Gsi8kAK2
	P7WykpFJxKZ4qnkuOFNVT4UaYS0SXpcHDEw0ZYOPWKSj+tE5gVcoEogfezd1oWNBULPr6AGAUHQBH
	upsbUqOXE5rEgM4OFm1DXtWNWbfe69J7gJ7j0vM8s52G98vHRaaFoe1BZwlR6r8RzzFU0jOdmaqTu
	dtUB9BOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM24a-00000006WPc-2xf0;
	Thu, 20 Nov 2025 10:39:32 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM24Y-00000006WPF-28I2
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 10:39:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6754844303;
	Thu, 20 Nov 2025 10:39:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E52C5C4CEF1;
	Thu, 20 Nov 2025 10:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763635169;
	bh=znEBJZ6KVjGxzXOPPFRsG2pfUqSyfqKNp3vpnt4GJOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+NMVcBnQBzC7bjU9SGmlKCg9QD1FjOqHhljO7/dgmuvdk6VrTEKwWCW4phwfHHd8
	 PB3TCRF0Zex+ImdB5soewloNhAA6U9XfQmF+FVBbt0wyqpGM3lMM6z48PXFeXL5gDu
	 oJHDekD5xXDH236W2gsv2C379JPZuS3UyL9zMlS2KjQF5bPKguchJ3gVDC43qr1cLM
	 zIoixbl2+j+a3DuJYs9R6KwP9+Vu2T/aHyyqC7tnGm+Bo/2VnFXgvtKzcowKux1Urs
	 B9lLldl/SE9NXZ6sEEqCAuT+5Cm6KFGrg8iX0WFXCJV3QfpwtPoD0hHRKo0f7BTyO3
	 A5dE/feCtJxBQ==
Date: Thu, 20 Nov 2025 12:39:21 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
	bhe@redhat.com, jasonmiu@google.com, arnd@arndb.de, coxu@redhat.com,
	dave@vasilevsky.ca, ebiggers@google.com, graf@amazon.com,
	kees@kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
Message-ID: <aR7v2VyYfs2HAUbW@kernel.org>
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
 <20251114155358.2884014-5-pasha.tatashin@soleen.com>
 <mafs0tsyw7e0a.fsf@kernel.org>
 <aRhJk_Glv2pX2dRo@kernel.org>
 <mafs0qztv4gw9.fsf@kernel.org>
 <CA+CK2bDfrx21=Aw3pwPn4=AKGVeh0O+sB5gp8rvh0fk8C_nsdw@mail.gmail.com>
 <mafs0a50j466b.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0a50j466b.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_023930_568769_56EDB928 
X-CRM114-Status: GOOD (  27.32  )
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

On Tue, Nov 18, 2025 at 06:11:24PM +0100, Pratyush Yadav wrote:
> On Tue, Nov 18 2025, Pasha Tatashin wrote:
> 
> >> > This page is never freed, so adding it to zone managed pages or keeping it
> >> > reserved does not change anything.
> >>
> >> In practice, sure. I still don't see a good reason to _not_ initialize
> >> the page properly. It's not like it costs us much in terms of
> >> performance or code complexity.
> >>
> >> Since kho_restore_folio() makes sure the folio was _actually_ preserved
> >> from KHO, you have a safety check against previous kernel having a bug
> >> and not preserving the FDT properly. And I get that the FDT has already
> >> been used by this point, but at least you would have some known point to
> >> catch this.
> >
> > The kho_alloc_preserve() API is different from kho_preserve_folio().
> > With kho_preserve_folio(), memory is allocated and some time later is
> > preserved, so there is a possibility for that memory to exist and be
> > used where it is not preserved, therefore it is a crucial step for
> > such memory to also do kho_restore_folio() before used. With
> > kho_alloc_preserve(), when the memory exists it is always preserved;
> > it is gurantee of this API. There is no reason to do
> > kho_restore_folio() on such memory at all. It can be released back to
> > the system via kho_free_restore()/kho_free_unpreserve().
> 
> Even for those I think there should be a kho_restore_mem() or something
> similar (naming things is hard :/), so they go through the restore,
> their struct page is properly initialized and accounted for, and
> make sure the pages were actually preserved.
> 
> Using the memory without restoring it first should be the exception IMO.
 
Base KHO and LUO FTDs are such exceptions for sure :)
We have to use them way before we can even think about restoring.

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

