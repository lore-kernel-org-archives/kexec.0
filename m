Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27D8CED63B
	for <kexec@archiver.kernel.org>; Tue, 18 Nov 2025 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TprChO0f6bKa/OkInckoXb38IeGLCxVtCRhDnKcSsvg=; b=ZzvIYYXaAr+M0NycR4AbdUh3pr
	JkXGPNzPeRlMDiOg9M9VVLcvP3H2F6a1nj7vVuaziJ9PBfv5t3kIxBBIkJs/tg4y9orkKY9PkC0TO
	whZfz26OTqTxftONZK7eiWItsTYvY3AUtvyeEidlfrNFpQDLBEEb4E3QjUgUmKtJDdiAZZaz//Bxc
	4MK9/EhCP/KokP29YttGNXJ+jusKM1pJoVq9TNeTpSisoo+U2XFSblfP7TQTI8KhjfmNn8DGkhTzf
	OzqbNCm2lPNd1Lnd/iIilvi9tLXzKAMsfxQhLrW40oFkSBiXRvlgY0flfAbwDBBzkHwquUcX7upfn
	9umgd9tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLLck-00000000Sp8-0NsV;
	Tue, 18 Nov 2025 13:19:58 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLLci-00000000Soy-45dq
	for kexec@lists.infradead.org;
	Tue, 18 Nov 2025 13:19:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 115D260194;
	Tue, 18 Nov 2025 13:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A61BCC116B1;
	Tue, 18 Nov 2025 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763471995;
	bh=xEfBSU/j2FGHLktRs1aJpVOnTyEUSa7gj3GAPsupGvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hV0NNWczFRQTiTZisfgnxT6TTqxqtFrXjsbKyb/0jDkDe2CrpBvZ/G2YqiqGlBI73
	 R4nzPN9VYeC/GXv7mcuEy/aD8p3BqFLyJP0Wp38xjy/VF2tuBQ196NHv3yELc6DNAA
	 wxBNAGkleKSIxy4uCkWPWnfh63pe4dskhjxYuQQrRxt6dzcA/yAO6cAYO6bcae5Sx1
	 4x3W6yvi8ew5rSru0nUcozzx1O6R5QI68W9WqQlPMyktTnruNnWGFFM/3afmir6ohQ
	 tTvgMSpyOzhGJfSD452gMmMLUV94nA1bhEUDFYTdB8eSuCpk/d2tM7D2RyFxb4dtG1
	 cz6tdOvb1RJQA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  akpm@linux-foundation.org,  bhe@redhat.com,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 04/13] kho: Verify deserialization status and fix FDT
 alignment access
In-Reply-To: <aRhJk_Glv2pX2dRo@kernel.org> (Mike Rapoport's message of "Sat,
	15 Nov 2025 11:36:19 +0200")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-5-pasha.tatashin@soleen.com>
	<mafs0tsyw7e0a.fsf@kernel.org> <aRhJk_Glv2pX2dRo@kernel.org>
Date: Tue, 18 Nov 2025 14:19:50 +0100
Message-ID: <mafs0qztv4gw9.fsf@kernel.org>
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

On Sat, Nov 15 2025, Mike Rapoport wrote:

> On Fri, Nov 14, 2025 at 05:52:37PM +0100, Pratyush Yadav wrote:
>> On Fri, Nov 14 2025, Pasha Tatashin wrote:
>> 
>> > @@ -1377,16 +1387,12 @@ static void __init kho_release_scratch(void)
>> >  
>> >  void __init kho_memory_init(void)
>> >  {
>> > -	struct folio *folio;
>> > -
>> >  	if (kho_in.scratch_phys) {
>> >  		kho_scratch = phys_to_virt(kho_in.scratch_phys);
>> >  		kho_release_scratch();
>> >  
>> > -		kho_mem_deserialize(kho_get_fdt());
>> > -		folio = kho_restore_folio(kho_in.fdt_phys);
>> > -		if (!folio)
>> > -			pr_warn("failed to restore folio for KHO fdt\n");
>> > +		if (!kho_mem_deserialize(kho_get_fdt()))
>> > +			kho_in.fdt_phys = 0;
>> 
>> The folio restore does serve a purpose: it accounts for that folio in
>> the system's total memory. See the call to adjust_managed_page_count()
>> in kho_restore_page(). In practice, I don't think it makes much of a
>> difference, but I don't see why not.
>
> This page is never freed, so adding it to zone managed pages or keeping it
> reserved does not change anything.

In practice, sure. I still don't see a good reason to _not_ initialize
the page properly. It's not like it costs us much in terms of
performance or code complexity.

Since kho_restore_folio() makes sure the folio was _actually_ preserved
from KHO, you have a safety check against previous kernel having a bug
and not preserving the FDT properly. And I get that the FDT has already
been used by this point, but at least you would have some known point to
catch this.

[...]

-- 
Regards,
Pratyush Yadav

