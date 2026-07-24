Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA97C531FA
	for <kexec@archiver.kernel.org>; Fri, 24 Jul 2026 16:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkpDhp8VBPqI8hSRT9Mbj+h0fN5D/FDUMTkVMZamhDA=; b=MTg5lOrDY1E6zqdFjcpUXaHbeW
	Uzn2DsttHkUzOKfzztygqbx3TK5gX3m+U+ydUjpnX3Xt3IezhlqfiD54iB2yLrPryBURQN2fZZwXB
	MdWovgNs/govrOvdYcPtNRZRL37njesqUwOIg8IT8/XpPs/gNjHtPBVUhJor8lpGJ7p3ukq1JtBbJ
	Ge1QCSvoglX5E4S8OOWY/Q0kMQ1WWbpxVykd/M8Z5aadW35Am4JXPlMuO9pqn/jg9qef0TbD+GS5k
	4XDGVmpfnf4thNV/gyAaaqz8/ZvW6wEKYsCjq3LDFJoU5zJA+VhV/wytJdPd/Hp20RvFq1liSTqG3
	4W10ZVcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ23-0000000Gs4e-1nwd;
	Fri, 24 Jul 2026 16:45:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnJ21-0000000Gs4Y-3pgj
	for kexec@lists.infradead.org;
	Fri, 24 Jul 2026 16:45:53 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 517F04373E;
	Fri, 24 Jul 2026 16:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113D11F000E9;
	Fri, 24 Jul 2026 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911553;
	bh=GkpDhp8VBPqI8hSRT9Mbj+h0fN5D/FDUMTkVMZamhDA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=oBmJQ1r5odw77YxBFbXOhrNSqncb51aVfrP6sjGnmxKA3dGrkLb8j9UiJUtE39I23
	 su3F0AF5cF3LEtk190eRP9gbWvgXoe0ztuzda3vX6XTRL+jpzZEy6o48nvj5NWnwKV
	 StsTlJ2ztUbZXhz6Fu734svC8GWjmQqYX1WUoKo6Dhpf6DxHllvKNTBiCBkc2nTyfC
	 xWWWjfbct9acr0HVc6d+M5oCSk8TE2Vk+0yHaW47waiJ8BrYrDZc16zQKvThOBWKcF
	 7NpGdzrrgLGsjpsMWwszuj0nlJxMG276KVmJEMWpuNOFvZNiDG0MX3wWmF2N1e3oEv
	 qgAuC53iR4cfA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Alexander Graf <graf@amazon.com>,  Muchun
 Song <muchun.song@linux.dev>,  Oscar Salvador <osalvador@suse.de>,  David
 Hildenbrand <david@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jason Miu <jasonmiu@google.com>,  Jork
 Loeser <jloeser@linux.microsoft.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/21] kho: return virtual address of mem_map
In-Reply-To: <178410811938.820181.15709073379301681705.b4-review@b4> (Mike
	Rapoport's message of "Wed, 15 Jul 2026 12:35:19 +0300")
References: <20260709173821.429921-1-pratyush@kernel.org>
	<20260709173821.429921-5-pratyush@kernel.org>
	<178410811938.820181.15709073379301681705.b4-review@b4>
Date: Fri, 24 Jul 2026 18:45:49 +0200
Message-ID: <2vxzse58gwua.fsf@kernel.org>
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

On Wed, Jul 15 2026, Mike Rapoport wrote:

>> kho: return virtual address of mem_map
>
> It's not really clear from where ...
>
>> Currently it is only used by kho_populate(), which doesn't care whether
>
> ... and where it is used ;-)

Here's what I changed the whole thing to:

    kho: return virtual address of mem_map from kho_get_mem_map()

    Currently the preserved memory map address is returned by
    kho_get_mem_map_phys(). It is only used by kho_populate().
    kho_populate() doesn't use the actual value. It only cares that the
    address exists and is valid.

    In coming patches, more callers will be added, all of which will need
    the virtual address of the preserved memory map. Since kho_populate()
    doesn't care about the actual value and only cares about validity, it
    can also use the virtual address returned by kho_get_mem_map(). It only
    needs to make sure the returned value is not NULL.

    Rename kho_get_mem_map_phys() to kho_get_mem_map() and return the
    virtual address of the preserved memory map.

-- 
Regards,
Pratyush Yadav

