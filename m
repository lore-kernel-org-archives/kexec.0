Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D9DC43334
	for <kexec@archiver.kernel.org>; Wed, 20 Jul 2022 06:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zUY3e3LW75zKoWfo5IlqQYjwCRbYu26GsuD3Na15oKQ=; b=WMqb2qHP8a4UKM
	vBNwLSjb0GR4hl6osMBlDS8CF9/8U7j1LeQl9y6LyMCxMKCP0jT6BetL186GD2T5EXdWIE9ts6Z7H
	rS0iiNau8ZH/kcRSy0h4cz5jI7Cw3klpLzgJ56uumflNLrypU9m8qLPNJwxqudhf2oQL2++PvdpAO
	oeFwltmDx81UILlG18jd36QIL+QsCx92XcusppFeAe6V4u/mlJcRrPIM23wS2HUPASk23A1NpvpnH
	hm5aCDG86vocMACkcfEVOlMb8aD+j5QlAPWlSjvdkou7SU3UOnvoDj0XfWvEx5ERSsX1JXTe64U91
	tXTXgQdxsGcBZY3iiQyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oE2nC-000s9h-Ab; Wed, 20 Jul 2022 06:02:42 +0000
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDtIz-00C9HQ-5P; Tue, 19 Jul 2022 19:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v6ALRzuY4RIlvqb5/OysD83kMB2n09igJBmCmJkb/mQ=; b=QX2ndssTwYlCGQttlP6yZb1v8t
	5s2Hg+pF+iNzzwWbJ4MQaGSaf6qkeb05PdTsq+Deth55WrA0pCBg5abgJ5rgV7rYQ1in6Q0iGiphA
	Ny8wQRwMi4VTn4nbzPtFheSJmfPAAsWP3wO6T6rwqeMZ6FBPSZbVJscxJAF1he9ZTINlqR7pMavHd
	JUmz54ZCbUg5czNAxrGNtKvvD4CjMf1IUILFMG1Fr7T+NXdQ+h0VrvP3Jd0esGE2WeLQ3wNsRgsoR
	A2H70K6+3TnyaQxqB5nwJ5zwLOp0Bqh1CdPhvwI1Y5O+c66ciesYb/MZNrPpMNAzxEEfLahEMj+q0
	vfS69Cnw==;
