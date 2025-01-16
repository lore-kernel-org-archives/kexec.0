Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10ACC02187
	for <kexec@archiver.kernel.org>; Thu, 16 Jan 2025 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VwrBhC/YyMly2thWvCHHIUGKY6zNWpcaZUpIR1maiIs=; b=r6n4bE3tC+VZViMYgYzIR1BP+w
	AEmTGpgo+zVcGqTow6dSVyycJPar+Zf81jRoSlAOO3LTbzvqUArEy6uUcV71HfGiDPNoWHWlntXFF
	Av0lCsP5Zlj6GWi5avxKnByEW5jdffMRAu0jXAuNfJPdnS4yOZnr1sxgUqtu5IhINWu1d1KzJI5ah
	20k5HNoHtjDJqfN2h/jDns3131JQWSdJapS5mU+4roTP/Hk2QolL9HbWtYs/SZbmvN2076FaMY+kX
	rrxFxco89gEUfIQ/zc1lgO/yfN0ALL7YMFXVj0yKlhZE7AE1np3G+r3X8oHbZ1rFDv/gNs5oz8FxN
	FMewN7eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMaN-0000000EQFp-2H7l;
	Thu, 16 Jan 2025 09:54:47 +0000
Received: from out-176.mta1.migadu.com ([2001:41d0:203:375::b0])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYMaK-0000000EQEW-0vBV
	for kexec@lists.infradead.org;
	Thu, 16 Jan 2025 09:54:45 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737021277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwrBhC/YyMly2thWvCHHIUGKY6zNWpcaZUpIR1maiIs=;
	b=E+IJUWpc9P7SteF3+XpDFrM/2l5bhBz/AlkhN9CP2dz8Ey9xUjH67DIWZ6/LL5IcspUI97
	/CBQTCUvPVVmxZZsEaslO8ebnH7Q6Ys1uHEjkwz9OOoeEy1FTilMmdQq+Cem5zbXG9GZyo
	flw3R3kD2U4XoS6+G274KX08pq7QArw=
From: Yuntao Wang <yuntao.wang@linux.dev>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	ebiederm@xmission.com,
	io@r-ricci.it,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@ucw.cz,
	rafael@kernel.org,
	regressions@lists.linux.dev,
	ytcoode@gmail.com
Subject: Re: [REGRESSION] Kernel booted via kexec fails to resume from hibernation
Date: Thu, 16 Jan 2025 17:54:22 +0800
Message-ID: <20250116095422.61742-1-yuntao.wang@linux.dev>
In-Reply-To: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
References: <Z4czuvi2BiNlDWPP@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250116_015444_725016_E1C50A80 
X-CRM114-Status: GOOD (  17.55  )
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

On Wed, 15 Jan 2025 12:04:10 +0800, Baoquan He <bhe@redhat.com> wrote:

> On 01/14/25 at 02:16pm, Roberto Ricci wrote:
> > On 2025-01-13 Mon 22:28:48 +0100, Roberto Ricci wrote:
> > > I can reproduce this with kernel 6.13-rc7 in a qemu x86_64 virtual machine
> > > running Void Linux, with the following commands:
> > > 
> > > ```
> > > # kexec -l /boot/vmlinuz-6.13.0-rc7 --initrd=/boot/initramfs-6.13.0-rc7 --reuse-cmdline
> > > # reboot
> > > # printf reboot >/sys/power/disk
> > > # printf disk >/sys/power/state
> > > ```
> > 
> > Looks like it's the kernel performing the kexec which causes the issue,
> > not the target one. E.g.: kexec-ing 6.7 from 6.13-rc7 makes resume from
> > hibernation fail; but if I kexec 6.13-rc7 from 6.7, then it works fine.
> 
> I tried the latest mainline kernel with your above command execution
> series, I didn't see the problem you reported. Can you try kexec from
> 6.7 to 6.7 or something like that and try to bisect a specific criminal
> commit?
> 
> As for below commit, it seems not a suspect.
> 18d565ea95fe ("kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()")
> 
> If possible, can you revert below two commits altogether to have a try?
> I am not sure if they caused the problem.
> 
> 18d565ea95fe kexec_file: fix incorrect temp_start value in locate_mem_hole_top_down()
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> 
> Thanks
> Baoquan 

I'm sorry that my two commits caused these weird issues.

Although I'm currently unable to identify the cause of these problems,
I'm REALLY curious as to why this happened.

Hope we make some progress this time.

