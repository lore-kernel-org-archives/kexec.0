Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA421C10DC3
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 18:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xodhCCDMdRX/bEIAlOrYApAq6dlA+2/hEL3rTrs032Y=; b=U8tgq3ios1cq9E
	TjPMTOyyH80NqDu8deC1phxogFppIX1P5/mrS0SSAq6fevkhX56+awmxDt0FMCcY2P7i3R8KuODcB
	ky/Yrpm38cl8Dr6uxxMVHDztk4t/eMY+RjObxlgfUAeswIn2+oSYwB5HC+snfUSDTT4Fx3APEwqek
	isah7eWI3Z6cP58BwLShb6uBJoNDwhhVeLEK5v5r7dloy+VtuO0RMPcOHwFl1gT7xSmuY5CI8P+YE
	ytKBHnbHC7KwUpkRm/4kmSb1kl2d4fxOffP29NKL3ucPLHjoCBiDPnSs8FPnCrN7BP0NNkSLhA7wQ
	yDLEl4pzxqpS0a461wIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rClK1-0077I7-0D;
	Mon, 11 Dec 2023 18:48:05 +0000
Received: from smtp-fw-52002.amazon.com ([52.119.213.150])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rClJx-0077Dw-0R;
	Mon, 11 Dec 2023 18:48:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702320481; x=1733856481;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=BBxHyiZZ7qd6t/Hnqi40UYRvuKrVu6V0t98axO4RwLo=;
  b=c3wNEtucrZxfolrwBFRP8gh8X4i0yEqIDvB8c6afv5JmVBWUwahflVSn
   Js3jhAbR6ePoFlOR9eQOjPb7Wje8yLTHLVfrpDHZB1+ug/NAfd74LZnDA
   0wLqv3FDJkoC1DD9nQ/hhUR/EHYxWyoQmOlbsEXgiROEvXTYy5cxEPmtz
   E=;
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="599945077"
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 18:47:54 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-7fa2de02.us-west-2.amazon.com (Postfix) with ESMTPS id EBACF40D7D;
	Mon, 11 Dec 2023 18:47:52 +0000 (UTC)
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:54605]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id 8884d293-f880-40f3-a23f-45b255ccad1a; Mon, 11 Dec 2023 18:47:52 +0000 (UTC)
X-Farcaster-Flow-ID: 8884d293-f880-40f3-a23f-45b255ccad1a
Received: from EX19D012EUC004.ant.amazon.com (10.252.51.220) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 18:47:51 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC004.ant.amazon.com (10.252.51.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 18:47:51 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Mon, 11 Dec 2023 18:47:50 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Graf (AWS), Alexander"
	<graf@amazon.de>, "seanjc@google.com" <seanjc@google.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>
CC: "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "atishp@atishpatra.org"
	<atishp@atishpatra.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "aleksandar.qemu.devel@gmail.com"
	<aleksandar.qemu.devel@gmail.com>, "anup@brainfault.org"
	<anup@brainfault.org>
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCAgAPOgQCAABR9AA==
Date: Mon, 11 Dec 2023 18:47:50 +0000
Message-ID: <55ef5cbf44bb73030d6387aa181393b8cb044f77.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
	 <20230512233127.804012-2-seanjc@google.com>
	 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	 <ZXdIIBUXcCIK28ys@google.com>
In-Reply-To: <ZXdIIBUXcCIK28ys@google.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-ID: <44768D8B1F7ED64C87222E7575E03BDD@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_104801_446250_895A5BF7 
X-CRM114-Status: GOOD (  25.68  )
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

On Mon, 2023-12-11 at 09:34 -0800, Sean Christopherson wrote:
> On Sat, Dec 09, 2023, James Gowans wrote:
> > Thoughts on possible ways to fix this:
> > a) go back to reboot notifiers
> > b) get kexec to call syscore_shutdown() to invoke all of these callbacks
> > c) Add a KVM-specific callback to native_machine_shutdown(); we only
> > need this for Intel x86, right?
> 
> I don't like (c).  VMX is the most sensitive/problematic, e.g. the whole blocking
> of INIT thing, but SVM can also run afoul of EFER.SVME being cleared, and KVM really
> should leave virtualization enabled across kexec(), even if leaving virtualization
> enabled is relatively benign on other architectures.

Good to know. Agreed that clean shutdown in all cases is best and we
discard (c).
> 
> One more option would be:
> 
>  d) Add another sycore hook, e.g. syscore_kexec() specifically for this path.
> 
> > My slight preference is towards adding syscore_shutdown() to kexec, but
> > I'm not sure that's feasible. Adding kexec maintainers for input.
> 
> In a vacuum, that'd be my preference too.  It's the obvious choice IMO, e.g. the
> kexec_image->preserve_context path does syscore_suspend() (and then resume(), so
> it's not completely uncharted territory.
> 
> However, there's a rather big wrinkle in that not all of the existing .shutdown()
> implementations are obviously ok to call during kexec.  Luckily, AFAICT there are
> very few users of the syscore .shutdown hook, so it's at least feasible to go that
> route.
> 
> x86's mce_syscore_shutdown() should be ok, and arguably is correct, e.g. I don't
> see how leaving #MC reporting enabled across kexec can work.
> 
> ledtrig_cpu_syscore_shutdown() is also likely ok and arguably correct.

I like your observation here that we probably have other misses like MCE
which should be shut down too - that's a hint that adding
syscore_shutdown() to kexec is the way to go.

> 
> The interrupt controllers though?  x86 disables IRQs at the very beginning of
> machine_kexec(), so it's likely fine.  But every other architecture?  No clue.
> E.g. PPC's default_machine_kexec() sends IPIs to shutdown other CPUs, though I
> have no idea if that can run afoul of any of the paths below.
> 
>         arch/powerpc/platforms/cell/spu_base.c  .shutdown = spu_shutdown,
>         arch/x86/kernel/cpu/mce/core.c          .shutdown = mce_syscore_shutdown,
>         arch/x86/kernel/i8259.c                 .shutdown = i8259A_shutdown,
>         drivers/irqchip/irq-i8259.c             .shutdown = i8259A_shutdown,
>         drivers/irqchip/irq-sun6i-r.c           .shutdown = sun6i_r_intc_shutdown,
>         drivers/leds/trigger/ledtrig-cpu.c      .shutdown = ledtrig_cpu_syscore_shutdown,
>         drivers/power/reset/sc27xx-poweroff.c   .shutdown = sc27xx_poweroff_shutdown,
>         kernel/irq/generic-chip.c               .shutdown = irq_gc_shutdown,
>         virt/kvm/kvm_main.c                     .shutdown = kvm_shutdown,
> 
> The whole thing is a bit of a mess.  E.g. x86 treats machine_shutdown() from
> kexec pretty much the same as shutdown for reboot, but other architectures have
> what appear to be unique paths for handling kexec.
> 
> FWIW, if we want to go with option (b), syscore_shutdown() hooks could use
> kexec_in_progress to differentiate between "regular" shutdown/reboot and kexec.

Yeah, perhaps that's the best: add syscore_shutdown to kexec and get the
callers to handle both cases if necessary. We could get maintainers for
all of these drivers to sign off on the change and say whether they need
to differentiate between kexec and reboot.

Eric, what are your thoughts on this approach? I can try to whip up a
patch for this and add the maintainers for all of the drivers.

JG

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
