Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtQ6N-0004Ti-6c
 for kexec@lists.infradead.org; Tue, 12 Feb 2019 04:55:26 +0000
Received: by mail-pg1-f194.google.com with SMTP id w7so646534pgp.13
 for <kexec@lists.infradead.org>; Mon, 11 Feb 2019 20:55:22 -0800 (PST)
Subject: Re: [PATCH] arm64, vmcoreinfo : Append 'MAX_USER_VA_BITS' and
 'MAX_PHYSMEM_BITS' to vmcoreinfo
References: <1548850991-11879-1-git-send-email-bhsharma@redhat.com>
 <239cdca4-1c7d-f236-f4a9-a0a3fe98f966@arm.com>
 <86c0dd9f-a55b-8ce8-69ca-893f63087d1a@redhat.com>
 <a646e38d-9351-e187-1571-c49d3558b164@redhat.com>
 <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <f4905b1c-c3f0-f5a1-193e-2997a0047b9c@redhat.com>
Date: Tue, 12 Feb 2019 10:25:15 +0530
MIME-Version: 1.0
In-Reply-To: <2d14484d-743e-080a-daf6-a07b0a659c3d@arm.com>
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
To: Robin Murphy <robin.murphy@arm.com>, James Morse <james.morse@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, kexec@lists.infradead.org, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, bhupesh.linux@gmail.com, linux-arm-kernel@lists.infradead.org

Hi Robin,

On 02/04/2019 09:01 PM, Robin Murphy wrote:
> On 04/02/2019 14:35, Bhupesh Sharma wrote:
> [...]
>>> Also hardcoding the PTE calculation to use the high address bit mask 
>>> always will break the backward compatibility with older kernels 
>>> (which don't support 52-bit address space extensions).
> 
> No it won't. There's no difference between an old kernel, a new kernel 
> on a CPU without ARMv8.2-LPA, or a new kernel on a CPU with ARMv8.2-LPA 
> in a system which happens to have less than 49 bits of physical memory 
> map - in all those cases the relevant bits are either RES0 or just 
> actually 0 in the PTE, so replacing 4 bits of zeros with 4 bits of other 
> zeros in the final physical address has no effect whatsoever other than 
> taking a couple of extra instructions to perform.

Right, but lets think this from a distribution user p-o-v. Why would a 
user with newer kernel and CPU which doesn't support ARMv8.2 LPA want to 
update a user-space utility? Well unless something is broken in the 
user-space. Requesting an upgrade is easier in this case, as the 
user-space components like crash-utility/kexec-tools (or for that matter 
any user-space tool which requires a page-table walk to determine 
vaddr/paddr values) are indeed broken with this combination.

On the other hand, if a user a having a old kernel, CPU which doesn't 
support LPA, but if we still want them to upgrade to a newer version of 
user-space utility (with a upgrade fix note reading something like: "Add 
52-bit PA support"), surely that would not be an ideal case requiring an 
upgrade as his underlying environment doesn't support the same.

That's what I meant when I said that we need to take care of the 
backward compatibility also when we propose new code changes to 
user-space packages.

Thanks,
Bhupesh

> If you're running a 64K page kernel on a system with an SMMU, note how 
> that's already been "broken" for nearly a year now ;)
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/iommu/io-pgtable-arm.c#n211 
> 
> 
> 
> Robin.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
