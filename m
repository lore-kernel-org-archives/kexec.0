Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3.mail.elte.hu ([157.181.1.138])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JMtpE-0001Ji-B2
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 23:37:15 +0000
Date: Thu, 7 Feb 2008 00:36:57 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080206233657.GB12393@elte.hu>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu>
	<20080206224805.GD11886@redhat.com> <47AA3B16.7000507@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47AA3B16.7000507@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Neil Horman <nhorman@tuxdriver.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, Vivek Goyal <vgoyal@redhat.com>


* H. Peter Anvin <hpa@zytor.com> wrote:

>> I am wondering if interrupts are disabled on crashing cpu or if 
>> crashing cpu is inside die_nmi(), how would it stop/prevent delivery 
>> of NMI IPI to other cpus.
>
> I don't see how it would.

cross-CPU IPIs are a bit fragile on some PC platforms. So if the kexec 
code relies on getting IPIs to all other CPUs, it might not be able to 
do it reliably. There might be limitations on how many APIC irqs there 
can be queued at a time, and if those slots are used up and the CPU is 
not servicing irqs then stuff gets retried. This might even affect NMIs 
sent via APIC messages - not sure about that.

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
