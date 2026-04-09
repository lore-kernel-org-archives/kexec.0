Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C5FEA3C59
	for <kexec@archiver.kernel.org>; Thu,  9 Apr 2026 12:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwTHIJxjIYpNKNbKPjX5z2YBlngCSlDhVOBalB65o7I=; b=EqR7g5W4730BatWC9U5wecRtN2
	MLfjmdemwFZYTOx4tgKDy1liPZ8pS3cB0urHpIN/gmcyd6aFMUquvswk+gZU6/OwAb99uJzlKTUtC
	VbIZpVwwRGpbs7by2snqA8Nqy6Y6UAHCNZgoCRdZTsd5/5UkN/smhQUNCdV8ZuEy9cZ//CSDo7sgF
	nd0N1LVuTcA1uDJuVw5JLMOPJ/0vI+uCBKXzfHdP8JsAN/nEwmPFolstItsR4BpQ03qGn331ngpia
	WoN4Iu6FKUg8P6JZVVlqU4BNTMtdKPz1T/b5kAsh0IaR7581c5vKjoWoQ9u6aipP04pVs77Rk+lTN
	hhnLkrDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAo7i-0000000ALJw-3dPK;
	Thu, 09 Apr 2026 12:04:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAo7i-0000000ALJh-0NcD
	for kexec@lists.infradead.org;
	Thu, 09 Apr 2026 12:04:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2106F600CB;
	Thu,  9 Apr 2026 12:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDE3C4CEF7;
	Thu,  9 Apr 2026 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775736276;
	bh=gcZxvku11NmaM/oQN+7sEkPtzgRgmTY51fejdl+f4iQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QRcRzH4ElTvkUK2UDiRPGgoHkPhNfpWtUwSuoa2hKEqYP6G2IulpGTGcXh78j7Unb
	 cv+2aeZFfqDHIYyM9ycPVHx5TbzOLMGI1syCd95GAdtXD+UUu0LIZeDeMSyX+QSOvE
	 lXSrFoSKNinfh4EE8/oSmIMXCg/B08rp04y85z8LUK4Yp4ydsPDBfEZOEWeTf4QRlR
	 kcI+zCjQNk2qkzg58EoMQS4nvuvPkg/X1PWkzbOgH8D1Vm6QV3mOAKj9H923tZP+HX
	 ldNqn/12cjl6IfK6hkex3+Q463rRVVL/tk05/l60JHkk6uUbs1L6UWNmDcEb84JELG
	 PfVMXLtN5Y2+Q==
From: Pratyush Yadav <pratyush@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  SeongJae Park <sj@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  kernel-team@meta.com
Subject: Re: [PATCH] kho: call kho_kexec_metadata_init() for both boot paths
In-Reply-To: <20260409-kho_fix_merge_issue-v1-1-710c84ceaa85@debian.org>
	(Breno Leitao's message of "Thu, 09 Apr 2026 03:31:40 -0700")
References: <20260409-kho_fix_merge_issue-v1-1-710c84ceaa85@debian.org>
Date: Thu, 09 Apr 2026 12:04:32 +0000
Message-ID: <2vxzjyug9w6n.fsf@kernel.org>
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

On Thu, Apr 09 2026, Breno Leitao wrote:

> kho_kexec_metadata_init() was placed after the fdt check, causing it to
> run only on the fresh boot path (no incoming FDT) and skipping metadata
> initialization on the KHO restore path.
>
> The original patch[1] was based on commit 5c9e55fecf93658 ("Add linux-next
> specific files for 20260312"), which included commit d7176a010afce8
> ("kho: fix deferred init of kho scratch"). That commit has since been
> rebased and reworked in linux-next, changing the code flow so that
> kho_kexec_metadata_init() is no longer reached on the restore path.
>
> Fix this by moving the call before the fdt check so it runs regardless
> of whether an incoming FDT is present.
>
> Link: https://lore.kernel.org/all/20260309-kho-v8-5-c3abcf4ac750@debian.org/ [1]
> Fixes: 047117e78331a ("kho: kexec-metadata: track previous kernel chain")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

Andrew, since the patch "kho: kexec-metadata: track previous kernel
chain" is still in mm-unstable, please meld this patch into it if
possible.

[...]

-- 
Regards,
Pratyush Yadav

