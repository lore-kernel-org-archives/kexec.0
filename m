Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745F6106ACCA
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sdcAvQYluRsHiaq27HB7UHGVzrwV+fXvIHwcGJQA/GA=; b=fl2MYyo0Hn6ZMJyoJjzx41AoSM
	sZkkj3gjh5Qpc21qp6/RjXWtsIPIXLPsKbVLQuYDUhoOw5wqr7qdsCaBLT0jHnmHT3yTf1Ake+WYl
	72+xl47zIgrdlcORg0JvPGQEZg9O1VWsYZW8v0XnK6sCCAOQ6SDWLeyDywK/9emmClrarY//wDhi2
	OEh0ZcpSq+40WxR4J4ITp9G4oSGVFhCdE8mvisOsM4g3+izI5ojH10/pBEW65VQt0BSx3rHs91yAS
	5Wo3OzXzuHu4ZI03d6/zwz7mvuBZ2DD3KBICrp4iL/vxEhpaA89cIMwTo9uueiel3aUGn0AKiHBEV
	IC2VXHaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ijj-0000000EWoC-0Fzo;
	Thu, 12 Mar 2026 16:18:11 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0ije-0000000EWns-1jpq
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 16:18:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 68DCA6012A;
	Thu, 12 Mar 2026 16:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F6CC4CEF7;
	Thu, 12 Mar 2026 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773332285;
	bh=9aDhjOigL7tYYsWcsq6290598xav89KKBwOignR3TsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR4fq5ey+rkrl42f8bTNCih0k4suiLD3rhGCe5CaADR2yCeiTLNLx4GkxQXgTyu8o
	 spccig8j7j6D1GH2FFsP//yuaJiSow5CXNeN0dv7br8TbEXK3f/RE2JMmeFXqf5UD+
	 i0+sDclWL56hy8NE9sigfV+gZDaRMSPHbLj8PbfgDaNfeI3RproqznpBet0J3a0Fby
	 YvUnaFCvM9YTcPHUmckr1rhKLcCqFCtY0Q3jr/dfduHb81ei8jJXEIfar98VajlwU4
	 By24JEmRJQAscmxF+y3ezqte4BIJcr80OKtkD4Os2MAxxpMFVxCjk5A5EYjgJVJTsS
	 Fik6r6HrOCo/w==
Date: Thu, 12 Mar 2026 18:17:57 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>,
	kernel-team@meta.com
Subject: Re: [PATCH v8 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
Message-ID: <abLnNbNCZgMNtKS9@kernel.org>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-4-c3abcf4ac750@debian.org>
 <aa_0OESNkyp8V2eF@kernel.org>
 <abKfG0w7frLldlfd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abKfG0w7frLldlfd@gmail.com>
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

Hi Breno,

On Thu, Mar 12, 2026 at 04:11:54AM -0700, Breno Leitao wrote:
> Hello Mike,
> 
> As this is my first contribution to KHO, could you please let me know
> which tree these patches typically go through?

KHO patches go via mm tree.
 
> Thanks,
> --breno

-- 
Sincerely yours,
Mike.

