Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690E1D6CFAC
	for <kexec@archiver.kernel.org>; Thu, 22 Jan 2026 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iozt8Us1Rhozyr7WEg9CFZCa93jzm5F1W9w70UUil4=; b=Qg5aWA+7e81msfytjIB5RM+arP
	18ET2Zn9jB5+LY3i2fhBN7B1HISDNZhybVLcfXXSZP5erfMRRRvoCDR12YFAISyNYOS1YWnsE4GuH
	vUMQ/jcDqnqMBfE88Dd5Yrw35AvUXem/GJM3ahMkNUbet7gGTwv6BDwds6vsgxuvjpnT2jn4MMCX6
	4wM61WBjV2WufmiicPa10tIU4ef1TVde94mIBAWQ6QQWFO2GNe9WpYZdf31gsqqILivwJOHau9L6e
	uHQjCyXtYAecqv+q1Wys4tjajtx+xdOI2YtsRwjpCxwiN+H46T0R/qNXrkX3fOfZnlYsZmug6qM//
	qGbOlbuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj3zJ-00000007sT5-0k9Z;
	Thu, 22 Jan 2026 23:21:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj3zH-00000007sSz-2N7l
	for kexec@lists.infradead.org;
	Thu, 22 Jan 2026 23:21:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 054A2601D0;
	Thu, 22 Jan 2026 23:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D9EC116C6;
	Thu, 22 Jan 2026 23:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769124073;
	bh=FQSbPcWqMsCprYFwJmBz3VE+4rqivk3gkSSozBLvfkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EDLiiCYlAOXiX2hksK+ejbN30bffeiS9x2mgFIdx/DnZKX7QrEZGQ69DKgTiRWOGh
	 RsXKpcqtgdEgrWVvBsn2b3xRnJyaXy987VYsCb6uoR63/DBiWd93QaDoRlvb7AIVBC
	 pTMdXz9lwP3LI6MfPe+taT8DT9kUK/oEZhA7O7JI=
Date: Thu, 22 Jan 2026 15:21:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Mike Rapoport <rppt@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>,
 "Alexander Graf" <graf@amazon.com>, Jason Miu <jasonmiu@google.com>,
 <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
 <linux-mm@kvack.org>, <nh-open-source@amazon.com>
Subject: Re: [PATCH v2] kho: skip memoryless NUMA nodes when reserving
 scratch areas
Message-Id: <20260122152112.1a8be8e7bdab72631234cd69@linux-foundation.org>
In-Reply-To: <20260120175913.34368-1-epetron@amazon.de>
References: <20260120175913.34368-1-epetron@amazon.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 20 Jan 2026 17:59:11 +0000 Evangelos Petrongonas <epetron@amazon.de> wrote:

> kho_reserve_scratch() iterates over all online NUMA nodes to allocate
> per-node scratch memory. On systems with memoryless NUMA nodes (nodes
> that have CPUs but no memory), memblock_alloc_range_nid() fails because
> there is no memory available on that node. This causes KHO initialization
> to fail and kho_enable to be set to false.
> 
> Some ARM64 systems have NUMA topologies where certain nodes contain only
> CPUs without any associated memory. These configurations are valid and
> should not prevent KHO from functioning.
> 
> Fix this by only counting nodes that have memory (N_MEMORY state) and
> skip memoryless nodes in the per-node scratch allocation loop.
> 

So kho is unusable on such machines.

Should we backport this?  I'm thinking

Fixes: 3dc92c311498 ("kexec: add Kexec HandOver (KHO) generation helpers").


