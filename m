Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyIdY-0003Ed-7k
 for kexec@lists.infradead.org; Wed, 22 Jul 2020 17:34:37 +0000
Subject: Re: [PATCH v4 07/12] ppc64/kexec_file: add support to relocate
 purgatory
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com>
 <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com>
 <871rl4rxao.fsf@mpe.ellerman.id.au>
From: Hari Bathini <hbathini@linux.ibm.com>
Message-ID: <2037fa32-28be-5995-1c22-c8b01cafe088@linux.ibm.com>
Date: Wed, 22 Jul 2020 23:03:00 +0530
MIME-Version: 1.0
In-Reply-To: <871rl4rxao.fsf@mpe.ellerman.id.au>
Content-Language: en-US
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
To: Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>
Cc: kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>, Kexec-ml <kexec@lists.infradead.org>, Nayna Jain <nayna@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Eric Biederman <ebiederm@xmission.com>



On 22/07/20 9:55 am, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.ibm.com> writes:
>> Right now purgatory implementation is only minimal. But if purgatory
>> code is to be enhanced to copy memory to the backup region and verify
>> sha256 digest, relocations may have to be applied to the purgatory.
>> So, add support to relocate purgatory in kexec_file_load system call
>> by setting up TOC pointer and applying RELA relocations as needed.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> * Michael, can you share your opinion on the below:
>>     - https://lore.kernel.org/patchwork/patch/1272027/
>>     - My intention in cover note.
> 
> It seems like a lot of complexity for little benefit.
> 
> AFAICS your final purgatory_64.c is only 36 lines, and all it does is a
> single (open coded) memcpy().
> 
> It seems like we could write that in not many more lines of assembler
> and avoid all this code.

Hi Michael,

I am not sure if you would agree with me on this, but I am looking at the
purgatory code as work in progress. As mentioned in the cover note, I intend
to add log messaging, sha256 verification into purgatory. And also change it
to position independent executable after moving common purgatory code (sha256
verification) to arch-independent code.

When I initially took this up, I wanted to add all the above changes too, but
cut down on it, in the interest of time, first to get kdump (kexec -s -p)
working in v5.9 merge window.

But as the logic in patches 07/12 & 08/12 has been tested in kexec-tools code
a lot of times and there are unlikely to be any changes to them except for
__kexec_do_relocs() function (afaics), when -PIE would be used, I submitted them.
With patch 09/12, I tried for a change that uses relocations while is minimal
for now.

Would you prefer it to be absolutely minimal by dropping patches 7 & 8 for
now and writing the backup data copy code in assembler?

Thanks
Hari

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
