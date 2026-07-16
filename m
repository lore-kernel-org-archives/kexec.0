Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5A0C4450A
	for <kexec@archiver.kernel.org>; Thu, 16 Jul 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hDNzQE/cEo8X7k5jxzm8lsveoH8jfJlE1Q6KURBCb/A=; b=E2zRubRla+N4kgNkpRtJDgfGDB
	Mcn8PLg6LRAG52//wj81yZoOzyp1tO/M9+gR5ou1EVAlEKlwmMkO4AnVsWMbOv4CqzL2Tm4trcCTY
	1PV04r8KygO2hfRmMpKfe+ppmL+8O2DptqG8yMsoYk7QJ2StapluGJn/ckGeW+Xak2cgnQxxIXjr4
	QoVHxpeYCzJTuD+tkw+35O6o6EySPcmfjHZiP6JPLWdyqxbUWfMUPsudVp1eChC1x3WhiBZjlP+2i
	LO/o+fdgNxlBcjUbiAHbPvuT47g8Lw5X3Mz0l39YOOS61TUf6lcl0kD5hAxpgpVkB3UzRKYHM/bh7
	eW7dNw8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkJ1F-0000000GyPk-3sNr;
	Thu, 16 Jul 2026 10:08:41 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkJ1B-0000000GyPQ-28SC
	for kexec@lists.infradead.org;
	Thu, 16 Jul 2026 10:08:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 111B04193C;
	Thu, 16 Jul 2026 10:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6DD1F000E9;
	Thu, 16 Jul 2026 10:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784196516;
	bh=hDNzQE/cEo8X7k5jxzm8lsveoH8jfJlE1Q6KURBCb/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=HbLqHCSW1WssukORkOhQXEXmnelBvUFltUUaD1mjWpQ3NTa52KaF5yyaD0J8fxR7p
	 uaUZGRrl3dmJdboUIaZjP1YkgM3KYhIK881BAKAz1OW2k+ys/dqv+uyTD3ClEgcjcF
	 LT33pitRTN4YuIGpFcYpFIG3uT8y1zRa4pHASYYO4uOZ8e/2hUmg53ScKAOgWkC1Z6
	 6WvcBReD8yJ3hNWXFBqDYg38VCTpGjpucogqr4hGv3T/Zuy5fykrK1l9PhEvrX9hL0
	 05mWK8MsAWJbs4cNYrJQ4fiW9BT21Cf3p5DsqTjkMB0GkBbb/RqSI9kKK7rWYU9HdM
	 NDbqE4DxYv8+A==
From: Mike Rapoport <rppt@kernel.org>
To: pratyush@kernel.org, Jackie Liu <liu.yun@linux.dev>
Cc: pasha.tatashin@soleen.com, kpm@linux-foundation.org, 
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260716012607.22020-1-liu.yun@linux.dev>
References: <20260716012607.22020-1-liu.yun@linux.dev>
Subject: Re: [PATCH v2 1/2] liveupdate: fix GET_NAME ioctl argument
 validation
Message-Id: <178419651136.7660.8853621323040986698.b4-ty@b4>
Date: Thu, 16 Jul 2026 13:08:31 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On Thu, 16 Jul 2026 09:26:06 +0800, Jackie Liu wrote:
> liveupdate: fix GET_NAME ioctl argument validation

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/2] liveupdate: fix GET_NAME ioctl argument validation
      commit: 4416f8a9ed5f49256dc69c664f1386b496ca16a1
[2/2] liveupdate: reject nonzero reserved value for SESSION_FINISH
      commit: 987de63719faed20741e3c4e1799d7a170e6a306

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.



