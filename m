Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1clwdq-0003WF-Cu
 for kexec@lists.infradead.org; Thu, 09 Mar 2017 11:54:00 +0000
Received: by mail-io0-x22d.google.com with SMTP id g6so26556441ioj.1
 for <kexec@lists.infradead.org>; Thu, 09 Mar 2017 03:53:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170309095408.GA17883@vader>
References: <20170308201616.GC8598@vader>
 <20170309063806.GB17257@dhcp-128-65.nay.redhat.com>
 <20170309095408.GA17883@vader>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 9 Mar 2017 12:53:36 +0100
Message-ID: <CAKv+Gu-gRmt=Vq=QCcT5ETY9DwLzJe0f4gHR_9sFMKX7-vK++w@mail.gmail.com>
Subject: Re: kexec regression since 4.9 caused by efi
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
To: Omar Sandoval <osandov@osandov.com>, Matt Fleming <matt@codeblueprint.co.uk>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-team@fb.com, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

On 9 March 2017 at 10:54, Omar Sandoval <osandov@osandov.com> wrote:
> On Thu, Mar 09, 2017 at 02:38:06PM +0800, Dave Young wrote:
>> Add efi/kexec list.
>>
>> On 03/08/17 at 12:16pm, Omar Sandoval wrote:
>
> [snip]
>
>> I have no more clue yet from your provided log, but the runtime value is
>> odd to me. It is set in below code:
>>
>> arch/x86/platform/efi/efi.c: efi_systab_init()
>>       efi_systab.runtime = data ?
>>                            (void *)(unsigned long)data->runtime :
>>                            (void *)(unsigne long)systab64->runtime;
>>
>> Here data is the setup_data passed by kexec-tools from normal kernel to
>> kexec kernel, efi_setup_data structure is like below:
>> struct efi_setup_data {
>>         u64 fw_vendor;
>>         u64 runtime;
>>         u64 tables;
>>         u64 smbios;
>>         u64 reserved[8];
>> };
>>
>> kexec-tools get the runtime address from /sys/firmware/efi/runtime
>>
>> So can you do some debuggin on your side, eg. see the sysfs runtime
>> value is correct or not. And add some printk in efi init path etc.
>
> The attached patch fixes this for me.

Hi Omar,

Thanks for tracking this down.

I wonder if this is an unintended side effect of the way we repurpose
the EFI_MEMORY_RUNTIME attribute in efi_arch_mem_reserve(). AFAIUI,
splitting memory map entries should only be necessary for regions that
are not runtime memory regions to begin with, and so whether their
virtual mapping address makes sense or not should be irrelevant.

Perhaps this only illustrates my lack of understanding of the x86 way
of doing this, so perhaps Matt can shed some light on this?

Thanks,
Ard.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
