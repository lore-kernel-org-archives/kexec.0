Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A905A10854B3
	for <kexec@archiver.kernel.org>; Sat, 14 Mar 2026 22:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4LC4vO+z03h38TyuUXSna+MHi+Y8iJWKQTQsN+0vF7A=; b=SkKPejoigvzwLGcPSs7XEvXmrK
	4alQNSHoMWp4tYrTrobxhMM8MTr7G/CJ+Lg794ESCMJ7dQ5GZVmkGUQXKO1jrPhKWSmGHaU+aiVmr
	06wbBuD1bsJEvW68WGbV/AT7gQKnntUebg+HtzAyf+PZjrn2Cb0jYEL9xRwfrI447tbgRKGh4bYKw
	HxPJin+SwFwYKUbaHqnmcGbCsTenjy+ce1bOmJKUoi4WYW1i0LE+ot+XCa4QzqUR2fDOtsURnAFPX
	ChyuRzmM6LQxBVceet+9FVJhj3fqzteBTppnIOWD3S6J+HvvR4NB6uupV8xfCEdG0BaBsdJDTEpnY
	zUuod3dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1Xkn-00000002Diy-3ZKw;
	Sat, 14 Mar 2026 22:46:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w1Xkl-00000002Did-3Ib5
	for kexec@lists.infradead.org;
	Sat, 14 Mar 2026 22:46:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2357341677;
	Sat, 14 Mar 2026 22:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3AC116C6;
	Sat, 14 Mar 2026 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773528398;
	bh=U8F8sQEevlT1oJz8WbNbwwR/C+qf3FlDr6nbrGx0w3A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LcZxi5eOHVWNyxzP64a67mhdnXd2ndbCuQsiQFLKWSK3izXNaUJiwA0YVmbKJQ7xu
	 Qvq0/8oC+gFn/D+cntBH0hJVxTn8siFA4Z0UQ0UO796b4wn9zqdKaAUV7IwgnmkseJ
	 F24VInAMD6uTc8Ith935eV5kgs/HzGeR0JszYdqo=
Date: Sat, 14 Mar 2026 15:46:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, rppt@kernel.org,
 pasha.tatashin@soleen.com, jasonmiu@google.com,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 ran.xiaokai@zte.com.cn, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
Message-Id: <20260314154637.86a7d4f07800b59c00049814@linux-foundation.org>
In-Reply-To: <2vxzpl58f3oh.fsf@kernel.org>
References: <20260309033530.244508-1-ranxiaokai627@163.com>
	<2vxzpl58f3oh.fsf@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260314_154640_160576_8EE55456 
X-CRM114-Status: GOOD (  14.24  )
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

On Fri, 13 Mar 2026 10:02:06 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> On Mon, Mar 09 2026, ranxiaokai627@163.com wrote:
> 
> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >
> > Commit e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> > changed KHO_FDT_SUB_TREE_PROP_NAME from "fdt" to "preserved-data". However,
> > kho debugfs code still hard-coded the "fdt" string when parsing the
> > device tree, causing the debugfs node /debugfs/kho/in/sub_fdts/
> > fail to parse child nodes correctly.
> >
> > Fix this by including the header file and using KHO_FDT_SUB_TREE_PROP_NAME
> > instead of the hard-coded string.
> >
> > Fixes: e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> 
> Breno's patch [0] also fixes this, but I'd rather have this go through
> hotfixes and get backported to stable, and Breno's series to build on
> top of this.
> 
> [0] https://lore.kernel.org/linux-mm/20260309-kho-v8-4-c3abcf4ac750@debian.org/

Confused.  This patch (kho: fix child node parsing for debugfs
in/sub_fdts) fixes the mm-unstable patch "kho: adopt radix tree for
preserved memory tracking".

So what are you suggesting be added to -stable?

(Please lay it all out very clearly, idenfifying patches by name!)

