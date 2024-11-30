Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5413D7360A
	for <kexec@archiver.kernel.org>; Sat, 30 Nov 2024 20:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AhSV92xctZtOIuDX4XdK6Ka318O9z4zvPM7btw6h77c=; b=Tp7KlUhOQa06yDej9c8tdaCc4A
	Z6/ObkncwWVtJQD4KqbN7Tn4iUNcw8bzUfW22413s0CaeZ7HNNecvLD9eh9k/AVaunQ94bEmJZNdT
	mgpOGY7EV5MZhhHroPuvi2aHK8UaCy3OrZeUnJPlRJxw17OPdKpdrLrOPvC+eXymS9cszc7Y78IRX
	A3wZ2sJLedYId8d/CWC9det92gxCIj5psYg/zY37MNNA6+PM6ZiE0cAXpx325v5xv33Vwv5kbKEyK
	l/ROmA73kLo5Hgw/drEISVVNzVQ06tQrcxGCZmT7qMjAmbPFTEZ4eOeG5dUnub7L/oR1q6Br/PGSN
	49F/nOrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tHTm3-00000002VWF-0rCv;
	Sat, 30 Nov 2024 20:09:03 +0000
Received: from smtp-fw-9106.amazon.com ([207.171.188.206])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tHTlw-00000002VVK-3nCu;
	Sat, 30 Nov 2024 20:08:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732997338; x=1764533338;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AhSV92xctZtOIuDX4XdK6Ka318O9z4zvPM7btw6h77c=;
  b=XxsQxaG83u3kcaIEol2oSzKW29PsjOXxIx71oO0fxcayfD2HYTFmu25d
   /WG9d5KC9YlTOjvW3MgufBKV5e0CRpxfHQjjjoiI8TL8BJwgS3hRCepNI
   5zh73d2eohXOFgmkRN/eB33W/Ma2djysGSBh3E8BkeHQM04sFEN/2NzTj
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,199,1728950400"; 
   d="scan'208";a="779857217"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2024 20:08:48 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:15968]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.11.83:2525] with esmtp (Farcaster)
 id 6ac350d1-00ea-4165-8f54-56833500c432; Sat, 30 Nov 2024 20:08:45 +0000 (UTC)
X-Farcaster-Flow-ID: 6ac350d1-00ea-4165-8f54-56833500c432
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 30 Nov 2024 20:08:45 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 30 Nov 2024 20:08:44 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d]) by
 EX19D018EUA004.ant.amazon.com ([fe80::e53:84f8:3456:a97d%3]) with mapi id
 15.02.1258.034; Sat, 30 Nov 2024 20:08:44 +0000
From: "Farber, Eliav" <farbere@amazon.com>
To: Thomas Gleixner <tglx@linutronix.de>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"naveen@kernel.org" <naveen@kernel.org>, "maddy@linux.ibm.com"
	<maddy@linux.ibm.com>, "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ebiederm@xmission.com" <ebiederm@xmission.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "bhe@redhat.com"
	<bhe@redhat.com>, "hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"sourabhjain@linux.ibm.com" <sourabhjain@linux.ibm.com>,
	"adityag@linux.ibm.com" <adityag@linux.ibm.com>, "songshuaishuai@tinylab.org"
	<songshuaishuai@tinylab.org>, "takakura@valinux.co.jp"
	<takakura@valinux.co.jp>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "kexec@lists.infradead.org"
	<kexec@lists.infradead.org>, Marc Zyngier <maz@kernel.org>
CC: "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: RE: [PATCH v4 1/2] kexec: Consolidate machine_kexec_mask_interrupts()
 implementation
Thread-Topic: [PATCH v4 1/2] kexec: Consolidate
 machine_kexec_mask_interrupts() implementation
Thread-Index: AdtDYtCFjQWQn9I6QGW+NnB/V7SCxQ==
Date: Sat, 30 Nov 2024 20:08:44 +0000
Message-ID: <cd8809e379dc4dd089350ec2d1f8c210@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.85.143.175]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241130_120857_309280_64859C35 
X-CRM114-Status: GOOD (  25.16  )
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org

On 11/29/2024 3:30 PM, Thomas Gleixner wrote:
>> Move the machine_kexec_mask_interrupts function to a common location in
>> kernel/kexec_core.c, removing duplicate implementations from architectur=
e
>> specific files (arch/arm, arch/arm64, arch/powerpc, and arch/riscv).
>
> Can you please move this into kernel/irq/kexec.c?
>
> It's pure interrupt core internal code and there is no point to make
> core internal functions visible to random other code just because.
Done (in v5 series)

>> +void machine_kexec_mask_interrupts(void)
>> +{
>> +     unsigned int i;
>> +     struct irq_desc *desc;
>
>         struct irq_desc *desc;
>         unsigned int i;
>
> please
Done (in v5 series)

>> +     for_each_irq_desc(i, desc) {
>> +             struct irq_chip *chip;
>> +             int check_eoi =3D 1;
>> +
>> +             chip =3D irq_desc_get_chip(desc);
>> +             if (!chip)
>> +                     continue;
>> +
>> +             if (IS_ENABLED(CONFIG_ARM64)) {
>
> This should not be CONFIG_ARM64. Add something like:
>
> config GENERIC_IRQ_KEXEC_CLEAR_VM_FORWARD
>         bool
>
> and select this from ARM64?
Done (in v5 series)

>> +                     /*
>> +                      * First try to remove the active state. If this f=
ails, try to EOI the
>> +                      * interrupt.
>
> This comment does not really explain what this is about. I know you
> copied it from the ARM64 implementation, but it should explain what this
> actually means. Something like:
>
>          First try to remove the active state from an interrupt which is
>          forwarded to a VM. If the interrupt is not forwarded, try to
>          EOI the interrupt.
>
> or something like that.
Done (in v5 series)

>> +                      */
>> +                     check_eoi =3D irq_set_irqchip_state(i, IRQCHIP_STA=
TE_ACTIVE, false);
>
> Looking deeper. This function actually cannot be called from this
> context. It does:
>
>           irq_get_desc_buslock(irq, &flags, 0);
>
> which means for any interrupt which has an actual buslock implementation
> it will end up in a sleepable function and deadlock in the worst case.
>
> Marc?
I will wait for Marc's response regarding this issue.
Regardless, if any changes are required, I believe it would be better
to address them in a separate patch, as this behavior existed before my
modification.

Thanks, Eliav

