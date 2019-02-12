Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
 <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
 <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
 <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
 <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <5256fbd8-6e96-0de7-c538-acbec6387c41@arm.com>
Date: Tue, 12 Feb 2019 10:49:55 +0000
MIME-Version: 1.0
In-Reply-To: <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
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
To: Bhupesh Sharma <bhsharma@redhat.com>, James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

On 12/02/2019 04:55, Bhupesh Sharma wrote:
> Hi Robin,
> 
> On 02/04/2019 09:01 PM, Robin Murphy wrote:
>> On 04/02/2019 14:35, Bhupesh Sharma wrote:
>> [...]
>>>> Also hardcoding the PTE calculation to use the high address bit mask 
>>>> always will break the backward compatibility with older kernels 
>>>> (which don't support 52-bit address space extensions).
>>
>> No it won't. There's no difference between an old kernel, a new kernel 
>> on a CPU without ARMv8.2-LPA, or a new kernel on a CPU with 
>> ARMv8.2-LPA in a system which happens to have less than 49 bits of 
>> physical memory map - in all those cases the relevant bits are either 
>> RES0 or just actually 0 in the PTE, so replacing 4 bits of zeros with 
>> 4 bits of other zeros in the final physical address has no effect 
>> whatsoever other than taking a couple of extra instructions to perform.
> 
> Right, but lets think this from a distribution user p-o-v. Why would a 
> user with newer kernel and CPU which doesn't support ARMv8.2 LPA want to 
> update a user-space utility? Well unless something is broken in the 
> user-space. Requesting an upgrade is easier in this case, as the 
> user-space components like crash-utility/kexec-tools (or for that matter 
> any user-space tool which requires a page-table walk to determine 
> vaddr/paddr values) are indeed broken with this combination.

Huh? Nothing gets broken unless we go out of our way to break it. The 
point I'm making is that the format of vmcoreinfo *does not* need to 
change in order for the userspace tool to support LPA. There is no 
compatibility issue either way. If a user's machine doesn't support or 
make use of LPA, then yeah, they should absolutely not have to upgrade 
their tools for the sake of LPA regardless of what kernel they use.

> On the other hand, if a user a having a old kernel, CPU which doesn't 
> support LPA, but if we still want them to upgrade to a newer version of 
> user-space utility (with a upgrade fix note reading something like: "Add 
> 52-bit PA support"), surely that would not be an ideal case requiring an 
> upgrade as his underlying environment doesn't support the same.

I don't get why we would "still want them to upgrade" if there's no 
technical reason for them to do so. That sounds like the kind of crap 
that proprietary OS vendors pull :/

> That's what I meant when I said that we need to take care of the 
> backward compatibility also when we propose new code changes to 
> user-space packages.

And what I meant is that you can trivially update the userspace tools to 
support LPA entirely transparently, without requiring kernel changes or 
creating any compatibility issues in any direction.

Robin.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
