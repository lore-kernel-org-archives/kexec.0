Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE36C5DF96
	for <kexec@archiver.kernel.org>; Fri, 21 Aug 2026 14:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kzLAPBXMlMhYI6ySzz6pnLfsKpX/Ftkzneo9qfA/5sU=; b=TU8e3IYS2w/sx/Quoe3Y0cJRoc
	pRgYvVKCDLjFrR6vFeYXX84Zeuw91/h1aBfQ2Sh2YTqMhZgwzy5DnbKmpy04PmVdi2rr8XLnphecf
	3yoJC6Wb4RomifgVhNIrxLyWUYQIFWKMnDtx8YJ2Ti05ptJOTD8PyWkeZJIIz1RoqfnqPWtzvnryo
	48UURsF22McH/hOH3xDZyi1dlKuJnW0UwrqegoHTXjb+GBZ7OQdBKNPpxLdtwDGHfFPaMAbRqfq0i
	07u58xD8eygG+1yMbG2j09sz0UZz8pnnZt0NAUFjYdSsKwcNfsQF8VaX2vdWbqU9JJAP69WozvPAC
	CWlLMqGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCU-0000000DXzP-0yVd;
	Fri, 21 Aug 2026 14:26:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxQCP-0000000DXwe-140J
	for kexec@lists.infradead.org;
	Fri, 21 Aug 2026 14:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787322384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kzLAPBXMlMhYI6ySzz6pnLfsKpX/Ftkzneo9qfA/5sU=;
	b=SOMaOxa3i96TlBpWjg42C8uP1mG0sugJ5mOWyINCxqAHRCsiShL/iauqnhvEI8KpI3TSuU
	EIt2V4vPJHznvR6D2qRzqfLFJFsus8OhBlMcZrQ3t6zCZYUSJ6/x9J4wqB9XnxpBc3JWI3
	P9t2pf1RaliH4H1Y88fIdbh/U/0HJO0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-9a5yc_PuOaGe1CNe4NBKQw-1; Fri,
 21 Aug 2026 10:24:47 -0400
X-MC-Unique: 9a5yc_PuOaGe1CNe4NBKQw-1
X-Mimecast-MFC-AGG-ID: 9a5yc_PuOaGe1CNe4NBKQw_1787322284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 487B018011EC;
	Fri, 21 Aug 2026 14:24:44 +0000 (UTC)
Received: from djeffery-thinkpadp1gen3.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 174BF1800346;
	Fri, 21 Aug 2026 14:24:40 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: driver-core@lists.linux.dev,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Tarun Sahu <tarunsahu@google.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Laurence Oberman <loberman@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	kexec@lists.infradead.org,
	David Jeffery <djeffery@redhat.com>
Subject: [PATCH v20 0/9] shut down devices asynchronously
Date: Fri, 21 Aug 2026 10:24:05 -0400
Message-ID: <20260821142414.150892-1-djeffery@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: wpnzJpuJSNbAAgWF-lSwQh_D_Wj57giBom_IX4m1aIc_1787322284
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_072625_500055_2614AD24 
X-CRM114-Status: GOOD (  29.10  )
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

These patches are rebased against the driver-core tree's driver-core-next
branch and should also apply against recent linux-next. Changes for v18 are
contained in patch 3.

This patchset allows the kernel to shutdown devices asynchronously and
unrelated async devices to be shut down in parallel to each other.

Only devices which explicitly enable it are shut down asynchronously. The
default is for a device to be shut down from the synchronous shutdown loop.

This can dramatically reduce system shutdown/reboot time on systems that
have multiple devices that take many seconds to shut down (like certain
NVMe drives). On one system tested, the shutdown time went from 11 minutes
without this patch to 55 seconds with the patch. And on another system from
80 seconds to 11.

And thank you to everyone who has spent some of their valuable time
providing reviews, suggestions, criticisms, or tests on the various
iterations of this patchset.

Changes from V19:
- Convert initial creation of shutdown_one_device to a code move with no
  changes or side effects
- Add a warning to device_move should some device ever mix need_parent_lock
  with device_move in the future
- Link a PCI virtual function as consumer of its associated physical
  function to ensure proper shutdown order

Changes from V18:
- Fix deadlock and race condition on concurrent device_add
- Use local variable to device_shutdown for caching async_shutdown
- Added dev->p check to avoid NULL pointer deference and tell if the
  device is not registered so no need to be shutdown. This is to handle
  the cases when devices consumers list might have devices that are not
  yet registered.

