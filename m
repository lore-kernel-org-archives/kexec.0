Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bNFPS-0006J3-5B
 for kexec@lists.infradead.org; Wed, 13 Jul 2016 08:20:47 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D8JRr3049548
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 04:20:25 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 243ej39eu0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 13 Jul 2016 04:20:24 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 02:20:24 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [RFC 0/3] extend kexec_file_load system call
In-Reply-To: <CAKv+Gu9kEeVuW6Hj7HYOMojE5SLEZ69uAW2t9xZySw0uWNLcBQ@mail.gmail.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <87furf7ztv.fsf@x220.int.ebiederm.org> <50662781.Utjsnse3nb@hactar>
 <20160712225805.0d27fe5d@hananiah.suse.cz>
 <20160712221804.GV1041@n2100.armlinux.org.uk>
 <87twfunneg.fsf@linux.vnet.ibm.com>
 <20160713073657.GX1041@n2100.armlinux.org.uk>
 <CAKv+Gu9kEeVuW6Hj7HYOMojE5SLEZ69uAW2t9xZySw0uWNLcBQ@mail.gmail.com>
Date: Wed, 13 Jul 2016 18:20:10 +1000
MIME-Version: 1.0
Message-Id: <87mvlmne4l.fsf@linux.vnet.ibm.com>
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
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Petr Tesarik <ptesarik@suse.cz>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>

Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
> On 13 July 2016 at 09:36, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
>> On Wed, Jul 13, 2016 at 02:59:51PM +1000, Stewart Smith wrote:
>>> Russell King - ARM Linux <linux@armlinux.org.uk> writes:
>>> > On Tue, Jul 12, 2016 at 10:58:05PM +0200, Petr Tesarik wrote:
>>> >> I'm not an expert on DTB, so I can't provide an example of code
>>> >> execution, but you have already mentioned the /chosen/linux,stdout-path
>>> >> property. If an attacker redirects the bootloader to an insecure
>>> >> console, they may get access to the system that would otherwise be
>>> >> impossible.
>>> >
>>> > I fail to see how kexec connects with the boot loader - the DTB image
>>> > that's being talked about is one which is passed from the currently
>>> > running kernel to the to-be-kexec'd kernel.  For ARM (and I suspect
>>> > also ARM64) that's a direct call chain which doesn't involve any
>>> > boot loader or firmware, and certainly none that would involve the
>>> > passed DTB image.
>>>
>>> For OpenPOWER machines, kexec is the bootloader. Our bootloader is a
>>> linux kernel and initramfs with a UI (petitboot) - this means we never
>>> have to write a device driver twice: write a kernel one and you're done
>>> (for booting from the device and using it in your OS).
>>
>> I think you misunderstood my point.
>>
>> On ARM, we do not go:
>>
>>         kernel (kexec'd from) -> boot loader -> kernel (kexec'd to)
>>
>> but we go:
>>
>>         kernel (kexec'd from) -> kernel (kexec'd to)
>>
>> There's no intermediate step involving any bootloader.
>>
>> Hence, my point is that the dtb loaded by kexec is _only_ used by the
>> kernel which is being kexec'd to, not by the bootloader, nor indeed
>> the kernel which it is loaded into.
>>
>> Moreover, if you read the bit that I quoted (which is what I was
>> replying to), you'll notice that it is talking about the DTB loaded
>> by kexec somehow causing the _bootloader_ to be redirected to an
>> alternative console.  This point is wholely false on ARM.
>>
>
> The particular example may not apply, but the argument that the DTB
> -as a description of the hardware topology- needs to be signed if the
> kernel is also signed is valid. We do the same in the UEFI stub, i.e.,
> it normally takes a dtb= argument to allow the DTB to be overridden,
> but this feature is disabled when Secure Boot is in effect. By the
> same reasoning, if any kind of kexec kernel image validation is in
> effect, we should either validate the DTB image as well, or disallow
> external DTBs and only perform kexec with the kernel's current DTB
> (the blob it was booted with, not the unflattened data structure)

DTB booted with != current description of hardware

We could have had: PCI hotplug, CPU/memory/cache offlined due to
hardware error, change in available pstates / CPU frequencies.

There is merit in having a signed dtb if you're booting a signed kernel
in a secure boot scenario. However, we still need to set up /chosen/ and
we still need a way to do something like the offb hack.

-- 
Stewart Smith
OPAL Architect, IBM.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
