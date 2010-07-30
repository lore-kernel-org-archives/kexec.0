Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OewyJ-0006yR-9g
	for kexec@lists.infradead.org; Fri, 30 Jul 2010 21:18:30 +0000
Subject: Re: In place kexec
From: Khalid Aziz <khalid_aziz@hp.com>
In-Reply-To: <4C533922.10901@zytor.com>
References: <4C50A7AD.8040902@zytor.com> <m1y6cvtgd0.fsf@fess.ebiederm.org>
	<20100729134343.GA31490@shamino.rdu.redhat.com>
	<4C519853.2040206@zytor.com>
	<20100729150640.GF31490@shamino.rdu.redhat.com>	<4C51BFA5.60507@zytor.com>
	<m1k4oe88n9.fsf@fess.ebiederm.org>	<4C51C878.2090102@zytor.com>
	<20100729191654.GB28704@redhat.com>	<m1lj8uvzgy.fsf@fess.ebiederm.org>
	<20100729125535.85dfd7da.randy.dunlap@oracle.com>
	<4C524934.5070806@zytor.com> <m1d3u5ins8.fsf@fess.ebiederm.org>
	<1280508817.28006.0.camel@macbook.infradead.org>
	<4C533922.10901@zytor.com>
Date: Fri, 30 Jul 2010 15:18:16 -0600
Message-Id: <1280524696.30160.34.camel@localhost>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Neil Horman <nhorman@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Simon Horman <horms@verge.net.au>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-driver@qlogic.com" <linux-driver@qlogic.com>, David Woodhouse <dwmw2@infradead.org>, Vivek Goyal <vgoyal@redhat.com>, Andrew Vasquez <andrew.vasquez@qlogic.com>

On Fri, 2010-07-30 at 20:42 +0000, H. Peter Anvin wrote:
> On 07/30/2010 09:53 AM, David Woodhouse wrote:
> > On Thu, 2010-07-29 at 21:41 -0700, Eric W. Biederman wrote:
> >> There isn't a bus master shut off at the core level.  
> > 
> > Effectively, there is if you have an IOMMU.
> 
> With the "core level" I meant Linux kernel code, as opposed to hardware
> level which is slightly different; I meant it would make sense to at
> least set the bus master control bit (PCI_COMMAND_MASTER) to zero before
> kexec.

Before kexec patch for ia64 was merged into mainline kernel, Zou Nan Hai
and I had added a device_shootdown() routine to arch/ia64/kernel/crash.c
that was called from machine_crash_shutdown(). device_shootdown() did
exactly what you are proposing:

+static void device_shootdown(void)
+{
+       struct pci_dev *dev;
+       irq_desc_t *desc;
+       u16 pci_command;
+
+       list_for_each_entry(dev, &pci_devices, global_list) {
+               desc = irq_descp(dev->irq);
+               if (!desc->action)
+                       continue;
+               pci_read_config_word(dev, PCI_COMMAND, &pci_command);
+               if (pci_command & PCI_COMMAND_MASTER) {
+                       pci_command &= ~PCI_COMMAND_MASTER;
+                       pci_write_config_word(dev, PCI_COMMAND, pci_command);
+               }
+               disable_irq_nosync(dev->irq);
+               desc->handler->end(dev->irq);
+       }
+}

There were some discussions regarding this and this code was removed by
the time it was merged into mainline kernel. I can't remember the
details of why. I remember one report of kernel hang on kexec that
seemed to happen in device_shootdown(). I will look for any discussion
threads I can find.

-- 
Khalid
====================================================================
Khalid Aziz                             Telco Platform Software, ISB
(970)898-9214                                        Hewlett-Packard
khalid.aziz@hp.com                                  Fort Collins, CO

"The Linux kernel is subject to relentless development" 
                                - Alessandro Rubini


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
