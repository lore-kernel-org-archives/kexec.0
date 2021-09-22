Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com
 ([40.107.94.45] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mT2UV-008f10-7X
 for kexec@lists.infradead.org; Wed, 22 Sep 2021 13:40:53 +0000
Subject: Re: [PATCH v3 5/8] x86/sme: Replace occurrences of sme_active() with
 cc_platform_has()
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <367624d43d35d61d5c97a8b289d9ddae223636e9.1631141919.git.thomas.lendacky@amd.com>
 <20210920192341.maue7db4lcbdn46x@box.shutemov.name>
 <77df37e1-0496-aed5-fd1d-302180f1edeb@amd.com> <YUoao0LlqQ6+uBrq@zn.tnic>
 <20210921212059.wwlytlmxoft4cdth@box.shutemov.name>
 <YUpONYwM4dQXAOJr@zn.tnic>
 <20210921213401.i2pzaotgjvn4efgg@box.shutemov.name>
 <00f52bf8-cbc6-3721-f40e-2f51744751b0@amd.com>
 <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <01891f59-7ec3-cf62-a8fc-79f79ca76587@amd.com>
Date: Wed, 22 Sep 2021 08:40:43 -0500
In-Reply-To: <20210921215830.vqxd75r4eyau6cxy@box.shutemov.name>
Content-Language: en-US
MIME-Version: 1.0
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
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Borislav Petkov <bp@alien8.de>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-graphics-maintainer@vmware.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Joerg Roedel <joro@8bytes.org>, Andi Kleen <ak@linux.intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On 9/21/21 4:58 PM, Kirill A. Shutemov wrote:
> On Tue, Sep 21, 2021 at 04:43:59PM -0500, Tom Lendacky wrote:
>> On 9/21/21 4:34 PM, Kirill A. Shutemov wrote:
>>> On Tue, Sep 21, 2021 at 11:27:17PM +0200, Borislav Petkov wrote:
>>>> On Wed, Sep 22, 2021 at 12:20:59AM +0300, Kirill A. Shutemov wrote:
>>>>> I still believe calling cc_platform_has() from __startup_64() is totally
>>>>> broken as it lacks proper wrapping while accessing global variables.
>>>>
>>>> Well, one of the issues on the AMD side was using boot_cpu_data too
>>>> early and the Intel side uses it too. Can you replace those checks with
>>>> is_tdx_guest() or whatever was the helper's name which would check
>>>> whether the the kernel is running as a TDX guest, and see if that helps?
>>>
>>> There's no need in Intel check this early. Only AMD need it. Maybe just
>>> opencode them?
>>
>> Any way you can put a gzipped/bzipped copy of your vmlinux file somewhere I
>> can grab it from and take a look at it?
> 
> You can find broken vmlinux and bzImage here:
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1n74vUQHOGebnF70Im32qLFY8iS3wvjIs%3Fusp%3Dsharing&amp;data=04%7C01%7Cthomas.lendacky%40amd.com%7C1c7adf380cbe4c1a6bb708d97d4af6ff%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637678583935705530%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=gA30x%2Bfu97tUx0p2UqI8HgjiL8bxDbK1GqgJBbUrUE4%3D&amp;reserved=0
> 
> Let me know when I can remove it.

Looking at everything, it is all RIP relative addressing, so those
accesses should be fine. Your image has the intel_cc_platform_has()
function, does it work if you remove that call? Because I think it may be
the early call into that function which looks like it has instrumentation
that uses %gs in __sanitizer_cov_trace_pc and %gs is not setup properly
yet. And since boot_cpu_data.x86_vendor will likely be zero this early it
will match X86_VENDOR_INTEL and call into that function.

ffffffff8124f880 <intel_cc_platform_has>:
ffffffff8124f880:       e8 bb 64 06 00          callq  ffffffff812b5d40 <__fentry__>
ffffffff8124f885:       e8 36 ca 42 00          callq  ffffffff8167c2c0 <__sanitizer_cov_trace_pc>
ffffffff8124f88a:       31 c0                   xor    %eax,%eax
ffffffff8124f88c:       c3                      retq


ffffffff8167c2c0 <__sanitizer_cov_trace_pc>:
ffffffff8167c2c0:       65 8b 05 39 ad 9a 7e    mov    %gs:0x7e9aad39(%rip),%eax        # 27000 <__preempt_count>
ffffffff8167c2c7:       89 c6                   mov    %eax,%esi
ffffffff8167c2c9:       48 8b 0c 24             mov    (%rsp),%rcx
ffffffff8167c2cd:       81 e6 00 01 00 00       and    $0x100,%esi
ffffffff8167c2d3:       65 48 8b 14 25 40 70    mov    %gs:0x27040,%rdx

Thanks,
Tom

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
