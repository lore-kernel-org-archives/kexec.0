Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h3iKz-00023d-4o
 for kexec@lists.infradead.org; Tue, 12 Mar 2019 14:25:07 +0000
Received: by mail-pf1-f196.google.com with SMTP id y124so958034pfy.7
 for <kexec@lists.infradead.org>; Tue, 12 Mar 2019 07:25:00 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Append new variables to vmcoreinfo (PTRS_PER_PGD
 for arm64 and MAX_PHYSMEM_BITS for all archs)
References: <1552212242-9479-1-git-send-email-bhsharma@redhat.com>
 <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <409a4754-0d01-6eab-2524-94d88bbc609b@redhat.com>
Date: Tue, 12 Mar 2019 19:54:49 +0530
MIME-Version: 1.0
In-Reply-To: <20190311090553.GA12130@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Paul Mackerras <paulus@samba.org>, James Morse <james.morse@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, bhupesh.linux@gmail.com, linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Dave Anderson <anderson@redhat.com>

Hi Dave,

On 03/11/2019 02:35 PM, Dave Young wrote:
> Hi Bhupesh,
> On 03/10/19 at 03:34pm, Bhupesh Sharma wrote:
>> Changes since v1:
>> ----------------
>> - v1 was sent out as a single patch which can be seen here:
>>    http://lists.infradead.org/pipermail/kexec/2019-February/022411.html
>>
>> - v2 breaks the single patch into two independent patches:
>>    [PATCH 1/2] appends 'PTRS_PER_PGD' to vmcoreinfo for arm64 arch, whereas
>>    [PATCH 2/2] appends 'MAX_PHYSMEM_BITS' to vmcoreinfo in core kernel code (all archs)
>>
>> This patchset primarily fixes the regression reported in user-space
>> utilities like 'makedumpfile' and 'crash-utility' on arm64 architecture
>> with the availability of 52-bit address space feature in underlying
>> kernel. These regressions have been reported both on CPUs which don't
>> support ARMv8.2 extensions (i.e. LVA, LPA) and are running newer kernels
>> and also on prototype platforms (like ARMv8 FVP simulator model) which
>> support ARMv8.2 extensions and are running newer kernels.
>>
>> The reason for these regressions is that right now user-space tools
>> have no direct access to these values (since these are not exported
>> from the kernel) and hence need to rely on a best-guess method of
>> determining value of 'PTRS_PER_PGD' and 'MAX_PHYSMEM_BITS' supported
>> by underlying kernel.
>>
>> Exporting these values via vmcoreinfo will help user-land in such cases.
>> In addition, as per suggestion from makedumpfile maintainer (Kazu)
>> during v1 review, it makes more sense to append 'MAX_PHYSMEM_BITS' to
>> vmcoreinfo in the core code itself rather than in arm64 arch-specific
>> code, so that the user-space code for other archs can also benefit from
>> this addition to the vmcoreinfo and use it as a standard way of
>> determining 'SECTIONS_SHIFT' value in user-land.
>>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Boris Petkov <bp@alien8.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Dave Anderson <anderson@redhat.com>
>> Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
>> Cc: x86@kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org
>>
>> Bhupesh Sharma (2):
>>    arm64, vmcoreinfo : Append 'PTRS_PER_PGD' to vmcoreinfo
>>    crash_core, vmcoreinfo: Append 'MAX_PHYSMEM_BITS' to vmcoreinfo
>>
>>   arch/arm64/kernel/crash_core.c | 1 +
>>   kernel/crash_core.c            | 1 +
>>   2 files changed, 2 insertions(+)
>>
> 
> Lianbo's document patch has been merged, would you mind to add vmcoreinfo doc
> patch as well in your series?

Thanks for the inputs. Will add it to the v3.
Let's wait for other comments/reviews, before I spin a version 3.

Regards,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
