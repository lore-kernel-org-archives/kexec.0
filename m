Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([193.142.43.55])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kdifs-0002D0-8H
 for kexec@lists.infradead.org; Fri, 13 Nov 2020 23:40:12 +0000
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] x86/quirks: Scan all busses for early PCI quirks
In-Reply-To: <87ft5cltqa.fsf@nanos.tec.linutronix.de>
References: <20201113164638.GA1019448@bjorn-Precision-5520>
 <87ft5cltqa.fsf@nanos.tec.linutronix.de>
Date: Sat, 14 Nov 2020 00:40:10 +0100
Message-ID: <87d00gltb9.fsf@nanos.tec.linutronix.de>
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
To: Bjorn Helgaas <helgaas@kernel.org>, "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: kernel@gpiccoli.net, andi@firstfloor.org, bhe@redhat.com, lukas@wunner.de, shan.gavin@linux.alibaba.com, linux-pci@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, kernelfans@gmail.com, ddstreet@canonical.com, mingo@redhat.com, bp@alien8.de, gavin.guo@canonical.com, hpa@zytor.com, bhelgaas@google.com, jay.vosburgh@canonical.com, okaya@kernel.org, dyoung@redhat.com, vgoyal@redhat.com, Eric Biederman <ebiederm@xmission.com>

Bjorn,

On Sat, Nov 14 2020 at 00:31, Thomas Gleixner wrote:
> On Fri, Nov 13 2020 at 10:46, Bjorn Helgaas wrote:
>> pci_device_shutdown() still clears the Bus Master Enable bit if we're
>> doing a kexec and the device is in D0-D3hot, which should also disable
>> MSI/MSI-X.  Why doesn't this solve the problem?  Is this because the
>> device causing the storm was in PCI_UNKNOWN state?
>
> That's indeed a really good question.

So we do that on kexec, but is that true when starting a kdump kernel
from a kernel crash? I doubt it.

Thanks,

        tglx


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
