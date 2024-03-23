Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D830AC54E64
	for <kexec@archiver.kernel.org>; Sat, 23 Mar 2024 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:Message-Id:Subject:
	References:In-Reply-To:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=skwasgC+9t7BGcz34Nw3ET0ofc3gTiqqA9q68dq17ZI=; b=D6KRUMMqupN7xz
	BHHvINTcOMWG4+OqqCUNinfNGmdrVjsoyUOZjp7WcgejzExjuL9Oh3Fw+1TP2E9nPYzZs7FA2Kwmw
	5e79IHfetFMlvju4ITjiCoqLAFNFqvb/tY9BuY2QcyRUng1uvjOOol+oinoSXLsRXj9JUSeugNZdj
	TusO+SGeVVVi+w62DfAU0/zryoPydstXqwTaN9c+ncHw29JgXJxsotX5LFevg+HMldi/ejFENKTpH
	5T4k4rX2pSq23SOpHdkLZINWSe//olPjlQDfgyvH16VHwsTNtuEELynjInbtp4XoJonH6o/bcici0
	SYd0/wuAMSY0N3fMyC6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnpX1-000000094Hz-3Di9;
	Sat, 23 Mar 2024 00:46:43 +0000
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3] helo=gandalf.ozlabs.org)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnpWx-000000094FL-0ZmM
	for kexec@lists.infradead.org;
	Sat, 23 Mar 2024 00:46:42 +0000
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V1gVx4dkjz4wyf;
	Sat, 23 Mar 2024 11:46:33 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Kexec-ml <kexec@lists.infradead.org>, Hari Bathini <hbathini@linux.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Dave Young <dyoung@redhat.com>
In-Reply-To: <20240226103010.589537-1-hbathini@linux.ibm.com>
References: <20240226103010.589537-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH linux-next v2 0/3] powerpc/kexec: split CONFIG_CRASH_DUMP out from CONFIG_KEXEC_CORE
Message-Id: <171115475789.936455.12230073027482662538.b4-ty@ellerman.id.au>
Date: Sat, 23 Mar 2024 11:45:57 +1100
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_174639_404198_531AB1E1 
X-CRM114-Status: UNSURE (   9.48  )
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

On Mon, 26 Feb 2024 16:00:07 +0530, Hari Bathini wrote:
> This patch series is a follow-up to [1] based on discussions at [2]
> about additional work needed to get it working on powerpc.
> 
> The first patch in the series makes struct crash_mem available with or
> without CONFIG_CRASH_DUMP enabled. The next patch moves kdump specific
> code for kexec_file_load syscall under CONFIG_CRASH_DUMP and the last
> patch splits other kdump specific code under CONFIG_CRASH_DUMP and
> removes dependency with CONFIG_CRASH_DUMP for CONFIG_KEXEC_CORE.
> 
> [...]

Applied to powerpc/next.

[1/3] kexec/kdump: make struct crash_mem available without CONFIG_CRASH_DUMP
      https://git.kernel.org/powerpc/c/56a34d799bfa53064e7b8bd354aacd176aeaecc8
[2/3] powerpc/kexec: split CONFIG_KEXEC_FILE and CONFIG_CRASH_DUMP
      https://git.kernel.org/powerpc/c/33f2cc0a2e90f7177c49559b434191b02efd0cd5
[3/3] powerpc/kdump: Split KEXEC_CORE and CRASH_DUMP dependency
      https://git.kernel.org/powerpc/c/5c4233cc0920cc90787aafe950b90f6c57a35b88

cheers

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
