Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3F2CD98CC
	for <kexec@archiver.kernel.org>; Thu, 11 Jun 2026 12:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vpDuoAAfa3pi6DaCEs/tUqazlgd1kzXI4h/l0xgipiI=; b=MXiLHHp0osuCpVvdOZFroCxjfH
	Cxyb+rYqScXzPC1SAaXYQmEas8pkq6WQjZ4KiJR4WDxbdPsfjzDbgimnLmT2+G5WFSCcHOyUoOPBu
	ZsTOHaB+xe9y090i45knNekHa4q9zsILY8+qNxduAF+ToX/LXI8rWFqc6Dy9IzAZdX4oOgNmBjc8f
	Omh5eQfNnGIS28kKWAKh8/lxGlHZHjDh6yhFHL+Q5Jv1qeiSRgBiqmrkGo1ZLnX275adhZORZffDt
	Cvjv5hpxHSpQRAkqOAvYGWioy+TvM/MHoguQA/bF6YmmdCxsnt3Vq1x5i5alx6IxU7xUjtZojL1pE
	gCtQgTzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXeaf-00000009PTD-1YFR;
	Thu, 11 Jun 2026 12:32:57 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXead-00000009PT4-13mz
	for kexec@lists.infradead.org;
	Thu, 11 Jun 2026 12:32:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 776F66001D;
	Thu, 11 Jun 2026 12:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76BE1F00893;
	Thu, 11 Jun 2026 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781181174;
	bh=vpDuoAAfa3pi6DaCEs/tUqazlgd1kzXI4h/l0xgipiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ePztP8aQhD2iLU3urqNcWGSwX3LpkF6rDc5L4zwTynmBf8maf3O1jDhc9T2Hl6aCQ
	 wJeqvdwRwOGR1nRwV5rCfkNQUnOeheZh/5zLWxpMKjDuM8IcRl6sQdY30vmH3jJJaq
	 2tNn3QQoBPdmZdBsrngGJQnz+4XGzEZZzRV9Q3oKpd4qY7DivuReOLF5iYF4ML3aJI
	 e1ZzDmsZ9ywQ1rvhNd5bTcWFLky8KneWSf3DS/2r2C5i46O6n1/hHV9cmT4wqQ6F8f
	 /ENsCgKF8rVTRl2lJEFm3wKeDFZI9hZKV4vbY3U3TaUWYbcwM/wQjtE3ZjeAK/Bj2T
	 HOE619OPLA9Uw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,  Mike Rapoport
 <rppt@kernel.org>,  Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  linux-kernel@vger.kernel.org,
  kexec@lists.infradead.org,  linux-mm@kvack.org
Subject: Re: [PATCH] mm/memfd_luo: validate serialized_data before conversion
In-Reply-To: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
	(Tarun Sahu's message of "Thu, 11 Jun 2026 10:30:03 +0000")
References: <c2478f79207b10a13282d917c961261d17b86a15.1781173768.git.tarunsahu@google.com>
Date: Thu, 11 Jun 2026 14:32:51 +0200
Message-ID: <2vxzv7bpqmto.fsf@kernel.org>
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

On Thu, Jun 11 2026, Tarun Sahu wrote:

> In memfd_luo_finish() and memfd_luo_retrieve(), phys_to_virt() was called
> on args->serialized_data before checking if the physical address is valid.
> Since physical address 0 does not map to virtual NULL (due to direct

Nit: this is only true on ARM64. On x86 physical address of 0 maps to
NULL.

Other than this,

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

> mapping offsets), the subsequent check 'if (!ser)' was ineffective at
> catching a missing serialized_data, leading to unsafe dereferences later.
>
> Validate that args->serialized_data is non-zero before calling
> phys_to_virt().
>
> Fixes: b3749f174d68 ("mm: memfd_luo: allow preserving memfd")
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
[...]

-- 
Regards,
Pratyush Yadav

