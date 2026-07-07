Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CCBC43458
	for <kexec@archiver.kernel.org>; Tue,  7 Jul 2026 06:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZNc0y12dxTbCTSDGQxXYQB8NIBc8OZfcTmhxyjcGs8=; b=hiNEWNj+764NzsZQTETXN/l7cB
	rS2yDeMaQyEZbjmcyt5nrxra+SMBqpMSag89gikIPLXDmfpz2Av1cbKl+S1qwTfxJsYLEv2lxu0jN
	o/DbY94Wap4nBykOK6koL0AYFoyXYzH3R4Epvq5ffUaOV0oxDobAQ0i1wMaDk/xgJeIgPPB00JOIx
	hRh3qNOHeHcfMbqKpE2kszMIcMsMOfJl6CU5sP74fE040bgQ133WpSifmPY5KwFDD78AVUvLa3f/U
	tCmtTg8xoN1RePkBwQQx69ORhtSYW8x4IKu5M5cY1QlND462PvO4JXa0u/hsas4Hw84VP1KgEPnds
	bFpteXEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgyvw-0000000EATi-3qC1;
	Tue, 07 Jul 2026 06:05:28 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgyvt-0000000EATR-1rf0
	for kexec@lists.infradead.org;
	Tue, 07 Jul 2026 06:05:27 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D24B961897;
	Tue,  7 Jul 2026 06:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EE21F000E9;
	Tue,  7 Jul 2026 06:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783404324;
	bh=zZNc0y12dxTbCTSDGQxXYQB8NIBc8OZfcTmhxyjcGs8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VRIuf9Ui2aEhgImeT4bK8YD6zuLtroYv0o1rV0bmbazbp8npluNA2T7Eu8sAgUIOe
	 s23aNtR7ll53cbAwSikVpwCZSTpKuFISZYJqromXATMSHwjHuWBmZtE7i2UpCtaXvU
	 Bh1Tdwvaj32pFxAhWZxkT3z9DZGhQ/18ZOY5pTKYtZ8voVL7Q8yddipGjm4SEOh7mL
	 ZUjH+6veQznd8ItENhZzulqHtz5i1ciBH9bcvKH+b7qugpZ6ZJq5NDlMfYGJ0X+lE5
	 zZUjH6OQMKRiCF0DVe3iML+vHVxm1UuZVMAY1hEvIF2UHSq6HpY7fl9acO+d1KBbwc
	 vvFXuPjQkQ7ww==
From: Mike Rapoport <rppt@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H. Peter Anvin" <hpa@zytor.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org
In-Reply-To: <20260706153751.1166003-1-pratyush@kernel.org>
References: <20260706153751.1166003-1-pratyush@kernel.org>
Subject: Re: [PATCH v3] x86/setup: do not include kexec_handover.h from
 asm/setup.h
Message-Id: <178340431691.3292146.18380865856141404475.b4-ty@b4>
Date: Tue, 07 Jul 2026 09:05:16 +0300
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

On Mon, 06 Jul 2026 17:37:49 +0200, Pratyush Yadav wrote:
> x86/setup: do not include kexec_handover.h from asm/setup.h

Applied to kho-scratch branch of liveupdate/linux.git tree, thanks!

[1/1] x86/setup: do not include kexec_handover.h from asm/setup.h
      commit: 08412b8c707fdbccb7bf2116f0554fe09113cd53

tree: https://git.kernel.org/pub/scm/linux/kernel/git/liveupdate/linux
branch: kho-scratch

--
Sincerely yours,
Mike.



