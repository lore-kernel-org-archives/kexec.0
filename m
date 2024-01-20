Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CBFC47258
	for <kexec@archiver.kernel.org>; Sat, 20 Jan 2024 22:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=htRIeWVBaBVKAGgznLzyO94JMJe210g5rmHVnb5MoIo=; b=FLRLE+u9kjn1AK
	1Z6Ug6J+SVlc+4r3+hpVh9sjdt15v3lma4zw2TeKtNmIB57QLUMXKcwOMno2akdFw3b0mKvk++iBZ
	D9Cx5zekIJnIsl440k1ET3Cj2BoEeTnZtjnUte5HosfYqAL+iKp4/qUElEhpqZWSVpGMo7tl/OuRb
	/vAFu+sJ4NDvF8UUFLv44epreO6Sx83tsBz10TkTIHS9Q3JaZgLyDlHSjzdEgYsaDExoL6RjjnzkU
	yB52IlVnbpJpcM0PaCmzcmOgpwzxGjzbJGHnEe/ncjAZvCGTgxyiWADPvtc9aQJDLPK/Azr0CBvaf
	yvmlIfG9WOf+JSmh3SUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRJdv-008VJ0-2L;
	Sat, 20 Jan 2024 22:16:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRIbF-008ODI-39;
	Sat, 20 Jan 2024 21:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 9656DB801B8;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46711C43601;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784996;
	bh=M7g5eRyDPxCySbVq6qDMpJN6lmzZYx8poGv+sF2twdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KbmoeAq7o7z84/lro+jEKm1k97jjrEPcVrACcDrYuLRy9Kepw5VBWZrC2wJxF6fuH
	 PW7SfU7Frq6lq7u1MDRxrasoF4gu1E1+tGwyHKlfb23T8CvY27FhMBUVLdIQURQjZm
	 TME1+Nh7DgfUkJdAsotvo6Ifk0SKEU6aBcd3MR33o1jGwt+90HguzQ/40bkIov21X2
	 if9wnzOWEZ8tvlAmKNrcP/dSqnu9Cxx5gHjMTGQiQ42QM79wr3k0Gy1ev8sOroM4MG
	 iq0uAD6C40c1E84s5qKqFoqo2AtGwThoOMyFSclSGQthE4LlXigIyHTYu1T8IvDXPE
	 lyUifJs78Drdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 363D3D8C970;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH] riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <170578499621.24348.1106516858388911395.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:56 +0000
References: <20231201062538.27240-1-bhe@redhat.com>
In-Reply-To: <20231201062538.27240-1-bhe@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, mick@ics.forth.gr, changbin.du@intel.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240120_130958_180068_796F2FB7 
X-CRM114-Status: UNSURE (   9.46  )
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

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri,  1 Dec 2023 14:25:38 +0800 you wrote:
> This was introduced in commit fba8a8674f68 ("RISC-V: Add kexec
> support").
> 
> It should work on CONFIG_KEXEC_CORE, but not CONFIG_KEXEC only, since
> we could set CONFIG_KEXEC_FILE=y and CONFIG_KEXEC=N, or only set
> CONFIG_CRASH_DUMP=y and disable both CONFIG_KEXEC and CONFIG_KEXEC_FILE.
> In these cases, the AFLAGS won't take effect with the current ifdeffery
> for AFLAGS_kexec_relocate.o.
> 
> [...]

Here is the summary with links:
  - riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o
    https://git.kernel.org/riscv/c/d53a154cdc54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
