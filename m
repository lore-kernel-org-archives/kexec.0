Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <20190131014800.GB15785@dhcp-128-65.nay.redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03567AA3@BPXM09GP.gisp.nec.co.jp>
 <d7d50b5a-3577-448e-d928-7898016a38fb@redhat.com>
 <20190212104407.GA17022@dhcp-128-65.nay.redhat.com>
 <CACi5LpOAADU8s+3e6=fO7FT+VtAmWYNeZN9COF+4Gt6twLWYaA@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035683DB@BPXM09GP.gisp.nec.co.jp>
 <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
From: James Morse <james.morse@arm.com>
Message-ID: <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
Date: Wed, 13 Feb 2019 18:22:17 +0000
MIME-Version: 1.0
In-Reply-To: <20190213111552.GA8265@dhcp-128-65.nay.redhat.com>
Content-Language: en-GB
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
To: Dave Young <dyoung@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Bhupesh Sharma <bhsharma@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, anderson@redhat.com, Borislav Petkov <bp@alien8.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi guys,

On 13/02/2019 11:15, Dave Young wrote:
> On 02/12/19 at 11:03pm, Kazuhito Hagio wrote:
>> On 2/12/2019 2:59 PM, Bhupesh Sharma wrote:
>>> BTW, in the makedumpfile enablement patch thread for ARMv8.2 LVA
>>> (which I sent out for 52-bit User space VA enablement) (see [0]), Kazu
>>> mentioned that the changes look necessary.
>>>
>>> [0]. http://lists.infradead.org/pipermail/kexec/2019-February/022431.html
>>
>>>>> The increased 'PTRS_PER_PGD' value for such cases needs to be then
>>>>> calculated as is done by the underlying kernel

Aha! Nothing to do with which-bits-are-pfn in the tables...

You need to know if the top level PGD is 512bytes or bigger. As we use a
kmem-cache the adjacent data could be some else's page tables.

Is this really a problem though? You can't pull the user-space pgd pointers out
of no-where, you must have walked some task_struct and struct_mm's to find them.
In which case you would have the VMAs on hand to tell you if its in the mapped
user range.

It would be good to avoid putting something arch-specific in here if we can at
all help it.


>>>>> (see
>>>>> 'arch/arm64/include/asm/pgtable-hwdef.h' for details):
>>>>>
>>>>> #define PTRS_PER_PGD          (1 << (MAX_USER_VA_BITS - PGDIR_SHIFT))
>>
>> Yes, this is the reason why makedumpfile needs the MAX_USER_VA_BITS.
>> It is used for pgd_index() also in makedumpfile to walk page tables.
>>
>> /* to find an entry in a page-table-directory */
>> #define pgd_index(addr)         (((addr) >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1))
> 
> Since Dave mentioned crash tool does not need it, but crash should also
> travel the pg tables.
> 
> If this is really necessary it would be good to describe what will
> happen without the patch, eg. some user visible error from an actual test etc.

Yes please, it would really help if there was a specific example we could discuss.


Thanks,

James

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
