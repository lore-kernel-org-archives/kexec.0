Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213F3CE8D60
	for <kexec@archiver.kernel.org>; Fri, 14 Nov 2025 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKcxNQOkeCc2qD0o2ipVqo2oXYeeJXxmlFCanUNhjhs=; b=z8LwFJURJZmH2KUyF2Rmphi3x0
	3EuAIqWeg/aumOOyVL+YLfz7qjCzk2CSI8qt3qasuk3/C2PlFkeXg9wBAPzUiFeGQ5WwFRVMZOJd5
	MhGhn6chgIHpIf6Xv1Vy8fJXMSwRCiuX5RNmzmBj5JqGzdr19OhDvG6ZHSteEoYzTaoIOxngRWPZH
	e+5OQyMRxJnlKLmNOs8Cv92OtqsGric67h+zYwSSCfmHzltzbbBKHUgDcZbWYf3yUwaekT6tfg9a3
	6fMBOXpGiNMSkALVMRr6pLG+7RQM1yXB5/g0YU9rumBXX5MojQuKtb0E4Musz93aDtZDhalYEBl4P
	dPyvI0Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxKr-0000000Covq-1rPV;
	Fri, 14 Nov 2025 17:11:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJxKo-0000000CovU-3mq5
	for kexec@lists.infradead.org;
	Fri, 14 Nov 2025 17:11:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83C7C43DC1;
	Fri, 14 Nov 2025 17:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 799B0C19421;
	Fri, 14 Nov 2025 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763140302;
	bh=KdPt1kVDnO95rsL6NNliJLGFmzAdmIAIkvZWlvYKdMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZnGKWdc4OQi1TdjZMUR3LD+7juKVZGWAyYe7+QViXFa622INTWRgLE2O2tKFoud9V
	 4/xbf0zjrd94xc1uXIcj2JcfJLYyr510GciQM0aRN2+l62sLj/IoA/ZUmjIz0T5J3B
	 SiZ6ocVCyj6QF0H8wrF/kyCII1RA/CxSw32+JrUEbsbG6154KLapkjVZKkOpeMHI2m
	 hYglF1n7c3oAjwTRpnzhB8cVs00W6orwNGzoaOj3bL272GRmBLVwmtPWC3RCxSdpBk
	 z8yJipGkv0JrgzvsfE5pyda5kuDXq9ic8Jnb9ydHxK5wmMxwpS7cSZcbQNOvFsGGt6
	 4XUgQkdy6dzSQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org,  bhe@redhat.com,  rppt@kernel.org,
  jasonmiu@google.com,  arnd@arndb.de,  coxu@redhat.com,
  dave@vasilevsky.ca,  ebiggers@google.com,  graf@amazon.com,
  kees@kernel.org,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH v1 07/13] kho: Remove global preserved_mem_map and store
 state in FDT
In-Reply-To: <20251114155358.2884014-8-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Fri, 14 Nov 2025 10:53:52 -0500")
References: <20251114155358.2884014-1-pasha.tatashin@soleen.com>
	<20251114155358.2884014-8-pasha.tatashin@soleen.com>
Date: Fri, 14 Nov 2025 18:11:39 +0100
Message-ID: <mafs0h5uw7d4k.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_091142_957817_08B63C1C 
X-CRM114-Status: UNSURE (   8.17  )
X-CRM114-Notice: Please train this message.
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

On Fri, Nov 14 2025, Pasha Tatashin wrote:

> Currently, the serialized memory map is tracked via
> kho_out.preserved_mem_map and copied to the FDT during finalization.
> This double tracking is redundant.
>
> Remove preserved_mem_map from kho_out. Instead, maintain the physical
> address of the head chunk directly in the preserved-memory-map FDT
> property.
>
> Introduce kho_update_memory_map() to manage this property. This function
> handles:
> 1. Retrieving and freeing any existing serialized map (handling the
>    abort/retry case).
> 2. Updating the FDT property with the new chunk address.
>
> This establishes the FDT as the single source of truth for the handover
> state.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

