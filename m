Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AAFF3C24A
	for <kexec@archiver.kernel.org>; Mon,  9 Mar 2026 13:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xVZJ8HA1Bq2a4PhlPxh0lErV720ISPGpbYGMuWQZ5Lk=; b=WBs7aIz4ovi/QqEUjkmRIciUPA
	w90uE8Jpod6iWT6t7GUyb9Mdl6TyQTEiuR1c1wBrF0mGKLHjJQls9DxYvzrY9zhK2NLYYDQAoM6t+
	ttdhghpb2dCeX3xPWt7XWPxbZBTZb99VJoijMXx2G8IkHkhaeAY4f7tWAygj791fXHgtctPBicksK
	kdfZu0PLnv2+088/Cp5R87H8SpBGTf/fL3nF9BMA7xmi0F0ZGwfNLAcZ4XDX/lqm2aUJzGr741Y9w
	X1o21aULtbCaagqSv0JizgzFkuRr0mUNYCiam23ULRyFy7fkkuHrBt6wIrGAZVj3JnkEYJX4PYtCR
	6lPUFy2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzaFF-00000007M66-2P7g;
	Mon, 09 Mar 2026 13:02:01 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzaFD-00000007M5T-0Q3g
	for kexec@lists.infradead.org;
	Mon, 09 Mar 2026 13:02:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xVZJ8HA1Bq2a4PhlPxh0lErV720ISPGpbYGMuWQZ5Lk=; b=NVFEsr7GEe+1IceOj9Tgde+bOM
	BC5ggZUCHv4FUkC8SvcoAo0kSlw6vUqgNYU0nkgjPTDujyZiRruV3N7EnE6SYJWyPj9GW4WINEhWf
	8T8PeoS2LmMwfA6T+eHQ8RUJnDGNjuK24LvozWiuHSCEskCAwJpMcXL5gDGBnspQUvfeY+9264KwL
	a9FRenXm8GKp8RmaWOerp16NZe6KVgCBikixT/yAN8hbwjNjcrKabTTv5MN5+71FtdE9Kz0BtTDwF
	QrhlPTYFNs1zdtPbv+3n4gCqLylkfoz/64UetKXX2maA2RUtc2fcu0mUbn4pLW0isgBHZh+4mgGuL
	sksMAMIw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzaF2-002EbW-0v; Mon, 09 Mar 2026 13:01:48 +0000
Date: Mon, 9 Mar 2026 06:01:43 -0700
From: Breno Leitao <leitao@debian.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org, linux-mm@kvack.org, 
	usamaarif642@gmail.com, SeongJae Park <sj@kernel.org>, kernel-team@meta.com
Subject: Re: [PATCH v7 4/6] kho: fix kho_in_debugfs_init() to handle non-FDT
 blobs
Message-ID: <aa7EoP1zQ9wAG1Ri@gmail.com>
References: <20260306-kho-v7-0-404d14c188bb@debian.org>
 <20260306-kho-v7-4-404d14c188bb@debian.org>
 <aa6DWto0xY5EPyxK@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa6DWto0xY5EPyxK@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_060159_142899_6BC94C72 
X-CRM114-Status: GOOD (  20.58  )
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

On Mon, Mar 09, 2026 at 10:22:50AM +0200, Mike Rapoport wrote:
> On Fri, Mar 06, 2026 at 04:39:23AM -0800, Breno Leitao wrote:
> > kho_in_debugfs_init() has two problems when displaying incoming
> > sub-blobs in debugfs:
> > 
> > 1. It uses the hardcoded property name "fdt" instead of
> >    KHO_FDT_SUB_TREE_PROP_NAME ("preserved-data"), so it never finds
> >    subtrees stored by the current kho_add_subtree().
> > 
> > 2. It calls fdt_totalsize() to determine blob sizes, which assumes
> >    all blobs are FDTs. This breaks for non-FDT blobs like struct
> >    kho_kexec_metadata.
> > 
> > Fix both issues by using KHO_FDT_SUB_TREE_PROP_NAME to find subtrees
> > and reading the "blob-size" property from the FDT (persisted by
> > kho_add_subtree()) instead of calling fdt_totalsize().
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  kernel/liveupdate/kexec_handover_debugfs.c | 38 ++++++++++++++++++++----------
> >  1 file changed, 26 insertions(+), 12 deletions(-)
> > 
> > diff --git a/kernel/liveupdate/kexec_handover_debugfs.c b/kernel/liveupdate/kexec_handover_debugfs.c
> > index 7a100f2bf3947..fc2baa8b104fd 100644
> > --- a/kernel/liveupdate/kexec_handover_debugfs.c
> > +++ b/kernel/liveupdate/kexec_handover_debugfs.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/io.h>
> >  #include <linux/libfdt.h>
> >  #include <linux/mm.h>
> > +#include <linux/kho/abi/kexec_handover.h>
> >  #include "kexec_handover_internal.h"
> >  
> >  static struct dentry *debugfs_root;
> > @@ -121,23 +122,36 @@ __init void kho_in_debugfs_init(struct kho_debugfs *dbg, const void *fdt)
> >  	fdt_for_each_subnode(child, fdt, 0) {
> >  		int len = 0;
> >  		const char *name = fdt_get_name(fdt, child, NULL);
> > -		const u64 *fdt_phys;
> > -		void *sub_fdt;
> > -
> > -		fdt_phys = fdt_getprop(fdt, child, "fdt", &len);
> > -		if (!fdt_phys)
> > +		const u64 *blob_phys;
> > +		const u64 *blob_size;
> > +		void *blob;
> > +		size_t size;
> 
> Do we really need two size variables? Can't we just have u64 *size and pass
> *size to __kho_debugfs_blob_add()?

We definitely can. let me respin with the other changes as well.

Thanks for the review,
--breno

