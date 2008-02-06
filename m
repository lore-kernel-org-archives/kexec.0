Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JMq8U-0000oh-JH
	for kexec@lists.infradead.org; Wed, 06 Feb 2008 19:40:52 +0000
Date: Wed, 6 Feb 2008 14:40:40 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH], issue EOI to APIC prior to calling crash_kexec in
	die_nmi path
Message-ID: <20080206194040.GA11886@redhat.com>
References: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080206192555.GA24910@hmsendeavour.rdu.redhat.com>
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
Cc: tglx@linutronix.de, mingo@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com

On Wed, Feb 06, 2008 at 02:25:55PM -0500, Neil Horman wrote:
> Hey all-
> 	A hang on kdump was reported to me awhile back, only when systems died
> via nmi watchdog panic.  The hang wouldn't always be in the same place, but it
> would usually be somewhere down in purgatory.  In looking at the code, it
> occured to me that since, during an nmi interrupt, we won't be able to handle
> additional interrupts, that we won't be able to halt the other processors on a
> system like we try to do in machine_crash_shutdown.  As such, it appears that
> leaving the other cpus running exposes us to the risk that another processor
> will encounter an error and halt the system while we are trying to boot the
> kdump kernel, and that can result in a hang.  I wrote the attached patch to end
> the nmi interrupt prior to calling crash_kexec from within die_nmi, and testing
> here has proven successfull.
> 

Hi Neil,

Why wouldn't I be able to stop other cpus if I am inside an NMI handler? I
just need to send an NMI IPI to other cpus and they should be able to
receive and handle it?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
