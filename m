Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCCDC77B73
	for <kexec@archiver.kernel.org>; Thu, 20 Apr 2023 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DmjMtsTuP/uXNiVYJq3S6lkdoTZ9S7WZa3dbHSuhH/k=; b=mzfRGm8YONyKcx
	BzgyBfKvXnfhRH8EBPv8F9+q6ZDjowN8tyAzaSdR/5K2xevg1HduKLQI7c/VxJBUKn0du8Rx4WeCg
	LguImm3xCz9dSVkRDBl1l9ZUk5id0ZSk78Eihba1y3yaqt5a0f9/VS6nITCwQZ0p3GfYwC9+r89Ag
	yrAll+Z8SeqezhM8w0i2FxKhx2+6NVLErbCTrL4LU38KhdUDBdRV0UbjF/Ze74MlpaOR0aHdk8H75
	BhW61gm/r0iAu1AfgZeZagCXu3QBDuxvIoKN6MISet5L54JNm9HsUwDiBQGeZ/XuZ+o1q0eDjqKwh
	bJqy6Nh5BZt1Ioq9+aHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppXiW-008bJN-2l;
	Thu, 20 Apr 2023 17:05:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppXiS-008bIS-1k;
	Thu, 20 Apr 2023 17:05:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2836B64AD4;
	Thu, 20 Apr 2023 17:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DE2C433A0;
	Thu, 20 Apr 2023 17:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1682010303;
	bh=r2eeQ0iXJ7ydhiOTGTE/GvYZEnWak6zfob+C7cJ437E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TfwBrO2q65C1eHTXV61cIp+2gCUDaNTYjaefe5ZlK43MNJTNn2QhvXosXRSQDXKvl
	 44tTliWSTD04CErcAswnGbaj8TP1m90CGal6nnJ2NTglMORS6Z9i2VtffJ31e5ozwL
	 mkwpj5AYKb4E/IpQw21iOit2kyeQdnsCiKTdTV4IurRsRWjKgZmnTced7HKTJvv4Ae
	 k1OXunaTz2jTHeMpwbtZlST4rjX+yw2irETHgmhe08apfNGJf17MRT24FTn8ObbXoL
	 ZkBL3cUoFFfxSY5iDALaaIdadWUUOtxwegLYrZzwhwDU9R8lCzIPH1vjqdPqr/a+1s
	 8AdnkcueFWDag==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Simon Horman <horms@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Baoquan He <bhe@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kexec@lists.infradead.org,
	"Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] arm64: kexec: include reboot.h
Date: Thu, 20 Apr 2023 18:04:53 +0100
Message-Id: <168198392367.147167.8214312015996528355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
References: <20230418-arm64-kexec-include-reboot-v1-1-8453fd4fb3fb@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_100504_618044_C39E259F 
X-CRM114-Status: UNSURE (   8.60  )
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

On Tue, 18 Apr 2023 13:54:00 +0200, Simon Horman wrote:
> Include reboot.h in machine_kexec.c for declaration of
> machine_crash_shutdown.
> 
> gcc-12 with W=1 reports:
> 
>  arch/arm64/kernel/machine_kexec.c:257:6: warning: no previous prototype for 'machine_crash_shutdown' [-Wmissing-prototypes]
>    257 | void machine_crash_shutdown(struct pt_regs *regs)
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64: kexec: include reboot.h
      https://git.kernel.org/arm64/c/b7b4ce84c830

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
