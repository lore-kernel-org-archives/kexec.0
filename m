Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1govqJ-0006Ir-JY
 for kexec@lists.infradead.org; Wed, 30 Jan 2019 19:48:19 +0000
Received: by mail-pl1-f193.google.com with SMTP id a14so281091plm.12
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2019 11:48:13 -0800 (PST)
Subject: Re: [PATCH 1/2] arm64: Expose address bits (physical/virtual) via
 cpuinfo
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-2-git-send-email-bhsharma@redhat.com>
 <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <8659c949-a588-387b-3cb6-1dd8ea86723e@redhat.com>
Date: Thu, 31 Jan 2019 01:18:05 +0530
MIME-Version: 1.0
In-Reply-To: <afa2417a-10d0-21f6-007f-e8eb7055f3d7@arm.com>
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
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, Steve.Capper@arm.com, catalin.marinas@arm.com, ard.biesheuvel@linaro.org, will.deacon@arm.com, bhupesh.linux@gmail.com, kexec@lists.infradead.org

Hi Suzuki,

Thanks for your review.

On 01/29/2019 03:39 PM, Suzuki K Poulose wrote:
> Hi Bupesh
> 
> On 28/01/2019 20:57, Bhupesh Sharma wrote:
>> With ARMv8.2-LVA and LPA architecture extensions, arm64 hardware which
>> supports these extensions can support upto 52-bit virtual and 52-bit
>> physical addresses respectively.
>>
>> Since at the moment we enable the support of these extensions via CONFIG
>> flags, e.g.
>>   - LPA via CONFIG_ARM64_PA_BITS_52, and
>>   - LVA via CONFIG_ARM64_FORCE_52BIT
>>
>> The easiest way a user can determine the physical/virtual
>> addresses supported on the hardware, is via the '/proc/cpuinfo'
>> interface.
> 
> Why do we need this information ?

Sorry for the delay in reply, but I wanted to collect as much 
information from our test teams as possible before replying to this thread.

So here is brief list of reasons, as to why we need this information in 
user-space:

1. This information is useful for a non-expert user, using Linux 
distributions (like Fedora) on different arm64 platforms. The default 
configuration (.config) will be the same for a distribution flavor and 
is supposed to work fine on all underlying arm64 platforms.

a). Now some of these underlying platforms may support ARMv8-8.2 
extension while others don't.

b). Users performing performance bench-marking on these platforms run 
benchmarks with different page-sizes and address ranges.

c). Right now they have no way to know, about the underlying VARange and 
PARange values other than reading the config file and search for the flags.

For e.g. lets consider the 'pg-table_tests' (See - 
<https://github.com/sanskriti-s/pg-table_tests>), which is used to test 
and verify 5-level page table behavior on x86_64 Linux. It requires 
determining if 5-level page tables are fully supported, for which it 
uses either 'Intel 'la57' cpu flag' in:

$ cat /proc/cpuinfo', or

$ grep CONFIG_X86_5LEVEL /boot/config-$(uname -r)
CONFIG_X86_5LEVEL=y

This test suite is easily modifiable for verifying 52-bit ARMv8.2-LVA 
support.

d). Now when running the above suite and sharing results, it might be 
that the .config file is not available or even in the case it is 
available the CONFIG flag settings in .config file are not intuitive to 
a non-expert user for arm64 (the example below is of 64K page size, 
48-bit kernel VA, 52-bit User space VA and 52-bit PA):

   CONFIG_ARM64_64K_PAGES=y
   CONFIG_ARM64_USER_VA_BITS_52=y
   CONFIG_ARM64_VA_BITS=48
   CONFIG_ARM64_PA_BITS_52=y
   CONFIG_ARM64_PA_BITS=52

Compare it with a single CONFIG_X86_5LEVEL=y config item for x86_64.

Also the cpu flag in '/proc/cpuinfo' may not hold any descriptive value 
for ARMv8.2 hardware.

2. So, its much easier in above cases to see and quote the output of '$ 
cat /proc/cpuinfo' instead, for example:

$ cat /proc/cpuinfo

<..snip..>
processor	: 31
<..snip..>
CPU architecture: 8
<..snip..>
address sizes	: 52 bits physical, 48 bits virtual

> Btw, this keeps coming up all the time and the answer to this approach is
> always no. We cannot break the "unwritten" ABI of /proc/cpuinfo, again.
> See :
> 
> https://patchwork.kernel.org/patch/8669301/

I understand your point, but from a user-space/command-line p-o-v we 
would ideally want an arm64 server to support most features that are 
already available on a x86_64 server (I guess that was the whole point 
of the SBSA server specifications - we want all arm64 servers to look 
and feel the same way in terms of user-experience).

Also right now there is an absence of a standard ABI between the 
user-space and kernel for exporting this information to the user-space, 
with two exceptions:

1. For vmcoreinfo specific user-space utilities (like makedumpfile and 
crash) I have proposed a couple of CONFIG flags to be added to the 
vmcoreinfo, so that user-space utilities can use the same (See 
<http://lists.infradead.org/pipermail/kexec/2019-January/022387.html> 
for details).

2. For other user-space utilities (especially those which make a 'mmap' 
call and pass an address hint to the get the kernel to provide a high 
address), I can see only two methods to determine the underlying kernel 
support:

a). Read the CONFIG flags from .config (as I captured some paragraphs 
above), or

b). In absence of .config file on the system, read the system ID 
registers like 'ID_AA64MMFR0_EL1' and 'ID_AA64MMFR2_EL1' (which PATCH 
2/2 of this series tries to enable from kernel side) and then make a 
decision on whether to pass a hint to 'mmap'.

It might be that I am missing other standard ABI mechanisms. If so, 
please point me to the same.

Thanks,
Bhupesh



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
