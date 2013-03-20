Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI9bs-00007l-O8
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 03:22:41 +0000
Message-ID: <51492B78.7020404@zytor.com>
Date: Tue, 19 Mar 2013 20:22:32 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
References: <3pfl8u1ugprwkcs5xmtjth3l.1363742692541@email.android.com>
 <51492379.3090302@zytor.com> <51492828.5070803@zytor.com>
 <1363749503.24132.482.camel@bling.home>
In-Reply-To: <1363749503.24132.482.camel@bling.home>
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>

On 03/19/2013 08:18 PM, Alex Williamson wrote:
>>
>> The "pinning" process needs to involve a call to the kernel to process
>> the page for DMA (pinning the page and opening it in the iommu) and
>> return a transaction address, of course.
>>
>> I think we have the interface for that in vfio, but I haven't followed
>> that work.
> 
> Yes, vfio does this and is meant to provide a secure-boot-friendly PCI
> passthrough interface.  Thanks,
> 

Right, and presumably vfio does *not* require CAP_SYS_RAWIO, right?

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
