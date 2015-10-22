Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pa0-x231.google.com ([2607:f8b0:400e:c03::231])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Zp7Vn-0002aA-Sd
 for kexec@lists.infradead.org; Thu, 22 Oct 2015 04:30:01 +0000
Received: by pabrc13 with SMTP id rc13so75133108pab.0
 for <kexec@lists.infradead.org>; Wed, 21 Oct 2015 21:29:38 -0700 (PDT)
Subject: Re: [PATCH 13/16] arm64: kdump: add kdump support
References: <cover.1445297709.git.geoff@infradead.org>
 <ef50b13d545f37a9fa95c5e6856e35f324798d00.1445297709.git.geoff@infradead.org>
 <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Message-ID: <5628662B.1020605@linaro.org>
Date: Thu, 22 Oct 2015 13:29:31 +0900
MIME-Version: 1.0
In-Reply-To: <20151022032534.GC11227@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>, Geoff Levand <geoff@infradead.org>
Cc: Mark Rutland <mark.rutland@arm.com>, AKASHI@infradead.org, marc.zyngier@arm.com, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, christoffer.dall@linaro.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

Thank you for your comment.

On 10/22/2015 12:25 PM, Dave Young wrote:
> Hi, AKASHI,
>
> On 10/19/15 at 11:38pm, Geoff Levand wrote:
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
>
> How does kexec-tools pass usable memory ranges to kernel? using dtb?
> Passing an extra mem=X sounds odd in the design. Kdump kernel should get
> usable ranges and hanle the limit better than depending on an extern kernel
> param.

Well, regarding "depending on an external kernel param,"
- this limitation ("mem=") is compatible with arm(32) implementation although
   it is not clearly described in kernel's Documentation/kdump/kdump.txt.
- "elfcorehdr" kernel parameter is mandatory on x86 as well as on arm/arm64.
   The parameter is explicitly generated and added by kexec-tools.

Do I miss your point?

Thanks,
-Takahiro AKASHI

> Thanks
> Dave
>

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
