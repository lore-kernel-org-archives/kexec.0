Return-Path: <kexec-bounces+kexec=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AECC4167B
	for <kexec@archiver.kernel.org>; Fri, 15 Dec 2023 20:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:References
	:In-Reply-To:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=joxdsHT1o5aa1Krb+yoAbLgDcC4Bqaw5JOZesCUIVV0=; b=bxb79wMw/NV+aI
	+eEqLlxuN+DpzWZeTG55qAy1YC61g848jp7AeaxgxlKtkT3aY5GhRTYNfH0xD5Uevc59a5lfErsbx
	X8qPJfNl5j88AcAm2TCbcSj1DlUM7gGHpC1yN1O6BDZf25/cJWetQh4TJKX5KtjkvDcq93fRpvL0n
	kBWmQTQXHTsStEkIz+GLlDXRXUAWB1RclTRhEo4X+/osAPzz4uXt4NZUhoFlVD2TlH0L+rtrEJ+LI
	Wguv3g3KHbgupwiLUA4T/1U+oaGWof4ByAgKbbA9Twm5guqR5hygCO8zRR/dx45fBTfi/YJKbILB+
	JN4732Lqjvjn0XW/dxrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEETp-004R8s-1q;
	Fri, 15 Dec 2023 20:08:17 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEETl-004R5J-1w
	for kexec@lists.infradead.org;
	Fri, 15 Dec 2023 20:08:15 +0000
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702670887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=901yYjGoVVKctXfDEcezEvC98dproV2+EzG1Mh+yZM0=;
	b=AgGTHkOV34ccu14DmKs2xRNtyh8yo6NK8Os/GA/oaKj5dJVO0iNqK3cc62YfKLntBxbx1E
	UjOXzyckYJzbxXGvFRgspqx1zO6uB+QM0Q3s/KUm6tcZndqIfJRDNSsnOfNdvweeYegV2X
	fRmI7JwL7c0aKPtI24kLIInpSa0omC+XyU11T7AK7pxoCY364HCXVjY2ef7DsW0PPE10bi
	z7ivC7FP+3SOS5r3Vqgx8zSRDzI0jwoJ8TRnilpeb8prw/2+KBL0bTCjooYpYZo4VuF8gt
	Lf33uLpWZXfUVlYbDTZIMf3We5jXqZSaiX6GQ/m1ZbB7USyrsAb3BySENDvgOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702670887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=901yYjGoVVKctXfDEcezEvC98dproV2+EzG1Mh+yZM0=;
	b=dBGh1ObS5w6jiyv0AKskvjWWTxQcRmMp8knq/NQOzQCNF43l0J5LmOMipb7DbsPhm1HVf7
	En8CAAG79zkWwiCQ==
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>, Jun Nakajima
 <jun.nakajima@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Tom
 Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>, "Huang,
 Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv4 13/14] x86/acpi: Do not attempt to bring up secondary
 CPUs in kexec case
In-Reply-To: <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
 <20231205004510.27164-14-kirill.shutemov@linux.intel.com>
Date: Fri, 15 Dec 2023 21:08:06 +0100
Message-ID: <87a5qbmdp5.ffs@tglx>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_120813_782192_0382BE7E 
X-CRM114-Status: GOOD (  18.91  )
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

On Tue, Dec 05 2023 at 03:45, Kirill A. Shutemov wrote:
> ACPI MADT doesn't allow to offline CPU after it got woke up. It limits

to offline a CPU after it was onlined. This limits kexec: ...

> kexec: the second kernel won't be able to use more than one CPU.

... one CPU, which is enough to cover the kdump case.


> Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> The acpi_wakeup_cpu() will use it to bring up secondary cpus.
>
> Zero out mailbox address in the ACPI MADT wakeup structure to indicate
> that the mailbox is not usable.  This prevents the kexec()-ed kernel
> from reading a vaild mailbox, which in turn makes the kexec()-ed kernel
> only be able to use the boot CPU.
>
> This is Linux-specific protocol and not reflected in ACPI spec.
>
> Booting the second kernel with signle CPU is enough to cover the most
> common case for kexec -- kdump.

This is confusing at best and I doubt that kdump is the most common case
for every one.

  To prevent a kexec kernel from onlining secondary CPUs invalidate the
  mailbox address in the ACPI MADT wakeup structure which prevents a
  kexec kernel to use it.

  This is safe as the booting kernel has the mailbox address cached
  already and acpi_wakeup_cpu() uses the cached value to bring up the
  secondary CPUs.

  Note: This is a Linux specific convention and not covered by the
        ACPI specification.

Hmm?

> +	/*
> +	 * ACPI MADT doesn't allow to offline CPU after it got woke up.

to offline a CPU after it was onlined.

> +	 * It limits kexec: the second kernel won't be able to use more than

           This limits kexec: ...

> +	 * one CPU.
> +	 *
> +	 * Now acpi_mp_wake_mailbox_paddr already has the mailbox address.
> +	 * The acpi_wakeup_cpu() will use it to bring up secondary cpus.
> +	 *
> +	 * Zero out mailbox address in the ACPI MADT wakeup structure to
> +	 * indicate that the mailbox is not usable.  This prevents the
> +	 * kexec()-ed kernel from reading a vaild mailbox, which in turn
> +	 * makes the kexec()-ed kernel only be able to use the boot CPU.
> +	 *
> +	 * This is Linux-specific protocol and not reflected in ACPI spec.

See changelog comment...

> +	 */
> +	mp_wake->mailbox_address = 0;
> +
>  	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
>  
>  	return 0;

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
