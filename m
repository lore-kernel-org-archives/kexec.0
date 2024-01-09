Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD47C46CD2
	for <kexec@archiver.kernel.org>; Tue,  9 Jan 2024 07:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iJ5ceSAUJ6aCzhEmZ9gYaIZnezuwZiS31oZOaerWdJY=; b=RYEoLHQyNhMfV2
	MEx5lsBgNryKEZmPq55O3QL0ZmSkGU9rumf39T4sUPSaPUBt0EuuNxPZaoKG4bP9OzIuKfV+CbqLf
	U3nACijQgtIHzIZn7K6ai0GPNpMA+8uRDMK7g6s+dXCobYhgNzaJ8zRQLRbjdIDYGWd7wO2VN6tvL
	9O5iTxWTV9V+1rMD5flRHfhLtFFIrell+k28F4XdG3gn8wxM2ozJS6wHhy4oaQ51m82ik/hg1pwBq
	pBrMw93ZYLzfhIh//g9xtITycUShkjSsQm5xqoAm/AFT/Go+/ZE0gUufl4g4vsn6NNtdRkoGbPK53
	Swap6D65PCGLslEC+Vlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rN65d-0076Fh-0G;
	Tue, 09 Jan 2024 06:59:57 +0000
Received: from smtp-fw-9102.amazon.com ([207.171.184.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rN65a-0076Eo-05
	for kexec@lists.infradead.org;
	Tue, 09 Jan 2024 06:59:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1704783594; x=1736319594;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=DxWJPW68SX3P25uHEQaZd1lorw0LGyHW2XlkUatCwlk=;
  b=adVZZKWr1lrt/sHuyS/GX3Dul1UvgTFXSK1fkSdkgjSd3JVArVhovUY2
   na/nQu0era1ti2p2ufymW27Pl92xjFnaXPLmkaJ3OKJ92ebCRJsSVcWf/
   3+TlFzgPJ/Vx5kX3r1a1NfZrmlRCZ2VoIkDRFMztDEHWckQ6XMDSnB9Ub
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,182,1695686400"; 
   d="scan'208";a="388508202"
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Thread-Topic: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 06:59:44 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 05D0449F11;
	Tue,  9 Jan 2024 06:59:37 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:13469]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.235:2525] with esmtp (Farcaster)
 id 4356981e-f386-42d0-87fc-dfdeedb550cd; Tue, 9 Jan 2024 06:59:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4356981e-f386-42d0-87fc-dfdeedb550cd
Received: from EX19D012EUC004.ant.amazon.com (10.252.51.220) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 06:59:35 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC004.ant.amazon.com (10.252.51.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 06:59:35 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Tue, 9 Jan 2024 06:59:35 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "maz@kernel.org"
	<maz@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"sre@kernel.org" <sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>, "Graf
 (AWS), Alexander" <graf@amazon.de>, =?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?=
	<jschoenh@amazon.de>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"bp@alien8.de" <bp@alien8.de>, "samuel@sholland.org" <samuel@sholland.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>
Thread-Index: AQHaLY9ODTyAGBa/a0igJR34RcFga7Cna2CZgAeYkYCAIjOQAA==
Date: Tue, 9 Jan 2024 06:59:35 +0000
Message-ID: <33a35d2c54b898ece210ead7d053db5c81e700f9.camel@amazon.com>
References: <20231213064004.2419447-1-jgowans@amazon.com>
	 <874jgm9huv.fsf@email.froward.int.ebiederm.org>
	 <5a0858597867948f271fa5676fb2e3361f35d920.camel@amazon.com>
In-Reply-To: <5a0858597867948f271fa5676fb2e3361f35d920.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.225]
Content-ID: <798B73416FE0AC429F2D086B523B02CA@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_225954_233845_978C950C 
X-CRM114-Status: GOOD (  45.16  )
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

+ akpm

Hi Eric and Andrew,
Just checking in on this patch.
Would be keen to get the fix merged if you're okay with it, or some
feedback.

Also still keen for input for the driver maintainers in CC if they
support or have objections to their shutdown hooks being invoked on
kexec.

JG

