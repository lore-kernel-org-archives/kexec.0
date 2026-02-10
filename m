Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820F3EB26FA
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Mime-Version:References:In-Reply-To:Message-Id:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxq56o4mssvH3z/W9HaPRr6S+5Q9Jw32TUdmbSJZpmY=; b=Rdg/rdEXWSgTyIyzeL4VzklEA+
	kNAtIrKm5zJ9CQgg5lrzCcsA7VKhWBD9bs28BsdtOnXfVD+zYeag/kZigj8uF5cy0bt4RKKnfifHT
	62h7pCo6hdITlGV4YSwc/l4OcVewDKjSzIzqCJ+BuNPnRN+xXwjME9dlw10EcmjjLXIglPJzWgQ/T
	ty0pxQ1RLZ5xfpGIcUQwUakJIL4dyumcHnUbupAoCq/YpGRayZO21gV/jPkJHAlUBucg/CdRpl9gw
	QBipIvY/bEa5t651S2H9gJBk4pgI/KAqcfYLEyoybs4g6NOhuQvBiTARSYQUVwByqJB2kPORqSZEC
	P42SKYdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpskm-0000000HPD1-21FD;
	Tue, 10 Feb 2026 18:46:28 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpskb-0000000HPCQ-2q60;
	Tue, 10 Feb 2026 18:46:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 043E460130;
	Tue, 10 Feb 2026 18:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55664C116C6;
	Tue, 10 Feb 2026 18:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1770749173;
	bh=cQmAZOlgqDEJoNzb/KC5ffX6k09b7GesQWLKzu3capA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ym6yPVTBOhUVK/R/XVvltsP0cb1lHsrBaN4N1frOdcI8ZO64AV9b6SjsYgFVyTrbn
	 2cgUFXabTY94F3aq2P8f4EETK2GqF9meau0+2NHKE37IQXjDtx9EKJlkDQFxvbIEVT
	 V6OjTffRlf2V1OMY/UxL3QtyZ+9VrQLYOVjfLzeY=
Date: Tue, 10 Feb 2026 10:46:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Breno Leitao <leitao@debian.org>
Cc: bhe@redhat.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com,
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Message-Id: <20260210104612.5547717cb6b5da794d9c4724@linux-foundation.org>
In-Reply-To: <aYr154HW4IiIw3PH@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
	<aYr154HW4IiIw3PH@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 10 Feb 2026 01:11:41 -0800 Breno Leitao <leitao@debian.org> wrote:

> Hello Andrew,
> 
> On Mon, Feb 02, 2026 at 06:27:38AM -0800, Breno Leitao wrote:
> > The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
> > CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
> > However, this data is only accessible after a crash.
> >
> > This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
> > expose these statistics at runtime, allowing monitoring tools to track
> > hardware health without requiring a kernel crash.
> >
> > The directory contains one file per error subsystem:
> >   /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}
> >
> > Each file contains a single integer representing the error count.
> >
> > This is useful for:
> > - Proactive detection of failing hardware components
> > - Time-series tracking of recoverable errors
> > - System health monitoring in cloud environments
> 
> Is there a chance this could be included in the 6.20 merge window?

During the 7.0 merge window?  Sure.  I'll be taking a look at this (and
a whole lot more) after 7.0-rc1 is released.  