Received: from 200-100-212-117.dial-up.telesp.net.br ([200.100.212.117] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1oDtIK-006f8k-U4; Tue, 19 Jul 2022 21:54:15 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: akpm@linux-foundation.org,
	bhe@redhat.com,
	pmladek@suse.com,
	kexec@lists.infradead.org
Subject: [PATCH v2 00/13] The panic notifiers refactor strikes back - fixes/clean-ups
Date: Tue, 19 Jul 2022 16:53:13 -0300
Message-Id: <20220719195325.402745-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220719_125453_246529_4E1828CD 
X-CRM114-Status: GOOD (  17.64  )
X-Mailman-Approved-At: Tue, 19 Jul 2022 23:02:40 -0700
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
Cc: linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org, halves@canonical.com, peterz@infradead.org, dave.hansen@linux.intel.com, feng.tang@intel.com, mikelley@microsoft.com, will@kernel.org, arnd@arndb.de, corbet@lwn.net, paulmck@kernel.org, fabiomirmar@gmail.com, x86@kernel.org, mingo@redhat.com, stern@rowland.harvard.edu, bcm-kernel-feedback-list@broadcom.com, dyoung@redhat.com, vgoyal@redhat.com, alejandro.j.jimenez@oracle.com, keescook@chromium.org, john.ogness@linutronix.de, linux-alpha@vger.kernel.org, linux-um@lists.infradead.org, rostedt@goodmis.org, bp@alien8.de, luto@kernel.org, hidehiro.kawai.ez@hitachi.com, tglx@linutronix.de, andriy.shevchenko@linux.intel.com, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, jgross@suse.com, linux-parisc@vger.kernel.org, gregkh@linuxfoundation.org, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, senozhatsky@chromium.org, d.hatayama@jp.fujitsu.com, mhiramat@kernel.org, kernel-dev@igalia.com, netdev@vger.kernel.org, vkuznets@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

Hi folks, this the second iteration of the panic notifiers refactor work,
but limited to the fixes/clean-ups in the first moment. The (full) V1 is
available at:
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/

The idea of splitting the series is that, originally we had a bunch of fixes
followed by the notifiers refactor, but this second part (the effective
refactor) is a bit "polemic", with reviews having antagonistic goals and some
complexities  - it might be hard to achieve consensus.
For the curious, here is a good summary of the conflicting views and some
strategies we might take in the refactor V2:
https://lore.kernel.org/lkml/0d084eed-4781-c815-29c7-ac62c498e216@igalia.com/

So splitting and sending only the simple fixes/clean-ups in a first moment
makes sense, this way we don't prevent them to be discussed/merged/reworked
while the more complex part is subject to scrutiny in a different (future)
email thread.


I've tried to test this series building for all affected architecture/drivers
and also through some boot/runtime tests; below the test "matrix" used:

Build tests (using cross-compilers): alpha, arm, arm64, parisc, um, x86_64.
Boot/Runtime tests: x86_64 (Hyper-V and QEMU guests).

Here is the link with the .config files used:
https://people.igalia.com/gpiccoli/panic_notifiers_configs/5.19-rc7/
(tried my best to build all the affected code).


The series is based on 5.19-rc7; I'd like to ask that, if possible, maintainers
take the patches here in their trees, since there is no need to merge the series
as whole, patches are independent from each other.

Regarding the CC strategy, I've tried to reduce a bit the list of CCed emails,
given that it was huge in the first iteration. Hopefully I didn't forget
anybody interested in the topic (my apologies if so).

As usual, reviews / comments are always welcome, thanks in advance for them!
Cheers,


Guilherme




Guilherme G. Piccoli (13):
  ARM: Disable FIQs (but not IRQs) on CPUs shutdown paths
  notifier: Add panic notifiers info and purge trailing whitespaces
  firmware: google: Test spinlock on panic path to avoid lockups
  soc: bcm: brcmstb: Document panic notifier action and remove useless header
  alpha: Clean-up the panic notifier code
  um: Improve panic notifiers consistency and ordering
  parisc: Replace regular spinlock with spin_trylock on panic path
  tracing: Improve panic/die notifiers
  notifier: Show function names on notifier routines if DEBUG_NOTIFIERS is set
  EDAC/altera: Skip the panic notifier if kdump is loaded
  video/hyperv_fb: Avoid taking busy spinlock on panic path
  drivers/hv/vmbus, video/hyperv_fb: Untangle and refactor Hyper-V panic notifiers
  panic: Fixes the panic_print NMI backtrace setting

 arch/alpha/kernel/setup.c           |  36 ++++-----
 arch/arm/kernel/machine_kexec.c     |   2 +
 arch/arm/kernel/smp.c               |   5 +-
 arch/parisc/include/asm/pdc.h       |   1 +
 arch/parisc/kernel/firmware.c       |  27 ++++++-
 arch/um/drivers/mconsole_kern.c     |   7 +-
 arch/um/kernel/um_arch.c            |   8 +-
 drivers/edac/altera_edac.c          |  16 +++-
 drivers/firmware/google/gsmi.c      |   8 ++
 drivers/hv/ring_buffer.c            |  16 ++++
 drivers/hv/vmbus_drv.c              | 109 +++++++++++++++++-----------
 drivers/parisc/power.c              |  17 +++--
 drivers/soc/bcm/brcmstb/pm/pm-arm.c |  16 +++-
 drivers/video/fbdev/hyperv_fb.c     |  16 +++-
 include/linux/hyperv.h              |   2 +
 include/linux/notifier.h            |   8 +-
 kernel/notifier.c                   |  22 ++++--
 kernel/panic.c                      |  47 +++++++-----
 kernel/trace/trace.c                |  55 +++++++-------
 19 files changed, 268 insertions(+), 150 deletions(-)

-- 
2.37.1


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
