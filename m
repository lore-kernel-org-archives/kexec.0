Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE677CA0EC4
	for <kexec@archiver.kernel.org>; Tue, 12 Aug 2025 16:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uPJ8Lxt3BleEOvsSUBjkL40gEZfMUtcuZAKrb/YcBdY=; b=ivQ8fs9l8TKL4PXqQYdEu66rBR
	Sfnxzzk61iX5+aSsk8pnZtrzH4ISzugVP78pgWY/+0GACyRcHKlLyhOuCOZ2QFh5Cy6sz6Fkvq5v0
	JuVpqfLVss2nc2T+RuE1WWcNEZvVCdVmml/VHSzHVslkS1zFOIAJ3OyVzlczdtnoxQvd+xaQ2slNF
	VqC3JLo9Zc94PoIu1uoez+gLfvoL/U0qOJ7fkeGgEEcQSlMpE+ONXvZtdB2Ta6t1OjRFKALAlxGje
	AiQu0VpoW8wcfE05wNED6OhCZ4QDbRBjPyibVqB7J6qQ+65Pq/NA8VPGA/7ZPawBG/RgWpLT0qns9
	VWlLGJog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulrje-0000000BJr8-0P6P;
	Tue, 12 Aug 2025 16:20:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulmu8-0000000AZjj-2L84
	for kexec@lists.infradead.org;
	Tue, 12 Aug 2025 11:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754997055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uPJ8Lxt3BleEOvsSUBjkL40gEZfMUtcuZAKrb/YcBdY=;
	b=FRlpH8lA5XAzhDwSF67Vc42LzBSrEm4Kp/PTNCZ3NWRK08mav0bEgpzAu5ByStdo4iTQ2M
	DQygcjXFd3N06fLT/pWUL/zzALic+icoAp311ADbRA9NAnFFW1odZvMFmkljJyNdWKmZLn
	nDISKdOYysf1SMmV80x0Rp/LCdoe6x0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-_hdY1YM5P7KqOdocA7SANA-1; Tue, 12 Aug 2025 07:10:52 -0400
X-MC-Unique: _hdY1YM5P7KqOdocA7SANA-1
X-Mimecast-MFC-AGG-ID: _hdY1YM5P7KqOdocA7SANA_1754997051
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400b28296fso81322315ad.1
        for <kexec@lists.infradead.org>; Tue, 12 Aug 2025 04:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754997051; x=1755601851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uPJ8Lxt3BleEOvsSUBjkL40gEZfMUtcuZAKrb/YcBdY=;
        b=Ke/TmyVyq8w28nFjvwfeMd836A8rBiXvMdE+CBoC9Fw2NYYCbxhMDMd+wQPzlm7ArM
         5PZfHnvhK9+sxwaHvxRR8s2cG1Rng/qKRAcVhYo01nxyCMrTUhZ+kQkjcFgLs8Tr+ldA
         x24uYBckJ1YTgGrjwT0/K/z5pl1ihCnmXBM0CqaZP5Xy6Btsc1mDuyXc/nfwA+AxJcbE
         O5rLDARq0lHUmmZy94x+yY0lPldlfzG+d/jL++Bd1CSQQhoA22pD6q4wykqZlZ3E0Ss0
         W7zds6tk8iAxRj3f/aO4KPJmmfz5cE2zzSa4K/ecThvX1hRP1GI8u6OF7r3V8F2ceDMF
         ajgg==
X-Forwarded-Encrypted: i=1; AJvYcCXgnwlcjuoaIo2yEY1XhoQe7eXkZd/i45AVlEctxRDUh9tECMOFhc/HgdnZXR0I1Vgx/Ga4JA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yxu/qYQJJ49euxVS6uEM6bV4xj0N6Xdlkh7UGoTP02EFlEcT+zE
	EhxM1btU6OBDU3Lt12eIyLrdrGzx4yTYNeuE+b1Jgnf+WZQ68IxlIB5dOE67ZWS2s5dSMseF0H+
	2ZT524C6qLe25tWT3As8l7XWhDgkTyjF/6tdn0JsxGLEj+KRyXYP7GxjQ4e9QzQ==
