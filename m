Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp07.in.ibm.com ([59.145.155.7] helo=e28esmtp07.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KOuUu-0007zM-HN
	for kexec@lists.infradead.org; Fri, 01 Aug 2008 13:16:46 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp07.in.ibm.com (8.13.1/8.13.1) with ESMTP id m71DGYbu018771
	for <kexec@lists.infradead.org>; Fri, 1 Aug 2008 18:46:34 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m71DGYf81744938
	for <kexec@lists.infradead.org>; Fri, 1 Aug 2008 18:46:34 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id m71DGYYK003883
	for <kexec@lists.infradead.org>; Fri, 1 Aug 2008 18:46:34 +0530
Date: Fri, 1 Aug 2008 17:43:45 +0530
From: Ankita Garg <ankita@in.ibm.com>
Subject: Re: kdump kernel hangs on 2-way AMD Opteron Intellistation
Message-ID: <20080801121345.GA7617@in.ibm.com>
References: <20080730120026.GA30011@in.ibm.com>
	<20080730120143.GB30011@in.ibm.com>
	<20080730121550.GC30011@in.ibm.com>
	<20080731134652.GD26782@redhat.com>
	<20080801064653.GB7782@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080801064653.GB7782@in.ibm.com>
Reply-To: Ankita Garg <ankita@in.ibm.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Darren Hart <dvhltc@us.ibm.com>, Chirag Jog <chirag@linux.vnet.ibm.com>, kexec@lists.infradead.org, linux-acpi@vger.kernel.org, Sripathi Kodi <sripathik@in.ibm.com>, "Sachin P. Sant" <sachinp@in.ibm.com>, Maneesh Soni <maneesh@in.ibm.com>, Dinakar Guniguntala <dino@in.ibm.com>

Hi,

On Fri, Aug 01, 2008 at 12:16:53PM +0530, Ankita Garg wrote:
> Hi Vivek,
> 
> On Thu, Jul 31, 2008 at 09:46:52AM -0400, Vivek Goyal wrote:
> > On Wed, Jul 30, 2008 at 05:45:50PM +0530, Ankita Garg wrote:
> > > Hi,
> > > 
> > > We have been using RT kernel as the kdump kernel for most of our work.
> > > This was working fine on 2.6.21.4-rt10 RT kernel. After which, we moved
> > > over to 2.6.24-rt1 RT kernel. Now, the kdump kernel hangs. Attaching the
> > > complete kdump kernel boot log with initcall_debug option passed to the
> > > kdump kernel.
> > > 
> > Can you please look at /proc/iomem in first kernel and make sure that
> > ACPI related areas are being passed to second kernel at command line
> > and are visible in second kernel's memory map?
> >
> 
> Yes, I checked that the ACPI related areas are being being passed to the
> second kernel. Just to be sure, providing the output of /proc/iomem from
> first kernel and second kernel commandline:
> 
> > Again CCing acpi mailing list.
> > 
> 
> Am also attaching the kdump kernel boot log when the following
> commandline option was passed to it:
> 
> > 
> PCI: Scanning behind PCI bridge 0000:81:00.1, config 838381, pass 1
> PCI: Bus scan for 0000:81 returning with max=83
> PCI: Scanning behind PCI bridge 0000:80:0e.0, config 878480, pass 0
> PCI: Scanning bus 0000:84
> PCI: Found 0000:84:00.0 [10de/01b3] 000604 01
> PCI: Fixups for bus 0000:84
> PCI: Scanning behind PCI bridge 0000:84:00.0, config 878584, pass 0
> PCI: Scanning bus 0000:85
> PCI: Found 0000:85:00.0 [10de/01b3] 000604 01
> PCI: Found 0000:85:01.0 [10de/01b3] 000604 01
> PCI: Fixups for bus 0000:85
> PCI: Scanning behind PCI bridge 0000:85:00.0, config 868685, pass 0
> PCI: Scanning bus 0000:86
> PCI: Found 0000:86:00.0 [10de/029f] 000300 00
> 

Looking at the above (ie where the kdump kernel apparently hung) and the
output of lspci,

#lspci
<snip>
83:04.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
83:04.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
84:00.0 PCI bridge: nVidia Corporation Unknown device 01b3 (rev a3)
85:00.0 PCI bridge: nVidia Corporation Unknown device 01b3 (rev a3)
85:01.0 PCI bridge: nVidia Corporation Unknown device 01b3 (rev a3)
86:00.0 VGA compatible controller: nVidia Corporation G70 [Quadro FX
4500 X2] (rev a1)
87:00.0 3D controller: nVidia Corporation G70 [Quadro FX 4500 X2] (rev
a1)

we thought that the PCI subsystem initialization somehow did not succeed
for the last nvidia card. Tried on another 2-way Opteron Intellistation
without the above card, and found that kdump succeeded. Considering
this, any idea on what could be going wrong here? Is the driver code
even invoked at the time the pci subsystem is being initialized? 

-- 
Regards,
Ankita Garg (ankita@in.ibm.com)
Linux Technology Center
IBM India Systems & Technology Labs, 
Bangalore, India   

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
