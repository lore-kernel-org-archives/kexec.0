Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01976C2D0CD
	for <kexec@archiver.kernel.org>; Mon, 19 May 2025 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lXzggVegcJaYU/PKMAlnm0SQ33yoeyXYBHu/n8B9S8s=; b=nvsVXJxwrncz17XcM8HQXuCiFP
	zVXNuFLpqx3egBiQz1zBKeYf74YRa53C5rx3UlguDPiVhZ9ETUkIoysghEOsJlzNt55uMeQAd5v4N
	yIBc2YeGJNF9DDoc1F5z8A5LaZor8LFxH14x/rXsT1+VcbDA8WWtKQRVPFEAt6mJkoaa46UB2D1ut
	ccRAlaA93GQ5qOQGjJBZpHWlQmaj7zkVsT4rofQpmYQL1favJlPNIvf06SEMe67LGXZf1OfaZK2Rk
	s55Wf9v9HVVOhXk6r2MbhrcEPg94IceKJxKKDU6xZi2793yV0+19mbr1fWMLhaGZ+QYdt+SgEL/60
	wO/JnRvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH2NV-00000009boM-1rxw;
	Mon, 19 May 2025 15:26:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH1Zt-00000009SYk-2uFU
	for kexec@lists.infradead.org;
	Mon, 19 May 2025 14:34:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747665292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXzggVegcJaYU/PKMAlnm0SQ33yoeyXYBHu/n8B9S8s=;
	b=cPyfI/TT8A/fXzjvKLFn6dANEqPiixzZSjDr/obVfLcr5/g6m+RRdpRpE53tM+mkxUeqt9
	5uRqS/3qd/4EpL4fhFXsC8gfdMFYigncNdQpGAizSWsEH/SS4Qz6Nb3I5Va2lqTgJa41aH
	q7TwmZJYCncthbAnyL5INKTzbFco9VU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-SM5ICl_JOaSxmooY_RCiZg-1; Mon,
 19 May 2025 10:34:49 -0400
X-MC-Unique: SM5ICl_JOaSxmooY_RCiZg-1
X-Mimecast-MFC-AGG-ID: SM5ICl_JOaSxmooY_RCiZg_1747665288
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0060D195609E;
	Mon, 19 May 2025 14:34:47 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E16E11956096;
	Mon, 19 May 2025 14:34:44 +0000 (UTC)
Date: Mon, 19 May 2025 22:34:39 +0800
From: Baoquan He <bhe@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Coiby Xu <coxu@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	fuqiang wang <fuqiang.wang@easystack.cn>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <aCtBf2LqRqlWXaUp@MiWiFi-R3L-srv>
References: <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
 <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
 <202505161616.F4C1BCCF6A@keescook>
 <aCksAsgAw1jsGBL9@MiWiFi-R3L-srv>
 <202505190716.B21F11984@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505190716.B21F11984@keescook>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_073453_797791_91C781C5 
X-CRM114-Status: GOOD (  47.80  )
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

On 05/19/25 at 07:19am, Kees Cook wrote:
> On Mon, May 19, 2025 at 09:22:30AM +0800, Baoquan He wrote:
> > On 05/16/25 at 04:20pm, Kees Cook wrote:
> > > On Fri, May 16, 2025 at 11:35:12AM +0800, Baoquan He wrote:
> > > > On 05/11/25 at 10:19am, Coiby Xu wrote:
> > > > > On Fri, May 09, 2025 at 06:35:18PM -0700, Andrew Morton wrote:
> > > > > > On Fri, 9 May 2025 17:58:01 +0800 Baoquan He <bhe@redhat.com> wrote:
> > > > > > 
> > > > > > > > The bad commit was introduced in 2021 but only recent gcc-15 supports
> > > > > > > > __counted_by. That's why we don't see this UBSAN warning until this
> > > > > > > > year. And although this UBSAN warning is scary enough, fortunately it
> > > > > > > > doesn't cause a real problem.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Baoquan, please re-review this?
> > > > > > > > >
> > > > > > > > > A -stable backport is clearly required.  A Fixes: would be nice, but I
> > > > > > > > > assume this goes back a long time so it isn't worth spending a lot of
> > > > > > > > > time working out when this was introduced.
> > > > > > > >
> > > > > > > > So I believe the correct fix should be as follows,
> > > > > > > 
> > > > > > > Thanks for testing and investigation into these. Could you arrange this
> > > > > > > into formal patches based on your testing and analysis?
> > > > > > > 
> > > > > > > It would be great if you can include Fuqiang's patch since it has
> > > > > > > conflict with your LUKS patch. This can facilitate patch merging for
> > > > > > > Andrew. Thanks in advance.
> > > > > > 
> > > > > > Yes please, I'm a bit lost here.
> > > > > > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch is not
> > > > > > presently in mm.git and I'd appreciate clarity on how to resolve the
> > > > > > conflicts which a new version of
> > > > > > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch will produce.
> > > > > 
> > > > > I'll resolve any conflict between these patches. Before that, I'm not sure
> > > > > if a separate patch to fix the UBSAN warnings alone is needed to Cc
> > > > > stable@vger.kernel.org because 1) the UBSAN warnings don't mean there is a
> > > > > real problem;
> > > > > 2) both Fuqiang's patch and my kdump LUKS support patches fix the UBSAN
> > > > > warnings as a by-product.
> > > > > 
> > > > > It seems the answer largely depends on if the stable tree or longterm
> > > > > trees need it. Currently, only longterm tree 6.12.28 and the stable tree
> > > > > 6.14.6 have the UBSAN warnings if they are compiled with gcc-15 or
> > > > > clang-18. Any advice will be appreciated! Thanks!
> > > > 
> > > > I personally think UBSAN warning fix is not necessary for stable kernel.
> > > > 
> > > > Hi Kees, Andrew,
> > > > 
> > > > Could you help answer Coiby's question about whether we need post a
> > > > standalone patch to fix the UBSAN warning fix so that it can be back
> > > > ported to stable kernel?
> > > 
> > > I went back through the thread and the referenced threads and I can't
> > > find any details on the USBAN splat. Can that please get reproduced in a
> > > commit log? That would help understand if it's a false positive or not.
> > 
> > 
> > The original patch is trying to fix a potential issue in which a memory
> > range is split, while the sub-range split out is always on top of the
> > entire memory range, hence no risk.
> > 
> > Later, we encountered a UBSAN warning around the above memory range
> > splitting code several times. We found this patch can mute the warning.
> > 
> > Please see below UBSAN splat trace report from Coiby:
> > https://lore.kernel.org/all/4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at/T/#u
> 
> Ah-ha! Thanks for the link.
> 
> > Later, Coiby got the root cause from investigation, please see:
> > https://lore.kernel.org/all/2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei/T/#u
> 
> Looking at https://lore.kernel.org/all/aBxfflkkQXTetmbq@MiWiFi-R3L-srv/
> it seems like this actually turned out to be a legitimate overflow
> detection? I.e. the fix isn't silencing a false positive, but rather
> allocating enough space?

This v5 is on top of below patch which Andrew has picked to his mm tree.
In there, it happened to get the ubsan warning fixed. But the hunk
doesn't reflect it in the v5 patch.

[PATCH v9 7/8] x86/crash: pass dm crypt keys to kdump kernel
https://lore.kernel.org/all/20250502011246.99238-8-coxu@redhat.com/T/#u


