Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90FB6C41535
	for <kexec@archiver.kernel.org>; Tue, 19 Dec 2023 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:CC:To:From:Subject:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cLKnHICU7a+AgOXbhAG6F3t/S+PM71E7zlGIrX90RUs=; b=H4k8FeHswxhGqH
	RWrzLKdNOnwCwHl4YKMSoC75ovQUNjHmOjkYOU+Db0/stFL8HqJRU0FTpx6UuHp0sYz6ZenchhPdy
	l1/Lcrjz5Rne8VUitwYX3/o3VW80eZ3MgJZRPmTIX2yxyf2CN8o/u/w6pyb98ZHE8XqAWqSzFZsmu
	932JNL1612fj62uVheBxkfn5cIRFN7ABnQNObBMiwj2dFGdX/PX4S8Lm/bDjJ4Nxfyr5VuC+CRxEH
	x3gvQCr9M3BIjt96vvGJYWOVu7YEb7M5TfrkBxv2v1Id4ki/pRtuJBQTXL3mq7DnJGNsfPxmMbQVO
	+IFm+Vjy9eeEi0a/atPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUjt-00D8FR-2r;
	Tue, 19 Dec 2023 07:42:05 +0000
Received: from smtp-fw-80006.amazon.com ([99.78.197.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFUjq-00D8CV-23
	for kexec@lists.infradead.org;
	Tue, 19 Dec 2023 07:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702971723; x=1734507723;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=opgInH91xzBuf6eAk7Qumo1WNIkpgtAJc0dLMfhU/Xo=;
  b=FPy/lzk6fcEoJARJJifJbUDCMjv4FV1m0XzfrFtuZMajayumUigQ+KBp
   ws7MpVSFW7CpRZ54jkoEvQ3UhtX3wVSHXMAPhbfoZg5AX2E93oYT2dMre
   HncJu8NAQChX4BA7wJnlB56gsuUCYjBU6qyiCBL56nP+zBnQ63n5USG0Y
   U=;
X-IronPort-AV: E=Sophos;i="6.04,287,1695686400"; 
   d="scan'208";a="260343204"
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Thread-Topic: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:41:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2a-m6i4x-d47337e0.us-west-2.amazon.com (Postfix) with ESMTPS id F0C0D60CA7;
	Tue, 19 Dec 2023 07:41:54 +0000 (UTC)
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:58965]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.114:2525] with esmtp (Farcaster)
 id e2b3b60b-ad0e-418a-bac9-9349b4714063; Tue, 19 Dec 2023 07:41:53 +0000 (UTC)
X-Farcaster-Flow-ID: e2b3b60b-ad0e-418a-bac9-9349b4714063
Received: from EX19D012EUC003.ant.amazon.com (10.252.51.208) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 07:41:53 +0000
Received: from EX19D014EUC004.ant.amazon.com (10.252.51.182) by
 EX19D012EUC003.ant.amazon.com (10.252.51.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 07:41:52 +0000
Received: from EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41]) by
 EX19D014EUC004.ant.amazon.com ([fe80::76dd:4020:4ff2:1e41%3]) with mapi id
 15.02.1118.040; Tue, 19 Dec 2023 07:41:52 +0000
From: "Gowans, James" <jgowans@amazon.com>
To: "bhe@redhat.com" <bhe@redhat.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "maz@kernel.org"
	<maz@kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"sre@kernel.org" <sre@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"bp@alien8.de" <bp@alien8.de>, "samuel@sholland.org" <samuel@sholland.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>
Thread-Index: AQHaLY9ODTyAGBa/a0igJR34RcFga7CwCs0AgAA3uIA=
Date: Tue, 19 Dec 2023 07:41:52 +0000
Message-ID: <9ffa2c4d3e808feb2afa6f02f4afabf1cd674516.camel@amazon.com>
References: <20231213064004.2419447-1-jgowans@amazon.com>
	 <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
In-Reply-To: <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
Accept-Language: en-ZA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.146.13.109]
Content-ID: <6F407D659EED834391131A368521AA34@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_234202_749967_2BC30B07 
X-CRM114-Status: GOOD (  23.25  )
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

On Tue, 2023-12-19 at 12:22 +0800, Baoquan He wrote:
> Add Andrew to CC as Andrew helps to pick kexec/kdump patches.

Ah, thanks, I didn't realise that Andrew pulls in the kexec patches.
> 
> On 12/13/23 at 08:40am, James Gowans wrote:
> ......
> > This has been tested by doing a kexec on x86_64 and aarch64.
> 
> Hi James,
> 
> Thanks for this great patch. My colleagues have opened bug in rhel to
> track this and try to veryfy this patch. However, they can't reproduce
> the issue this patch is fixing. Could you tell more about where and how
> to reproduce so that we can be aware of it better? Thanks in advance.

Sure! The TL;DR is: run a VMX (Intel x86) KVM VM on Linux v6.4+ and do a
kexec while the  KVM VM is still running. Before this patch the system
will triple fault.

In more detail:
Run a bare metal host on a modern Intel CPU with VMX support. The kernel
I was using was 6.7.0-rc5+.
You can totally do this with a QEMU "host" as well, btw, that's how I
did the debugging and attached GDB to it to figure out what was up.

If you want a virtual "host" launch with:

-cpu host -M q35,kernel-irqchip=split,accel=kvm -enable-kvm

Launch a KVM guest VM, eg:

qemu-system-x86_64 \
  -enable-kvm \
  -cdrom alpine-virt-3.19.0-x86_64.iso \
  -nodefaults -nographic -M q35 \
  -serial mon:stdio

While the guest VM is *still running* do a kexec on the host, eg:

kexec -l --reuse-cmdline --initrd=config-6.7.0-rc5+ vmlinuz-6.7.0-rc5+ && \
  kexec -e

The kexec can be to anything, but I generally just kexec to the same
kernel/ramdisk as is currently running. Ie: same-version kexec.

Before this patch the kexec will get stuck, after this the kexec will go
smoothly and the system will end up in the new kernel in a few seconds.

I hope those steps are clear and you can repro this?

BTW, the reason that it's important for the KVM VM to still be running
when the host does the kexec is because KVM internally maintains a usage
counter and will disable virtualisation once all VMs have been
terminated, via:

__fput(kvm_fd)
  kvm_vm_release
    kvm_destroy_vm
      hardware_disable_all
        hardware_disable_all_nolock
          kvm_usage_count--;
          if (!kvm_usage_count)
            on_each_cpu(hardware_disable_nolock, NULL, 1);

So if all KVM fds are closed then kexec will work because VMXE is
cleared on all CPUs when the last VM is destroyed. If the KVM fds are
still open (ie: QEMU process still exists) then the issue manifests.  It
sounds nasty to do a kexec while QEMU processes are still around but
this is a perfectly normal flow for live update:
1. Pause and Serialise VM state
2. kexec
3. deserialise and resume VMs.
In that flow there's no need to actually kill the QEMU process, as long
as the VM is *paused* and has been serialised we can happily kexec.

JG

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
