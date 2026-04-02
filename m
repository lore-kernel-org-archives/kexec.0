Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5949D730B7
	for <kexec@archiver.kernel.org>; Fri,  3 Apr 2026 08:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JXSTWyXJ+TnyRw0WBxA8l+YYXyO0fVka0N6NTBeoq8Q=; b=lVkTk81L5YHMxqxt2ZWFZ71Y2U
	198C/GnyIRyiDBsKNFhPbGWhuNcTrkw92ZHsUr4Onz7MAmuS72lI+gPw7GhaVNHSD5gPxaMP+izPR
	2/M54p4H5+ZkmTy4x22RguKytfVhJywFDy8m8iub9+Im+TVAN09eQkJCP34XaxCjf5IsYYjxSa6mL
	f3TIxNRKoPt9pdEaaMI+VyL6mdwvlKVSkye0SXjJA5O5scXIyXsR+h74UpuVy94PrHy2qlCY8mjI/
	JZxUEXEi3/2fyuWXFMkROwoMQpiYmvTLuA6dNYRdr8PzNIcZH3AKXsco7Ja4/3JudjmDQpEa+uRnt
	ysWYNm8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8ZXR-00000001fz7-3wq2;
	Fri, 03 Apr 2026 08:05:57 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8IFH-00000000CGH-11cS;
	Thu, 02 Apr 2026 13:38:04 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFFAA40E0176;
	Thu,  2 Apr 2026 13:37:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oTdXorvwZNA8; Thu,  2 Apr 2026 13:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1775137075; bh=JXSTWyXJ+TnyRw0WBxA8l+YYXyO0fVka0N6NTBeoq8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bCQgimxvGmerirQlClnnYZmqi+uWMoqL95VwwSjtIF+Vf5UgtTcb7MS8LHreRfpek
	 GoKJE6bZ4mED1jv5T74akOqGqj6cVX0+gMq4JPJ5IXhW1g4caBQiG82F44yKCaUpHB
	 JKWGY6mrqIRGR7O4FfRKFTim4d0LlcNUNCcKJP5mrqJnhW7Zn6VsSiEjgSCPhKlRdY
	 Vz5bw9JgpcSP6iZZbF2pLqppz547O8r9pCTuwtdspA8PUUwCXcWPbXdcKb8H+KtEnA
	 vYV5UH9kk2R5DT86KkZXWL5/mET7B7l3QZkYztBFJ7a0PvDzmo/YIDl+Eg84lF8N0f
	 cXFNcJJV2IRYckfYEkZhkVrhIiorIFlejmBkiW959HnGweu56QSzj2gTTWdAAaJrrS
	 sh9Pp0D8Htj2up7P8oufGTYxoz9qRnLmpXA57NNz0RGrJXhZpOkLL3aR1nA9urPhxQ
	 tbt47maHxAeQaYmg6AyhXHj67cdIJvhQE/sb9BqBhp83IhtTGVjXBGdkhdgPdJ185q
	 K69pAch9YdpEB836VpaYWFh+Ip6YTtKtLGaP4i3L7l4LcOjBagTb6CrVT7jaRTwuHJ
	 Al4nQrXZYlR6lYI26Sosm0aZwIokhEkI8od4RIJbjj59kdoSLsB5B75aVXY5ViEq95
	 e1RjUlJ3M2nuatbtPJRqSTio=
Received: from zn.tnic (p5de8e020.dip0.t-ipconnect.de [93.232.224.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 59DDE40E0031;
	Thu,  2 Apr 2026 13:36:50 +0000 (UTC)
Date: Thu, 2 Apr 2026 15:36:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, catalin.marinas@arm.com,
	will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
	maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	robh@kernel.org, saravanak@kernel.org, akpm@linux-foundation.org,
	bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
	rdunlap@infradead.org, peterz@infradead.org,
	pawan.kumar.gupta@linux.intel.com, feng.tang@linux.alibaba.com,
	dapeng1.mi@linux.intel.com, kees@kernel.org, elver@google.com,
	paulmck@kernel.org, lirongqing@baidu.com, rppt@kernel.org,
	leitao@debian.org, ardb@kernel.org, jbohac@suse.cz,
	cfsworks@gmail.com, tangyouling@kylinos.cn,
	sourabhjain@linux.ibm.com, ritesh.list@gmail.com,
	hbathini@linux.ibm.com, eajames@linux.ibm.com, guoren@kernel.org,
	songshuaishuai@tinylab.org, kevin.brodsky@arm.com,
	vishal.moola@gmail.com, junhui.liu@pigmoral.tech, coxu@redhat.com,
	fuqiang.wang@easystack.cn, liaoyuanhong@vivo.com,
	takahiro.akashi@linaro.org, james.morse@arm.com,
	lizhengyu3@huawei.com, x86@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	kexec@lists.infradead.org
Subject: Re: [PATCH v12 00/15] arm64/riscv: Add support for crashkernel CMA
 reservation
Message-ID: <20260402133644.GBac5w7OYl9MwvVxY_@fat_crate.local>
References: <20260402072701.628293-1-ruanjinjie@huawei.com>
 <20260402113137.GAac5Tmc5b7SL98KdY@fat_crate.local>
 <c6eb858c-5275-6fdc-b6e9-bd6d4b169e05@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6eb858c-5275-6fdc-b6e9-bd6d4b169e05@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_063803_435831_7A0D0AA1 
X-CRM114-Status: UNSURE (   7.57  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 03 Apr 2026 01:05:56 -0700
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

On Thu, Apr 02, 2026 at 07:47:53PM +0800, Jinjie Ruan wrote:
> Thank you for the reminder and for your patience. I apologize for the
> frequent updates; I am becoming more familiar with the community's
> workflow.

Yap, and you can use that time while waiting to learn about it:

Documentation/process/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

