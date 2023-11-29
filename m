Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D07C4167B
	for <kexec@archiver.kernel.org>; Wed, 29 Nov 2023 22:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Mime-Version:References:In-Reply-To:
	Message-Id:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IlEQWc+uVlJE0l0eW29Ect1EQjvZB41PTkurSp67u5Q=; b=yjto2u3b/zwVC6
	+Cx1wTDM9pQUFsFYZ9xf2uQsMx6bou7MVfZJGHsdWIdzawpKaGJxb5xT1FfqpcRD/QCclx3uJ0bWc
	PJUoEclxQ/RDgnBg9sPEVMnKlggraDaAiCTZcULpmDst5xalpA1hjYRVVisKuu60bp+YQJJzJcdT7
	1uiNHoyCH6v18Me+USE54ynelpRSFlXxy+vzHwK9ZWVMZg9dgF4p8rPWjyInm1E2dS5f8BeGkS52+
	vRT2sXem+BXn6yEZ7xcsrGftwWSUtGsSYsTYqaajYo0Ay99JXMnmwVknLjX+/HadWGmd7bgF9uS3e
	G4ntaL4m4g7ADrmibIog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8SyF-009Qc6-2n;
	Wed, 29 Nov 2023 22:23:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8SyD-009QbS-0H;
	Wed, 29 Nov 2023 22:23:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E165B61D05;
	Wed, 29 Nov 2023 22:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4025EC433C8;
	Wed, 29 Nov 2023 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701296627;
	bh=fEXq9E8HmJBtiL8syNoj8Vbn8l4dQ40YP+5YhnLV0Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p85de6TjKrzSuMxCk7vCrt0nm7vVwuO17usm2SverDaBt/fW0T0gQ+I34dSYpgWk4
	 cxlL1oAEbTUUu6md7D41xK215v7YgzhPYGmgZPhiGVKsHo/lY2HCn7DlxkJl+kLSfH
	 Rt61YCWDZtqg4yTn5/ZLBnL2lSPWdQdgqeXnlorE=
Date: Wed, 29 Nov 2023 14:23:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, eric_devolder@yahoo.com,
 agordeev@linux.ibm.com, bhe@redhat.com, kernel-team@cloudflare.com,
 stable@vger.kernel.org
Subject: Re: [PATCH] kexec: drop dependency on ARCH_SUPPORTS_KEXEC from
 CRASH_DUMP
Message-Id: <20231129142346.594069e784d20b3ffb610467@linux-foundation.org>
In-Reply-To: <20231129220409.55006-1-ignat@cloudflare.com>
References: <20231129220409.55006-1-ignat@cloudflare.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_142349_192834_35B4DE4F 
X-CRM114-Status: UNSURE (   8.19  )
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

On Wed, 29 Nov 2023 22:04:09 +0000 Ignat Korchagin <ignat@cloudflare.com> wrote:

> Fixes: 91506f7e5d21 ("arm64/kexec: refactor for kernel/Kconfig.kexec")
> Cc: stable@vger.kernel.org # 6.6+: f8ff234: kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP
> Cc: stable@vger.kernel.org # 6.6+

I doubt if anyone knows what the two above lines mean.  What are your
recommendations for the merging of this patch?

> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
