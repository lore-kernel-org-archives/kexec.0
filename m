Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C48C5B572
	for <kexec@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:In-Reply-To:Subject:CC:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=XDUATBNDii0rNPk0EPcFSgfeQuKfSAIXVv7jigaLJ2w=; b=pRDKcbjXt9as7kn70+MVsf6BZc
	5cxLnJ+BzNaAm0KPlmrMSnxXQpJ9Nlm4vi69zVQeAgvDENuoPoLCm6oZVKA2dwBP3efztD3ASDdR+
	tPuodO3P5IL6zXYUYncfSKelIKalvDcPSVr/pfBoNQcI9r5S6X4AkixohX5ycYlzKl/xT4k/y+qxe
	Mv+DNNhCeLpJXtCo47n9BNqjg1Z9WWB9rRVTG/5AzUtZUVpq5l5lNSdZ9CwqZOvRj/S/qHVrh8Wmq
	0cnL02Ihef/ssOTCWUjfuTC+bhs3OowbaBIF6m1cNr2jQ1SaHpgf3KtM05+ZJYDzHJv0UCMYWgvpZ
	BMDG0rGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuAXk-0000000GR5j-1GKh;
	Wed, 12 Aug 2026 15:07:00 +0000
Received: from devianza.investici.org ([2c0f:f930:0:4::108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuAXh-0000000GR3q-2Cbd
	for kexec@lists.infradead.org;
	Wed, 12 Aug 2026 15:06:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786547205;
	bh=XDUATBNDii0rNPk0EPcFSgfeQuKfSAIXVv7jigaLJ2w=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=r00F92aQkFiiqDI4p41cgXIft6pY2N1ydZXbq+hN2+psjMJhAzrMv+g6ybxjuZQ91
	 M4+6YqEHKuDLIo5gh1nSZ2S5iNQObZe3tblnvfIjJ2eXJyyEjSlt/bNTQa3leH/ahE
	 lx/z5KaeGnRpd1pXbU33K40MCrxUdSRkmVct0qeM=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hKsK10jvsz6vLd;
	Wed, 12 Aug 2026 15:06:45 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hKsK04HyKz4y6W;
	Wed, 12 Aug 2026 15:06:44 +0000 (UTC)
Date: Wed, 12 Aug 2026 16:06:45 +0100
From: Bradley Morgan <include@grrlz.net>
To: leitao@debian.org
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, david@kernel.org,
 kernel-team@meta.com, kexec@lists.infradead.org, liam@infradead.org,
 linmiaohe@huawei.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, mhocko@suse.com, nao.horiguchi@gmail.com,
 pasha.tatashin@soleen.com, pratyush@kernel.org, riel@surriel.com,
 rmikey@meta.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_1/2=5D_kexec=5Ffile=3A_stop_th?=
 =?US-ASCII?Q?e_top-down_search_before_it_underflows?=
In-Reply-To: <20260812-kexec_posioned-v6-1-e477887086f0@debian.org>
Message-ID: <5AEF66B9-D749-4E2F-8B24-62988FE9D960@grrlz.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_080657_713795_2AD65B53 
X-CRM114-Status: UNSURE (   5.80  )
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

Hi Breno,

> Nothing stops that subtraction at zero, so a search that reaches the
> bottom of the address space wraps temp_start around and continues.

ack, and the wrapped value sails through both existing checks since
it is not below start or buf_min, misses every segment and exclude
range, and the loop breaks with kbuf->mem pointing outside of RAM.

since the walk only moves down... temp_start > end can only be true after
a wrap, so the new check has no false positives. It is also what lets
patch 2 drop the poison < memsz guard.


Please absolutely add:


Reviewed-by: Bradley Morgan <include@grrlz.net>

Thanks!

