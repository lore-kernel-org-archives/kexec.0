Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA1105A585
	for <kexec@archiver.kernel.org>; Thu, 12 Mar 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f6AcXBztT5Sj+QpF3YNwZU4UQU3fnhpf/t4o8/38YWo=; b=bjkyrzUdIPWMXMcIQmi8ur91XU
	hMamMQnlT2oCx6AH+r6LDEHeT5ZpN99iqW9ywERosNJOIK+xfm6+iG3TmCaIoKTmpFg9HPh/eUD57
	qAR72kYhiBQYBkUry/LXbLmfZpuz9K8nnGm77JlKogeX2LSem8aTfbCOYu2y+aUy5k6K0ZyjGcUMG
	5NEG+seXjSD38auJyHE8tK2b7uvFNiFD2bGLmjF+CfFB0SqchlPaNEUPRHLwL5d042XdZBumoikBP
	aiSMi+QVBdBbvXRiugpDYX77O4gLejgogjHP9I7rkToPe2bUMFuTy0k7Kvfp+lOwhs8NoBdtODGt2
	Zy0wCLOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0dxk-0000000Dv4k-12W6;
	Thu, 12 Mar 2026 11:12:20 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0dxh-0000000Dv3h-0QHL
	for kexec@lists.infradead.org;
	Thu, 12 Mar 2026 11:12:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f6AcXBztT5Sj+QpF3YNwZU4UQU3fnhpf/t4o8/38YWo=; b=PjN9deAvJ2jmYwchkDw9K/1IDW
	RDvBjTzu2dy1mbJuwxKv0HZQrtfZqSFEAu7HYwU1mPcbgs1Wy7Sz7jhOgXg/EldB7YZywQi9qnXBc
	gI9pj6E37zd5K2g9bkLCwgqwgL2IJQun2hk81vcF3+5Q6BY9r3yF4wjhMUbg93ciB906m6k2FYfqX
	ilqbWKGK0kkd8/YZlNworwuz+HryM6l5ooq5hK9DH4Niqo5d+5WOP7RxHnrhbUlca8vVw6fPFcHCO
	B+Tk1y5dMsoGlCWft/JjWbKDsv0I3LJcESQXWtslE5bwDRZ3Zmo5IuBSNKcFQx3qk4dxtx52mZf2p
	LRQeitOw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w0dxO-004VL3-S2; Thu, 12 Mar 2026 11:11:59 +0000
Date: Thu, 12 Mar 2026 04:11:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v8 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
Message-ID: <abKfG0w7frLldlfd@gmail.com>
References: <20260309-kho-v8-0-c3abcf4ac750@debian.org>
 <20260309-kho-v8-4-c3abcf4ac750@debian.org>
 <aa_0OESNkyp8V2eF@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa_0OESNkyp8V2eF@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_041217_146399_DD9F7C7B 
X-CRM114-Status: GOOD (  13.44  )
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

Hello Mike,

On Tue, Mar 10, 2026 at 12:36:40PM +0200, Mike Rapoport wrote:
> On Mon, Mar 09, 2026 at 06:41:47AM -0700, Breno Leitao wrote:
> > kho_in_debugfs_init() has two problems when displaying incoming
> > sub-blobs in debugfs:
> >
> > 1. It uses the hardcoded property name "fdt" instead of
> >    KHO_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
> >    subtrees stored by the current kho_add_subtree().
> >
> > 2. It calls fdt_totalsize() to determine blob sizes, which assumes
> >    all blobs are FDTs. This breaks for non-FDT blobs like struct
> >    kho_kexec_metadata.
> >
> > Fix both issues by using KHO_SUB_TREE_PROP_NAME to find subtrees
> > and reading the "blob-size" property from the FDT (persisted by
> > kho_add_subtree()) instead of calling fdt_totalsize().
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you for the review.

As this is my first contribution to KHO, could you please let me know
which tree these patches typically go through?

Thanks,
--breno