On Mon, 2023-12-18 at 14:41 +0200, James Gowans wrote:
> Hi Eric,
> 
> On Wed, 2023-12-13 at 10:39 -0600, Eric W. Biederman wrote:
> > 
> > James Gowans <jgowans@amazon.com> writes:
> > 
> > > syscore_shutdown() runs driver and module callbacks to get the system
> > > into a state where it can be correctly shut down. In commit
> > > 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> > > syscore_shutdown() was removed from kernel_restart_prepare() and hence
> > > got (incorrectly?) removed from the kexec flow. This was innocuous until
> > > commit 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> > > changed the way that KVM registered its shutdown callbacks, switching from
> > > reboot notifiers to syscore_ops.shutdown. As syscore_shutdown() is
> > > missing from kexec, KVM's shutdown hook is not run and virtualisation is
> > > left enabled on the boot CPU which results in triple faults when
> > > switching to the new kernel on Intel x86 VT-x with VMXE enabled.
> > > 
> > > Fix this by adding syscore_shutdown() to the kexec sequence. In terms of
> > > where to add it, it is being added after migrating the kexec task to the
> > > boot CPU, but before APs are shut down. It is not totally clear if this
> > > is the best place: in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> > > it is stated that "syscore_ops operations should be carried with one
> > > CPU on-line and interrupts disabled." APs are only offlined later in
> > > machine_shutdown(), so this syscore_shutdown() is being run while APs
> > > are still online. This seems to be the correct place as it matches where
> > > syscore_shutdown() is run in the reboot and halt flows - they also run
> > > it before APs are shut down. The assumption is that the commit message
> > > in commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
> > > is no longer valid.
> > > 
> > > KVM has been discussed here as it is what broke loudly by not having
> > > syscore_shutdown() in kexec, but this change impacts more than just KVM;
> > > all drivers/modules which register a syscore_ops.shutdown callback will
> > > now be invoked in the kexec flow. Looking at some of them like x86 MCE
> > > it is probably more correct to also shut these down during kexec.
> > > Maintainers of all drivers which use syscore_ops.shutdown are added on
> > > CC for visibility. They are:
> > > 
> > > arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
> > > arch/x86/kernel/cpu/mce/core.c                .shutdown = mce_syscore_shutdown,
> > > arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
> > > drivers/irqchip/irq-i8259.c           .shutdown = i8259A_shutdown,
> > > drivers/irqchip/irq-sun6i-r.c         .shutdown = sun6i_r_intc_shutdown,
> > > drivers/leds/trigger/ledtrig-cpu.c    .shutdown = ledtrig_cpu_syscore_shutdown,
> > > drivers/power/reset/sc27xx-poweroff.c .shutdown = sc27xx_poweroff_shutdown,
> > > kernel/irq/generic-chip.c             .shutdown = irq_gc_shutdown,
> > > virt/kvm/kvm_main.c                   .shutdown = kvm_shutdown,
> > > 
> > > This has been tested by doing a kexec on x86_64 and aarch64.
> > 
> > From the 10,000 foot perspective:
> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Thanks for the ACK!
> What's the next step to get this into the kexec tree?
> 
> JG
> 
> > 
> > 
> > Eric
> > 
> > > Fixes: 6735150b6997 ("KVM: Use syscore_ops instead of reboot_notifier to hook restart/shutdown")
> > > 
> > > Signed-off-by: James Gowans <jgowans@amazon.com>
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Sean Christopherson <seanjc@google.com>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Cc: Tony Luck <tony.luck@intel.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Chen-Yu Tsai <wens@csie.org>
> > > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > > Cc: Samuel Holland <samuel@sholland.org>
> > > Cc: Pavel Machek <pavel@ucw.cz>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Orson Zhai <orsonzhai@gmail.com>
> > > Cc: Alexander Graf <graf@amazon.de>
> > > Cc: Jan H. Schoenherr <jschoenh@amazon.de>
> > > ---
> > >  kernel/kexec_core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index be5642a4ec49..b926c4db8a91 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -1254,6 +1254,7 @@ int kernel_kexec(void)
> > >               kexec_in_progress = true;
> > >               kernel_restart_prepare("kexec reboot");
> > >               migrate_to_reboot_cpu();
> > > +             syscore_shutdown();
> > > 
> > >               /*
> > >                * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
