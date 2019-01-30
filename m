Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gowSh-0004Pr-IU
 for kexec@lists.infradead.org; Wed, 30 Jan 2019 20:27:57 +0000
Received: by mail-pg1-f194.google.com with SMTP id c25so322469pgb.4
 for <kexec@lists.infradead.org>; Wed, 30 Jan 2019 12:27:52 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: Expose PARange via ID_AA64MMFR0_EL1 and
 VARange via ID_AA64MMFR2_EL1
References: <1548709076-22317-1-git-send-email-bhsharma@redhat.com>
 <1548709076-22317-3-git-send-email-bhsharma@redhat.com>
 <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <e27040aa-4317-5406-e57e-d6eabed8f307@redhat.com>
Date: Thu, 31 Jan 2019 01:57:43 +0530
MIME-Version: 1.0
In-Reply-To: <cff44754-7fe4-efea-bc8e-4dde2277c821@arm.com>
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

Thanks for the review.

On 01/29/2019 03:44 PM, Suzuki K Poulose wrote:
> Hi,
> 
> On 28/01/2019 20:57, Bhupesh Sharma wrote:
>> ARMv8.2 architecture hardware extensions can support
>> upto 52-bit physical addresses (ARMv8.2-LPA) and 52-bit virtual
>> addresses (ARMv8.2-LVA).
>>
>> User-space utilities like 'makedumpfile' can try and use the getauxval()
>> function to retrieve the underlying PARange and VARange values
>> supported.
> 
> Why do we need VARange here ? This value could be different from the
> kernel VA. As for decoding the PTE, you could safely do the flip
> of the upper byte by checking the page size of 64K.

I shared the makedumpfile implementation (for decoding the PTE) just as 
an example, however there can be other user-space applications, for e.g 
a user-space application running with 48-bit kernel VA and 52-bit user 
space VA and requesting allocation in 'high' address via a 'hint' to 
mmap (See 
<http://lists.infradead.org/pipermail/kexec/2019-January/022389.html> 
for details).

As I mentioned in the reply to the 1/2 PATCH review, I can see only two 
methods to determine the underlying kernel support in such cases:

a). Read the CONFIG flags from .config, or

b). In absence of .config file on the system, read the system ID
registers like 'ID_AA64MMFR0_EL1' and 'ID_AA64MMFR2_EL1' and then make a
decision on whether to pass a hint to 'mmap'.

> What is the usecase for exposing the PARange ?

Again it's perfectly possible to use a 48-bit VA in kernel/user-space 
and 52-bit PA overall. This means that the user-space applications need 
to again depend on reading CONFIG file changes for reading the PARange 
and VARange values to determine the actual values set on the hardware 
before they can make a 'mmap' call.

Also one can use the VARange and PARange values (printed or returned as 
part of the user-space application code) to inform the overall calling 
benchmarkingtest-suite about the address space configuration for which 
the test-suite was executed.

>>
>> An example implementation can be via the 'Appendix I: Example' shown
>> in 'Documentation/arm64/cpu-feature-registers.txt'. A reference
>> 'makedumpfile' implementation which uses a similar approach is
>> available in [0].
>>
>> So, we expose these properties via 'FTR_NONSTRICT' and 'FTR_VISIBLE'
>> settings for 'ID_AA64MMFR0_PARANGE_SHIFT' and 'ID_AA64MMFR2_LVA_SHIFT'.
> 
> What is the rationale behind changing the feature to NONSTRICT ?

Yes, this seems like a left-over. Will fix in v2.

>>
>> [0]. 
>> https://github.com/bhupesh-sharma/makedumpfile/blob/9d7da4aad3efe79b448f48cc3454fcae46a316d6/arch/arm64.c#L499 
>>
> 
> Btw, if you are not using a 64K page size, the usage of the lva support
> feature could corrupt your PTE-> PHYS conversion, unless I am missing 
> something.

Fedora arm64 servers use 64K page size by default.

Also as a side note, perhaps the ABI example for the system id register 
access 
<https://www.kernel.org/doc/Documentation/arm64/cpu-feature-registers.txt> 
needs to be updated for ARMv8.2 (as it doesn't support ID_AA64MMFR2_EL1 
via get_cpu_ftr(). May be I can send a separate patch to address the same.

Please let me know your thoughts on the same.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
