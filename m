Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0B3FF6E81
	for <kexec@archiver.kernel.org>; Tue, 17 Mar 2026 21:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uo+sc9qtwp6kqB7OasLtqZPI/cn9yQ3hXnA5nGv6tW8=; b=XtMIuO7crPLOh1ZLXXmYzmFvbx
	l5gmW1rRCM6QSexhebpqglaxLgSO1OFdaQYDlPCC+R9LZJWhsytAoycEKzllKxEMPkLPV8vJPmdOj
	gYrrbPSHCGQlNHSKnx8fdsk5iFO7UeHf1dye47ne+MWeG0+7nbrLDU86hZ6uc3xO+5AxP9skvrIBz
	y/V+P+v7HlYGSV7Kw3Lwk6LuwqUZq8mlT9UfbIux4uBQJ2WG+86qVriuJ6HSQFmOmqOrXB7eh0oCz
	sDSkVRBAxf5WxVhQQf/CBQ2fcooaJawGMI3DH2NgUQpxRs9H9bowPFllwWMDEMBfntr3cT2MvwO2v
	E/nhbzuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2beS-00000007ED8-46ju;
	Tue, 17 Mar 2026 21:08:32 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2beQ-00000007ECm-40Al
	for kexec@lists.infradead.org;
	Tue, 17 Mar 2026 21:08:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id ABDE460133;
	Tue, 17 Mar 2026 21:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6C2C4CEF7;
	Tue, 17 Mar 2026 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773781709;
	bh=23rJd7OQTs97ptMEKnft/LfTEyuJevK5LsE998S/Bu8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gnzTwDHB+LON/8XQTI6j0sODF2eLkRSJ1rjux0lTpj8qsELE5DIxmkIGh4fk+dd1e
	 0YkkbbXECZgs+rvbbcHjVXs0gr1Q72rIqEmn4oI4J1Jfdy5nSBAzd4zarK/s9y/9Lh
	 7xQ9cfkWLOtayLoivQWDPP4i2PlozPDucLf74H74=
Date: Tue, 17 Mar 2026 14:08:28 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: ranxiaokai627@163.com, graf@amazon.com, rppt@kernel.org,
 pasha.tatashin@soleen.com, jasonmiu@google.com,
 linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 ran.xiaokai@zte.com.cn, Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] kho: fix child node parsing for debugfs in/sub_fdts
Message-Id: <20260317140828.f5edbc151f85ffb8751b0f2d@linux-foundation.org>
In-Reply-To: <2vxzse9yddpr.fsf@kernel.org>
References: <20260309033530.244508-1-ranxiaokai627@163.com>
	<2vxzpl58f3oh.fsf@kernel.org>
	<20260314154637.86a7d4f07800b59c00049814@linux-foundation.org>
	<2vxzse9yddpr.fsf@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Tue, 17 Mar 2026 09:09:36 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:

> On Sat, Mar 14 2026, Andrew Morton wrote:
> 
> > On Fri, 13 Mar 2026 10:02:06 +0000 Pratyush Yadav <pratyush@kernel.org> wrote:
> >
> >> On Mon, Mar 09 2026, ranxiaokai627@163.com wrote:
> >> 
> >> > From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> >
> >> > Commit e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> >> > changed KHO_FDT_SUB_TREE_PROP_NAME from "fdt" to "preserved-data". However,
> >> > kho debugfs code still hard-coded the "fdt" string when parsing the
> >> > device tree, causing the debugfs node /debugfs/kho/in/sub_fdts/
> >> > fail to parse child nodes correctly.
> >> >
> >> > Fix this by including the header file and using KHO_FDT_SUB_TREE_PROP_NAME
> >> > instead of the hard-coded string.
> >> >
> >> > Fixes: e0c1731f5d57 ("kho: adopt radix tree for preserved memory tracking")
> >> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >> 
> >> Breno's patch [0] also fixes this, but I'd rather have this go through
> >> hotfixes and get backported to stable, and Breno's series to build on
> >> top of this.
> >> 
> >> [0] https://lore.kernel.org/linux-mm/20260309-kho-v8-4-c3abcf4ac750@debian.org/
> >
> > Confused.  This patch (kho: fix child node parsing for debugfs
> > in/sub_fdts) fixes the mm-unstable patch "kho: adopt radix tree for
> > preserved memory tracking".
> >
> > So what are you suggesting be added to -stable?
> >
> > (Please lay it all out very clearly, idenfifying patches by name!)
> 
> Sorry, my bad for causing the confusion. I thought the radix tree
> patches ("kho: adopt radix tree for preserved memory tracking") already
> landed in mainline, but I went and checked and it seems that they
> haven't. They are still in mm-unstable. So we should just meld this
> patch ("kho: fix child node parsing for debugfs in/sub_fdts") into
> ("kho: adopt radix tree for preserved memory tracking").

OK, that's how we presently have things:

kho-adopt-radix-tree-for-preserved-memory-tracking.patch
kho-adopt-radix-tree-for-preserved-memory-tracking-fix.patch <- "kho: fix child node..."
kho-remove-finalize-state-and-clients.patch

> There is nothing that needs to be added to -stable, and there is nothing
> that needs to go to hotfixes.

Great.

> Breno's patch ("kho: fix kho_in_debugfs_init() to handle non-FDT blobs")
> also fixes this bug, but then also adds some other changes with it. So
> Breno's patch will cause conflicts once applied on top of this patch,
> but they should be simple enough to resolve I think.

OK, let's deal with that when the time comes.

