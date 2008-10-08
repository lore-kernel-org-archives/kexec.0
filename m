Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([59.145.155.6] helo=e28esmtp06.in.ibm.com)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KnZSB-0002oN-VR
	for kexec@lists.infradead.org; Wed, 08 Oct 2008 13:51:52 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28esmtp06.in.ibm.com (8.13.1/8.13.1) with ESMTP id m98DpmkI003413
	for <kexec@lists.infradead.org>; Wed, 8 Oct 2008 19:21:48 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m98DpmjF954502
	for <kexec@lists.infradead.org>; Wed, 8 Oct 2008 19:21:48 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m98Dpm5p015985
	for <kexec@lists.infradead.org>; Thu, 9 Oct 2008 00:51:48 +1100
Message-ID: <48ECBAF5.5010309@in.ibm.com>
Date: Wed, 08 Oct 2008 19:21:49 +0530
From: Chandru <chandru@in.ibm.com>
MIME-Version: 1.0
Subject: Re: kdump: quad core Opteron
References: <48EB5B68.8010401@in.ibm.com> <20081007132401.GA4007@redhat.com>
	<1223395191.2215.179.camel@amd.troyhebe>
In-Reply-To: <1223395191.2215.179.camel@amd.troyhebe>
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
To: bob.montgomery@hp.com
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Vivek Goyal <vgoyal@redhat.com>

Bob Montgomery wrote:
> Here's the README for the patch:
>
> This patch changes the initialization of the GART (in
> pci-gart.c:init_k8_gatt) to set the DisGartCpu bit in the GART Aperture
> Control Register.  Setting the bit Disables requests from the CPUs from
> accessing the GART.  In other words, CPU memory accesses within the
> range of addresses in the aperture will not cause the GART to perform an
> address translation.  The aperture area was already being unmapped at
> the kernel level with clear_kernel_mapping() to prevent accesses from
> the CPU, but that kernel level unmapping is not in effect in the kexec'd
> kdump kernel.  By disabling the CPU-side accesses within the GART, which
> does persist through the kexec of the kdump kernel, the kdump kernel is
> prevented from interacting with the GART during accesses to the dump
> memory areas which include the address range of the GART aperture.
> Although the patch can be applied to the kdump kernel, it is not
> exercised there because the kdump kernel doesn't attempt to initialize
> the GART.
>
> Bob Montgomery
> working at HP
>
>   

I made the following changes and it seems like it is working.

--- linux-2.6.27-rc8/include/asm-x86/gart.h.orig        2008-10-08 
09:41:23.000000000 -0400
+++ linux-2.6.27-rc8/include/asm-x86/gart.h     2008-10-08 
09:44:35.000000000 -0400
@@ -42,7 +42,8 @@ static inline void enable_gart_translati
         /* Enable GART translation for this hammer. */
         pci_read_config_dword(dev, AMD64_GARTAPERTURECTL, &ctl);
         ctl |= GARTEN;
-        ctl &= ~(DISGARTCPU | DISGARTIO);
+       ctl |= DISGARTCPU;
+       ctl &= ~(DISGARTIO);
         pci_write_config_dword(dev, AMD64_GARTAPERTURECTL, ctl);
 }

The system doesn't reset now while copying /proc/vmcore. Thanks!

Chandru

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