X-Gm-Gg: ASbGncs3ZzjVDFCwREPeEQ4GRrUwmcew5HSHfCy6H6snpgL0cJZq2L6itpVZKFN1y6y
	7ZPZuDOLbmQ/JtI5DVg5vAuP4jtceHaWDIIiCTYqJnz+yekmIANemholl9nLsmsqrVq1TpiRFEf
	FzMF5osLsfvo8bY3VAILz2VVWyOIy23Xhdac57608HOuF2CPk0z3fEkvWBc65ADuvdpZtwS7kpI
	Iaho6Ruy8naEvzGC8QkZJKYi5PtzoRXn+wUwrAoOfCfp3s1OH/olZHSNOm3GqpVBWlEEZR6DK0L
	TItIF1x15OA8l5VlBgJIrMeVclzh9Bw=
X-Received: by 2002:a17:902:d58c:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242fc372b34mr41461375ad.55.1754997050797;
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJVKxxP3qAclSLG5krLKovafdMdrQyd8bvZiT7pPhzWqWVFBiBgJYCXhmR+aHa6BbxpO2Hew==
X-Received: by 2002:a17:902:d58c:b0:242:9bbc:6017 with SMTP id d9443c01a7336-242fc372b34mr41461085ad.55.1754997050394;
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24309a18411sm2476495ad.146.2025.08.12.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 04:10:50 -0700 (PDT)
Date: Tue, 12 Aug 2025 19:07:56 +0800
From: Coiby Xu <coxu@redhat.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [Regression] kdump fails to get DHCP address unless booting with
 pci=nomsi or without nr_cpus=1
Message-ID: <gec2yl5wx6vvt67smx5emhcoifvtp4orw6sub24b2nrqwryhp2@i4h7qbtwjo3r>
References: <x5dwuzyddiasdkxozpjvh3usd7b5zdgim2ancrcbccfjxq7qwn@i6b24w22sy6s>
 <87bjom8106.ffs@tglx>
 <878qjq80yu.ffs@tglx>
 <86v7mt9ai3.wl-maz@kernel.org>
 <i2l2ujhqjd6akzosvzj4njv2vemsfuvywz4gsnj2nwo3fwyjyz@cfhekxpartf2>
 <86ms84974v.wl-maz@kernel.org>
MIME-Version: 1.0
In-Reply-To: <86ms84974v.wl-maz@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hfmqEufSEtwenumItA7HUcfA1XTp9AYgyXyqLVpswXo_1754997051
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_041056_670499_35BD8C06 
X-CRM114-Status: GOOD (  32.76  )
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

