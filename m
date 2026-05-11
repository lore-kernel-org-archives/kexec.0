Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63129CD37B9
	for <kexec@archiver.kernel.org>; Mon, 11 May 2026 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ByIc7zIIWGLLI0p+nPyGQsuprNRGT/xo9ZNlU6v687k=; b=ISs5jGuqyOcdkXuDqKiiuy25NW
	bXEv7UxOTXO8FJ5WCxSFWy0c8r43c8CEmDwTYPF2m8AaG7N7apohDQ5wz50rIWTRPZSh+d6YzUsYt
	IDIGl8IBWqO89DAfKvzCmIV3edEnHP1HvTbQsk2bmeNs2lwKceNzVmn1ARAY0R49T5Ub2wu8weAIf
	45v8CoAGwpjP4HELz75EaUK+yS0RsVoV9VqVkdj0RlvKIGN1Vbgt41JLxugx0yKgPTfYSD/n5KQL+
	To5acSBtz27QC992ZX3pSTxb50J0DMaMG/z/uTpJ9B0H/qFkD8tYYIwLIJmgQErMDc6a2r6s1u9Cl
	hM/7/8QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMON8-0000000DCrM-3s4L;
	Mon, 11 May 2026 11:00:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMON7-0000000DCqq-2UYR
	for kexec@lists.infradead.org;
	Mon, 11 May 2026 11:00:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C0F7B6001A;
	Mon, 11 May 2026 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02967C2BCB0;
	Mon, 11 May 2026 11:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778497224;
	bh=izvnagj9ZLJVxR+qNc7RMbvt9I2ey8INGl6X8JOMJbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EKgSxuzDb6hj8qW6BihC8pNQpuLkpsS/rpx3FJpEScZc4OBPrfWt/ibmj9igKBasG
	 SFrgdhQpEKGkgE7P+7isoCIrzDb6xjlhFz8R1QS5FGx062XzkqMqmmup+di9h16mCp
	 m6IijHxemds9GdkcSbj8GdRq9Re49Al/h86jRNbdBqsGV7AhmqdJw8mr73Si8CFNAD
	 I+MMOroM3IEeHiuzN7ErYkwMESlI79yRWU0TB6+/t7r1mHBjWHClN8I8OqKjMUEDda
	 nniyDISCueVN8cpTW/129Lv+ty0uhEJDy3XcPqu/9eUwEUGPA3K7foSNF599cCajlV
	 xOMnTylqpXrjA==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: rppt@kernel.org,  sourabhjain@linux.ibm.com,  jbouron@amazon.com,
  akpm@linux-foundation.org,  linux-mm@kvack.org,  bhe@redhat.com,
  linux-kernel@vger.kernel.org,  dan.carpenter@linaro.org,
  rafael.j.wysocki@intel.com,  piliu@redhat.com,
  kexec@lists.infradead.org,  pratyush@kernel.org,  graf@amazon.com,
  changyuanl@google.com,  mario.limonciello@amd.com
Subject: Re: [PATCH v2 1/3] kho: skip KHO data for context-preserving kexec
In-Reply-To: <20260506182039.2623553-6-pasha.tatashin@soleen.com> (Pasha
	Tatashin's message of "Wed, 6 May 2026 14:20:41 -0400")
References: <20260506182039.2623553-5-pasha.tatashin@soleen.com>
	<20260506182039.2623553-6-pasha.tatashin@soleen.com>
Date: Mon, 11 May 2026 13:00:20 +0200
Message-ID: <2vxzzf26cit7.fsf@kernel.org>
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

On Wed, May 06 2026, Pasha Tatashin wrote:

> A preserve_context kexec returns to the current kernel, which means the
> 2nd kernel does not use KHO data (and their memory spaces don't
> overlap). Passing KHO data to the 2nd kernel via setup_data or
> devicetree is unnecessary.
>
> Add a check in kho_fill_kimage() and return early if preserve_context is
> set, to avoid passing KHO state during context-preserving kexecs.
>
> Fixes: 3bdecc3c93f9 ("kexec: add KHO support to kexec file loads")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

