Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2E6E77188
	for <kexec@archiver.kernel.org>; Tue, 14 Jan 2025 13:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmRf/WPiVxAimIYsZVKC5WhgZrbd93EcpRocS2JRKMg=; b=XMVJ5aN7R3AiWVd7HlIWmfebOq
	esdKetnx4jYzYzrxbcQeEcQtOSNHz6kh5EnBIh7axkvItIQbFDYh8Aa+w0sZOw6G9GH7NixN8guPY
	Dowg1simknzwJN1q3JDaDqpi9YLCbMyF198MxLTDZ5GVNBahuWtFCeOWCQE7XxjBMJ1MCVnAKrd2Y
	2NEI+9zAYug3JMcjr4Rwc3lHwyhneWo8685j6KNbZab7ORGOScGGahgAGHG14f5iMzIB9898UFkaX
	qdlXzuSQsGJ05SAnfDerXHsXIo4BqTufUA21iYxgrOFnnAFLxh/CoUIhwmn+jMSix8HhzsbBktPGo
	Fu+/bsmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXgmJ-00000008UkL-1mJG;
	Tue, 14 Jan 2025 13:16:19 +0000
Received: from out-180.mta0.migadu.com ([91.218.175.180])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXgmG-00000008Ujx-0f4t
	for kexec@lists.infradead.org;
	Tue, 14 Jan 2025 13:16:18 +0000
Date: Tue, 14 Jan 2025 14:16:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-ricci.it; s=key1;
	t=1736860573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GmRf/WPiVxAimIYsZVKC5WhgZrbd93EcpRocS2JRKMg=;
	b=Imheh64uhV65zTPsP5pL+DbNtlZOJIhz+GWVcf5nzPFNmx/tWaRo5XbKBF7mX+jOMSCxb4
	zLymQF9ATUH7J5YuJv1Zowpwh/vopW4juRzuU8VH4u3IgG0YgWJifClm2xS8jGZFBfsr1+
	a+0EG5VeFVD353yOZHrpYWSzcVs1kK7NT74Vom0rCh5hhm6FrV80GxkuA6jcBgY/iEYP1o
	oPXlB0+P3JelpTPDz30zRyDmEIXMmlTBWdBiApL5mgWtFPWQvqOKhNFpLBPrfIqdzJrlSM
	9f2qoRDFwcxUwzu7TspBcjq0of6b/QG9Gh65B2HVZ67e3EWYhut8xzzStCggUA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roberto Ricci <io@r-ricci.it>
To: ebiederm@xmission.com, rafael@kernel.org, pavel@ucw.cz,
	ytcoode@gmail.com
Cc: kexec@lists.infradead.org, linux-pm@vger.kernel.org,
	akpm@linux-foundation.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from
 hibernation
Message-ID: <Z4Zjmva-pLbLjtQv@desktop0a>
References: <Z4WFjBVHpndct7br@desktop0a>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4WFjBVHpndct7br@desktop0a>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_051616_784384_6C7C52F3 
X-CRM114-Status: UNSURE (   6.59  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> running Void Linux, with the following commands:
> 
> ```
> # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> # reboot
> # printf reboot >/sys/power/disk
> # printf disk >/sys/power/state
> ```

Looks like it's the kernel performing the kexec which causes the issue,
not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.

