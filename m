Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI9Xn-0008Sm-T6
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 03:18:29 +0000
Message-ID: <1363749503.24132.482.camel@bling.home>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
From: Alex Williamson <alex.williamson@redhat.com>
Date: Tue, 19 Mar 2013 21:18:23 -0600
In-Reply-To: <51492828.5070803@zytor.com>
References: <3pfl8u1ugprwkcs5xmtjth3l.1363742692541@email.android.com>
 <51492379.3090302@zytor.com> <51492828.5070803@zytor.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On Tue, 2013-03-19 at 20:08 -0700, H. Peter Anvin wrote:
> On 03/19/2013 07:48 PM, H. Peter Anvin wrote:
> > On 03/19/2013 06:28 PM, Matthew Garrett wrote:
> >> Mm. The question is whether we can reliably determine the ranges a
> device should be able to access without having to trust userspace
> (and, ideally, without having to worry about whether iommu vendors
> have done their job). It's pretty important for PCI passthrough, so we
> do need to care. 
> > 
> > It is actually very simple: the device should be able to DMA into/out of:
> > 
> > 1. pinned pages
> > 2. owned by the process controlling the device
> > 
> > ... and nothing else.
> > 
> 
> The "pinning" process needs to involve a call to the kernel to process
> the page for DMA (pinning the page and opening it in the iommu) and
> return a transaction address, of course.
> 
> I think we have the interface for that in vfio, but I haven't followed
> that work.

Yes, vfio does this and is meant to provide a secure-boot-friendly PCI
passthrough interface.  Thanks,

Alex


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
