Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF9AC47089
	for <kexec@archiver.kernel.org>; Sat,  3 Dec 2022 01:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jq84G2CM4gMhVa9iL/2+0Q6w2IAHhlYgQDRe/u55UCk=; b=zXdoAQgc5uiiDq
	4sDITuPBlJfDORgCCLShzX/mImhny0i5PcuVTf6JvN6C5suub3PRh6QPr2RH6hYv7/8HESroteD6R
	FXe2eskqRxoiOFEZLEmyClYDtGzzdNbrrfkuYSmhRYpQxZ46ElQQ3k3G43FS/8IDMgqGnewUlTTHO
	/Ol9NLOJs/NGZ4afISO1/bHupollLOzndoJeoweEqrq6qnRnniFTMSWaN/LYYjrfwE9D4wAZBSHAi
	38BO+O4hogXUoAHXJs7ITg2X6Y3Gu8X4xhfCHkDw+z9fKBYcwhCiOTnnkOkE7RQTTrjtZgz/4lvhs
	TpWOSbPFKxovsqQOptSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1GtC-001sMC-RF; Sat, 03 Dec 2022 01:00:22 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1GtA-001sLh-52; Sat, 03 Dec 2022 01:00:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4D81761CD3;
	Sat,  3 Dec 2022 01:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91984C433B5;
	Sat,  3 Dec 2022 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670029216;
	bh=MGsPTcfIDMe8NsW+WgRecjSM7wji1B+lYnN8B7L988E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DnOIfI/oz3QrsMN5TuUpL4+k48Cgf1oo2sPSBBvl6Mo2HqJPMaI4tz0CSTIIMRaIS
	 SRZTLFxi/xfJ97DlMF+60OXNAFRBpTu16M8+4yWIsMp2wnMsFUhHyGQTVDuhRpOfzE
	 aUSYPDS3QoRdCA/VDPMI1Q+qjhIi8g4eU32SuTTunZnYJI54tig6yhCL3uTtsnPWSv
	 wXKqPBGKxfustW6KDKNC461eKxZ/w+M8KuoeYuT3g0KVrPZcvtEG8p2A4AjKoB+AEI
	 h8MyMtL+i41gbjgKPFmN0FJVqltNSLhB0aKd0g8xHKHlUREnuYDKx8nlGNgSd3saoC
	 CvQZOE7R7ptAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75819C395EC;
	Sat,  3 Dec 2022 01:00:16 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
From: patchwork-bot+linux-riscv@kernel.org
Message-Id:  <167002921647.19521.1698989789137180552.git-patchwork-notify@kernel.org>
Date: Sat, 03 Dec 2022 01:00:16 +0000
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
To: Xianting Tian <xianting.tian@linux.alibaba.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
 heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
 alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
 bagasdotme@gmail.com, kexec@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, crash-utility@redhat.com,
 heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
 hschauhan@nulltrace.org, yixun.lan@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_170020_254182_38DAEBC8 
X-CRM114-Status: UNSURE (   8.73  )
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

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 26 Oct 2022 22:42:06 +0800 you wrote:
> As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> need to update according to Bagas's comments.
> https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> 
> As others patches in above patch set already applied, so this patch set only contains below two
> patches.
> 
> [...]

Here is the summary with links:
  - [V5,1/2] RISC-V: Add arch_crash_save_vmcoreinfo support
    https://git.kernel.org/riscv/c/649d6b1019a2
  - [V5,2/2] Documentation: kdump: describe VMCOREINFO export for RISCV64
    https://git.kernel.org/riscv/c/c5b4216929eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
