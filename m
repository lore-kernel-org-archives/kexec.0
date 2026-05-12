Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90231CD4F24
	for <kexec@archiver.kernel.org>; Tue, 12 May 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Message-ID:References:Mime-Version:In-Reply-To:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J0Ccv1UfqMOOxOflEQc2h7d3MsFikd1q1lwa5Y7ivPA=; b=p5vGZB6UB6278uJ5hLGBOkiPBh
	Snrn9tVBqBk0K8UKG189n2n9+Nrbl5NB6W1IBoJJI92gPPRHP8lSsNMkXSjtE262hR5ODWX2p8bbN
	B9Rw5lbMLYTccZfcbDauRmDMBAAj0P0KGYwo9Fj+tfwbiOiLyYiFLmXtt8RlNCOAvmbH4qRPieTTJ
	PWSyzddxybJJ1R92V30DYA5C0sQ4HJaqoVZHhmyMRKWnbKK4hhric+RJgwiKhYbH3+UBGxm5Gwchl
	9eLOmPsSFOsPVLkGrujxNU2VZj1/+s3Ar2krEDEg5jvP92IDdY/C8n6Tkn/Iujnvh4Rja0i89Y+cq
	X7KXA2pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMprn-0000000HLKq-03CS;
	Tue, 12 May 2026 16:21:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMprk-0000000HLJn-47f4
	for kexec@bombadil.infradead.org;
	Tue, 12 May 2026 16:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:Cc:To:From:Subject:
	Message-ID:References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J0Ccv1UfqMOOxOflEQc2h7d3MsFikd1q1lwa5Y7ivPA=; b=UYdFM9HhiOzTkxPi2reg8jLB4Q
	x8PZWb6rNgJX3KFmFcKr8ek7paEGRBObZdmYzscclOsI2UpqCNWx4jUvbXaz6r/GsVgXmOtgZ1zTe
	o/lZvA/p/htb7DIPg6FovkvrBIUFuPWmETG+w/vHme2UM61byMooeHXIZkYmGJLmdFi87h4PhprCA
	AX+GXKO8yS8n7FQIr5v/nLKVmEFmLzWRrcwhq6gJpI3ELXJXlkU7cFknIiK6tV7lcwX96rFIouI+S
	2W0ldHXRFpuVz7Sj6xYnEWXuWdnJT+k0sJFY5TEhRq3DnVKeOZlhm0uhxLQpauTnLa0NwaU0do0Ch
	FzqFktDw==;
Received: from mail-ed1-x549.google.com ([2a00:1450:4864:20::549])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMprh-0000000FJDo-2OdN
	for kexec@lists.infradead.org;
	Tue, 12 May 2026 16:21:51 +0000
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-6749e8562a7so4874696a12.3
        for <kexec@lists.infradead.org>; Tue, 12 May 2026 09:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778602906; x=1779207706; darn=lists.infradead.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Ccv1UfqMOOxOflEQc2h7d3MsFikd1q1lwa5Y7ivPA=;
        b=a0D+4P4WMKSwz0vMGWLjbNyT1errVGUhKmIe8tBwMupQGgt1BNxKyZLXvql/XGibg1
         0Q+A1AE/b2TBxODbyLrUEwaaJsH+VXBvMZxZah2cUsZ2c32KtxsiQj5dMWk0iyHdOfWh
         iCjfr2vNo88IPIpT02Mr3QCkYnb7QdVN8TDfG3PazilKWEVEZX5dvAC7u8Lxx2cCxtQ5
         n3he8GxnsBwemRtD1zxQfW5nPV3bCQZBbkRx5RpXBu/bZXBJLzAgRFmJtzfw/q9DXMct
         R2PVY7PRLSuY5x3ZN0Ic82auOxozDB/uESq/1twfKVqzgWcJPrWc8bC0eRo2RB/9pxZB
         hn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778602906; x=1779207706;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0Ccv1UfqMOOxOflEQc2h7d3MsFikd1q1lwa5Y7ivPA=;
        b=jcbUUJsW61teJBWK/jm910YiUMTe5W5oO/HC2C/aiYX/IqjOZMrH4NoMVnaVHL+Q7m
         raQu1mBftaGB4jclHGR8RVfcYqp0mLiQJxSYt5yhp8BuSpNIXvxLJjQsd2epQ4S1RKoo
         XXzoMfKwCb2VIIrhnvebob0WLDUcJ/W3V848M3Ygo4GDb3yG4houjgI+1N1QvNGaROEW
         5EfSMwlUi0A9unLAHUV2yyDb3gSkY4C/12j2MjTSnWpflmLgN2dIgaDfKHmZGdkOvvLK
         1nqiSgOTsIzfec5TaRQClN/Y+aQQ8S6I4Aty8D0InvlrdYC+RiKl+D9HBfPZKtczfGEf
         aRRg==
X-Forwarded-Encrypted: i=1; AFNElJ/HWlbping39cmPfHK8B+QvhZwgrd1A6eLhV3E6zHBk4aY4L+Ow/JTCrG8HVhBiBLz1DNj5EQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YwuSMe4kxVukWzLBwPDV0ysgUdFvSGQLD2CqYh5aOh9QhStim2E
	IVmF0kG+PM+g0a7i2rSaRuXJmvinLAP78JTLPzsODeKw9pqrM3osurUzsnekZ/wnKM8iy/8BkEd
	PiCmP/Vtn5+971W0dlQ==
X-Received: from edbij16.prod.google.com ([2002:a05:6402:1590:b0:672:29ae:9a33])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:158d:b0:677:15b6:4d6b with SMTP id 4fb4d7f45d1cf-680d02f613cmr2154738a12.26.1778602905910;
 Tue, 12 May 2026 09:21:45 -0700 (PDT)
