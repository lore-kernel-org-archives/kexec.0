Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x233.google.com ([2607:f8b0:400e:c03::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMTgc-000821-Ue
 for kexec@lists.infradead.org; Fri, 22 Jan 2016 04:51:03 +0000
Received: by mail-pa0-x233.google.com with SMTP id yy13so34860941pab.3
 for <kexec@lists.infradead.org>; Thu, 21 Jan 2016 20:50:42 -0800 (PST)
Subject: Re: [PATCH 16/19] arm64: kdump: add kdump support
References: <cover.1452884156.git.geoff@infradead.org>
 <c1faadcc74ca0670413396b36e2bdcc02b15bcd9.1452884156.git.geoff@infradead.org>
 <56A0E869.1020906@arm.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <56A1B51A.3000001@linaro.org>
Date: Fri, 22 Jan 2016 13:50:34 +0900
MIME-Version: 1.0
In-Reply-To: <56A0E869.1020906@arm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: James Morse <james.morse@arm.com>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, christoffer.dall@linaro.org

James,

On 01/21/2016 11:17 PM, James Morse wrote:
> Hi!
>
> On 15/01/16 19:18, Geoff Levand wrote:
>> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
>>
>> On crash dump kernel, all the information about primary kernel's core
>> image is available in elf core header specified by "elfcorehdr=" boot
>> parameter. reserve_elfcorehdr() will set aside the region to avoid any
>> corruption by crash dump kernel.
>>
>> Crash dump kernel will access the system memory of primary kernel via
>> copy_oldmem_page(), which reads one page by ioremap'ing it since it does
>> not reside in linear mapping on crash dump kernel.
>> Please note that we should add "mem=X[MG]" boot parameter to limit the
>> memory size and avoid the following assertion at ioremap():
>> 	if (WARN_ON(pfn_valid(__phys_to_pfn(phys_addr))))
>> 		return NULL;
>> when accessing any pages beyond the usable memories of crash dump kernel.
>>
>> We also need our own elfcorehdr_read() here since the weak definition of
>> elfcorehdr_read() utilizes copy_oldmem_page() and will hit the assertion
>> above on arm64.
>
> How does this work for a different-endian crash kernel?
>
> It looks like fs/proc/vmcore.c:parse_crash_elf64_headers() does some
> validation on the elf-headers that doesn't look like it will work if
> elfcorehdr:endian != kernel:endian.

Good point!

> Is it worth preventing this corner case by getting kexec-tools to
> prevent linux with a different endianness being loaded as a kdump kernel?

It may be, but I think that people should always check whether or not kdump
will work in their environment before puting the system in practical use.

(I know the check costs almost nothing though.)

Thanks,
-Takahiro AKASHI

>
> Thanks,
>
> James
>
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
