Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2144ACF8575
	for <kexec@archiver.kernel.org>; Thu, 20 Nov 2025 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LTfZeiaXGWQ6vbYaGKegjGaFNQc9BuDEVM1zPEh/xbo=; b=3vvLZ47zB/nGddKX6wnfkaLXmI
	oKdOqYTTetXC3KtZgCG82OXdSqk5UmOm/wCqQKWGo+RudozWVMRcuwwQe4E8gIcCfJpxcqSE0aWYQ
	c4ETJU2B1HOlRPjE7jtMvvtOfC52/2IcBe9f/2wYn9xjAlrYGYjaYqjHLXFofpp4sitUONugEtehI
	Mw02fv0bu5lWpcDNztAYArRPIYeGA9tB9IpV1ACP7OxtXho5+Br9iSgQrdCkBEBEdzLZpWhWFfiRB
	aPU27DbYrwxAfHk58h+LkhgzIvouSXROVotvL4pskTP0ugbGJc9LezY0xmRJwyzc/puRpkPaF4UEJ
	GnTX8lYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0vy-00000006Q2D-35GI;
	Thu, 20 Nov 2025 09:26:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM0vv-00000006Q1o-2zcS
	for kexec@lists.infradead.org;
	Thu, 20 Nov 2025 09:26:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2539E43E19;
	Thu, 20 Nov 2025 09:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F8EC19422;
	Thu, 20 Nov 2025 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763630791;
	bh=O8ppzezBVngh9p2neSkJwi7IKljaPCF/ARYNeHVOvFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nyE0zf7+Zm3qEjzxMy+D6jswoaBimOO39W356YHTZBNMo8zH0aeaxEbym99oYc6gy
	 wLqFIQc4dMFf7rbeeKyEhc5kdWQw6tC/hLcd70clP1tOj3ei8D7BJXc45z1RbBOV7s
	 BgCYKBFbX4iMq8jb/TvSO6gJbQc+Gg36FiHawDAe9k3i26hPvZb3W+gEHATFDqjSNL
	 LVgCVSqbUBOCrmwJdsk4jNUtHGgnlJZwZD0IyIm444iBFesnMNFlH6yCvSWC2f69jg
	 jLoMOC2QlXaBHleNVdIQyjCt+4aWkfdZr+aT4MGJrDmD+3IYR2LJIjQj7JZ0xWybEt
	 R7hLK7DWFIE/w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Alexander Graf <graf@amazon.com>,  Mike
 Rapoport <rppt@kernel.org>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kho: free already restored pages when
 kho_restore_vmalloc() fails
In-Reply-To: <CA+CK2bAumctR3WyDW0b+NeeX22+OuCMkQ2VsGvnE1NxJwOVPEQ@mail.gmail.com>
	(Pasha Tatashin's message of "Tue, 18 Nov 2025 13:43:32 -0500")
References: <20251118181811.47336-1-pratyush@kernel.org>
	<CA+CK2bAumctR3WyDW0b+NeeX22+OuCMkQ2VsGvnE1NxJwOVPEQ@mail.gmail.com>
Date: Thu, 20 Nov 2025 10:26:28 +0100
Message-ID: <mafs0ikf52gxn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251120_012631_790306_933F14BD 
X-CRM114-Status: GOOD (  12.98  )
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

On Tue, Nov 18 2025, Pasha Tatashin wrote:

>> When kho_restore_vmalloc() fails, it frees up the pages array, but not
>> the pages it contains. These are the pages that were successfully
>> restored using kho_restore_pages(). If the failure happens when
>> restoring the pages, the ones successfully restored are leaked. If the
>> failure happens when allocating the vm_area or when mapping the pages,
>> all the pages of the preserved vmalloc buffer are leaked.
>
> Hm, I am not sure if KHO should be responsible for freeing the
> restored pages. We don't know the content of those pages, and what
> they are used for. They could be used by a hypervisor or a device.
> Therefore, it may be better to keep them leaked, and let the caller
> decide what to do next: i.e., boot into a maintenance mode, crash the
> kernel, or allow the leak until the next reboot.

Hmm, fair point. This patch can be ignored then.

-- 
Regards,
Pratyush Yadav

