Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from linux.microsoft.com ([13.77.154.182])
 by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
 id 1lJod1-005oGn-56
 for kexec@lists.infradead.org; Wed, 10 Mar 2021 02:31:22 +0000
Subject: Re: [PATCH v2] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
References: <20210220005204.1417200-1-bauerman@linux.ibm.com>
 <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <7d0c6062-ca73-f183-110d-f5b75ae91d10@linux.microsoft.com>
Date: Tue, 9 Mar 2021 18:31:04 -0800
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJatxTwSbM8a0PB2ievO_fRFeYJ8ZtBN0pRfnEjSXyUkg@mail.gmail.com>
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
To: Rob Herring <robh@kernel.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kexec@lists.infradead.org, Hari Bathini <hbathini@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3/9/21 6:08 PM, Rob Herring wrote:

Hi Rob,

> On Fri, Feb 19, 2021 at 6:52 PM Thiago Jung Bauermann
> <bauerman@linux.ibm.com> wrote:
>>
>> Commit 2377c92e37fe ("powerpc/kexec_file: fix FDT size estimation for kdump
>> kernel") fixed how elf64_load() estimates the FDT size needed by the
>> crashdump kernel.
>>
>> At the same time, commit 130b2d59cec0 ("powerpc: Use common
>> of_kexec_alloc_and_setup_fdt()") changed the same code to use the generic
>> function of_kexec_alloc_and_setup_fdt() to calculate the FDT size. That
>> change made the code overestimate it a bit by counting twice the space
>> required for the kernel command line and /chosen properties.
>>
>> Therefore change kexec_fdt_totalsize_ppc64() to calculate just the extra
>> space needed by the kdump kernel, and change the function name so that it
>> better reflects what the function is now doing.
>>
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>>   arch/powerpc/include/asm/kexec.h  |  2 +-
>>   arch/powerpc/kexec/elf_64.c       |  2 +-
>>   arch/powerpc/kexec/file_load_64.c | 26 ++++++++------------------
>>   3 files changed, 10 insertions(+), 20 deletions(-)
> 
> I ended up delaying the referenced series til 5.13, but have applied
> it now. Can I get an ack from the powerpc maintainers on this one?
> I'll fixup the commit log to make sense given the commit id's aren't
> valid.

I checked the change applied in linux-next branch and also Device Tree's 
for-next branch - it looks like v1 of Thiago's patch has been applied. 
Could you please pick up the v2 patch?

thanks,
  -lakshmi



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
