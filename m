Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k11gz-0000bl-Nn
 for kexec@lists.infradead.org; Thu, 30 Jul 2020 06:05:26 +0000
Subject: Re: [RESEND PATCH v5 00/11] ppc64: enable kdump support for
 kexec_file_load syscall
References: <159579157320.5790.6748078824637688685.stgit@hbathini>
 <23911b9d-7534-031c-6f98-80f90439c834@redhat.com>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <df8f1d6f-d85b-f2fb-548b-ecdaddec311c@linux.ibm.com>
Date: Thu, 30 Jul 2020 11:35:07 +0530
MIME-Version: 1.0
In-Reply-To: <23911b9d-7534-031c-6f98-80f90439c834@redhat.com>
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
To: piliu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Kexec-ml <kexec@lists.infradead.org>, Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Vivek Goyal <vgoyal@redhat.com>, Laurent Dufour <ldufour@linux.ibm.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 28/07/20 8:02 am, piliu wrote:
> 
> 
> On 07/27/2020 03:36 AM, Hari Bathini wrote:
>> Sorry! There was a gateway issue on my system while posting v5, due to
>> which some patches did not make it through. Resending...
>>
>> This patch series enables kdump support for kexec_file_load system
>> call (kexec -s -p) on PPC64. The changes are inspired from kexec-tools
>> code but heavily modified for kernel consumption.
>>
>> The first patch adds a weak arch_kexec_locate_mem_hole() function to
>> override locate memory hole logic suiting arch needs. There are some
>> special regions in ppc64 which should be avoided while loading buffer
>> & there are multiple callers to kexec_add_buffer making it complicated
>> to maintain range sanity and using generic lookup at the same time.
>>
>> The second patch marks ppc64 specific code within arch/powerpc/kexec
>> and arch/powerpc/purgatory to make the subsequent code changes easy
>> to understand.
>>
>> The next patch adds helper function to setup different memory ranges
>> needed for loading kdump kernel, booting into it and exporting the
>> crashing kernel's elfcore.
>>
>> The fourth patch overrides arch_kexec_locate_mem_hole() function to
>> locate memory hole for kdump segments by accounting for the special
>> memory regions, referred to as excluded memory ranges, and sets
>> kbuf->mem when a suitable memory region is found.
>>
>> The fifth patch moves walk_drmem_lmbs() out of .init section with
>> a few changes to reuse it for setting up kdump kernel's usable memory
>> ranges. The next patch uses walk_drmem_lmbs() to look up the LMBs
>> and set linux,drconf-usable-memory & linux,usable-memory properties
>> in order to restrict kdump kernel's memory usage.
>>
>> The seventh patch updates purgatory to setup r8 & r9 with opal base
>> and opal entry addresses respectively to aid kernels built with
>> CONFIG_PPC_EARLY_DEBUG_OPAL enabled. The next patch setups up backup
>> region as a kexec segment while loading kdump kernel and teaches
>> purgatory to copy data from source to destination.
>>
>> Patch 09 builds the elfcore header for the running kernel & passes
>> the info to kdump kernel via "elfcorehdr=" parameter to export as
>> /proc/vmcore file. The next patch sets up the memory reserve map
>> for the kexec kernel and also claims kdump support for kdump as
>> all the necessary changes are added.
>>
>> The last patch fixes a lookup issue for `kexec -l -s` case when
>> memory is reserved for crashkernel.
>>
>> Tested the changes successfully on P8, P9 lpars, couple of OpenPOWER
>> boxes, one with secureboot enabled, KVM guest and a simulator.
>>
>> v4 -> v5:
>> * Dropped patches 07/12 & 08/12 and updated purgatory to do everything
>>    in assembly.

Hello Pingfan,

Sorry, I missed out on responding to this.


> I guess you achieve this by carefully selecting instruction to avoid
> relocation issue, right?

Yes. No far branching or reference to data from elsewhere.

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
