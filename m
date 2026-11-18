Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1BB606A32A
	for <kexec@archiver.kernel.org>; Wed, 18 Nov 2026 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WPPPC2i8;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=vUvwXW2W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YxfLuSOt8ET85QiZh6OvB/zGAowvN5z/7eyIr5ItJTU=; b=WPPPC2i8hxMz1q
	SZ/coIuRJpwOwLLXEw3Tkw7PIFgB7DnTYS6Nh/SjktoWBhe0Lz3CWbHrFraJDy2XizUYKw6VxY0Fh
	wlEXQAsRuu/76QHTfTwk4Fvp/BqE/ZBgJZTZKqvOKEbJrizM3VUYbINGrotggVb79OuDNLRP1dJs4
	X9Trm5aNTdGrkgfKePdTXpnNOnqfZXi2SJvKgvQLaIle2tKMLjYNo5dVALGwqwk/lELNcaRSuLOwI
	UpB9mi4I/fA8JAZFyEcEJwVnZ8+t0xvuyQNZzXKr5SqaGe/JJMKU5Cgr7Sb5uxANAzRbjo9mKEHUU
	oCRNQl00bMnmvcQ8C5KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTa2A-0000000802u-46dO;
	Wed, 18 Nov 2026 07:24:47 +0000
Received: from canpmsgout03.his.huawei.com ([113.46.200.218])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTa27-0000000801i-0D87;
	Wed, 18 Nov 2026 07:24:45 +0000
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YxfLuSOt8ET85QiZh6OvB/zGAowvN5z/7eyIr5ItJTU=;
	b=vUvwXW2WIA+PKi7kpUQn/IdJA3tUeSnR/DAy6nHLaKc51qgaH4uezVDugKTwg71dSQ0iQnYz5
	7qfqxPWENL8AfnzkCAe0uglj9oduqtAzDO52wcZSeb5b7e7OqW+v6g0PKUzKYgC0I/sddQ8CfqM
	XuwpFrFNaB2bAcjdpHKAdqo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4jTtPZ0n3fzpSyt;
	Wed, 18 Nov 2026 15:23:46 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id D205D4056E;
	Wed, 18 Nov 2026 15:24:35 +0800 (CST)
Received: from [10.173.125.21] (10.173.125.21) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 18 Nov 2026 15:24:32 +0800
Subject: Re: [PATCH v6 7/7] mm/memory-failure: efi: record hardware-poisoned
 frames into the poisoned-memory table
To: Breno Leitao <leitao@debian.org>
CC: <linux-efi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
	<driver-core@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<rmikey@meta.com>, <riel@surriel.com>, <harry@kernel.org>,
	<kernel-team@meta.com>, Ard Biesheuvel <ardb@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
	<liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, Oscar Salvador
	<osalvador@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, <kas@kernel.org>,
	<kexec@lists.infradead.org>, Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	<shakeel.butt@linux.dev>
References: <20261016-hwpoison-kho-v6-0-f304255147da@debian.org>
 <20261016-hwpoison-kho-v6-7-f304255147da@debian.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f04d766b-2942-3627-14b4-dc3c88c899dd@huawei.com>
Date: Wed, 18 Nov 2026 15:24:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016-hwpoison-kho-v6-7-f304255147da@debian.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 whupemk100004.china.huawei.com (7.152.185.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_232444_212468_A5CAC2A0 
X-CRM114-Status: GOOD (  17.38  )
X-Spam-Score: -3.8 (---)
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
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/10/16 20:15, Breno Leitao wrote:
> When memory_failure() reports the outcome of a hard offline, set the
> frame's bit in the LINUX_EFI_POISONED_MEMORY bitmap, so that the next
> kernel reserves its unit.
> 
> Hook action_result() ahead of the statistics guard. A hard error on a
> frame that was soft-offlined earlier comes in as MF_MSG_ALREADY_POISONED,
> which skips the statistics, but it is a real failure and has to be
> recorded. MF_MSG_PFN_MAP is left out, as it is not System RAM.
> 
> A bit is only ever set, never cleared (for now). Several frames share
> a bit, and an unpoison cannot tell whether the unit as a whole is good
> again. That is a known limitation.
> 
> The table is mapped with memremap() from an early_initcall rather than
> through the direct map. On arm64, mem= and the usable memory range of a
> crash kernel trim memblock, which drops the table's pages from the direct
> map, and the first recorded error then faults.
> 
> Recording is skipped on a host with SME active. The stub writes the table
> in the clear, so reading it back there needs a decrypted mapping. That is
> left for a follow up.
> 
> memory_failure() has already taken the frame out of this kernel's
> allocator, so only the cross-kexec record happens here.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

For memory-failure part:

Acked-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.


