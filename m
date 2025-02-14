Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6348FC02198
	for <kexec@archiver.kernel.org>; Fri, 14 Feb 2025 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7yi72R0Nz8kBHfuyIk+iNfsKyBAeioxJSncv2DyzS0=; b=GuGiALvvenjSR1z85ffPnf1frO
	NnwQ1MkrulSsgKzAVsHhICtBxsb13PWODT813txyscwmSlkg4XmwnYlRP+nZHfb4RVWUC6cWCUrmR
	L+EpC09IRqj3mvvWhuO10dCpJtPKUxAwaTHO2gbDkKY+8E6KTPWBtCV6etvYlmYOO4YDQhHNc7S+L
	VWuAjjYiLZc33gEptzdAOJ9FQfCXl5tHWBwuJre4JndoyF+49dS0DobmM9TmXL8SECfPotjjkJgZB
	gpjMypQIgfnlBr7A8L2YsIayk+Mu9Nwu5TAfT+N5ruNknOPhw1RXw/mBDog3VvTzKZ1mMYq8Z5LvR
	1gfutEcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tj5P4-0000000GWU8-21Sv;
	Fri, 14 Feb 2025 23:47:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tj5P1-0000000GWTj-3ib5
	for kexec@lists.infradead.org;
	Fri, 14 Feb 2025 23:47:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4CD195C5CCF;
	Fri, 14 Feb 2025 23:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21389C4CED1;
	Fri, 14 Feb 2025 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739576841;
	bh=UaT4pT/qCsHoeJRBMNkHe+2UwOkbHkv+62ubBAL9wn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FbfD5i3/hVxZvhRBj9Xwgju60aRyu8cYTKKxyet3yFHWi0hqDcNdqpdW3zpxCMVrs
	 PYjf/m80SHm8qi1KBfIizD9udceLsmL0Bz6AuB24uT6QZ57jEWGot9IoPrVZ26fbO1
	 OnAdpsgluBvpvc13iIvT43rlFp2/N6iRNgqe8PcU=
Date: Fri, 14 Feb 2025 15:47:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>, Alexander Graf
 <graf@amazon.com>, Baoquan he <bhe@redhat.com>, Hari Bathini
 <hbathini@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec: Fix kexec_locate_mem_hole() for missing
 CONFIG_KEXEC_HANDOVER
Message-Id: <20250214154720.42c1fab53ad7c3d3f8c968aa@linux-foundation.org>
In-Reply-To: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
References: <20250214125402.90709-1-sourabhjain@linux.ibm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250214_154723_982475_3C15C0B2 
X-CRM114-Status: UNSURE (   9.61  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Fri, 14 Feb 2025 18:24:02 +0530 Sourabh Jain <sourabhjain@linux.ibm.com> wrote:

> While adding KHO support, commit 7d128945e003 ("kexec: add KHO support
> to kexec file loads") returns early from kexec_locate_mem_hole() if
> CONFIG_KEXEC_HANDOVER is not defined.
> 
> Due to this, kexec_locate_mem_hole() does not locate a hole for the
> kexec segment, and kbuf.mem holds 0x0. This leads to a kexec_file_load
> syscall failure in sanity_check_segment_list(). This impacts both
> kexec and kdump kernels.

Thanks.

Mike, I'll remove the v4 series from mm-unstable to gie you a clean
shot at v5.  Please incorporate Sourabh's fix?

