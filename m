Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A769BCEE33B
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 17:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAuXzOsPqw0m0YAW+RsjDAL9ltpp0Z9O6eBfwFHYa0s=; b=az0hlkxfSJFL9QcNvrRlDqtmOh
	T5rPEikif/e9jf27zp7aBracesCVDvaj+tvLQtE2EgynuzZETsRladdlZxw9Rie+Tj+gC7+m9IZiy
	AGDvFG6wBthXchakFaOZuEMqXkSUp6pXtkohZubgMjsGvls2CvPAkVf9QDfcMgtdpYH5/hS5Yma1q
	CyLdL2a6bNAwZBlpACQ2zsB/TniaLLl0g0vXV+5vS2j5yx6+f1Pk9T/UTM05JjFUVTzZMGhHmebtv
	JfnYSzSnBlZTm1yEsCqLkKQti8Hgozo6MeEtGcCGoijkVQyfvMt9ZkiUCui1iu5KajP5jrsAsuCdn
	qQnJoUkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLPEp-00000000pCb-3hp7;
	Tue, 18 Nov 2025 17:11:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLPEo-00000000pCK-3lSR
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 17:11:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F259C60C08;
	Tue, 18 Nov 2025 17:11:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C666C2BCAF;
	Tue, 18 Nov 2025 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763485889;
	bh=5JkkdNYQ6lS2Vy4m/7JD+soJwbTsSsI1qxv44jf5Qxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q45YUTFmc2JS/qJay40kgKnFUmQ23dQg0nbzqsc4QhJBmpbi1vTPRw6OWwKG4BUcX
	 5BB5rsvuq3xfamLRyekbtfqb5Qq96QILIPWV9ShluHdJqk6L9RaKTwE07NTJBVpN6l
	 5/6dj8Q1ySwBu0wJdfpl/NMdhwU/fXYcZS/0AhE6+5SYEDR3kPJmeH+ya98T3ciyrH
	 asJ1TaOt7XbkJEtOe7PWaipWGFnIjO8gZEQOVRVgdx6Kkay1IA0WdBQhqgno8pkkKL
	 T22fiGxggOUmugSmDqvIFlJx8Qn6vRwPchjhMg7GDxxLmb+KfGjx0t0aiD+8qjyhm9
	 7+6cJWGnwV8LA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Mike Rapoport <rppt@kernel.org>,
  akpm@linux-foundation.org,  bhe@redhat.com,  jasonmiu@google.com,
  arnd@arndb.de,  coxu@redhat.com,  dave@vasilevsky.ca,
  ebiggers@google.com,  graf@amazon.com,  kees@kernel.org,
  linux-kernel@vger.kernel.org,  kexec@lists.infradead.org,
  linux-mm@kvack.org
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
In-Reply-To: <CA+CK2bDfrx21=Aw3pwPn4=AKGVeh0O+sB5gp8rvh0fk8C_nsdw@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 18 Nov 2025 10:25:37 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-5-pasha.tatashin@soleen.com>
	<mafs0tsyw7e0a.fsf@kernel.org> <aRhJk_Glv2pX2dRo@kernel.org>
	<mafs0qztv4gw9.fsf@kernel.org>
	<CA+CK2bDfrx21=Aw3pwPn4=AKGVeh0O+sB5gp8rvh0fk8C_nsdw@mail.gmail.com>
Date: Tue, 18 Nov 2025 18:11:24 +0100
Message-ID: <mafs0a50j466b.fsf@kernel.org>
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

On Tue, Nov 18 2025, Pasha Tatashin wrote:

>> > This page is never freed, so adding it to zone managed pages or keeping it
>> > reserved does not change anything.
>>
>> In practice, sure. I still don't see a good reason to _not_ initialize
>> the page properly. It's not like it costs us much in terms of
>> performance or code complexity.
>>
>> Since kho_restore_folio() makes sure the folio was _actually_ preserved
>> from KHO, you have a safety check against previous kernel having a bug
>> and not preserving the FDT properly. And I get that the FDT has already
>> been used by this point, but at least you would have some known point to
>> catch this.
>
> The kho_alloc_preserve() API is different from kho_preserve_folio().
> With kho_preserve_folio(), memory is allocated and some time later is
> preserved, so there is a possibility for that memory to exist and be
> used where it is not preserved, therefore it is a crucial step for
> such memory to also do kho_restore_folio() before used. With
> kho_alloc_preserve(), when the memory exists it is always preserved;
> it is gurantee of this API. There is no reason to do
> kho_restore_folio() on such memory at all. It can be released back to
> the system via kho_free_restore()/kho_free_unpreserve().

Even for those I think there should be a kho_restore_mem() or something
similar (naming things is hard :/), so they go through the restore,
their struct page is properly initialized and accounted for, and
make sure the pages were actually preserved.

Using the memory without restoring it first should be the exception IMO.

-- 
Regards,
Pratyush Yadav

