Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6E3C3DA7E
	for <kexec@archiver.kernel.org>; Mon, 29 Jul 2024 16:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mKasWaV8U7SxO2CdVzxZX7821LDV9/gPEvZB9CskrzY=; b=uvJ3ZyTfhLfoXq
	TYwTTDGxEAMZKG4BP90mrWEjXUHj9smFgXDQu/uJ2VE2B1Fdfj60+1FIXZL098qcRXxadxddtFjJZ
	s0XPs6SCXZBSRxftcl1yn5QdR/l9KXAs5hNzueEWbZ6OEXX+QSXfHNJazZ5NZSXRFEfQUmH+JIvdl
	2UVM5Ydah9NAbG+iH3r4SPilP+xy/NvrULsTpvf7BXnQt+9wRNEtKj7o6HIxyJkXVL7rAmFyl9b18
	RXXMREEAurNPHQxPyaT/dJngvJpbYuWfVT3RGtAyNObGurOW0BcUk5hQYWwQJRfJQ9R0yVqTui554
	y4f4JIjeYf2yiPAMEYNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTPV-0000000C4kf-1Mol;
	Mon, 29 Jul 2024 16:39:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYTPR-0000000C4ho-0bL6;
	Mon, 29 Jul 2024 16:39:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3915361B45;
	Mon, 29 Jul 2024 16:39:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5937C4AF0C;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271179;
	bh=ACOFD4CnvNQvgxH3c3fJIkYLBWpRIGrdoWdi94w0LGY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxGffYremrlYV7IoL+PFdzTVghbhUmYE24NoiOXwot130hJR092fMDPljyjOFHVdc
	 BwOk8pSOjwwKbEdqNqxYUxpql4UoUKiFJ2lsCDqaei8fiv2nLmq0phzDybvS4Ruc8d
	 z/XfJg+CKgAclYeW7CbbQLEE7gLL/hM0xFPcU/zrpTnoN8mAo4/WHGmlPe/dDySyr4
	 +P5sQueNRxv+PdBs1m2FMKXNsYAKLBJPpcrqn+AXFKcM9NOrWmX7bCZDnXiuc8wZZk
	 cgjYyQYbzjQhie1m/6w7FgPL23bO3WKyoer9qNey5Cb3pqkqUfzFfvK9OYAA6SDF3G
	 K/Q0xuxSAzaPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA0BC43613;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <172227117976.3603.14526183264046270376.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:39:39 +0000
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
X-CRM114-CacheID: sfid-20240729_093941_261720_CAD3514F 
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

This pull request was applied to riscv/linux.git (fixes)
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
    https://git.kernel.org/riscv/c/f8a8b94d0698

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
