Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9710C44501
	for <kexec@archiver.kernel.org>; Sat, 11 Jul 2026 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cRWIfNssA7u1GORCvVdy33O3ebBCpe8ieQd8Nngqvvc=; b=m5N+qRzR5Om/lR
	XWUBVYXYMWd3fp2qQpDOtjKys55o9ffEIKOO6gC8WzYPZltYgIRof6Yt30H49Ku7QjOEFJLK+Kg9n
	d4HpEO+woBryZSFtZXGaA7nEOt6NGdBiAzdbhLXdvG74lGUQ6KtOncQr5cERlvf97VtgHGnshZtsM
	ZNPWqfBQb+Yfl1Bd2QTyd5WJgeuAFnXs7P/F01aAdhnxnAWIjIt6jzXGbDSoE5ynkniEtg5oD7F3g
	eJGFEGTI4tjy5pHFXfvE3Zz1IvfKARsuvXY+/fRZ3XJjhzkkOKjVKkJq/nYX7Y81sdr8gNh+u6Xvo
	F28suYAT+oSbbhGk4tug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUq-0000000634C-0jLZ;
	Sat, 11 Jul 2026 00:23:08 +0000
Received: from confino.investici.org ([2a11:7980:1::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiLUn-00000006318-1KEt
	for kexec@lists.infradead.org;
	Sat, 11 Jul 2026 00:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1783729372;
	bh=cRWIfNssA7u1GORCvVdy33O3ebBCpe8ieQd8Nngqvvc=;
	h=From:To:Cc:Subject:Date:From;
	b=HSRuhDEW021iisa8zsueE8fi/EGpG6y41y/Ax7D0xw/9F0+uM+JPdW1MhEwSLWo9b
	 enLQHflJJqNZg7kx1yOIhp85MIiZuT8gA05CY5AHLmI+CPa7WV0yNAZQGhXH13nugL
	 sGyjToZRMVTf5uK07ZzNLTGV8J9q1n2ehEW9XIys=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gxqCw6tzjz114C;
	Sat, 11 Jul 2026 00:22:52 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gxqCw171tz113X;
	Sat, 11 Jul 2026 00:22:52 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: akpm@linux-foundation.org
Subject: [RFC PATCH 0/4] panic: a pre kdump notifier list for hypervisor upcalls
Date: Sat, 11 Jul 2026 00:22:49 +0000
Message-ID: <20260711002253.1115-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260710_172305_504942_372A566A 
X-CRM114-Status: GOOD (  20.09  )
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
Cc: pmladek@suse.com, include@grrlz.net, baoquan.he@linux.dev, arnd@arndb.de, corbet@lwn.net, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, feng.tang@linux.alibaba.com
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

When a crash kernel is loaded, panic() jumps to it before the panic
notifiers run, unless crash_kexec_post_notifiers is set. So the
hypervisor or firmware never finds out the guest panicked. Hyper-V
doesn't get the crash registers, gsmi drops its firmware log entry,
pvpanic stays silent, SEV-SNP skips its firmware and IOMMU shutdown.
Whatever's watching the machine, the host, the BMC, fleet, sees a
clean reboot instead of a crash.

The only way around it today is crash_kexec_post_notifiers, but that
runs the whole legacy notifier list before the kdump. That list has
slow callbacks in it, IPMI being the obvious one since it talks to a
BMC, so turning it on slows down every crash dump on the box. Hyper-V
turns it on anyway and eats the cost for one callback. SNP did the
same.

This adds a separate list that runs before the crash kexec no matter
what. Callbacks on it have to follow a contract: no locks, no
allocation, no sleeping, other CPUs may still be running, and it has
to tolerate being entered again if the panic path itself panics. The
list head is private and you register through a function, because
that's how you make people follow the contract. Priorities order it
like any notifier chain. It lives in its own file because it's not
panic code, just a notifier chain vpanic() calls once, and the custom
walk it needs doesn't belong in the generic notifier API either. A
separate file is also the only thing a MAINTAINERS entry can scope a
reviewer to.

Running anything before the crash kexec is a reliability trade. If an
upcall hangs or faults and costs the dump, you want to know which one
did it, so the notify path walks the chain itself and prints each
callback's name on the console before calling it. Return values are
ignored. A nested panic picks up the walk after the callback that was
running, instead of re-faulting on it.

This is the minimum: the list, the hook in the panic path, one driver
converted so there's a real user, and the MAINTAINERS entry. pvpanic
is the first one. Its callback is a self contained upcall that already
takes its lock as a trylock, so it fits the contract as is. The rest
(Hyper-V, Xen, gsmi, SNP) come in a follow on series. gsmi needs a
rework to a trylock because its old deadlock guard assumed the other
CPUs were stopped, which isn't true on this list. Once SNP's notifier
is on the new list, the crash_kexec_post_notifiers forcing in
snp_rmptable_init() goes away and SNP gets the early crash kexec back.
Hyper-V keeps its forcing for now because its kmsg dump pass also needs
to run before kdump. The register report just doesn't depend on it
anymore.

IPMI stays out. Its panic handling assumes the other CPUs have been
stopped, and poking a BMC before the crash kexec would slow down every
kdump on any box with a BMC. It stays on the legacy list, where kdump
skips it like before.

The legacy list, its position in the panic path and
crash_kexec_post_notifiers itself are untouched, so the remaining
registrants see zero change and nothing is renamed.

This is on purpose. Piccoli's 2022 series tried to classify every
panic notifier and the list split didn't go in. This does the one piece
that fixes the kdump versus hypervisor conflict and stops.

One alternative is splitting the legacy list by priority and calling the
high priority half before the crash kexec. That can't do what this list
does. The walk prints each callback's name on the console before it runs,
and it ignores return values. atomic_notifier_call_chain can't do
either. It honors NOTIFY_STOP_MASK, so one callback can halt the pass
and lose every upcall after it. The walk also resumes past the faulting
callback on a nested panic and runs under RCU instead of the atomic
spinlock. Getting this behavior under a priority split means pushing a
custom walk into the generic notifier API, which is more invasive than
a file.

Build tested on arm64.

Bradley Morgan (4):
  panic: add a pre kdump notifier list
  panic: run the pre kdump list before crash kexec
  misc/pvpanic: notify the host on the pre kdump list
  MAINTAINERS: add an entry for the pre kdump notifier list

 Documentation/admin-guide/kernel-parameters.txt |  3 ++
 MAINTAINERS                                     |  6 +++
 drivers/misc/pvpanic/pvpanic.c                  |  5 +-
 include/linux/panic_notifier.h                  | 18 +++++++
 kernel/Makefile                                 |  2 +-
 kernel/panic.c                                  |  7 +++
 kernel/panic_notifiers.c                        | 65 +++++++++++++++++++++++++
 7 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100644 kernel/panic_notifiers.c

--
2.53.0

