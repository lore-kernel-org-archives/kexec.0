Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D520CD98C7
	for <kexec@archiver.kernel.org>; Tue,  9 Jun 2026 15:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZbzCK1HDZ6UQM0wxmODd5gt3PhXikPzvdF+pmduOMD4=; b=T7o8n8wuWwjyoFrQMPJn42S5cL
	2bRbfbO3/2D2KgUtwrH+jHsLqG1/StwbXSYdwd+0s6bfzbir89iyz7PPe8jUkXMXC1LIZCIHaVxdu
	cop7jPHBmRadzRwmwhwsC5tfGLxDejW2qr3za7x+vSBPsARXqlPwlJIjazs5vap+ZOfQw3kzk2KIX
	GfaytUhoC46CxncxHt3oc2Rqb6WrdpAeLceNB+yNjV5M0fZLfX4hEacc6Slbvxl2fAfVifKyPuUJ2
	J68YMiMr/7q4omj/4FtcHuHQokk5/BuS4Ng2tb1w8DWUdVK50M31qpS5aEoXG3qE9YTE+hWExdF/i
	8u5QedaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWynX-00000005ybW-0vHA;
	Tue, 09 Jun 2026 15:55:27 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWynV-00000005ybM-36tU
	for kexec@lists.infradead.org;
	Tue, 09 Jun 2026 15:55:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0869A60234;
	Tue,  9 Jun 2026 15:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACA31F00893;
	Tue,  9 Jun 2026 15:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020524;
	bh=ZbzCK1HDZ6UQM0wxmODd5gt3PhXikPzvdF+pmduOMD4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=hHxclXE61EFMwxcZZ4ijcKdmZQrXuHFpw/8CotX43ijEM7cIj8eoOWyMjiEpkQs9z
	 8s+wxGuYEcL7qIWh2PuqYhtJ6sViwxkpG7ntvpgu2+iqzL+PKZjbAqlVXkOA9EB3JM
	 RXOop81ORKUegIcXQm2xuJUzqk3dxVGZP+7fF5udRvb4yV+c/UJA45i5eC40GfmVU7
	 DatfDIxUwYt+satO6eHDulTBroOMM0WfB/mOWLojxGfwT4BDyImoIC9N801qlUZf0D
	 TE0DXAd/e0ONGvRHfe6p72N+i7y/1poMqooU5WCKSx9FexX1x+6j+rR0jpJR23Q5/I
	 ZOJgu/CycSMNg==
From: Pratyush Yadav <pratyush@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: Mike Rapoport <rppt@kernel.org>,  Huacai Chen <chenhuacai@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  Pratyush Yadav
 <pratyush@kernel.org>,  Shuah Khan <shuah@kernel.org>,  WANG Xuerui
 <kernel@xen0n.name>,  Alexander Graf <graf@amazon.com>,
  loongarch@lists.linux.dev,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org,
  linux-kselftest@vger.kernel.org,  George Guo <guodongtai@kylinos.cn>
Subject: Re: [PATCH v3 0/3] LoongArch: add KHO support and selftests
In-Reply-To: <20260609143945.512688-1-dongtai.guo@linux.dev> (George Guo's
	message of "Tue, 9 Jun 2026 22:39:45 +0800")
References: <20260601092823.110362-1-dongtai.guo@linux.dev>
	<20260609143945.512688-1-dongtai.guo@linux.dev>
Date: Tue, 09 Jun 2026 17:55:21 +0200
Message-ID: <2vxzbjdjso7q.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
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

On Tue, Jun 09 2026, George Guo wrote:

> Hi Mike, Huacai,
>
> Gentle ping on this v3. In the v2 review you mentioned you'd wait for
> v3 for a more detailed look -- v3 addresses both points (folded the two
> selftest patches into one, and replaced the LoongArch-specific kill
> loop with timeout(1), with the timeout value set per-arch in the conf).
>
> No rush, just making sure it didn't slip through the cracks. Happy to
> spin a rebase if it's gone stale.

It is on my review list, and I hope to get to it soon. But no promises
unfortunately.

-- 
Regards,
Pratyush Yadav

