Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89E35C54E58
	for <kexec@archiver.kernel.org>; Sat, 23 Mar 2024 16:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Date:Message-Id:
	References:In-Reply-To:From:Subject:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pVJaSDV/jqbYkpQpouxk/z9FrVCDZnFbQ9v4pKNsCdY=; b=e2ePlYezuoI9ft
	CnWt9VVoWzaYJ319gm0A0vBLoE10nx9AgnNYNZ10lqomVoNz238GrAwBDt+rhSukqog4LG7tuMVqy
	NpqTprJD4kkjnMPW0+wl/Nnsy1g5MCOyJZL3KoccxnJoAGMZmauDT17D9a6AoP9cfCqsKF+LKp/1x
	cbzjS16WII5ao3ra46A7SBItO1At/NADq/MBMVnlJuKuCG6j0PBHyuANB2HW7JWg9IvA5LApgs3nk
	XogoGWgcZWHBdO1wp0vLuv0W95KBwwFZ/rs/R8rqWsp2pnGSIk6N7BotaeABeKaVwqjcMtJS9U1MO
	6HgkiGgW6oN/z4PHcRww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro4B1-0000000AifX-31jr;
	Sat, 23 Mar 2024 16:24:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ro4Av-0000000Aibl-3UhV
	for kexec@lists.infradead.org;
	Sat, 23 Mar 2024 16:24:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B9AB60202;
	Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 252D9C433F1;
	Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711211092;
	bh=T3OAyKyJpcbqAIQyHuZW09u3eIcA963sn5FOSQf9ROY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UIcg4FACYS16+O2uIsLA5ERgr+Zak+DWfradJRPzhFtZcYLF/JCxCRkdUMRkXKyAm
	 rrLOxckhyzcAKBJbDBCAcS8Q/VINEqGBpGjohK3UtqpR8zdCL8An9IFJ+GKGAPnxrQ
	 NM6sJcJgTGQfNmzNaamljx3R8W6r6jRS1LHfs+LU9YQ9zXPU8Ih9RKWufB05MeFSut
	 BWhP7v0F4z2eSNiAhizTDPJF/r24vQJ7yn5e7Y5LZZTs2dsiPFjKBGqGEGJaqTFI5i
	 ipcTj199sfSl5HqY8uZUMSAbLeFjmSMsR4DplanVAQyTCLEmUQ2xcpTu5DKxIhW1AT
	 xZ9ynmS9Ana5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C228D8BCE3;
	Sat, 23 Mar 2024 16:24:52 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.9-2 tag
From: pr-tracker-bot@kernel.org
In-Reply-To: <87zfupix7p.fsf@mail.lhotse>
References: <87zfupix7p.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87zfupix7p.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-2
X-PR-Tracked-Commit-Id: 5c4233cc0920cc90787aafe950b90f6c57a35b88
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 484193fecd2b6349a6fd1554d306aec646ae1a6a
Message-Id: <171121109210.3260.13947764386545794887.pr-tracker-bot@kernel.org>
Date: Sat, 23 Mar 2024 16:24:52 +0000
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bhe@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, hbathini@linux.ibm.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240323_092454_031350_66362188 
X-CRM114-Status: UNSURE (   4.62  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

The pull request you sent on Sat, 23 Mar 2024 11:54:50 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.9-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/484193fecd2b6349a6fd1554d306aec646ae1a6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
