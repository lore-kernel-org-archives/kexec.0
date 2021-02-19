Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDFPu-0008A3-LO
 for kexec@lists.infradead.org; Fri, 19 Feb 2021 23:42:35 +0000
References: <20210219142552.762608-1-bauerman@linux.ibm.com>
 <5a28907e-9231-7a19-62ff-3ed1c0282642@linux.microsoft.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kexec_file: Restore FDT size estimation for
 kdump kernel
In-reply-to: <5a28907e-9231-7a19-62ff-3ed1c0282642@linux.microsoft.com>
Date: Fri, 19 Feb 2021 20:42:16 -0300
Message-ID: <878s7jy693.fsf@manicouagan.localdomain>
MIME-Version: 1.0
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
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: Rob Herring <robh@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Hari Bathini <hbathini@linux.ibm.com>


Lakshmi Ramasubramanian <nramas@linux.microsoft.com> writes:

> On 2/19/21 6:25 AM, Thiago Jung Bauermann wrote:
>
> One small nit in the function header (please see below), but otherwise the
> change looks good.
>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

Thanks for your review. I incorporated your suggestion and will send v2
shortly.

>> --- a/arch/powerpc/kexec/file_load_64.c
>> +++ b/arch/powerpc/kexec/file_load_64.c
>> @@ -927,37 +927,27 @@ int setup_purgatory_ppc64(struct kimage *image, const void *slave_code,
>>   }
>>     /**
>> - * kexec_fdt_totalsize_ppc64 - Return the estimated size needed to setup FDT
>> - *                             for kexec/kdump kernel.
>> - * @image:                     kexec image being loaded.
>> + * kexec_extra_fdt_size_ppc63 - Return the estimated size needed to setup FDT
>
> Perhaps change to
>
> "Return the estimated additional size needed to setup FDT for kexec/kdump
> kernel"?

That's better indeed. I also hadn't noticed that I changed ppc64 to
ppc63. Fixed as well.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
