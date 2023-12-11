Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D873BC4167B
	for <kexec@archiver.kernel.org>; Mon, 11 Dec 2023 10:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ockAk0RSXRJN6Wd+9T9WsZqYspnp+oL8qZ41KdoEHw=; b=aNmYAK8hcfjhm0
	/3BnEoKIgchn18zyFKH7njOpEa0cHp1SepdUt11rnW/ekTSHDiQlFCEk949qpcmg4TXqmhlJp/dM4
	yf1BLVsfu9j+k0JJbFUoSTgQDaaOTfQeK+xl6K5rhI092/lAbhg+VA7mgSvpMCHBejryTnyYs2taE
	VOUwgZJ1C5FFeWi25hBOYNuK+NZD41XWS4cw/L4WRYAomA5thNQlBIPlVKkAAEc0sHH/lYinzyezB
	YI0Ql/dxGOQ4VPPTH+bmikvD1LuZvhabp3hrx9vu1fJ84oEMAVPDpY+pstZh8u83zi/FbPNtzRzOP
	xajo3x2GBMCrWoMsLGcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCdVs-004bgB-16;
	Mon, 11 Dec 2023 10:27:48 +0000
Received: from smtp-fw-52003.amazon.com ([52.119.213.152])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCdVi-004bZI-1g;
	Mon, 11 Dec 2023 10:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702290459; x=1733826459;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=uu88w/luOrmMKhh/lVhjbkCtD1EpiHoLlqjWo1AtlNw=;
  b=Vv2TluhJwAHR/iis768RsapWbjihN5m6XnNo57FfxepuSpiFI3K0qXnS
   i6VIbL3W+zNCH+hLd7GmB+54LY9cG1a18ayrbfQl23KBkLOAvSH78vQtY
   wf1XlzH1M9sjyZ95JjG5kPPwBk2Tl/Gj1rvloGWGq80iimbXYrEHyUITE
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,267,1695686400"; 
   d="scan'208";a="624463210"
Subject: Re: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Thread-Topic: [PATCH v2 1/2] KVM: Use syscore_ops instead of reboot_notifier to hook
 restart/shutdown
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:27:18 +0000
Received: from smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-32fb4f1a.us-west-2.amazon.com (Postfix) with ESMTPS id 7582EC0126;
	Mon, 11 Dec 2023 10:27:16 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:22647]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.26.133:2525] with esmtp (Farcaster)
 id 120ac3af-72bf-44ea-87cd-f3555d0aa2c2; Mon, 11 Dec 2023 10:27:15 +0000 (UTC)
X-Farcaster-Flow-ID: 120ac3af-72bf-44ea-87cd-f3555d0aa2c2
Received: from EX19D012EUC002.ant.amazon.com (10.252.51.162) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:27:15 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC002.ant.amazon.com (10.252.51.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Dec 2023 10:27:15 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Mon, 11 Dec 2023 10:27:15 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "Graf (AWS), Alexander" <graf@amazon.de>, "seanjc@google.com"
	<seanjc@google.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>
CC: "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"kvm-riscv@lists.infradead.org" <kvm-riscv@lists.infradead.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"james.morse@arm.com" <james.morse@arm.com>, "oliver.upton@linux.dev"
	<oliver.upton@linux.dev>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"chenhuacai@kernel.org" <chenhuacai@kernel.org>, "atishp@atishpatra.org"
	<atishp@atishpatra.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "maz@kernel.org" <maz@kernel.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "kvm@vger.kernel.org"
	<kvm@vger.kernel.org>, "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"anup@brainfault.org" <anup@brainfault.org>,
	"aleksandar.qemu.devel@gmail.com" <aleksandar.qemu.devel@gmail.com>
Thread-Index: AQHaKm9F6TfLvhzSVEeLxKjiUjwNTrCgjTCAgAFn6T+AAcSbgIAAKp8A
Date: Mon, 11 Dec 2023 10:27:15 +0000
Message-ID: <7e30cfc2359dfef39d038e3734f7e5e3d9e82d68.camel@amazon.com>
References: <20230512233127.804012-1-seanjc@google.com>
	 <20230512233127.804012-2-seanjc@google.com>
	 <cfed942fc767fa7b2fabc68a3357a7b95bd6a589.camel@amazon.com>
	 <871qbud5f9.fsf@email.froward.int.ebiederm.org>
	 <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
In-Reply-To: <a02b40d3d9ae5b3037b9a9d5921cfb0144ab5610.camel@amazon.com>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.111]
Content-ID: <994E5A9245CB014D9CBFED3CDA08F664@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_022738_729713_19851D44 
X-CRM114-Status: GOOD (  17.41  )
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

On Mon, 2023-12-11 at 09:54 +0200, James Gowans wrote:
> > 
> > What problem are you running into with your rebase that worked with
> > reboot notifiers that is not working with syscore_shutdown?
> 
> Prior to this commit [1] which changed KVM from reboot notifiers to
> syscore_ops, KVM's reboot notifier shutdown callback was invoked on
> kexec via kernel_restart_prepare.
> 
> After this commit, KVM is not being shut down because currently the
> kexec flow does not call syscore_shutdown.

I think I missed what you're asking here; you're asking for a reproducer
for the specific failure? 

1. Launch a QEMU VM with -enable-kvm flag

2. Do an immediate (-f flag) kexec:
kexec -f --reuse-cmdline ./bzImage 

Somewhere after doing the RET to new kernel in the relocate_kernel asm
function the new kernel starts triple faulting; I can't exactly figure
out where but I think it has to do with the new kernel trying to modify
CR3 while the VMXE bit is still set in CR4 causing the triple fault.

If KVM has been shut down via the shutdown callback, or alternatively if
the QEMU process has actually been killed first (by not doing a -f exec)
then the VMXE bit is clear and the kexec goes smoothly.

So, TL;DR: kexec -f use to work with a KVM VM active, now it goes into a
triple fault crash.

JG

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
