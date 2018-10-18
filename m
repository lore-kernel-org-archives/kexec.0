Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDEfo-00072S-Aw
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 20:13:37 +0000
Received: from mail-qt1-f198.google.com ([209.85.160.198])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gDEfZ-0004xz-NQ
 for kexec@lists.infradead.org; Thu, 18 Oct 2018 20:13:21 +0000
Received: by mail-qt1-f198.google.com with SMTP id j60-v6so33125214qtb.8
 for <kexec@lists.infradead.org>; Thu, 18 Oct 2018 13:13:21 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
 <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
Date: Thu, 18 Oct 2018 17:13:10 -0300
MIME-Version: 1.0
In-Reply-To: <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
Content-Language: en-US
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
To: Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org
Cc: cascardo@canonical.com, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, kernel@gpiccoli.net, linux-kernel@vger.kernel.org, gavin.guo@canonical.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, billy.olsen@canonical.com, mfo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, tglx@linutronix.de, dyoung@redhat.com, fabiomirmar@canonical.com, vgoyal@redhat.com



On 18/10/2018 17:08, Sinan Kaya wrote:
> On 10/18/2018 2:37 PM, Guilherme G. Piccoli wrote:
>> We observed a kdump failure in x86 that was narrowed down to MSI irq
>> storm coming from a PCI network device. The bug manifests as a lack of
>> progress in the boot process of kdump kernel, and a flood of kernel
>> messages like:
>>
>> [...]
>> [ 342.265294] do_IRQ: 0.155 No irq handler for vector
>> [ 342.266916] do_IRQ: 0.155 No irq handler for vector
>> [ 347.258422] do_IRQ: 14053260 callbacks suppressed
>> [...]
> 
> These kind of issues are usually fixed by fixing the network driver's
> shutdown routine to ensure that MSI interrupts are cleared there.


Sinan, I'm not sure shutdown handlers for drivers are called in panic
kexec (I remember of an old experiment I did, loading a kernel
with "kexec -p" didn't trigger the handlers).

But this case is even worse, because the NICs were in PCI passthrough
mode, using vfio. So, they were completely unaware of what happened
in the host kernel.

Also, this is spec compliant - system reset events should guarantee the
bits are cleared (although kexec is not exactly a system reset, it's
similar)

Cheers,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
