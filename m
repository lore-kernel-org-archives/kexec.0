Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366D3C4332F
	for <kexec@archiver.kernel.org>; Tue, 12 Dec 2023 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4PYHLxwecYMg3jcrZXnXMDplhEah2ZSss15X996IKAc=; b=Yjn/V+d4/iw7Mg
	z9QjdKSMGl2zDVy5NSVbtqG7HK7LN3F8ZNl4MZ4mv3OEFIJdLDPWn9Rg0CVcBJq7ZxfcJzqb4Rxwy
	MEzpYXspTsiwsjmKFHZKkzQWTEe+Rs4l3XYG4cOf0VOLFEd5FyonjSfLa9sRFHR/qbV3PY0RIpx8L
	44oFANfmQN/Sh0VDVSFaceG8ZIeTHRJVF06VuEZfOJWTTUIbXJls8HpDnjydGL9QeSnVpbz7PuW8u
	COzIEzProKwXMgpDz//ORbVhHkqQ9FgPRa0mesexsdQms4U9ANTbb4/s/uK0YSzJUV39J25/nUOIt
	T30XG7+LvWncaeYm9NGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCyU1-00B68T-2w;
	Tue, 12 Dec 2023 08:51:17 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCyTy-00B64v-0b;
	Tue, 12 Dec 2023 08:51:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702371074; x=1733907074;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=kbYhK6bcNLvWaLADIREECSkT5n5R6xh4aWNtaq66HUw=;
  b=L/flnOaNfeOYCgRlq88Zy2FGhsWuY7ytSmWSF5Em4eIO94OPh9CW4MK+
   9oK6JHKohu2c9ksPf3owjgYJGZhbGZeTHR4Lbpv1krdf5HRj74c+8EcMk
   GCa0Dm/80P6KyaqwKmH2p2AzXvp91H1w5Xo5rNbBwOhYOlculAZ83y9mV
   8=;
X-IronPort-AV: E=Sophos;i="6.04,269,1695686400"; 
   d="scan'208";a="258431658"
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 08:50:52 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 3BEDC497EE;
	Tue, 12 Dec 2023 08:50:47 +0000 (UTC)
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:27324]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.100:2525] with esmtp (Farcaster)
 id fe0bb469-decf-4e0f-878d-e52a4e884b55; Tue, 12 Dec 2023 08:50:46 +0000 (UTC)
X-Farcaster-Flow-ID: fe0bb469-decf-4e0f-878d-e52a4e884b55
Received: from EX19D012EUC003.ant.amazon.com (10.252.51.208) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 08:50:40 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC003.ant.amazon.com (10.252.51.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 08:50:40 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Tue, 12 Dec 2023 08:50:40 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>, "seanjc@google.com"
	<seanjc@google.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>
CC: "yuzenghui@huawei.com" <yuzenghui@huawei.com>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "james.morse@arm.com" <james.morse@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"atishp@atishpatra.org" <atishp@atishpatra.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"maz@kernel.org" <maz@kernel.org>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>,
	"anup@brainfault.org" <anup@brainfault.org>
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCAgAFn6T+AAcSbgIAAKp8AgADgykyAAJaPgA==
Date: Tue, 12 Dec 2023 08:50:40 +0000
Message-ID: <cf9e15bf3da411ada1c5b2bbdbfdea836029a5e1.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
	 <20230512233127.804012-2-seanjc@google.com>
	 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	 <871qbud5f9.fsf@email.froward.int.ebiederm.org>
	 <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
	 <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
	 <87wmtk9u46.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87wmtk9u46.fsf@email.froward.int.ebiederm.org>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.221]
Content-ID: <76D26AF16DA5D4499D562F4A2CD6FDBF@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_005114_331605_6E756C52 
X-CRM114-Status: GOOD (  36.03  )
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

On Mon, 2023-12-11 at 17:50 -0600, Eric W. Biederman wrote:
> "Gowans, James" <jgowans@amazon.com> writes:
> 
> > On Mon, 2023-12-11 at 09:54 +0200, James Gowans wrote:
> > > > 
> > > > What problem are you running into with your rebase that worked with
> > > > reboot notifiers that is not working with syscore_shutdown?
> > > 
> > > Prior to this commit [1] which changed KVM from reboot notifiers to
> > > syscore_ops, KVM's reboot notifier shutdown callback was invoked on
> > > kexec via kernel_restart_prepare.
> > > 
> > > After this commit, KVM is not being shut down because currently the
> > > kexec flow does not call syscore_shutdown.
> > 
> > I think I missed what you're asking here; you're asking for a reproducer
> > for the specific failure?
> > 
> > 1. Launch a QEMU VM with -enable-kvm flag
> > 
> > 2. Do an immediate (-f flag) kexec:
> > kexec -f --reuse-cmdline ./bzImage
> > 
> > Somewhere after doing the RET to new kernel in the relocate_kernel asm
> > function the new kernel starts triple faulting; I can't exactly figure
> > out where but I think it has to do with the new kernel trying to modify
> > CR3 while the VMXE bit is still set in CR4 causing the triple fault.
> > 
> > If KVM has been shut down via the shutdown callback, or alternatively if
> > the QEMU process has actually been killed first (by not doing a -f exec)
> > then the VMXE bit is clear and the kexec goes smoothly.
> > 
> > So, TL;DR: kexec -f use to work with a KVM VM active, now it goes into a
> > triple fault crash.
> 
> You mentioned I rebase so I thought your were backporting kernel patches.
> By rebase do you mean you porting your userspace to a newer kernel?

I've been working on some patches and when I rebased my work-in-progress
patches to latest master then kexec stopped working when KVM VMs exist.
Originally the WIP patches were based on an older stable version.

> 
> In any event I believe the bug with respect to kexec was introduced in
> commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after
> disable_nonboot_cpus()").  That is where syscore_shutdown was removed
> from kernel_restart_prepare().
> 
> At this point it looks like someone just needs to add the missing
> syscore_shutdown call into kernel_kexec() right after
> migrate_to_reboot_cpu() is called.

Seems good and I'm happy to do that; one thing we need to check first:
are all CPUs online at that point? The commit message for
6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after disable_nonboot_cpus()")
speaks about: "one CPU on-line and interrupts disabled" when
syscore_shutdown is called. KVM's syscore shutdown hook does:

on_each_cpu(hardware_disable_nolock, NULL, 1);

... so that smells to me like it wants all the CPUs to be online at
kvm_shutdown point.

It's not clear to me:

1. Does hardware_disable_nolock actually need to be done on *every* CPU
or would the offlined ones be fine to ignore because they will be reset
and the VMXE bit will be cleared that way? With cooperative CPU handover
we probably do indeed want to do this on every CPU and not depend on
resetting.

2. Are CPUs actually offline at this point? When that commit was
authored there used to be a call to hardware_disable_nolock() but that's
not there anymore.

> 
> That said I am not seeing the reboot notifiers being called on the kexec
> path either so your issue with kvm might be deeper.

Previously it was called via:

kernel_kexec
  kernel_restart_prepare
    blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
      kvm_shutdown

JG
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
