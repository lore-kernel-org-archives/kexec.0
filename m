Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D65EC2D0CD
	for <kexec@archiver.kernel.org>; Fri, 16 May 2025 03:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QrgAgySR+qWyR+vITbnGF4AFTvEjlTBU5z505u2bgoQ=; b=Sq2l+J6xjt8ARc7KSwcHPJSCE6
	2zh/8CM/AdlXD4BABK5jqF+rWhs3/SMiCqK8TnL/9XuchEdqAb0YrgdJGrTtbywLcy+uZU1MB2btx
	7nWooSrX1i3qEMS1t1dGmZ0xfTip36DFDswiQTNt5nYr/toF2MsMYXxVZewBwuf3m3hawCePj3yid
	/F7fLh8/3nDlCgOCywortzTlcQOd7SYDC0PapohMtp4UE72tV1Y6gxZhOOrqZ6mU65vZaLfblbb6g
	Xnozlxl4OzmC126l3gysfLico9ov2ELZoFU0s5DCg9DGYWQJZGB623JcvNcK1K3ivSahvlz0aT6I8
	0EYziO9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFlr5-00000002Odl-3Ano;
	Fri, 16 May 2025 03:35:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFlr2-00000002OdC-2uWi
	for kexec@lists.infradead.org;
	Fri, 16 May 2025 03:35:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747366523;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QrgAgySR+qWyR+vITbnGF4AFTvEjlTBU5z505u2bgoQ=;
	b=C+BZIMYB0ELv9sGTdmv6OwlJtsBkpJPLjBqGGBMYbt4XcvfizGKGG51qM/9hMMPbZFPAND
	qlWn69DyJE3PZAnWydV35fU+/LMdzAJyru2YsgGHhf2u4yCQOdeGz3agy8v0rfgV3x63F+
	DipxP8PKfq7mMSUX8D9HUUE1vnGiERw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-jUuzTCx1N76rAkaJx-LxpQ-1; Thu,
 15 May 2025 23:35:21 -0400
X-MC-Unique: jUuzTCx1N76rAkaJx-LxpQ-1
X-Mimecast-MFC-AGG-ID: jUuzTCx1N76rAkaJx-LxpQ_1747366520
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70D5F1800570;
	Fri, 16 May 2025 03:35:19 +0000 (UTC)
Received: from localhost (unknown [10.72.112.140])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EA2A195608D;
	Fri, 16 May 2025 03:35:16 +0000 (UTC)
Date: Fri, 16 May 2025 11:35:12 +0800
From: Baoquan He <bhe@redhat.com>
To: Coiby Xu <coxu@redhat.com>, kees@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Cc: fuqiang wang <fuqiang.wang@easystack.cn>,
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v4] x86/kexec: fix potential cmem->ranges out of bounds
Message-ID: <aCaycGEtgNvynjNQ@MiWiFi-R3L-srv>
References: <20240108130720.228478-1-fuqiang.wang@easystack.cn>
 <ZZzBhy5bLj0JuZZw@MiWiFi-R3L-srv>
 <4de3c2onosr7negqnfhekm4cpbklzmsimgdfv33c52dktqpza5@z5pb34ghz4at>
 <20250507225959.174dd1eed6b0b1354c95a0fd@linux-foundation.org>
 <2754f4evjfumjqome63bc3inqb7ozepemejn2lcl57ryio2t6k@35l3tnn73gei>
 <aB3RqS85p6DiHKHm@MiWiFi-R3L-srv>
 <20250509183518.bf7cd732ac667a9c20f1fee1@linux-foundation.org>
 <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sn775iwfnogyvgxetbcfneuuzsnr5wva6kc4vachyzc7r6uhfi@ozhimoihtk4b>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_203524_821814_24F506D5 
X-CRM114-Status: GOOD (  32.16  )
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

On 05/11/25 at 10:19am, Coiby Xu wrote:
> On Fri, May 09, 2025 at 06:35:18PM -0700, Andrew Morton wrote:
> > On Fri, 9 May 2025 17:58:01 +0800 Baoquan He <bhe@redhat.com> wrote:
> > 
> > > > The bad commit was introduced in 2021 but only recent gcc-15 supports
> > > > __counted_by. That's why we don't see this UBSAN warning until this
> > > > year. And although this UBSAN warning is scary enough, fortunately it
> > > > doesn't cause a real problem.
> > > >
> > > > >
> > > > > Baoquan, please re-review this?
> > > > >
> > > > > A -stable backport is clearly required.  A Fixes: would be nice, but I
> > > > > assume this goes back a long time so it isn't worth spending a lot of
> > > > > time working out when this was introduced.
> > > >
> > > > So I believe the correct fix should be as follows,
> > > 
> > > Thanks for testing and investigation into these. Could you arrange this
> > > into formal patches based on your testing and analysis?
> > > 
> > > It would be great if you can include Fuqiang's patch since it has
> > > conflict with your LUKS patch. This can facilitate patch merging for
> > > Andrew. Thanks in advance.
> > 
> > Yes please, I'm a bit lost here.
> > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch is not
> > presently in mm.git and I'd appreciate clarity on how to resolve the
> > conflicts which a new version of
> > x86-kexec-fix-potential-cmem-ranges-out-of-bounds.patch will produce.
> 
> I'll resolve any conflict between these patches. Before that, I'm not sure
> if a separate patch to fix the UBSAN warnings alone is needed to Cc
> stable@vger.kernel.org because 1) the UBSAN warnings don't mean there is a
> real problem;
> 2) both Fuqiang's patch and my kdump LUKS support patches fix the UBSAN
> warnings as a by-product.
> 
> It seems the answer largely depends on if the stable tree or longterm
> trees need it. Currently, only longterm tree 6.12.28 and the stable tree
> 6.14.6 have the UBSAN warnings if they are compiled with gcc-15 or
> clang-18. Any advice will be appreciated! Thanks!

I personally think UBSAN warning fix is not necessary for stable kernel.

Hi Kees, Andrew,

Could you help answer Coiby's question about whether we need post a
standalone patch to fix the UBSAN warning fix so that it can be back
ported to stable kernel?

In the case exposed during reviewing this patch, the code UBSAN warned
is not risky.

Thanks
Baoquan


