Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C36C4332F
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 23:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:
	In-Reply-To:Date:References:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=otDOoZEtQmC4bzLomTPWH7caI06GJ8lnP6f8tLg6Pn8=; b=Mv1SE6rnq37k09yga6XWIoAzOp
	AWMddr/l3ES1xl+E+4c/JpqpMxBECM3g10+y8QDofRPjNzIeoDbEKst6DuYe1uPIJLJJunt0ojq5A
	UgJQGOcBJntZ9k/hexs9BWqv3ZnVfQtbdVEh0cw24Ntlvl9I/dTrK+QI7kN2G4n7zvnicAZpEBGs6
	7bCHsZQURKhfRu+aKEJsNaSHZ3zMl72i/8igZtNOMCWwv1WSSzMwdplVzYxNCwN5iLYbCH+EHPvEI
	4tuaXZdDRinA7mEd+as5KI+wzdYfBOI6I3Kv2QGr8YZK6S1of2hC0Lwl7oQnMasPWevKRuY72veFB
	59B0VryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCq3W-009vOb-1W;
	Mon, 11 Dec 2023 23:51:22 +0000
Received: from out03.mta.xmission.com ([166.70.13.233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCq3T-009vAQ-1R;
	Mon, 11 Dec 2023 23:51:20 +0000
Received: from in02.mta.xmission.com ([166.70.13.52]:37898)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rCq36-00EVyC-FL; Mon, 11 Dec 2023 16:50:56 -0700
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:49742 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1rCq35-00F4Dc-Cg; Mon, 11 Dec 2023 16:50:56 -0700
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "Graf (AWS), Alexander" <graf@amazon.de>,  "seanjc@google.com"
 <seanjc@google.com>,  =?utf-8?Q?Sch=C3=B6nherr=2C_Jan_H=2E?=
 <jschoenh@amazon.de>,
  "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
  "kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
  "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
  "james.morse@arm.com" <james.morse@arm.com>,  "oliver.upton@linux.dev"
 <oliver.upton@linux.dev>,  "suzuki.poulose@arm.com"
 <suzuki.poulose@arm.com>,  "chenhuacai@kernel.org"
 <chenhuacai@kernel.org>,  "atishp@atishpatra.org" <atishp@atishpatra.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "maz@kernel.org" <maz@kernel.org>,  "pbonzini@redhat.com"
 <pbonzini@redhat.com>,  "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
  "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,  "anup@brainfault.org"
 <anup@brainfault.org>,  "aleksandar.qemu.devel@gmail.com"
 <aleksandar.qemu.devel@gmail.com>
References: <20230512233127.804012-1-seanjc@google.com>
	<20230512233127.804012-2-seanjc@google.com>
	<cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	<871qbud5f9.fsf@email.froward.int.ebiederm.org>
	<a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
	<7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
Date: Mon, 11 Dec 2023 17:50:33 -0600
In-Reply-To: <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
	(James Gowans's message of "Mon, 11 Dec 2023 10:27:15 +0000")
Message-ID: <87wmtk9u46.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1rCq35-00F4Dc-Cg;;;mid=<87wmtk9u46.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX183erp/ctJyjnDuDEXnwg8YrcYEg8oGrjc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier
 to hook restart/shutdown
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_155119_510048_22E52AAC 
X-CRM114-Status: GOOD (  23.72  )
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

"Gowans, James" <jgowans@amazon.com> writes:

> On Mon, 2023-12-11 at 09:54 +0200, James Gowans wrote:
>> > 
>> > What problem are you running into with your rebase that worked with
>> > reboot notifiers that is not working with syscore_shutdown?
>> 
>> Prior to this commit [1] which changed KVM from reboot notifiers to
>> syscore_ops, KVM's reboot notifier shutdown callback was invoked on
>> kexec via kernel_restart_prepare.
>> 
>> After this commit, KVM is not being shut down because currently the
>> kexec flow does not call syscore_shutdown.
>
> I think I missed what you're asking here; you're asking for a reproducer
> for the specific failure? 
>
> 1. Launch a QEMU VM with -enable-kvm flag
>
> 2. Do an immediate (-f flag) kexec:
> kexec -f --reuse-cmdline ./bzImage 
>
> Somewhere after doing the RET to new kernel in the relocate_kernel asm
> function the new kernel starts triple faulting; I can't exactly figure
> out where but I think it has to do with the new kernel trying to modify
> CR3 while the VMXE bit is still set in CR4 causing the triple fault.
>
> If KVM has been shut down via the shutdown callback, or alternatively if
> the QEMU process has actually been killed first (by not doing a -f exec)
> then the VMXE bit is clear and the kexec goes smoothly.
>
> So, TL;DR: kexec -f use to work with a KVM VM active, now it goes into a
> triple fault crash.

You mentioned I rebase so I thought your were backporting kernel patches.
By rebase do you mean you porting your userspace to a newer kernel?


In any event I believe the bug with respect to kexec was introduced in
commit 6f389a8f1dd2 ("PM / reboot: call syscore_shutdown() after
disable_nonboot_cpus()").  That is where syscore_shutdown was removed
from kernel_restart_prepare().

At this point it looks like someone just needs to add the missing
syscore_shutdown call into kernel_kexec() right after
migrate_to_reboot_cpu() is called.

That said I am not seeing the reboot notifiers being called on the kexec
path either so your issue with kvm might be deeper.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
