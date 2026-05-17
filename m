Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83F8CD4F25
	for <kexec@archiver.kernel.org>; Sun, 17 May 2026 07:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lGPm7nhYCc0ixV/hzdYgw08TpHkQjt6PueGrxwrLVco=; b=G4LEuxnBa5eS0Fc+PDRW4fWfJZ
	CmbvjmsGxNhRHcZA+WlM05si+H5eB8NPqKsGfUIWHVy048Ict785WVIcdCaGIZRnbKLfiEGdiFFfJ
	GxVz+zCRiXNQryVIepf//q8fkXhfjrAMBAGlKWck35+fEe3D0KKUeqelzgimbuChDBT2sUl866ee0
	M3SFKTImmlOeZAQfAmVb8dWWnInCePwAaK4y1jMcZupW31zGjlV4fQ2JOEg+eX+E63nmQKiNROsPS
	v8+0aEDWskB3r0SGESKMYhLyw8X12LDoeDioX2RXLO8Up6nZd8W0VsXd3FNDiwhcpPjMA8Mdd9Zpo
	8S0+5XEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOVsh-0000000CI8d-0Z7H;
	Sun, 17 May 2026 07:25:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOVsg-0000000CI88-13wp
	for kexec@lists.infradead.org;
	Sun, 17 May 2026 07:25:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E1E78600BB;
	Sun, 17 May 2026 07:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D8AC2BCB0;
	Sun, 17 May 2026 07:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779002743;
	bh=zckPYiemyEgyVGDic7O0DE23J30OXeMsCNnWfL12Kiw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLaVg7vybcang0lQO3yvsq42kBqNRFEo9vB3Lxs+pqRr5BQ5b/Li/2WugOwRu5YmD
	 JGn4WUbJWvSK8bH4JRV3m1FXdUkG3M792KxpoVgYanw4unUk8dGJ8Szb2+aB6sZuv9
	 glkVXE6L5bap+Q3r/1XuMzMjglFDmpGjZaHgC4+oxTJKU4xd/ltS9m19UVLUIEpkMr
	 +Mb26n1MeCaGR+56vJu0ht7Oo/8cLWeM7zhAwIrI0R7KNFIGJ1L2+gcXWoWNGH431J
	 pq6/iBQWC9F3Ke8Uxjv1ya6mdXmX9UeLTxbUVHDIJ23f1VH/8YsttyE0WKI5zQMpeq
	 e6OwUQs01xtPA==
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	longwei <longwei27@huawei.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	hewenliang4@huawei.com
Subject: Re: [PATCH] kho: docs: fix typo in ABI documentation
Date: Sun, 17 May 2026 10:25:29 +0300
Message-ID: <177900272376.2854906.3562157499024061729.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516085653.2193872-1-longwei27@huawei.com>
References: <20260516085653.2193872-1-longwei27@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

From: Mike Rapoport (Microsoft) <rppt@kernel.org>

On Sat, 16 May 2026 16:56:53 +0800, longwei wrote:
> Replace "Indentifies" with "Identifies".

Applied to fixes branch of liveupdate/linux.git tree, thanks!

[1/1] kho: docs: fix typo in ABI documentation
      commit: b1378127003b61930ce30064328640503ad3ef6d

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: fixes

--
Sincerely yours,
Mike.


