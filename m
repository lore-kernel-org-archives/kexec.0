Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JjbkH-0004ZD-Qf
	for kexec@lists.infradead.org; Wed, 09 Apr 2008 14:57:54 +0000
Date: Wed, 9 Apr 2008 10:57:51 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Bad IRQs & SATA ADMA failures
Message-ID: <20080409145751.GB19491@redhat.com>
References: <47FBC1F0.5030105@hp.com> <20080408234801.GA6454@redhat.com>
	<47FCD8AE.3010901@hp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47FCD8AE.3010901@hp.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Cc: kexec@lists.infradead.org

On Wed, Apr 09, 2008 at 10:54:38AM -0400, Alan D. Brunelle wrote:
> Vivek Goyal wrote:
> >>
> > 
> > This one just means that there is a device out there which has interrupt
> > line asserted and there is no associated driver to handle those. Hence 
> > kernel sees a flood of interrupts and disables interrupt line. That's
> > why we boot with paramter "irqpoll". In kdump situations, these things
> > are expected. You can ignore this error.
> > 
> 
> Thanks - that makes me feel better about that.
> 
> 
> >> 2. Very soon thereafter, I start seeing:
> >>
> >> [    4.671112]  sda:<3>ata1: EH in ADMA mode, notifier 0x1
> >> notifier_error 0x0 g0
> >> [   34.681112] ata1: CPB 0: ctl_flags 0xd, resp_flags 0x1
> >> [   34.681112] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
> >> frozen
> >> [   34.691112] ata1.00: cmd c8/00:08:00:00:00/00:00:00:00:00/e0 tag 0
> >> dma 4096 n
> >> [   34.691112]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask
> >> 0x4 (time)
> >> [   34.701112] ata1.00: status: { DRDY }
> >> [   35.051112] ata1: soft resetting link
> >> [   35.211112] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> >> [   35.251112] ata1.00: configured for UDMA/100
> >> [   35.251112] ata1: EH complete
> >>
> >> This goes on "forever" - and the system fails to boot.
> >>
> > 
> > This is problem with SATA. It is not able to reset the device and recover
> > and re-initialize. I think we shall have to open a bug for this for the
> > SATA driver owner.
> 
> 
> OK - could you send me a quick pointer on how to open a bug?
> 

http://bugzilla.kernel.org/

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
