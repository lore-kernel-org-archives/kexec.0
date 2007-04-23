Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gw3.adaptec.com ([216.52.22.36])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hg2DM-0007V8-FJ
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 13:20:40 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [PATCH] aacraid: fails to initialize after a  kexec operation
Date: Mon, 23 Apr 2007 13:20:32 -0400
Message-ID: <AE4F746F2AECFC4DA4AADD66A1DFEF0188AE58@otce2k301.adaptec.com>
In-Reply-To: <20070423161203.GA2129@in.ibm.com>
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
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
To: vgoyal@in.ibm.com
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kexec Mailing List <kexec@lists.infradead.org>, Judith Lebzelter <judith@linux-foundation.org>, linux-scsi@vger.kernel.org

That is a failure to route the interrupts and is possibly an issue with
the kernel and the hardware, and not the driver directly (since there is
an expectation that request_irq will connect the interrupt to the
interrupt service routine). Judith reported success in the past with
this patch on her hardware, perhaps the motherboard on your system has
some odd BIOS setup of the hardware that is giving acpi or the apic some
headaches? Can you check out success or failure on other motherboards?
Please try the suggestions from the driver (safe flags)?

Sincerely -- Mark Salyzyn

> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@in.ibm.com] 
> Sent: Monday, April 23, 2007 12:12 PM
> To: Salyzyn, Mark
> Cc: linux-scsi@vger.kernel.org; James Bottomley; Kexec 
> Mailing List; Judith Lebzelter
> Subject: Re: [PATCH] aacraid: fails to initialize after a 
> kexec operation
> 
> 
> On Mon, Apr 23, 2007 at 09:38:43AM -0400, Salyzyn, Mark wrote:
> > Missing portion of the kexec changes to the aacraid driver. 
> The platform
> > functions were not initialized when the restart function is 
> activated
> > resulting in a panic when these platform functions are 
> called. Please
> > note that it is NOT a mistake that the disable interrupt 
> handler is used
> > as the initial value of the enable interrupt platform 
> function, it will
> > be set up correctly once the adapter is discovered and initialized.
> > 
> > Please note that aacraid_kexec_5.patch contains this fix, since an
> > earlier aacraid_kexec patch was applied to the tree and 
> appears to have
> > propagated, this is meant to supersede the earlier patch 
> and bring it up
> > to date with aacraid_kexec_5.patch, but expected to break when the
> > aacraid_kexec_5.patch propagates... James, can you sort out 
> this mess
> > (either by stopping aacraid_kexec_5.patch, or by letting 
> this enclosed
> > patch move with some level of priority)?
> > 
> > ObligatoryDisclaimer: Please accept my condolences 
> regarding Outlook's
> > handling of patches.
> > 
> > This attached patch is against current scsi-misc-2.6. Also 
> expect this
> > patch can be applied to 2.6.21-rc6-mm1
> > 
> > Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>
> > 
> > ---
> > 
> 
> Thanks Mark,
> 
> I applied this patch but it still does not work. Now oops is gone but
> I get following while aacraid is trying to initialize.
> 
> Adaptec aacraid driver (1.1-5[2437]-mh4)
> ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 25
> aacraid: aac_fib_send: first asynchronous command timed out.
> Usually a result of a PCI interrupt routing problem;
> update mother board BIOS or consider utilizing one of
> the SAFE mode kernel options (acpi, apic etc)
> aac_fib_free, XferState != 0, fibptr = 0xffff810104140000, 
> XferState = 0x810ad
> ACPI: PCI interrupt for device 0000:01:02.0 disabled
> aacraid: probe of 0000:01:02.0 failed with error -110
> 
> 
> Thanks
> Vivek
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
