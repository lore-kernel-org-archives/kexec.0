Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B26CC6B08
	for <kexec@archiver.kernel.org>; Tue, 13 Oct 2026 10:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gU5utLVnwFgQmWLZFQ4HFSchng7Sy7XfB2Vr8rq8k3s=; b=Le+7ricyrx4vZz6ThRTQxmWhXG
	ceWoG3RSryyIM0NUns2IuCrGyN1QS9l3xkOxlSNVLksoCldGtmyIRfpdqDFZ14jUse1IrB0jEDI/Q
	Z8mR5ztThWHnrq9aLkUq4sqr77priy4YGh53cJ8qyHB/folrm/vzksH9fZUirwRFDlrxSYHi8vkHa
	0MuFNzpCsC1nFU2UKXLBS6OzzCaQCjMzDaKxMs1fN1h7ghrkPqcgcnCaX/O6AKLdEYomzgD4S5CFb
	EHFEWlVcZQLWP70SGxAb3lYHtXykO1yKBb/c4yunYicngtfJ9xTbJNUOSk0D1HAPfx9U/EzWkUV6g
	jOiU+8yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZP2-0000000CWUQ-0WA4;
	Tue, 13 Oct 2026 10:06:36 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZP0-0000000CWUK-3hnl
	for kexec@lists.infradead.org;
	Tue, 13 Oct 2026 10:06:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8462D415CA;
	Tue, 13 Oct 2026 10:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287461F000FF;
	Tue, 13 Oct 2026 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791885994;
	bh=gU5utLVnwFgQmWLZFQ4HFSchng7Sy7XfB2Vr8rq8k3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bm5Rr0+ol4pjiJzwi/GQKJ0ntegEVZPrz4cJnarSTTrO2k5Etyt/wleY5J38Ll9d3
	 4XNROqEiPrx7zUF3rOmVGAi08whzPjLZoLyItDQukcM4GczFOp0rERJ9Vd4737LeQu
	 FuHeXWHT+swUu4L7Eb1fb+bi54KfTLOAXebsIXVAS460rKVp82oAHQRbL0606tkr2J
	 wEZEN7tLiPwGNYTjRo6Rrlqe0aCg5RLB8qMfWcwHq4G6A8Es1LI1uy41aUF7+oerkv
	 BvFUMMHP0u7GRBvfEujf/sMCaRuDCErqPAtbDKwvEsz+JGvGNAnKFcvf2GYIvymRrn
	 UsuItD5TgJMIA==
From: Mike Rapoport <rppt@kernel.org>
To: dmatlack@google.com,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Tarun Sahu <tarunsahu@google.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] memblock: drop for_each_memblock_type() and open code its users
Date: Tue, 13 Oct 2026 13:06:27 +0300
Message-ID: <179188590478.4188181.17324869307973975022.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008190828.3221718-1-tarunsahu@google.com>
References: <20261008190828.3221718-1-tarunsahu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Thu, 08 Oct 2026 19:08:27 +0000, Tarun Sahu wrote:
> for_each_memblock_type() always starts the iteration at index 0 and its
> body is a trivial 'for' loop, so it hides very little. It also gets in
> the way of iterating from an arbitrary index, which the next patch
> needs.
> 
> Remove the macro and open code its three users: memblock_add_range(),
> memblock_isolate_range() and memblock_dump(). While at it, move the
> region pointer into the loop body scope.
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[1/2] memblock: drop for_each_memblock_type() and open code its users
      commit: aedb8dde08f8cd93ce1cc3a23273f2ff7238f832
[2/2] memblock: use binary search to locate candidate regions
      commit: 7a3477ec5793ab8c25be4db3e7dfe8a461bc775c

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.


