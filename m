Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9FDC5B572
	for <kexec@archiver.kernel.org>; Mon, 17 Aug 2026 02:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DG7jvyN4yQ09VtnD0SMCMFuTSpCJepXj1RyMlY9C2vA=; b=aQLn7UbF+P8FH443WtGh/lFusT
	hC8SC6f3nr44bb32LlcAJKmuF2GBIel+Un/WCLPNgIuyG5OZAAbjGEYLbo0XyQ822JGUotkVIiEHq
	Kmk5oK+rbm0g+xslhZ8cB6McjnybkXyTZrdRsNp5WvT/A9rYo37DaOxBN1e4VMgU6GTZdzaPFZ/4N
	vUSg9fte6ASal0uqbg0BI4ZyW3l+sEKN4pDhmRGNPzqy8sKuJoCujCrm/0QzZFlVpIW3HNkYMF8z0
	3SwckvTb1dybz9vjGjWviJbhVbYw6xfp/k0bv82oGx5yJdvrHLeclWPFaKZJI/n34Id2q0GJ0IUgg
	Mj44Mr6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvnSH-00000005KzX-0D61;
	Mon, 17 Aug 2026 02:52:05 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvnSD-00000005Kys-0CMg
	for kexec@lists.infradead.org;
	Mon, 17 Aug 2026 02:52:03 +0000
X-UUID: 9745b16299e611f19a56ed5b684f684d-20260817
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8a4b23c4-8c59-4b38-9c88-39599c3a48bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:373428cd7313b842758528a80ea0ef58,BulkI
	D:nil,BulkQuantity:0,SF:80|81|82|83|102|136|850|865|898,TC:nil,Content:0|1
	5|50,EDM:-3|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9745b16299e611f19a56ed5b684f684d-20260817
X-User: duanchenghao@kylinos.cn
Received: from localhost [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <duanchenghao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 159149812; Mon, 17 Aug 2026 10:51:48 +0800
Date: Mon, 17 Aug 2026 10:51:46 +0800
From: Chenghao Duan <duanchenghao@kylinos.cn>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: pasha.tatashin@soleen.com, rppt@kernel.org, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kexec@lists.infradead.org, jianghaoran@kylinos.cn
Subject: Re: [PATCH] liveupdate: use scoped_guard for mutex in session
 operations
Message-ID: <20260817025146.GA133735@chenghao-pc>
References: <20260814095506.631274-1-duanchenghao@kylinos.cn>
 <2vxzzeyo23ol.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2vxzzeyo23ol.fsf@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260816_195201_393723_D41026C0 
X-CRM114-Status: GOOD (  14.67  )
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

On Fri, Aug 14, 2026 at 04:10:34PM +0200, Pratyush Yadav wrote:
> On Fri, Aug 14 2026, Chenghao Duan wrote:
> 
> > Replace manually paired mutex_lock/unlock with scoped_guard to align
> > with the coding style of the rest of the codebase and simplify locking
> > paths.
> 
> No. This is done explicitly because we don't want to mix gotos with the
> automatic cleanup-style locking. I don't think we should change this.
> 

Thank you for the clarification. I understand your concern about mixing
`goto`-based error handling with automatic cleanup-style locking.

I was wondering if these particular cases might still be suitable for
using `scoped_guard()`. The patch only changes two manually paired mutex
lock/unlock instances, and in both cases, the guard scope is limited to
the operation that requires the mutex. The lock is released before the
subsequent error-handling logic is executed, so the `goto` paths do not
cross the scope of the guard.

We could also use an explicit `scoped_guard { ... }` scope to make the
lifetime of the guard more obvious and easier to review.

Of course, I may be missing some broader considerations. If there are
other reasons why these cases should retain the explicit lock/unlock
pattern, I would be happy to follow your guidance.

Regards,
Chenghao

> [...]
> 
> -- 
> Regards,
> Pratyush Yadav