Date: Tue, 12 May 2026 16:21:44 +0000
In-Reply-To: <20260429175016.7915-1-djeffery@redhat.com>
Mime-Version: 1.0
References: <20260429175016.7915-1-djeffery@redhat.com>
Message-ID: <9huzh5ocmwdj.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v15 0/5] shut down devices asynchronously
From: tarunsahu@google.com
To: David Jeffery <djeffery@redhat.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-scsi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Pasha Tatashin <tatashin@google.com>, 
	"=?utf-8?B?TWljaGHFgiBDxYJhcGk=?= =?utf-8?B?xYRza2k=?=" <mclapinski@google.com>, Jordan Richards <jordanrichards@google.com>, 
	Ewan Milne <emilne@redhat.com>, John Meneghini <jmeneghi@redhat.com>, 
	"Lombardi, Maurizio" <mlombard@redhat.com>, Stuart Hayes <stuart.w.hayes@gmail.com>, 
	Laurence Oberman <loberman@redhat.com>, Bart Van Assche <bvanassche@acm.org>, 
	Bjorn Helgaas <helgaas@kernel.org>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	John Garry <john.g.garry@oracle.com>, kexec@lists.infradead.org, 
	David Jeffery <djeffery@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_172150_069104_1F3B1A56 
X-CRM114-Status: GOOD (  36.43  )
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

David Jeffery <djeffery@redhat.com> writes:

FWIW,
I have tested this series by opting it for NVMe devices and observed
significant performance benefit (from 9 sec to 2 sec).

Please feel free to use
Tested-by: Tarun Sahu <tarunsahu@google.com>

> This patchset allows the kernel to shutdown devices asynchronously and
> unrelated async devices to be shut down in parallel to each other.
>
> Only devices which explicitly enable it are shut down asynchronously. The
> default is for a device to be shut down from the synchronous shutdown loop.
>
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch. And on another system from
> 80 seconds to 11.
>
> And thank you to everyone who has spent some of their valuable time
> providing reviews, suggestions, criticisms, or tests on the various
> iterations of this patchset.
>
>
> Changes from V14:
>
> Remove unneeded use of '!!' with boolean type
>
> Changes from V13:
>
> Remove duplicate flagging of async shutdown on scsi hosts/targets/devices
>
> Changes from V12:
>
> Only acquire a parent reference if acquiring the parent's lock
> device_enable_async_shutdown should return void
> Minor comment and description cleanups
>
> Changes from V11:
>
>   * Swap the order of the first two patches
>   * Rework conditional parent locking so that lock and unlock no longer use
>     separate conditional checks
>   * Remove an used variable
>   * Comment and description text cleanups
>
> Changes from V10:
>
> Reworked to more closely match the design used for async suspend
>   * No longer uses async subsystem cookies for synchronization
>   * Minimized changes to struct device
>   * Enable async shutdown for pci and scsi devices which support async suspend
>
> Changes from V9:
>
> Address resource and timing issues when spawning a unique async thread
> for every device during shutdown:
>   * Make the asynchronous threads able to shut down multiple devices,
>     instead of spawning a unique thread for every device.
>   * Modify core kernel async code with a custom wake function so it
>     doesn't wake up a thread waiting to synchronize on a cookie until
>     the cookie has reached the desired value, instead of waking up
>     every waiting thread to check the cookie every time an async thread
>     ends.
>
> Changes from V8:
>
> Deal with shutdown hangs resulting when a parent/supplier device is
>   later in the devices_kset list than its children/consumers:
>   * Ignore sync_state_only devlinks for shutdown dependencies
>   * Ignore shutdown_after for devices that don't want async shutdown
>   * Add a sanity check to revert to sync shutdown for any device that
>     would otherwise wait for a child/consumer shutdown that hasn't
>     already been scheduled
>
> Changes from V7:
>
> Do not expose driver async_shutdown_enable in sysfs.
> Wrapped a long line.
>
> Changes from V6:
>
> Removed a sysfs attribute that allowed the async device shutdown to be
> "on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
> previously "safe" is now the only behavior, so drivers now only need to
> have the option to enable or disable async shutdown.
>
> Changes from V5:
>
> Separated into multiple patches to make review easier.
> Reworked some code to make it more readable
> Made devices wait for consumers to shut down, not just children
>   (suggested by David Jeffery)
>
> Changes from V4:
>
> Change code to use cookies for synchronization rather than async domains
> Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
>   opt-out of async shutdown (when not disabled), with ability to control
>   driver opt-in/opt-out via sysfs
>   
> Changes from V3:
>
> Bug fix (used "parent" not "dev->parent" in device_shutdown)
>  
> Changes from V2:
>  
> Removed recursive functions to schedule children to be shutdown before
>   parents, since existing device_shutdown loop will already do this
>  
> Changes from V1:
>
> Rewritten using kernel async code (suggested by Lukas Wunner)
>
>
> Stuart Hayes (2):
>   driver core: separate function to shutdown one device
>   driver core: do not always lock parent in shutdown
>
> David Jeffery (3):
>   driver core: async device shutdown infrastructure
>   PCI: Enable async shutdown support
>   scsi: Enable async shutdown support
>
>  drivers/base/base.h       |   2 +
>  drivers/base/core.c       | 180 ++++++++++++++++++++++++++++++--------
>  drivers/pci/probe.c       |   2 +
>  drivers/scsi/hosts.c      |   2 +
>  drivers/scsi/scsi_sysfs.c |   3 +
>  include/linux/device.h    |  14 ++-
>  6 files changed, 166 insertions(+), 37 deletions(-)
>
> -- 
> 2.53.0

