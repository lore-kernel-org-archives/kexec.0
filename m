Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9099CCCFA0D
	for <kexec@archiver.kernel.org>; Thu,  6 Nov 2025 00:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dx8KbzB8U3adI/MsBHI0j+YsuKf6tme5LPO3Ki6qVss=; b=CPitxv13ytJBERR64n0Sk4AMjc
	4hFq/HWLU8F7S9gb+N1yDjNfGzi9GtJf1BSK4CdcAuejMUkPtnHwQ6JhNpI/QFAU/tESjZYRHsTbi
	2GYCq3gd2csBfKl6c8wMLUu83hKUn8JOBKXpbxzAYPuFOPnXWW85Nx8xcSYLTl9bZILjonfM+qKFo
	9Xogv3uiqmkJWVf+EgIJItOI+4ArgYwT6ZGWCh0luCLmM5zuvnLQhnAgxeEhyDetNsmEK3rr9NsgW
	GT/J+1dzGfEFN24h6bQjsXAyW1H6Rb/sQ4aH/AmPx4BirNbxNvmvBfPLevm700+opGsJcny6Zj+TN
	rsq2ec3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGne8-0000000Ee4S-2hpH;
	Thu, 06 Nov 2025 00:14:36 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGne6-0000000Ee45-1hDa
	for kexec@lists.infradead.org;
	Thu, 06 Nov 2025 00:14:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5AA1C43F7E;
	Thu,  6 Nov 2025 00:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA616C4CEFB;
	Thu,  6 Nov 2025 00:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762388073;
	bh=PqIMT15INbsDmi302tCo0x1agvgPMTbLwB2w2oCbItw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IDYLs/+jmgPawiu8djO7RICBEuZjVxeN9ymzOonINTrbeQax65Wnxq4h9asnvwHEA
	 ieAoDovK/pPjI3Glja3hmw0/iHT2rJo+tt58yKL6mU3UeQmk4hypgzaafJ+g+zZRle
	 6aIJ0CIV1GPmsCCktI0DeYf+svYMfb2GZ+jNhpTI=
Date: Wed, 5 Nov 2025 16:14:32 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-Id: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105130922.13321-2-piliu@redhat.com>
References: <20251105130922.13321-1-piliu@redhat.com>
	<20251105130922.13321-2-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_161434_485987_9883A26B 
X-CRM114-Status: GOOD (  12.95  )
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

On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> When I tested kexec with the latest kernel, I ran into the following warning:
> 
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
> 
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area. In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.

This is something we should backport into tearlier kernels.

> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> To: kexec@lists.infradead.org

So I'm thinking we should add

Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
Cc: <stable@vger.kernel.org>

yes?

