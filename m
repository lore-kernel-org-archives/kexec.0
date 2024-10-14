Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDD7D1812F
	for <kexec@archiver.kernel.org>; Mon, 14 Oct 2024 16:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T3KTilP16YGctpZab0s2n06WrOAoGkVxI1jF7D7hjhY=; b=sBjdDiADcGmjBI
	WtsQYeiJ+5LNrWtI1p+G51nrx5GWAZtaFV+ra11SBK90INV38synINJee/n09KanEQ9bdYz/IjEFZ
	QgU6d7vJFf5yFrqPDdHuJvDaC+UNQ7DsnQ4TgsXu437jITc2MlmaIWCWqveNd6Bm3HugOna1O/siE
	z6e9K321bcOBxV6BtUAYDjbn9msIbPmXH/Hd1GlYMPVl097wiA0ph1f/dZR9jLKR7bI7gn3vQjmzN
	u11J6ljEdURmozN5sUp/tt5ye6u2re0D9KA3seGoivwrUigaIZsh0bJ7B4j6ry+XqGGv7zJifRKcV
	fyeowt6DGVtx3Iu/KDJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0NsO-00000005qgs-3JCK;
	Mon, 14 Oct 2024 16:24:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0NsL-00000005qf6-2qco
	for kexec@lists.infradead.org;
	Mon, 14 Oct 2024 16:24:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C834E5C5B20;
	Mon, 14 Oct 2024 16:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F82C4CEC3;
	Mon, 14 Oct 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728923093;
	bh=kzhu+ScGwynYfTPPOHJ45nIuKsOo4+AGTK4XV/x3XkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MQJJKsJawhcMH6y9yhfKJc601aZBa/hg1S7DH754yeBDkSHojOSHRhShlK/bfg1ww
	 LsCE/TH4h50TlvTA3yQmBamQjTCJE7Rvughv2Hsmg2PoZTv0/7tYDUvgjM9a3wgELJ
	 afWz8xxJHs6I3G7GH6LylnlDtoGJKVgF/lV3pnLtED0aBaY80Ws7r9MbQdaB251lGW
	 aJeZ84ClThKEDKYb5YuLUq0vd+tNpnNGA/q4lwM4BYNZU5jtJAzDY4s9EUx9rowpaH
	 M8TXijGu8c7xqTfafk2Zr/fhhyayYe/MLIqdA6sglhnaodLf1BB9EQFnCGc/Fl37g9
	 4KGwz0tNyYD5g==
Date: Mon, 14 Oct 2024 17:24:50 +0100
From: Simon Horman <horms@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: kexec@lists.infradead.org
Subject: Re: [PATCH v1 1/4] kexec: i386: Fix 32-bit right shifts on 32-bit
 architectures
Message-ID: <20241014162450.GA569285@kernel.org>
References: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241014153129.295176-1-andriy.shevchenko@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_092453_812660_36E53464 
X-CRM114-Status: UNSURE (   7.60  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Mon, Oct 14, 2024 at 06:31:26PM +0300, Andy Shevchenko wrote:
> 32-bit compilation makes compiler unhappy about too big right shifts.
> Use a similar trick to Linux kernel project by replacing foo >> 32 by
> (foo >> 16) >> 16.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy,

Series applied.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
