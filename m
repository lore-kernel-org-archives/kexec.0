Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ch1ehsobe003.messaging.microsoft.com ([216.32.181.183]
 helo=ch1outboundpool.messaging.microsoft.com)
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI7pF-000581-OS
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 01:28:23 +0000
From: Matthew Garrett <matthew.garrett@nebula.com>
Subject: Re: [PATCH 01/12] Security: Add CAP_COMPROMISE_KERNEL
Date: Wed, 20 Mar 2013 01:28:06 +0000
Message-ID: <3pfl8u1ugprwkcs5xmtjth3l.1363742692541@email.android.com>
Content-Language: en-US
Content-ID: <493191EDBCC13545A1048D9E1A896040@nebula.com>
MIME-Version: 1.0
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
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Mm. The question is whether we can reliably determine the ranges a device should be able to access without having to trust userspace (and, ideally, without having to worry about whether iommu vendors have done their job). It's pretty important for PCI passthrough, so we do need to care. 
-- 
Matthew Garrett | matthew.garrett@nebula.com
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
