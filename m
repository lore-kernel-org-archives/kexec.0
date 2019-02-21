Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwr5T-0001j1-W1
 for kexec@lists.infradead.org; Thu, 21 Feb 2019 16:20:41 +0000
Received: by mail-pg1-f194.google.com with SMTP id q206so13926540pgq.4
 for <kexec@lists.infradead.org>; Thu, 21 Feb 2019 08:20:39 -0800 (PST)
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
 <bed51e6e-3dcb-8e07-1d31-9d81bfca20e5@arm.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568504@BPXM09GP.gisp.nec.co.jp>
 <37ed4c14-e4b9-49c0-4816-c289ce65fd76@arm.com>
 <CACi5LpN6gVy4gCTYLGRiWW1VNGrVc-+Ykn919LKsO2bP-v1NHw@mail.gmail.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
From: Bhupesh Sharma <bhsharma@redhat.com>
Message-ID: <891eaf5a-aede-364d-6465-832e377c3e29@redhat.com>
Date: Thu, 21 Feb 2019 21:50:30 +0530
MIME-Version: 1.0
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC03568A9F@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "lijiang@redhat.com" <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, Steve Capper <Steve.Capper@arm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, James Morse <james.morse@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>, Borislav Petkov <bp@alien8.de>, "anderson@redhat.com" <anderson@redhat.com>, Dave Young <dyoung@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kazu,

On 02/20/2019 02:17 AM, Kazuhito Hagio wrote:
> Hi Bhupesh,
> 
> -----Original Message-----
>> I am not sure you got a chance to look at the two regression cases I
>> reported here:
>> <http://lists.infradead.org/pipermail/kexec/2019-February/022449.html>
>>
>> Unfortunately the above suggestion doesn't provide any fix for
>> ARMv8.2-LPA regression (see text under heading '
>> (1). Regression Case 1 (ARMv8.2-LPA enabled kernel)')
> 
> As for MAX_PHYSMEM_BITS, I realized that ppc64 makedumpfile can detect
> it because there is only one SECTION_SIZE_BITS for ppc64. I think we
> can use the same way as set_ppc64_max_physmem_bits() does also for
> arm64 for now. I'm going to write it for kernels not having
> NUMBER(MAX_PHYSMEM_BITS) in vmcoreinfo.

I see two drawbacks with the above approach:

a). This means that other user-space tools like crash-utility would 
still be broken and would probably need to find MAX_PHYSMEM_BITS for 
arm64 via a similar (hack'ish ?) approach.

b). I am looking at the makedumpfile code for 'MAX_PHYSMEM_BITS' 
determination for two archs as an example:

ppc
---

int
set_ppc64_max_physmem_bits(void)
{
         long array_len = ARRAY_LENGTH(mem_section);
         /*
          * The older ppc64 kernels uses _MAX_PHYSMEM_BITS as 42 and the
          * newer kernels 3.7 onwards uses 46 bits.
          */

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG ;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_3_7;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_19;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_4_20;
         if ((array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT_EXTREME()))
                 || (array_len == (NR_MEM_SECTIONS() / 
_SECTIONS_PER_ROOT())))
                 return TRUE;

         return FALSE;
}

x86_64:
------

int
get_versiondep_info_x86_64(void)
{
     /*
      * On linux-2.6.26, MAX_PHYSMEM_BITS is changed to 44 from 40.
      */
     if (info->kernel_version < KERNEL_VERSION(2, 6, 26))
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_ORIG;
     else if (info->kernel_version < KERNEL_VERSION(2, 6, 31))
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_26;
     else if(check_5level_paging())
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_5LEVEL;
     else
         info->max_physmem_bits  = _MAX_PHYSMEM_BITS_2_6_31;

     ...
}

Looking at the above, two questions come to my mind:

- Do we really need all the above complexity in user-space code, to hoop 
across various kernel versions and perform allocations for something 
that can be so easily exported via vmcoreinfo? Also we need to see how 
portable is the above code for a new kernel version - IMO, it will need 
another fix patch when we update to a new kernel version in near future.

- Also do we need to replicate the above implementations across 
user-space tools when they can also utilize the vmcoreinfo information 
to determine the PA_BITS range without any additional arch/kernel 
version specific details as the single point of obtaining this 
information from the kernel?

So, in view of the above, I would still advocate that we use a 
vmcoreinfo export for 'MAX_PHYSMEM_BITS' as well to have a uniform 
interface for the same across all user-land applications.

Thanks,
Bhupesh


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
