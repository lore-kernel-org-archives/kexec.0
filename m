Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnEyO-0005lF-4G
	for kexec@lists.infradead.org; Tue, 07 Oct 2008 15:59:44 +0000
Subject: Re: kdump: quad core Opteron
From: Bob Montgomery <bob.montgomery@hp.com>
In-Reply-To: <20081007132401.GA4007@redhat.com>
References: <48EB5B68.8010401@in.ibm.com> <20081007132401.GA4007@redhat.com>
Content-Type: multipart/mixed; boundary="=-1Y657zDPTIuJ3l5Sp0NH"
Date: Tue, 07 Oct 2008 09:59:51 -0600
Message-Id: <1223395191.2215.179.camel@amd.troyhebe>
Mime-Version: 1.0
Reply-To: bob.montgomery@hp.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Chandru <chandru@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>


--=-1Y657zDPTIuJ3l5Sp0NH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2008-10-07 at 13:24 +0000, Vivek Goyal wrote:
> On Tue, Oct 07, 2008 at 06:21:52PM +0530, Chandru wrote:
> > kdump on a quad core Opteron blade machine doesn't give a complete
> > vmcore on the system.   All works well until we attempt to copy
> > /proc/vmcore to some target place ( disk , n/w ). The system immediately
> > resets without any OS messages after having copied few mb's of vmcore
> > file.  Problem also occurs with 2.6.27-rc8 and latest kexec-tools.  If
> > we pass 'mem=4G' as boot parameter to the first kernel, then kdump
> > succeeds in copying a readable vmcore to /var/crash.
> >
> 
> Hi Chandru,
> 
> How much memory this system has got. Can you also paste the output of
> /proc/iomem of first kernel.
> 
> Does this system has GART? So looks like we are accessing some memory area
> which platform does not like. (We saw issues with GART in the past.)
> 
> Can you also provide /proc/vmcore ELF header (readelf output), in both
> the cases (mem=4G and without that).
> 
> You can try putting some printk in /proc/vmcore code and see which
> physical memory area you are accessing when system goes bust. If in all
> the failure cases it is same physical memory area, then we can try to find
> what's so special about it.

Or you can assume this is pretty much exactly the problem I ran into in
August.  I've attached the patch that I'm using with our 2.6.18 kernel
to disable CPU-side access by the GART, which prevents the problem on
our Family 10H systems.  You'll need to fix the directory name for
kernels newer than the arch/x86_64 merge.

Now that someone else has seen the problem, if this fixes it, I'll
submit the patch upstream. 

Here's the README for the patch:

This patch changes the initialization of the GART (in
pci-gart.c:init_k8_gatt) to set the DisGartCpu bit in the GART Aperture
Control Register.  Setting the bit Disables requests from the CPUs from
accessing the GART.  In other words, CPU memory accesses within the
range of addresses in the aperture will not cause the GART to perform an
address translation.  The aperture area was already being unmapped at
the kernel level with clear_kernel_mapping() to prevent accesses from
the CPU, but that kernel level unmapping is not in effect in the kexec'd
kdump kernel.  By disabling the CPU-side accesses within the GART, which
does persist through the kexec of the kdump kernel, the kdump kernel is
prevented from interacting with the GART during accesses to the dump
memory areas which include the address range of the GART aperture.
Although the patch can be applied to the kdump kernel, it is not
exercised there because the kdump kernel doesn't attempt to initialize
the GART.

Bob Montgomery
working at HP





--=-1Y657zDPTIuJ3l5Sp0NH
Content-Disposition: attachment; filename=gart.cpuside.patch
Content-Type: text/x-patch; name=gart.cpuside.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

--- k-2.6.18-6-clim-amd64-bobm/arch/x86_64/kernel/pci-gart.c.orig	2008-08-13 08:53:33.000000000 -0600
+++ k-2.6.18-6-clim-amd64-bobm/arch/x86_64/kernel/pci-gart.c	2008-08-13 08:55:48.000000000 -0600
@@ -540,8 +540,9 @@ static __init int init_k8_gatt(struct ag
 		pci_write_config_dword(dev, 0x98, gatt_reg);
 		pci_read_config_dword(dev, 0x90, &ctl); 
 
-		ctl |= 1;
-		ctl &= ~((1<<4) | (1<<5));
+		ctl |= 1;	/* set GartEn */
+		ctl |= (1<<4);	/* set DisGartCpu */
+		ctl &= ~(1<<5); /* clear DisGartIO */
 
 		pci_write_config_dword(dev, 0x90, ctl); 
 	}

--=-1Y657zDPTIuJ3l5Sp0NH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--=-1Y657zDPTIuJ3l5Sp0NH--


