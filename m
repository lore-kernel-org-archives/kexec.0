Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2968A606A33A
	for <kexec@archiver.kernel.org>; Wed,  4 Nov 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=dElQIs3h;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTuJgPLh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=PFO6n7YvwMi4NU0WsSwg3JV5MxCZrjERTzdE+It3Nco=; b=dElQIs3hA94EBJaHMcutTKQec1
	X7BV7AQsw6W3cl/1bRcTZ4+DYGjnPeY6V033gZ7+2bS2noCs7UQ2qTvR656As56L8Ih/mWaZcMj6g
	Y3ZvBAvg5DiYmA8kbisAFGRvoyBBIyHDxu62Pqq5Sqpp+zmpSJwY7rPN+ACyFUiYd+INEgs8pJ98E
	d7DVOIZUntDc742LuY58h7krja3wrL0w/w2aluYqzIeNHATJ0KTTS1HEZc3Ny9oNTDmTjFad13mCh
	rNbW7BmliestDYIHZ9FWcCZv75obCl+aLksQ17gUqUb/TkKlIISPMaECQL51GeNHlXps6xu8Jesj9
	65o82dXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOaDN-00000005LOD-2VkS;
	Wed, 04 Nov 2026 12:35:41 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOaDL-00000005LNw-1f2P
	for kexec@lists.infradead.org;
	Wed, 04 Nov 2026 12:35:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BF3FD60F3C;
	Wed,  4 Nov 2026 12:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204001F00919;
	Wed,  4 Nov 2026 12:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793795738;
	bh=PFO6n7YvwMi4NU0WsSwg3JV5MxCZrjERTzdE+It3Nco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iTuJgPLh5PToKdG49zOOVGH+CQ5Jys5z+yon0oacjCMpG3mh7Huv/U7eeplq8Y/4T
	 GDeSwjJNvN2jmjilE8nwtasTYSExBga0xXx/eUBVa64gQ9G+BQyFV+JQtMkZ45fKWn
	 vetmLgnio3ES0nDRWx1FQGPvJ2KDpxE62qLURkN+atkAyL+E1OCENc7QWMVsobG3Hg
	 IFvB1WyFF8tMfYZKgkfKSFe4/fR5XDUYh/NuVMDndBIdcyOv4fPkC450V+FDNyPGV1
	 wJvr4tyZ2wG2NiH8747tItOCsS1x6aqhw5LvR9qgZPbDqZS0w4w9pylKndJjVeyBl5
	 Jxl/jzq3Cgkuw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pratyush@kernel.org,  graf@amazon.com,  kexec@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  pasha.tatashin@soleen.com,  rppt@kernel.org
Subject: Re: [PATCH] kho: Skip zero-sized bootmem areas
In-Reply-To: <20261027074028.13042-1-cp0613@linux.alibaba.com> (Chen Pei's
	message of "Tue, 27 Oct 2026 15:40:25 +0800")
References: <20261026131851.9942-1-cp0613@linux.alibaba.com>
	<2vxzld7kpmmi.fsf@kernel.org>
	<20261027074028.13042-1-cp0613@linux.alibaba.com>
Date: Wed, 04 Nov 2026 13:35:35 +0100
Message-ID: <2vxz8q38lqp4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Chen,

On Tue, Oct 27 2026, Chen Pei wrote:

>> Do you see zero sized lowmem or global scratch in practice? If yes,
>> how? What's your setup?
>
> Yes. Enabling KHO for riscv64 gave me three cases. They differ in which
> size ends up 0 and in what it costs, and all three are measured:
[...]
>
>> Note that I already fixed this for per-node areas since those do end
>> up with no allocations with movable_node set [0].
>
> That one covers the per-node loop only; lowmem and global are still
> unconditional in linux-next today, which is what cases 1, 2 and 3 above
> are about. Is there anything I have not considered here? Please point
> it out and I will follow up accordingly.

Mike sent out [0] recently which should fix this problem. Please take a
look at that, and see if it works for you.

[0] https://lore.kernel.org/kexec/20261103-kho-bootmem-sizing-v1-1-45aa74098f34@kernel.org/

-- 
Regards,
Pratyush Yadav

