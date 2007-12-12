Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J2SSy-0006zU-F9
	for kexec@lists.infradead.org; Wed, 12 Dec 2007 14:21:47 +0000
Date: Wed, 12 Dec 2007 15:21:32 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] kexec: force x86_64 arches to boot kdump kernels on
	boot cpu
Message-ID: <20071212142132.GC4889@bingen.suse.de>
References: <m1k5nm2g3w.fsf@ebiederm.dsl.xmission.com>
	<20071211034349.GA3635@localhost.localdomain>
	<m1ejdt25x0.fsf@ebiederm.dsl.xmission.com>
	<20071211143910.GA10999@hmsreliant.think-freely.org>
	<m1ve75z1v3.fsf@ebiederm.dsl.xmission.com>
	<20071211182254.GB10999@hmsreliant.think-freely.org>
	<m1ejdtysqd.fsf@ebiederm.dsl.xmission.com>
	<20071211192434.GD10999@hmsreliant.think-freely.org>
	<86802c440712111151t29acd38kf9fac8e41743f3e4@mail.gmail.com>
	<20071211205955.GF10999@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071211205955.GF10999@hmsreliant.think-freely.org>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Ben Woodard <woodard@redhat.com>, Neil Horman <nhorman@redhat.com>, kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, Andi Kleen <andi@firstfloor.org>, Yinghai Lu <yhlu.kernel@gmail.com>, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>

> +	htcfg = read_pci_config(num, slot, func, 0x68);
> +	if (htcfg & (1 << 18)) {	
> +		printk(KERN_INFO "Detected use of extended apic ids on hypertransport bus\n");
> +		if ((htcfg & (1 << 17)) == 0) {
> +			printk(KERN_INFO "Enabling hypertransport extended apic interrupt broadcast\n");
> +			printk(KERN_INFO "Note this is a bios bug, please contact your hw vendor\n");

I'm not convinced the message is correct. e.g. on a system with only a dual core not enabling
that is fine, but the extended IDs might be still set.

>  #endif /* CONFIG_ACPI */
>  
> -static void __init nvidia_bugs(void)
> +static void __init nvidia_bugs(int num, int slot, int func)
>  {
> +	static int fix_applied = 0;
> +
> +	if (fix_applied++)
> +		return;

This looks like the wrong place to do this. Better add a flag or something
in the structure. Dito others.

Also while not a problem here in general it's bad style to add potential
wrapping bugs like this. Never use ++ for flags.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
