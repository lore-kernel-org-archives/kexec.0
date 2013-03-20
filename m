Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI94r-0006Pq-VZ
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 02:48:34 +0000
Message-ID: <51492379.3090302@zytor.com>
Date: Tue, 19 Mar 2013 19:48:25 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
References: <3pfl8u1ugprwkcs5xmtjth3l.1363742692541@email.android.com>
In-Reply-To: <3pfl8u1ugprwkcs5xmtjth3l.1363742692541@email.android.com>
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
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 03/19/2013 06:28 PM, Matthew Garrett wrote:
> Mm. The question is whether we can reliably determine the ranges a device should be able to access without having to trust userspace (and, ideally, without having to worry about whether iommu vendors have done their job). It's pretty important for PCI passthrough, so we do need to care. 

It is actually very simple: the device should be able to DMA into/out of:

1. pinned pages
2. owned by the process controlling the device

... and nothing else.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
