Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ra.tuxdriver.com ([70.61.120.52])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1JP2OL-00022f-B5
	for kexec@lists.infradead.org; Tue, 12 Feb 2008 21:10:19 +0000
Date: Tue, 12 Feb 2008 16:08:16 -0500
From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080212210816.GA1862@hmsreliant.think-freely.org>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
	<20080206220001.GA15155@elte.hu>
	<20080206224805.GD11886@redhat.com>
	<47AA3B16.7000507@zytor.com> <20080206233657.GB12393@elte.hu>
	<m1r6fpd2uo.fsf@ebiederm.dsl.xmission.com>
	<20080207121719.GA29279@hmsreliant.think-freely.org>
	<20080207122404.GA8195@elte.hu>
	<20080208161422.GA32204@hmsreliant.think-freely.org>
	<20080208164544.GA23772@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080208164544.GA23772@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, tglx@linutronix.de

> 
> Neil, is it possible to do some serial console debugging to find out
> where exactly we are hanging? Beats me, what's that operation which can
> not be executed while being in NMI handler and makes system to hang. I am
> also curious to know if it is nested NMI case.
> 
> Thanks
> Vivek
> 


Hey-
	Some intermediate results:

I've instrumented head.S in the kernel with the following code:
#define SEROUT(z) \     
mov $0x3F8,%dx;\
movb z,%al;\
outb %dx


And peppered different ascii characters throughout the startup code from
startup_32 to right before the jump to start_kernel.  When I panic the system
via an:
echo c > /proc/sysrq_trigger
I see an appropriate sequence of characters on the serial console

When I panic the box by forcing an NMI watchdog timeout however, I see nothing.
 The machine will either hang, or reset into the bios.  I think this is
reasonably conclusive in its indication that we're not getting into the second
kernel when this problem occurs.  Next I'll instrument the purgatory code in a
simmilar way.

Regards
Neil

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/****************************************************
 * Neil Horman <nhorman@tuxdriver.com>
 * Software Engineer, Red Hat
 ****************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
