Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Message-ID: <52616B56.10407@gmail.com>
Date: Fri, 18 Oct 2013 19:09:42 +0200
From: Daniel Mack <zonque@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2] ARM: head-common.S: relocate atags area if necessary
References: <1382112776-20300-1-git-send-email-zonque@gmail.com>
 <20131018162956.GE25034@n2100.arm.linux.org.uk>
In-Reply-To: <20131018162956.GE25034@n2100.arm.linux.org.uk>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: kexec@lists.infradead.org, neumann@teufel.de, linux-arm-kernel@lists.infradead.org

Hi Russell,

thanks for having a look.

On 10/18/2013 06:29 PM, Russell King - ARM Linux wrote:
> On Fri, Oct 18, 2013 at 06:12:56PM +0200, Daniel Mack wrote:
>> If the supplied atags/dtb pointer is located at memory inside the bss
>> section, it will be erased by __mmap_switched. The problem is that the
>> code that sets up the pointer can't know about a safe value unless it
>> examines the kernel's symbol tables, so we should care about that case
>> and relocate the area if necessary.
>>
>> This patch does that from inside __vet_atags. In order to determine the
>> size of the section in dtb cases, it reads the next word after the dtb
>> binary magic, and also has to convert that value from big to CPU
>> endianess. For the atags case, a total size of up to 4k is assumed for
>> now.
> 
> I'm not convinced that this is a good solution.  If this oerlaps the
> BSS region, it could well end up being overlapped by something else
> more serious, like the data segment

My v1 had a cover letter, don't know if you've seen it. In that, I
describe that the setup I see that faulty condition is caused by kexec,
which currently assumes that the decompressed kernel size is max. 4
times bigger than the zImage it executes. While that is naive, it seems
to be an assumption that reflects reality in my tests.

Correct me if I'm wrong, but AFAIK the .bss section is the only thing
that can grow to arbitrary size at runtime without accounting to the
compressed image size; so in order to fix kernels executed by kexec that
way, my fixup seems reasonable, doesn't it?

> - at which point doing the fixup
> here means we've already lost.

The question is whether it does any harm to at least try to fix up
things in that situation.

> We already give the decompressor the size of the kernel's BSS and take
> action if we believe that the kernel's BSS will overlap the DTB/ATAGs
> there.

Only for CONFIG_ARM_ATAG_DTB_COMPAT (which is unset in my config),
right? I've read through the sources relevant for my system (AM33xx),
and couldn't find any other place where my case is covered. The
relocation I propose does fix it, though.


Thanks,
Daniel


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
