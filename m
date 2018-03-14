Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1evumw-0002ol-4b
 for kexec@lists.infradead.org; Wed, 14 Mar 2018 01:01:07 +0000
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2E0xm2P147221
 for <kexec@lists.infradead.org>; Tue, 13 Mar 2018 21:00:52 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gpseugeaa-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 13 Mar 2018 21:00:52 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 19:00:51 -0600
References: <20180306102303.9063-1-takahiro.akashi@linaro.org>
 <20180306102303.9063-3-takahiro.akashi@linaro.org>
 <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/7] kexec_file, x86,
 powerpc: factor out kexec_file_ops functions
In-reply-to: <20180308011303.GB2600@dhcp-128-65.nay.redhat.com>
Date: Tue, 13 Mar 2018 22:00:39 -0300
MIME-Version: 1.0
Message-Id: <87zi3b8o94.fsf@morokweng.localdomain>
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
To: Dave Young <dyoung@redhat.com>
Cc: linux-s390@vger.kernel.org, prudo@linux.vnet.ibm.com, bhe@redhat.com, mpe@ellerman.id.au, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org, vgoyal@redhat.com


Dave Young <dyoung@redhat.com> writes:

> On 03/06/18 at 07:22pm, AKASHI Takahiro wrote:
>> As arch_kexec_kernel_image_{probe,load}(),
>> arch_kimage_file_post_load_cleanup() and arch_kexec_kernel_verify_sig()
>> are almost duplicated among architectures, they can be commonalized with
>> an architecture-defined kexec_file_ops array. So let's factor them out.
>> 
>> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
>> Cc: Dave Young <dyoung@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kexec.h            |  2 +-
>>  arch/powerpc/kernel/kexec_elf_64.c          |  2 +-
>>  arch/powerpc/kernel/machine_kexec_file_64.c | 39 ++-----------------
>>  arch/x86/include/asm/kexec-bzimage64.h      |  2 +-
>>  arch/x86/kernel/kexec-bzimage64.c           |  2 +-
>>  arch/x86/kernel/machine_kexec_64.c          | 45 +---------------------
>>  include/linux/kexec.h                       | 13 +++----
>>  kernel/kexec_file.c                         | 60 +++++++++++++++++++++++++++--
>>  8 files changed, 71 insertions(+), 94 deletions(-)
>> 
>
> For this patch it also needs some review from powerpc people. 

FWIW:

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

Also, tested on a ppc64le KVM guest:

Tested-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
