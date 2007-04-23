Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hg19M-00070m-C1
	for kexec@lists.infradead.org; Mon, 23 Apr 2007 12:12:26 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3NGCMBM024886
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 12:12:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3NGCMsI532850
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 12:12:22 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3NGCMOD014619
	for <kexec@lists.infradead.org>; Mon, 23 Apr 2007 12:12:22 -0400
Date: Mon, 23 Apr 2007 21:42:03 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] aacraid: fails to initialize after a  kexec operation
Message-ID: <20070423161203.GA2129@in.ibm.com>
References: <AE4F746F2AECFC4DA4AADD66A1DFEF0188ADBF@otce2k301.adaptec.com>
	<AE4F746F2AECFC4DA4AADD66A1DFEF0188ADCE@otce2k301.adaptec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AE4F746F2AECFC4DA4AADD66A1DFEF0188ADCE@otce2k301.adaptec.com>
Reply-To: vgoyal@in.ibm.com
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
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kexec Mailing List <kexec@lists.infradead.org>, Judith Lebzelter <judith@linux-foundation.org>, linux-scsi@vger.kernel.org

On Mon, Apr 23, 2007 at 09:38:43AM -0400, Salyzyn, Mark wrote:
> Missing portion of the kexec changes to the aacraid driver. The platform
> functions were not initialized when the restart function is activated
> resulting in a panic when these platform functions are called. Please
> note that it is NOT a mistake that the disable interrupt handler is used
> as the initial value of the enable interrupt platform function, it will
> be set up correctly once the adapter is discovered and initialized.
> 
> Please note that aacraid_kexec_5.patch contains this fix, since an
> earlier aacraid_kexec patch was applied to the tree and appears to have
> propagated, this is meant to supersede the earlier patch and bring it up
> to date with aacraid_kexec_5.patch, but expected to break when the
> aacraid_kexec_5.patch propagates... James, can you sort out this mess
> (either by stopping aacraid_kexec_5.patch, or by letting this enclosed
> patch move with some level of priority)?
> 
> ObligatoryDisclaimer: Please accept my condolences regarding Outlook's
> handling of patches.
> 
> This attached patch is against current scsi-misc-2.6. Also expect this
> patch can be applied to 2.6.21-rc6-mm1
> 
> Signed-off-by: Mark Salyzyn <aacraid@adaptec.com>
> 
> ---
> 

Thanks Mark,

I applied this patch but it still does not work. Now oops is gone but
I get following while aacraid is trying to initialize.

Adaptec aacraid driver (1.1-5[2437]-mh4)
ACPI: PCI Interrupt 0000:01:02.0[A] -> GSI 25 (level, low) -> IRQ 25
aacraid: aac_fib_send: first asynchronous command timed out.
Usually a result of a PCI interrupt routing problem;
update mother board BIOS or consider utilizing one of
the SAFE mode kernel options (acpi, apic etc)
aac_fib_free, XferState != 0, fibptr = 0xffff810104140000, XferState = 0x810ad
ACPI: PCI interrupt for device 0000:01:02.0 disabled
aacraid: probe of 0000:01:02.0 failed with error -110


Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
