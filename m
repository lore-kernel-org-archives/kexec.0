Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EFDC47DDB
	for <kexec@archiver.kernel.org>; Sat, 20 Jan 2024 21:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References:Date:
	Message-Id:From:Subject:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AO1/QTgy16nDlAyh6oUXQnzeixqymRWcTZeK8r1u9QM=; b=CRAaKceUVM1qsv
	OuEOSf5/9yA+QkJ6f+VUlKmUfK4DCcxILRYuCgVzISAYg20VI7q9OI4prarh5kKNQVipKtAXj5c4l
	imXBYlSZn+6wfWaPLbIg9W5pgWvY/BGfB20aum/vK4iwD63HwwRgNf8vQesvfs97KZG1EKjOOO56z
	lbaT3PqRfsx0KTU9vmDniEnO0XnJyGFnY6GY+eQ/+FLVb0TJz7rmaV6Rb3FYSzbiob9kns4WRdGTG
	agu+HlcNMEArSplhJXP7aePc6CIwJTlW4E6GN/rC4hm87gJ5rdD1VNl/axTK3U/har7Bq6n8xyZCd
	SQkMxPUERv/jgRX3Ri/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRIbQ-008OPB-1J;
	Sat, 20 Jan 2024 21:10:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRIbI-008OFK-2f;
	Sat, 20 Jan 2024 21:10:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 68D25B8093B;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16022C43399;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=Ak11chN7WclRj25UANXp4k7/EzZxe8YnZ7/DdCdJ/Eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IkVsrhLG/8fIWEIS1jEMWek7Zvt5oHhH4iIiHcFrYKDuct84cFWNZbyPVw7aE5USn
	 EdxvcG4HNDlt83k333dnvaOcO2tidVEdbhq0CJFxJ93Prs3gEH/p58Qy+GRyl8MbIG
	 meRvcghCnLWoHc45/tNBHxbTKecNuou/KLSqasbtSvlo31zpH/vwXMEceiLwTJ5m7a
	 YjChVCAqCod2OXw7UwGW23JceU1AUwebt/FMs3NKZ8hUGwmQQ5/Zq5DoX5UetCZ7iJ
	 PdCbAB2zls/W0Ay7Xq8My+r1A2H2Yz4w3lrzw3EiKKtObnuVW7ravh/Ls8/tlKFzw/
	 65jpJECS34fYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0468BD8C96C;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/7] kexec_file: print out debugging message if required
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: <170578499901.24348.12653685452300606867.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20231213055747.61826-1-bhe@redhat.com>
In-Reply-To: <20231213055747.61826-1-bhe@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-parisc@vger.kernel.org, akpm@linux-foundation.org, joe@perches.com,
 nathan@kernel.org, conor@kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240120_131001_015772_A0D84921 
X-CRM114-Status: UNSURE (   7.64  )
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

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Wed, 13 Dec 2023 13:57:40 +0800 you wrote:
> Currently, specifying '-d' on kexec command will print a lot of debugging
> informationabout kexec/kdump loading with kexec_load interface.
> 
> However, kexec_file_load prints nothing even though '-d' is specified.
> It's very inconvenient to debug or analyze the kexec/kdump loading when
> something wrong happened with kexec/kdump itself or develper want to
> check the kexec/kdump loading.
> 
> [...]

Here is the summary with links:
  - [v4,1/7] kexec_file: add kexec_file flag to control debug printing
    (no matching commit)
  - [v4,2/7] kexec_file: print out debugging message if required
    (no matching commit)
  - [v4,3/7] kexec_file, x86: print out debugging message if required
    (no matching commit)
  - [v4,4/7] kexec_file, arm64: print out debugging message if required
    (no matching commit)
  - [v4,5/7] kexec_file, ricv: print out debugging message if required
    https://git.kernel.org/riscv/c/eb7622d908a0
  - [v4,6/7] kexec_file, power: print out debugging message if required
    (no matching commit)
  - [v4,7/7] kexec_file, parisc: print out debugging message if required
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
