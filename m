Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A330C3DA61
	for <kexec@archiver.kernel.org>; Mon, 29 Jul 2024 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fHXLRhcgzUSFiJNJErAGcLjDr+4D7av6IiPKfEp23gg=; b=ZsQzfy9K1MaZEf
	vd04ZJDhfDmvRdJt7cKKtWVnmPrjh15ZavdpCp0LD8sK76aAwdP3A8BlFkAZ7js3yOD++u/9mnOCW
	1O8AYChj/AgTC3Eob9Ddn1bZgC7rKfl7oQUeCvrqQt1j77oTrUzXxI6NJxDmbkyE6jJSl1EV30zX+
	oFcihEvwYjVY17unJGBHG13+I5xTxRimr/gYmFisgZzedtHNm22y/Ht8kw1OZ4d4ABKP/NGUkwtcI
	2fsHdqqAMQ116WknKz0mrFsJh3hVjmlyk8NBJKt+3xO79GcBz0draEnMdrBz0yP6f+gZ7toeknNgb
	q9DDpaVb6TgtlS6jo51Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTSN-0000000C61d-3vLV;
	Mon, 29 Jul 2024 16:42:43 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTSJ-0000000C606-3CU3;
	Mon, 29 Jul 2024 16:42:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id E2FECCE0E04;
	Mon, 29 Jul 2024 16:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 219B9C4AF09;
	Mon, 29 Jul 2024 16:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271357;
	bh=mA3Plo9rccbKR8tQpMvqb5/37K14bOyxIOzFzkCyo2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQESavfQWIyHKftqPvTmy4wVhUA6HIJqwcdczB7gzKs7W9HP4VgXBcAvnS2OY1QPQ
	 6v8azN0AnBdvEUaiuvvYn24UYpSAPhOt9Kc8PnA5pAQgRzOyjZDqBpRpAggC47L+YO
	 3pDtCbTERg/BZjIP98WKxyLB+Jl8i0jRFbFjiovwHjjJOglSPdvIoPPigoU6llsN7p
	 NnUKMTJeRMcEWdczEcxBDiNNs1O1d1p7FYZtvzItkwiDmtNqDhaPHf3wXrrW8U4yYI
	 kgmuh8yjEhzjRpHcoAw7LVo1omVPzA9Do3we2wqTVe6+zyxFoijU6kc6a1Jy9HiSUh
	 MFjtM1ssSTzFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0CA11C43445;
	Mon, 29 Jul 2024 16:42:37 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <172227135704.3603.7348565051958076479.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:42:37 +0000
References: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
To: Joel Granados <j.granados@samsung.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux@weissschuh.net, mcgrof@kernel.org, kees@kernel.org, kuba@kernel.org,
 david@fromorbit.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org,
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240729_094239_984781_668941FF 
X-CRM114-Status: UNSURE (   9.33  )
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

Hello:

This pull request was applied to riscv/linux.git (for-next)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 24 Jul 2024 23:00:14 +0200 you wrote:
> Linus
> 
> Constifying ctl_table structs will prevent the modification of
> proc_handler function pointers as they would reside in .rodata. To get
> there, the proc_handler arguments must first be const qualified which
> requires this (fairly large) treewide PR. Sending it in the tail end of
> of the merge window after a suggestion from Kees to avoid unneeded merge
> conflicts. It has been rebased on top of 7a3fad30fd8b4b5e370906b3c554f64026f56c2f.
> I can send it later if it makes more sense on your side; please tell me
> what you prefer.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] sysctl constification changes for v6.11-rc1
    https://git.kernel.org/riscv/c/b485625078ca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
