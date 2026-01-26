Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5838CD13C0D
	for <kexec@archiver.kernel.org>; Mon, 26 Jan 2026 13:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aa1DMzjW5ihMgg92YYEEvi+hVWZtO1QQ1kl6+AaoZvQ=; b=EWNDMEDVKKzUB/n/MGPHWBXEU0
	xtGZnVPJZDv7+FhM0ZWAu9vrhkcl5gI1mssAtgTAuFJFMrHw60mO8ay41PbxfG5sG2MXwylJX5Iia
	s89ei3MTlrK1K02ffa05RC0u5xStX5MnwOJ1HvTJjoYNhtnCcgcVbejXyF1gOUBN5YYi+531jjolA
	azPhB40cZGlswrEdo+QHs/B6HXJK8lzS4SisDJ+Q3XRzh43X4wzBt7XcnyQcvhmwDs/TQ3Mv/bkF7
	4qfbLOhRArgRG8FynD0Yy3wzuYLZcNbhtTHMSgwIkc1ieZcmG+QCfh+3iVo4OK9oBbBnPEnrijpM7
	VcmhYC1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMwA-0000000Cdqv-25ut;
	Mon, 26 Jan 2026 13:47:26 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkMw7-0000000CdqX-42np
	for kexec@lists.infradead.org;
	Mon, 26 Jan 2026 13:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aa1DMzjW5ihMgg92YYEEvi+hVWZtO1QQ1kl6+AaoZvQ=; b=PTW8TqhgFvvUWcRC3HJM028fcP
	M7Vxisjv/gGMNmxFO/SLOgwXfepfwBg8TfKn2bhZf1AVDlJkcvSDMbJLwOpj10bTWKE3kluom+K+N
	/L0DHiSRwa7TItLibUQbsjIgw5OQ5QBdu/vN9mLeWAu9Bt2yyDrmdLewyCBzHo1Q9fkJfSQdJfOka
	MCN20eKZFSUeIVHI1U2iyeA/KMrVnyztbocEcxEPWBtKFAZcXb76eg90AIrS+9ZSs2PscROltDqCp
	YsKRS5aiepm+1WZlSQvL1/1oDp0bVAyFumjQytrDAxjxZyw7mUrB54GxuaxhmlLkyF1ke7ddLpjHE
	Ynk/aOxg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vkMvr-00GDT2-Op; Mon, 26 Jan 2026 13:47:08 +0000
Date: Mon, 26 Jan 2026 05:47:02 -0800
From: Breno Leitao <leitao@debian.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-mm@kvack.org, usamaarif642@gmail.com, rmikey@meta.com, clm@fb.com, 
	riel@surriel.com, kernel-team@meta.com, SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4] kho: kexec-metadata: track previous kernel chain
Message-ID: <aXdwObCI5z6qbuwE@gmail.com>
References: <20260121-kho-v4-1-5c8fe77b6804@debian.org>
 <aXdTEzsm88JKu9zY@gmail.com>
 <2vxzikcoa4g1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2vxzikcoa4g1.fsf@kernel.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_054724_037414_9F87CF95 
X-CRM114-Status: GOOD (  29.92  )
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

On Mon, Jan 26, 2026 at 02:28:30PM +0100, Pratyush Yadav wrote:
> > On Wed, Jan 21, 2026 at 06:50:38AM -0800, Breno Leitao wrote:
> >> +static __init int kho_populate_kexec_metadata(void)
> >> +{
> >> +	struct kho_kexec_metadata *metadata;
> >> +	int err;
> >> +
> >> +	metadata = kho_alloc_preserve(sizeof(*metadata));
> >> +	if (IS_ERR(metadata))
> >> +		return PTR_ERR(metadata);
> >> +
> >> +	strscpy(metadata->previous_release, init_uts_ns.name.release,
> >> +		sizeof(metadata->previous_release));
> >> +	/* kho_in.kexec_count is set to 0 on cold boot */
> >> +	metadata->kexec_count = kho_in.kexec_count + 1;
> >> +
> >> +	err = kho_add_subtree(KHO_METADATA_NODE_NAME, metadata);
> >
> > There is a hidden bug in here when CONFIG_KEXEC_HANDOVER_DEBUGFS is set.
> 
> Good catch!
> 
> >
> > kho_add_subtree() expects a fdt as the second argument, and we are
> > passing a pure C struct. That works fine, except for debugfs, which
> > does:
> >
> >  1. kho_add_subtree() calls kho_debugfs_fdt_add()
> >  2. kho_debugfs_fdt_add() calls __kho_debugfs_fdt_add()
> >  3. __kho_debugfs_fdt_add() executes fdt_totalsize(fdt)
> >
> > The fdt_totalsize() macro reads bytes 4-7 of the input as a big-endian u32, and
> > this will hit struct kho_kexec_metadata, given I am passing a C struct instead
> > of a FDT.
> >
> >   struct kho_kexec_metadata {
> >       char previous_release[__NEW_UTS_LEN + 1];  // 65 bytes
> >       u32 kexec_count;
> >   } __packed;
> >
> > Bytes 4-7 would be characters from previous_release (e.g., "0-rc" from
> > "6.19.0-rc4..."). Interpreted as big-endian u32, this gives a garbage size
> > value.
> >
> > The alternatives I see here are:
> >
> >  1) Come back to FDT instead of plain C struct, similarly to the previous
> >     version [1]
> >  2) Created some helpers to treat C struct fields specially just for this
> >     feature, and we can do it later if we have more users.
> >  3) Move this kexec_metadata to work on top of LUO (similarly to memfd), but
> >     that would be an unnecessary dependency just to have this kexec_metadata.
> >
> > That said, for the next version, I am coming back to to FDT.
> 
> Please, no. Don't go back to it just for the sake of this bug.
> 
> I think KHO's assumption that the subtree will always point to an FDT is
> broken, and we should fix that. I think KHO should expose the blob of
> serialized data and let userspace figure out what the format is and how
> to decode it.
> 
> To do that, we would need to update kho_add_subtree() to take a size
> parameter from callers, and pass that down to debugfs code. I count 3
> callers of kho_add_subtree() - memblock, LUO, and test_kho. I think all
> 3 should be fairly easy to update, but I am happy to help out if you
> need.

Sure, let me hack and see what I can get here.

Thanks for the direction,
--breno

