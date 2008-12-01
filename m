Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L70ng-0007kf-7B
	for kexec@lists.infradead.org; Mon, 01 Dec 2008 04:54:24 +0000
Message-ID: <49336802.2020102@mxs.nes.nec.co.jp>
Date: Mon, 01 Dec 2008 13:28:50 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
References: <20081127160034.121f5911@hale.suse.de>	<492F465D.6000609@mxs.nes.nec.co.jp>
	<20081128083852.330bd44a@kopernikus.site>
In-Reply-To: <20081128083852.330bd44a@kopernikus.site>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0058192610=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============0058192610==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Thank you for the explanation.

Bernhard Walle wrote:
>>> This bug fixes the problem that on a 32 bit userland makedumpfile (as common
>>> on the PPC platform) the parsing of the 64 bit VMCOREINFO fails with:
>>>
>>>    # makedumpfile -c /home/sachin/dump/vmcore vmcore.filtered
>>>    read_vmcoreinfo_symbol: Invalid data in /tmp/vmcoreinfowVoyJK:
>>>    SYMBOL(mem_section)=c000000000bb4400
>>>
>>> We just need to assume that the symbols are always 'unsigned long long' (64 bit)
>>> instead of 'unsigned long' (native pointer size on Linux platforms).
>> I agree with this patch basically. But I have not tested kdump on PPC64
>> platform (PPC32 also) and I don't know it well. So may I ask a question ?
>>
>> For PPC64 kdump, is it common thing that makedumpfile runs on PPC32 ?
>> In other words, do you use PPC32 kernel as 2nd-kernel for PPC64 kdump ?
> 
> No. Both kernels are 64 bit. The system does not boot with a 32 bit
> kernel (it's not like x86-64 where the system is entirely i386
> compatible from the beginning).
> 
> But for openSUSE and SLES 9/SLES 10 at least -- that are the only
> distributions I know on PPC [1] --, the userland is 90 % ppc32 and only
> some small stuff is ppc64 (like an additional 64 bit C library and stuff
> that is absolutely needed to be 64 bit like crash since that's not yet
> capable of debugging 64 bit dumps on 32 bit).

I think it is better that makedumpfile for PPC64 is compiled with 64
bit like the crash utility, because I guess that PPC32 makedumpfile 
annot run with option '-d 2+' on PPC64 machine even if this patch is
merged. Could you please use makedumpfile compiled with 64 bit for
PPC64 ?


'unsigned long' is native pointer size on Linux platforms as you said,
and makedumpfile reads many pointers into 'unsigned long' variables by
readmem() function like the following:

 get_mm_flatmem(void)
 {
        unsigned long mem_map;

        if (!readmem(VADDR, SYMBOL(mem_map), &mem_map, sizeof mem_map)
            || !mem_map) {
                ERRMSG("Can't get the address of mem_map.\n");
                return FALSE;
        }

'unsigned long' of PPC32 is 32 bit, so PPC32 makedumpfile cannot read
64 bit pointer. If they will be changed to 'unsigned long long'(64 bit),
makedumpfile reads invalid area on 32 bit machine. Then this change is
not acceptable.


> Having that said, every tool that not needs to be 64 bit is a plus. 
> Some month ago I already sent patches to 'fix' makedumpfile for 64 bit
> kernels and you accepted them.

This patch is different purpose from the patch you sent some month ago:

 [PATCH] Fix vmcoreinfo generation on 32bit hosts for 64bit kernels
 http://lists.infradead.org/pipermail/kexec/2008-June/001945.html

The patch you sent some month ago is for generating the vmcoreinfo
file of PPC64 on PPC32 machine, but this patch is for executing PPC32
makedumpfile for PPC64 kdump. I accepted the former, but I don't like
the latter because of the above reason.


> [1] I'm not in the PPC team, so I don't know that platform very well,
>     either. And I personally don't like that approach (64 bit kernel,
>     32 bit userland) very much because it does cause trouble, but I
>     cannot make decisions. ;-)

You are right. This approach (64 bit kernel, 32 bit userland) causes
trouble, and I also don't like it. 


Thanks
Ken'ichi Ohmichi


--===============0058192610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0058192610==--
