Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91C7C4332F
	for <kexec@archiver.kernel.org>; Fri, 18 Nov 2022 19:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=whwBGoQHML+oU3ua51rngR/C2VYXSIHZ/6uWzw+ATWc=; b=QGudqc88UGaPR4
	AZPZ6QMiYHuPGfgDaA1jdD991K0kw9cGVsiauLIZ5dMf2bQHIZYW+as9ip9fmt+n5CYG/5mRvFa32
	eaEzgudS6ndNUU7p8ER6K4vrfwBZiPaNN/5sMo+RWe4vu4S6vHJ2TjdKaIS524C/YyzxMiyeyFpU+
	R73YMI22NfI6FNd80atUNFkNFnn4ZlIlFClGVm6PVjr3NWbXDQbSMW0kYGAE1GzePMBnm+UlOTG3l
	sCGHYEIEBsDdL5q1DJVy0A32U7aG0iouU/o0lXco5+wW3qHK5ww8MSMMcaU+fd30L0ud3K+yj3Jq3
	a36HdRpu9OZGPC1LahJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow7HQ-007fa2-V5; Fri, 18 Nov 2022 19:44:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow7Em-007e2d-Ra; Fri, 18 Nov 2022 19:41:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 72D356276A;
	Fri, 18 Nov 2022 19:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE23C43140;
	Fri, 18 Nov 2022 19:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668800479;
	bh=+3EX58SiFaImStqvJ4r/d4PsMH6/0v2Cwfofas6RK3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P4WpzHo8y+JQNfimsmgcCDI07q4Ve15Hri1lw0PWWcMut4ZlaL0DQe28Pk/+zv3tC
	 NF8djW/LcCjP8mGau2x1Vx7yEdLL/ZyaeNm3XRCmvNok3b3M66YTYovuoK8uJVkvEG
	 9dX+xSYdhMMQ7PdibUHMtNxcG74Y6YQTONHQu6/+3QLWmcxgs0FBFH28Cn4TaGWBnq
	 rfRIx601XTi/u+nYXoV9R+ShLqvfF2idEqBtBvGXNcREgnlPT//tQeCla31uwdh34Y
	 T+lcgj94LMP/nznWgI/0HgpqC4rmIkF7gEA3U+JF1zOCymM6l5Llx6p6rSLxHAPVp2
	 vum3etFRxpsww==
From: Will Deacon <will@kernel.org>
To: kexec@lists.infradead.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Dave Young <dyoung@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Baoquan He <bhe@redhat.com>,
	Zhen Lei <thunder.leizhen@huawei.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Vivek Goyal <vgoyal@redhat.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	John Donnelly <John.p.donnelly@oracle.com>,
	Feng Zhou <zhoufeng.zf@bytedance.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Chen Zhou <dingguo.cz@antgroup.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 0/2] arm64: kdump: Function supplement and performance optimization
Date: Fri, 18 Nov 2022 19:40:48 +0000
Message-Id: <166878087548.1783067.11242325570720961559.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116121044.1690-1-thunder.leizhen@huawei.com>
References: <20221116121044.1690-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_114120_964458_2B0DB1F8 
X-CRM114-Status: UNSURE (   8.46  )
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

On Wed, 16 Nov 2022 20:10:42 +0800, Zhen Lei wrote:
> v3 --> v4:
> 1. Set DEFAULT_CRASH_KERNEL_LOW_SIZE to a fixed 128M.
> 2. Some lightweight code adjustments based on Catalin Marinas's comments
> 
> v2 --> v3:
> 1. Discard patch 3 in v2, a cleanup patch.
> 
> [...]

Applied to arm64 (for-next/kdump), thanks!

[1/2] arm64: kdump: Provide default size when crashkernel=Y,low is not specified
      https://git.kernel.org/arm64/c/a149cf00b158
[2/2] arm64: kdump: Support crashkernel=X fall back to reserve region above DMA zones
      https://git.kernel.org/arm64/c/a9ae89df7377

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
