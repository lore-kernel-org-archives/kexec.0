Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BFAC4167B
	for <kexec@archiver.kernel.org>; Wed, 13 Dec 2023 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yWLni+crYIg8kBpxMColHs05xqJW5K/zQi7GGSU4F1Q=; b=f+PG3478bIcy8oUCFoVldwBjxL
	vTrrhSPRxllNVpqL/an+LOS6jI72krjYI9WBYe76gSA5SLJ3e6TKMB4JzBKp0qR1oYQ1TVESRKuQb
	oWjbEdY63vk3G4oRvNLm/Za+5cqPoi/552OG/ufdmWOrNtRXkAtZcdDdxoM1eVuOqvy2QADvOfQi1
	h8ApkEtq6lN6boPmGv1do3+Oz0NFBzDvrRci7mnUoTnCwF9ZWRqtVeVZWyEoIolE4dgeAHp/q+vlM
	pimFE2RBG5r+ZpAPtFsf8hCrg2uoHxWyyxNOlkuAxUL9bFu6eL2ypscjd1a1yI5xszHrFMIj53Ogp
	+MuA2azw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDSIF-00FU3i-0y;
	Wed, 13 Dec 2023 16:41:07 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDSIC-00FU1y-1O
	for kexec@lists.infradead.org;
	Wed, 13 Dec 2023 16:41:06 +0000
Received: from in01.mta.xmission.com ([166.70.13.51]:34198)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDSHq-000F5P-IN; Wed, 13 Dec 2023 09:40:42 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57650 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rDSHp-007ayE-7B; Wed, 13 Dec 2023 09:40:42 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: James Gowans <jgowans@amazon.com>
Cc: "Sean Christopherson" <seanjc@google.com>,  <kexec@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,
  Marc Zyngier <maz@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Tony Luck
 <tony.luck@intel.com>,  Borislav Petkov <bp@alien8.de>,  Thomas Gleixner
 <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>,  Chen-Yu Tsai
 <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  "Pavel Machek" <pavel@ucw.cz>,  Sebastian
 Reichel <sre@kernel.org>,  Orson Zhai <orsonzhai@gmail.com>,  Alexander
 Graf <graf@amazon.de>,  "Jan H . Schoenherr" <jschoenh@amazon.de>
References: <20231213064004.2419447-1-jgowans@amazon.com>
Date: Wed, 13 Dec 2023 10:39:52 -0600
In-Reply-To: <20231213064004.2419447-1-jgowans@amazon.com> (James Gowans's
	message of "Wed, 13 Dec 2023 08:40:04 +0200")
Message-ID: <874jgm9huv.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rDSHp-007ayE-7B;;;mid=<874jgm9huv.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+gZJHyqWjEBJwoHvIZu/SXC+PpnQcK/vQ=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_084104_510354_7BE2FE7E 
X-CRM114-Status: GOOD (  32.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

James Gowans <jgowans@amazon.com> writes:

> syscore_shutdown() runs driver and module callbacks to get the system
> into a state where it can be correctly shut down. In commit
> 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> syscore_shutdown() was removed from kernel_restart_prepare() and hence
> got (incorrectly?) removed from the kexec flow. This was innocuous until
> commit 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> changed the way that KVM registered its shutdown callbacks, switching from
> reboot notifiers to syscore_ops.shutdown. As syscore_shutdown() is
> missing from kexec, KVM's shutdown hook is not run and virtualisation is
> left enabled on the boot CPU which results in triple faults when
> switching to the new kernel on Intel x86 VT-x with VMXE enabled.
>
> Fix this by adding syscore_shutdown() to the kexec sequence. In terms of
> where to add it, it is being added after migrating the kexec task to the
> boot CPU, but before APs are shut down. It is not totally clear if this
> is the best place: in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> it is stated that "syscore_ops operations should be carried with one
> CPU on-line and interrupts disabled." APs are only offlined later in
> machine_shutdown(), so this syscore_shutdown() is being run while APs
> are still online. This seems to be the correct place as it matches where
> syscore_shutdown() is run in the reboot and halt flows - they also run
> it before APs are shut down. The assumption is that the commit message
> in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> is no longer valid.
>
> KVM has been discussed here as it is what broke loudly by not having
> syscore_shutdown() in kexec, but this change impacts more than just KVM;
> all drivers/modules which register a syscore_ops.shutdown callback will
> now be invoked in the kexec flow. Looking at some of them like x86 MCE
> it is probably more correct to also shut these down during kexec.
> Maintainers of all drivers which use syscore_ops.shutdown are added on
> CC for visibility. They are:
>
> arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
> arch/x86/kernel/cpu/mce/core.c	        .shutdown = mce_syscore_shutdown,
> arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
> drivers/irqchip/irq-i8259.c	        .shutdown = i8259A_shutdown,
> drivers/irqchip/irq-sun6i-r.c	        .shutdown = sun6i_r_intc_shutdown,
> drivers/leds/trigger/ledtrig-cpu.c	.shutdown = ledtrig_cpu_syscore_shutdown,
> drivers/power/reset/sc27xx-poweroff.c	.shutdown = sc27xx_poweroff_shutdown,
> kernel/irq/generic-chip.c	        .shutdown = irq_gc_shutdown,
> virt/kvm/kvm_main.c	                .shutdown = kvm_shutdown,
>
> This has been tested by doing a kexec on x86_64 and aarch64.

From the 10,000 foot perspective:
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>


Eric

> Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
>
> Signed-off-by: James Gowans <jgowans@amazon.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Alexander Graf <graf@amazon.de>
> Cc: Jan H. Schoenherr <jschoenh@amazon.de>
> ---
>  kernel/kexec_core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index be5642a4ec49..b926c4db8a91 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1254,6 +1254,7 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> +		syscore_shutdown();
>  
>  		/*
>  		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
