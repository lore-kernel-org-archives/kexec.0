Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44DAC32796
	for <kexec@archiver.kernel.org>; Wed, 24 Aug 2022 13:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=uyuBdN4FaWwxb3zPfgQGUjQp0eVjqH2Q3FmlAzidqzQ=; b=oQCMoGu3DPr7QB
	X5I3WreZLh7RO32oxAocjkQRkDj3pzN+THyYjNwmPvMoxLODLd7eHhMO2wJjimAKJw1uFFHdrUEPJ
	u6dlFgHHHtjTCzZfQm9Zt9MBkdpzlXhHg6gdM/fuZl7DkkE2VTw21LpW24+2vkal64GqDih1FQUNi
	Enat4UEaayYm1KGMplF+WYNjFYX5AuYv8jGH6EST8X/piSrlnzzy/EV/h13gX8+P52clmM9mQlvQ2
	obMs2ODU6KP3FUp/OSarZLpx+vu2UChW3LNdZCmVt2tO9DBL7kD/dekd93Xz+mH7vG5g40K9RIqQQ
	vZYqlI3LvX+Ym9Y9Oqmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQq57-00D5qh-Ip; Wed, 24 Aug 2022 13:06:05 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oPAKp-00Cmj6-CF; Fri, 19 Aug 2022 22:19:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pfV3W5tIDS7uvHHlXIEyDkDagWNi+Z86KWqZSqCzOrI=; b=sY1n8Aq6cKn+8C+zsSeV/uxggm
	nsj/09ZQvFYE+q97bRBlzjnW1zw5RbFDAnFolBKYT6KrCpDrsXE1skijRnZWS19ElGNWcV5X4mpAU
	dPTTKVW8Ybf0lsZ+/2nZtUSKRL8Tsrvh7PeUAO5+1gcci5JuGcxPHddWjR8qmRG7owXlYfJB4r7z2
	gygAEeJyjzZWEZLKLqNxZ2NITsVeZECMoYr2HilmMgOn6hF92BWV6bQedzTrYdl8A4e5mubOIC1f3
	GjHAfCmlUSyzNEzj/212l9Gi3pAbATQtzxezcnnn2wIWy1pePhpNmlSJIReIg6cL3Lz4Qmauejy6k
	jX0jtSbQ==;
Received: from [179.232.144.59] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oPAJo-00Carb-O5; Sat, 20 Aug 2022 00:18:22 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH V3 00/11] The panic notifiers refactor - fixes/clean-ups (V3)
Date: Fri, 19 Aug 2022 19:17:20 -0300
Message-Id: <20220819221731.480795-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220819_151925_720615_54BA1722 
X-CRM114-Status: GOOD (  11.22  )
X-Mailman-Approved-At: Wed, 24 Aug 2022 06:05:59 -0700
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
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, bcm-kernel-feedback-list@broadcom.com, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, jgross@suse.com, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, xuqiang36@huawei.com, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hey everybody, this the third iteration of the panic notifiers
fixes/clean-ups;

V2 available at:
https://lore.kernel.org/lkml/20220719195325.402745-1-gpiccoli@igalia.com/

V1 (including the refactor) available at:
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/


There wasn't much change here compared to V2 (the specifics are in the
patches), but a global change is that I've rebased against 6.0-rc1.
One patch got merged in -next, another one was re-submit in a standalone
format (requested by maintainer), so both of these are not here anymore.


As usual, tested this series building for all affected architecture/drivers
and also through some boot/runtime tests; below the test "matrix" used:

Build tests (using cross-compilers): alpha, arm, arm64, parisc, um, x86_64.
Boot/Runtime tests: x86_64 (QEMU guests and Steam Deck).

Here is the link with the .config files used:
https://people.igalia.com/gpiccoli/panic_notifiers_configs/6.0-rc1/


About the merge strategy: I've noticed there is a difference in maintainers
preferences (and my preference as well), so I see 3 strategies for merge:

(a) Maintainers pick patches that are good from the series and merge in
their trees;

(b) Some maintainer would pick the whole series and merge, at once, given
that everything is fine/ack/reviewed.

(c) I must re-send patches individually once they are reviewed/acked, as
standalone patches to the relevant maintainers, so they can merge it in
their trees.

I'm willing to do what's best for everybody - (a) is my choice when possible,
(b) seems to stall things and potentially cause conflicts, (c) seems to be
the compromise. I'll do that as per preference of the respective maintainers.


As usual, reviews / comments are always welcome, thanks in advance for them!
Cheers,

Guilherme


Guilherme G. Piccoli (11):
  ARM: Disable FIQs (but not IRQs) on CPUs shutdown paths
  notifier: Add panic notifiers info and purge trailing whitespaces
  alpha: Clean-up the panic notifier code
  um: Improve panic notifiers consistency and ordering
  parisc: Replace regular spinlock with spin_trylock on panic path
  tracing: Improve panic/die notifiers
  notifiers: Add tracepoints to the notifiers infrastructure
  EDAC/altera: Skip the panic notifier if kdump is loaded
  video/hyperv_fb: Avoid taking busy spinlock on panic path
  drivers/hv/vmbus, video/hyperv_fb: Untangle and refactor Hyper-V panic notifiers
  panic: Fixes the panic_print NMI backtrace setting

 arch/alpha/kernel/setup.c        |  36 +++++-----
 arch/arm/kernel/machine_kexec.c  |   2 +
 arch/arm/kernel/smp.c            |   5 +-
 arch/parisc/include/asm/pdc.h    |   1 +
 arch/parisc/kernel/firmware.c    |  27 ++++++--
 arch/um/drivers/mconsole_kern.c  |   7 +-
 arch/um/kernel/um_arch.c         |   8 +--
 drivers/edac/altera_edac.c       |  16 +++--
 drivers/hv/ring_buffer.c         |  13 ++++
 drivers/hv/vmbus_drv.c           | 109 +++++++++++++++++++------------
 drivers/parisc/power.c           |  17 +++--
 drivers/video/fbdev/hyperv_fb.c  |  16 ++++-
 include/linux/hyperv.h           |   2 +
 include/linux/notifier.h         |   8 ++-
 include/trace/events/notifiers.h |  69 +++++++++++++++++++
 kernel/notifier.c                |   6 ++
 kernel/panic.c                   |  47 +++++++------
 kernel/trace/trace.c             |  55 ++++++++--------
 18 files changed, 302 insertions(+), 142 deletions(-)
 create mode 100644 include/trace/events/notifiers.h

-- 
2.37.2


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
