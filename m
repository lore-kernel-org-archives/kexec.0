Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9D7EA3F28
	for <kexec@archiver.kernel.org>; Tue, 10 Feb 2026 09:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=szkXnntPPaw/iZii5G+5XATrzVuI/KG7DFWma9HeAR8=; b=YTJ5rQMp/rLbhpPmBnUEJ+MWwd
	U/m+icKPFfmcpl86aCMRxwM5+l/w3AC2kLczG31AXCSKqrrKm7/jf67UG43jAPwR92xmKoQzBpnnw
	LTnaLAVo2floZQoqr6J8Ofb8oD7izvuKmmG92qmivyOV+qF43YT139V8mz5rlj53uMFH423QxyPKC
	1WIVnfZN3bicEw4UsoVGzKDRxVlMyl6mo3+1NDOnpw+jhtrar1mSm0Oh9ht4vS4eynS3aeExCP15P
	m9viTOP8QVmkTrPQJlBl0YvNEtPADL2EeB5/1wqkNdKQ4h6kRf0Od2GKKRHFn/WthsvFiUi9GwWU5
	Ul2qOncw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpjmy-0000000Gjbe-0vAX;
	Tue, 10 Feb 2026 09:12:08 +0000
Received: from stravinsky.debian.org ([2001:41b8:202:deb::311:108])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpjmv-0000000GjZw-3Y0p;
	Tue, 10 Feb 2026 09:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=szkXnntPPaw/iZii5G+5XATrzVuI/KG7DFWma9HeAR8=; b=n05Y8xfYet9S8xJDuQsHgj4piC
	ee31Csk//iNiTDywJaIpqYXUvQ1SJRh38fr4nArhiXJmu2Bxg+ZrTfhmm4+hm6vRg1pLoQ5T9zFT3
	Bag9chsy4wtvp96lUZJByvC/yHFR0FIaqc4sk1OMqvWUTAEN7ABPrHqByNSGHlei6sPV7cuCO/A+t
	4g/camxqrL4zVki8U7vMgru7o76RUR0ArIzD9aKRvYFEETI7bNFC242KXZltxjwYsrV+sQdJHtUlg
	FbVIrjbUEvl8UxF+4RNRk812Tl7QORBWBT+tbUPMOVnn9DC/Gnvl6Um683Cpq/9zguhmxY3m0e9yt
	Cb4BAFFg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vpjmc-00A9cQ-D8; Tue, 10 Feb 2026 09:11:46 +0000
Date: Tue, 10 Feb 2026 01:11:41 -0800
From: Breno Leitao <leitao@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, dyoung@redhat.com, 
	tony.luck@intel.com, xueshuai@linux.alibaba.com, vgoyal@redhat.com, 
	zhiquan1.li@intel.com, olja@meta.com, kernel-team@meta.com
Subject: Re: [PATCH v2 0/2] vmcoreinfo: Expose hardware error recovery
 statistics via sysfs
Message-ID: <aYr154HW4IiIw3PH@gmail.com>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
X-Debian-User: leitao
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_011205_885946_C6132357 
X-CRM114-Status: GOOD (  11.58  )
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

Hello Andrew,

On Mon, Feb 02, 2026 at 06:27:38AM -0800, Breno Leitao wrote:
> The kernel already tracks recoverable hardware errors (CPU, memory, PCI,
> CXL, etc.) in the hwerr_data array for vmcoreinfo crash dump analysis.
> However, this data is only accessible after a crash.
>
> This series adds a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to
> expose these statistics at runtime, allowing monitoring tools to track
> hardware health without requiring a kernel crash.
>
> The directory contains one file per error subsystem:
>   /sys/kernel/hwerr_recovery_stats/{cpu, memory, pci, cxl, others}
>
> Each file contains a single integer representing the error count.
>
> This is useful for:
> - Proactive detection of failing hardware components
> - Time-series tracking of recoverable errors
> - System health monitoring in cloud environments

Is there a chance this could be included in the 6.20 merge window?

Thanks,
--breno