Changes from V17:

Fix mangled text in kernel parameter description
Re-protect the list removal with the spinlock
  * Hold a device reference to ensure the device cannot be freed before
    attempting list removal

Changes from V16:

Drop spinlock before async subsystem call which uses GFP_KERNEL
Handle that async shutdown can widen races between device shutdown and deletion
  * __shutdown_one_device will immediately return if a device is dead
  * Set shutdown device completion to complete when marking a device dead to
      prevent waiting on a dead device
  * Only late-access a parent pointer if device is in a non-dead state to
      ensure the pointer is still valid

Changes from V15:

The async_shutdown bit field is converted to a device flags bit
Convert all patches to use the flag bit accessor macros to set or check if
  async shutdown should be used
Added documentation on the kernel parameter to control use of async shutdown

Changes from V14:

Remove unneeded use of '!!' with boolean type

Changes from V13:

Remove duplicate flagging of async shutdown on scsi hosts/targets/devices

Changes from V12:

Only acquire a parent reference if acquiring the parent's lock
device_enable_async_shutdown should return void
Minor comment and description cleanups

Changes from V11:

  * Swap the order of the first two patches
  * Rework conditional parent locking so that lock and unlock no longer use
    separate conditional checks
  * Remove an used variable
  * Comment and description text cleanups

Changes from V10:

Reworked to more closely match the design used for async suspend
  * No longer uses async subsystem cookies for synchronization
  * Minimized changes to struct device
  * Enable async shutdown for pci and scsi devices which support async suspend

Changes from V9:

Address resource and timing issues when spawning a unique async thread
for every device during shutdown:
  * Make the asynchronous threads able to shut down multiple devices,
    instead of spawning a unique thread for every device.
  * Modify core kernel async code with a custom wake function so it
    doesn't wake up a thread waiting to synchronize on a cookie until
    the cookie has reached the desired value, instead of waking up
    every waiting thread to check the cookie every time an async thread
    ends.

Changes from V8:

Deal with shutdown hangs resulting when a parent/supplier device is
  later in the devices_kset list than its children/consumers:
  * Ignore sync_state_only devlinks for shutdown dependencies
  * Ignore shutdown_after for devices that don't want async shutdown
  * Add a sanity check to revert to sync shutdown for any device that
    would otherwise wait for a child/consumer shutdown that hasn't
    already been scheduled

Changes from V7:

Do not expose driver async_shutdown_enable in sysfs.
Wrapped a long line.

Changes from V6:

Removed a sysfs attribute that allowed the async device shutdown to be
"on" (with driver opt-out), "safe" (driver opt-in), or "off"... what was
previously "safe" is now the only behavior, so drivers now only need to
have the option to enable or disable async shutdown.

Changes from V5:

Separated into multiple patches to make review easier.
Reworked some code to make it more readable
Made devices wait for consumers to shut down, not just children
  (suggested by David Jeffery)

Changes from V4:

Change code to use cookies for synchronization rather than async domains
Allow async shutdown to be disabled via sysfs, and allow driver opt-in or
  opt-out of async shutdown (when not disabled), with ability to control
  driver opt-in/opt-out via sysfs
  
Changes from V3:

Bug fix (used "parent" not "dev->parent" in device_shutdown)
 
Changes from V2:
 
Removed recursive functions to schedule children to be shutdown before
  parents, since existing device_shutdown loop will already do this
 
Changes from V1:

Rewritten using kernel async code (suggested by Lukas Wunner)

David Jeffery (7):
  driver core: warn should device_move try to move a need_parent_lock
    device
  driver core: separate function to shutdown one device
  driver core: do not always lock parent in shutdown
  driver core: async device shutdown infrastructure
  PCI: Link a virtual function to its physical function
  PCI: Enable async shutdown support
  scsi: Enable async shutdown support

Tarun Sahu (2):
  driver core: rely on put_device to free dev->p
  driver core: prevent device_add() during system shutdown

 .../admin-guide/kernel-parameters.txt         |  10 +
 drivers/base/base.h                           |   2 +
 drivers/base/core.c                           | 273 +++++++++++++++---
 drivers/pci/iov.c                             |  11 +-
 drivers/pci/probe.c                           |   2 +
 drivers/scsi/hosts.c                          |   2 +
 drivers/scsi/scsi_sysfs.c                     |   3 +
 include/linux/device.h                        |   2 +
 8 files changed, 265 insertions(+), 40 deletions(-)

-- 
2.53.0