On Tue, Aug 12, 2025 at 11:17:04AM +0100, Marc Zyngier wrote:
>On Tue, 12 Aug 2025 11:09:12 +0100,
>Coiby Xu <coxu@redhat.com> wrote:
>>
>> On Mon, Aug 11, 2025 at 03:52:04PM +0100, Marc Zyngier wrote:
>> > On Mon, 11 Aug 2025 14:03:21 +0100,
>> > Thomas Gleixner <tglx@linutronix.de> wrote:
>> >>
>> >> On Mon, Aug 11 2025 at 15:02, Thomas Gleixner wrote:
>> >>
>> >> CC+ Marc
>> >>
>> >> > On Mon, Aug 11 2025 at 11:23, Coiby Xu wrote:
>> >> >> Recently I met an issue that on certain virtual machines, the kdump
>> >> >> kernel fails to get DHCP IP address most of times starting from
>> >> >> 6.11-rc2. git bisection shows commit b5712bf89b4b ("irqchip/gic-v3-its:
>> >> >> Provide MSI parent for PCI/MSI[-X]") is the 1st bad commit,
>> >> >>
>> >> >>      # good: [7d189c77106ed6df09829f7a419e35ada67b2bd0] PCI/MSI: Provide
>> >> >>      # MSI_FLAG_PCI_MSI_MASK_PARENT
>> >> >>      git bisect good 7d189c77106ed6df09829f7a419e35ada67b2bd0
>> >> >>      # good: [48f71d56e2b87839052d2a2ec32fc97a79c3e264] irqchip/gic-v3-its:
>> >> >>      # Provide MSI parent infrastructure
>> >> >>      git bisect good 48f71d56e2b87839052d2a2ec32fc97a79c3e264
>> >> >>      # good: [8c41ccec839c622b2d1be769a95405e4e9a4cb20] irqchip/irq-msi-lib:
>> >> >>      # Prepare for PCI MSI/MSIX
>> >> >>      git bisect good 8c41ccec839c622b2d1be769a95405e4e9a4cb20
>> >> >>      # first bad commit: [b5712bf89b4bbc5bcc9ebde8753ad222f1f68296]
>> >> >>      # irqchip/gic-v3-its: Provide MSI parent for PCI/MSI[-X]
>> >> >
>> >> > There were follow up fixes on this, so isolating this one is not really
>> >> > conclusive.
>> >> >
>> >> > Is the problem still there on v6.16 and v6.17-rc1?
>> >
>> > Yeah, there are way too many things that have been addressed since.
>> > kdump is also a particularly nasty case, as it tends to rely on the
>> > redistributor tables programmed by the previous kernel.
>>
>> Thanks for providing a clue. This may also explain explain why I fails
>> to reproduce this issue against 1st kernel even with the same cmdline of
>> the kdump kernel.
>
>I'm not sure that's a clue. It's only an indication that things are
>not necessarily easy to spot.
>
>Has it ever been reproduced on bare metal? Have you tried v6.16 as
>instructed?

Thanks for replying so quickly!

No, I haven't reproduced it on a bare metal machine and our QE engineers
haven't noticed this issue on any bare metal machine either. 

And I can confirm this issue still happens to 6.16.0-200.fc42.aarch64
and 6.17.0-0.rc1.17.fc43.aarch64 on the type of KVM VMS (QEMU PnP device
PNP0c02) where the issue was found.

>
>>
>> >
>> > Also, this says "virtual machines". What's the hypervisor?
>>
>> I'll contact the lab administrator. What kinds of info I should collect
>> to help you narrow down the issue?
>
>Surely you know what hypervisor you're running on, right?

Yes, the hypervisor is KVM. Sorry, I thought merely providing the
hypervisor info isn't sufficient and also misunderstood your request as
providing more details on the host machine.

>
>>
>> > How hard is it to reproduce?
>>
>> It can be reproduced reliably on certain machines. But as of writing I
>> haven't reproduced it on other KVM virtual machines on three different
>> host machines.
>
>Which machines? I'm sorry, but if you want help on this, you'll have
>to provide actual information.

Sorry, I didn't mean to be vague. I thought you question is on how
reproducible this issue is and there is no need to provide the details
on the machines where I can't reproduce this issue. Since you explicitly
request it, I'll be glad to share the details.

I just grabbed three arbitrary bare metal machines having Fedora-42
installed and launched some KVM VMs to see if this issue can be
reproduced easily. Two host machines are as follows (sorry I can't find
the info of the 3rd one)
- GIGABYTE PnP device PNP0c02, ARMv8 (M128-30)
- LTHPCSR112 (01234567890123456789AB), ARMv8 (Q80-30)

The virtual machine image is downloaded from
https://download.fedoraproject.org/pub/fedora/linux/releases/42/Cloud/aarch64/images/Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2.
I tried different vCPUs (2, 4), different RAM (4G, 35G) and also two
different UEFI firmware (the default one and one from edk2-experimental
package) but haven't reproduced this issue so far.

>
>Thanks,
>
>	M.
>
>-- 
>Without deviation from the norm, progress is not possible.
>

-- 
Best regards,
Coiby


