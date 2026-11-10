Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC10606A32A
	for <kexec@archiver.kernel.org>; Tue, 10 Nov 2026 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oH74y+ly;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Um8HSqo0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:References:
	In-Reply-To:Cc:To:From:Subject:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=VdROMlQmJbX1gHfrkVRtS1i5XA9kfJ95m7dZ9kFx1V0=; b=oH74y+lyZ+gYP6
	eJneuPGB2YLztCkOo/B2Gqz1OzhgP5LpNkE7IqTog6YXpF4kkPs9Yz8aon/BVS55XKCp4uYzNaiNv
	UWTSiF6eiEcwaz00RR1GVnqgTgyLv3w70XRIsim6O0pVJMt8HZgLA92QbFGQPJOFKmrf8ohzQgoB6
	2sSbxGS81ZiwldRSeUub6O//TOB0LtUr0uE3EPo9eU4X68YQOjv5kVgdQAepPPjGyoqRbGYWu2dEm
	niP0eOoToe4Dd+0ulqA1LXNHt8QnoRXLzrpsbnEBjX6qg7xHF9TheQ7pchwspSR66hsYQbUQNC7Cb
	jKDNEIPm2GCdx4+r+K4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQuLl-00000005A2T-09on;
	Tue, 10 Nov 2026 22:29:57 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQuLj-00000005A2M-0SsU
	for kexec@lists.infradead.org;
	Tue, 10 Nov 2026 22:29:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6062E4348B;
	Tue, 10 Nov 2026 22:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47ECE1F008A3;
	Tue, 10 Nov 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349794;
	bh=VdROMlQmJbX1gHfrkVRtS1i5XA9kfJ95m7dZ9kFx1V0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Um8HSqo0e/qyCuooxYE3S43WlTBqf3p2D1B6gr/2AqyHtdbN7GKfEinvFb5SwtQF2
	 KZGCZ3JAJ/qcn2LFVxx74pcK6i6lu4ysfK5SuvAcsa87P4luukBbnRNg3AlyhYSsfj
	 Q+pjah8epaZ1ExXAITOmxKkuGphC30diBaBb8NfyWjwzVuURK5UYE2fz761TAqc6lc
	 nMt8czdCQ9gfxQFfr35doxmgpDUNRpSDD44szamLAsVAlJ1Y2ceGyUZStXgTUbwT3V
	 QZtnd0AbUw7hWhyetRJXLrf7Zrx+tOlbr/HfZ4QYfBeQ0JE8C7/oMMlaZ89Zl0SIJk
	 nxm1NwolMcXBQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] mm/hugetlb: allow crashkernel to reuse hugetlb CMA
 memory
From: Mike Rapoport <rppt@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, baoquan.he@linux.dev, 
 rppt@kernel.org, pasha.tatashin@soleen.com, pratyush@kernel.org, 
 ruirui.yang@linux.dev, corbet@lwn.net, skhan@linuxfoundation.org, 
 rdunlap@infradead.org, muchun.song@linux.dev, osalvador@suse.de, 
 david@kernel.org, jbohac@suse.cz, sourabhjain@linux.ibm.com, 
 ruanjinjie@huawei.com, leitao@debian.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, 
 shakeel.butt@linux.dev, zaslonko@linux.ibm.com, brads@mainlining.org, 
 kernel-team@meta.com
In-Reply-To: <20261106165142.2847916-1-usama.arif@linux.dev>
References: <20261106165142.2847916-1-usama.arif@linux.dev>
Date: Wed, 11 Nov 2026 00:29:44 +0200
Message-Id: <179434978421.425130.1365679547411253774.b4-review@b4>
X-Mailer: b4 0.16.1-dev
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 08:51:42 -0800, Usama Arif <usama.arif@linux.dev> wrote:
> crashkernel=size,cma reserves a separate CMA pool. On systems that
> already reserve several gigabytes with hugetlb_cma= (which is common in
> the Meta fleet), the crash kernel cannot use that existing memory as
> part of its working set. With hugetlb_cma=6G, requesting another 2G
> with crashkernel=2G,cma brings the total CMA reservation to 8G, none of
> which can serve unmovable kernel allocations.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.


