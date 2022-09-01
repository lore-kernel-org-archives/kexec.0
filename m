Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981F2ECAAD3
	for <kexec@archiver.kernel.org>; Thu,  1 Sep 2022 13:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oXrFCfh6vH0qM9jf8bXPSKA8XmfZMPUkgH490aciqQE=; b=T/+qMlaYf8bPPI
	tDJRtcyshfLyz5PcmHako1506nnNRrW1Pu0kjTsf8qaNxaXuZp6xNssY4WAP273xvhOUjprQnmvLD
	78AkKKZWTxyoKVo4kTbcq0BvheGFZIBEPKOZ/lTVsKiaT3Rhb5DJ/EnQYwdHCuKzsJn7fzTVZ41mB
	1kle2YgGAb969p5U9zpgvSxgLzoYIlRAbZT58jXRzfhX8kN+HxsaRG0063PiSbAvKLBA2K/3I5BMN
	RiU6+YFN7Jy3tcKjlaZOG9Stfj/1GRJ2tcoMPEUcRFxtG5VnjyH/SUK9eLelMEA40inKL725sUY4w
	3FBeTwq0t69cZRxyfiRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTk0x-00BvQR-32; Thu, 01 Sep 2022 13:13:47 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTjuI-00BsTA-4n; Thu, 01 Sep 2022 13:06:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 75F76B82658;
	Thu,  1 Sep 2022 13:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC3C433C1;
	Thu,  1 Sep 2022 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662037611;
	bh=k4/b3x6e6SI+9q/vBPkMaUT6KMzbrIuxz/LSLsU5QlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9uBqDWQ0uYLzjPTow6VHbQvhcZTA4EN4n6BEXZ2T5GsDrTF/jm2M3y4AwNVpvsdf
	 Z5jdYWnqqaqm+5XiS7S4ce6gbfoheq8oxd1hCwbEWR+cPoPghq5Ywq9MfhKqqlw8bh
	 R62Lk2L4G/BavBdBJpHW+RgQ/YBAYBPVKrH2RIUE+FuF7fdrge+JNq2CQ7//5XPeq5
	 +pWVq+MdLV/gcTz/yK0Ytt7f7u/KvrnGOEJFeqV4GdgoXKzxNQl3a9F8M8Pfj+w2hR
	 psVky6z711ojrKzf5E0r9WFoeYeGNO434QPjP6BYffKYGBXm+aazj10XTLJ8w/r1aj
	 /obzQKo7eeTUw==
From: Will Deacon <will@kernel.org>
To: Levi Yun <ppbuk5246@gmail.com>,
	catalin.marinas@arm.com,
	bhe@redhat.com
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	nramas@linux.microsoft.com,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	thunder.leizhen@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64/kexec: Fix missing extra range for crashkres_low.
Date: Thu,  1 Sep 2022 14:06:32 +0100
Message-Id: <166202940119.739039.2574146355073942653.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220831103913.12661-1-ppbuk5246@gmail.com>
References: <CAM7-yPRp7wpP1a=SrH4o2SBijF4ZfxkLTe7vpRXq_D_y1Kz-1g@mail.gmail.com> <20220831103913.12661-1-ppbuk5246@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_060654_369952_08CC8E98 
X-CRM114-Status: UNSURE (   8.39  )
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

On Wed, 31 Aug 2022 19:39:13 +0900, Levi Yun wrote:
> Like crashk_res, Calling crash_exclude_mem_range function with
> crashk_low_res area would need extra crash_mem range too.
> 
> Add one more extra cmem slot in case of crashk_low_res is used.
> 
> 

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/kexec: Fix missing extra range for crashkres_low.
      https://git.kernel.org/arm64/c/4831be702b95

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
