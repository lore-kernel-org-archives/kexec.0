Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gEg7p-0006pp-9i
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 19:44:30 +0000
Received: from mail-qt1-f197.google.com ([209.85.160.197])
 by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.76) (envelope-from <gpiccoli@canonical.com>)
 id 1gEg7Z-0005hn-Ep
 for kexec@lists.infradead.org; Mon, 22 Oct 2018 19:44:13 +0000
Received: by mail-qt1-f197.google.com with SMTP id u2-v6so9574460qtg.14
 for <kexec@lists.infradead.org>; Mon, 22 Oct 2018 12:44:13 -0700 (PDT)
Subject: Re: [PATCH 3/3] x86/quirks: Add parameter to clear MSIs early on boot
References: <20181018183721.27467-1-gpiccoli@canonical.com>
 <20181018183721.27467-3-gpiccoli@canonical.com>
 <6fd4e2d2-c0ac-b26d-9a14-0379b4421679@kernel.org>
 <12d6175b-7f09-872a-61c4-700e905579c7@canonical.com>
 <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <92dc24c9-0963-e894-66fe-ad74bdbc0ac3@canonical.com>
Date: Mon, 22 Oct 2018 16:44:04 -0300
MIME-Version: 1.0
In-Reply-To: <50d84d48-eebf-ed91-8148-be727f76883f@kernel.org>
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

On 18/10/2018 17:30, Sinan Kaya wrote:
> 
> AFAIK, all shutdown (not remove) routines are called before launching
> the next
> kernel even in crash scenario. It is not safe to start the new kernel while
> hardware is doing a DMA to the system memory and triggering interrupts.

Hi Sinan,

I agree with you, it's definitely not safe to start a new kernel with
in-flight DMA transactions, but in the crash scenario I think the
rationale was that running kernel is broken so it's even more unreliable
to try gracefully shutdown the devices than hope-for-the-best and start
the kdump kernel right away heheh

Fact is that the shutdown handlers are not called in the crash scenario.
They come from device_shutdown(), the code paths are as follow:

Regular kexec flow:

syscall_reboot()
  kernel_kexec()
    kernel_restart_prepare()
	  device_shutdown()
	machine_kexec()
	
Although if CONFIG_KEXEC_JUMP is set, it doesn't call device_shutdown()
either.


Crash kexec flow:
  __crash_kexec()
      machine_kexec()

There are some entry points to __crash_kexec(), like panic() or die() in
x86, for example.
To validate this, one can load a kernel with "initcall_debug" parameter,
and performs a kexec - if the shutdown handlers are called, there's a
dev_info() call that shows a message per device.


> Shutdown routine in PCI core used to disable MSI/MSI-x on behalf of all
> endpoints but it was later decided that this is the responsibility of the
> endpoint driver.
> 

This may be a good idea, using the pci layer to disable MSIs in the
quiesce path of the broken kernel. I'll follow-up this discussion in
Bjorn's reply.

Thanks,


Guilherme

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
