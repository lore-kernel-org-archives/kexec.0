Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hTfZu-0002Hg-Kv
 for kexec@lists.infradead.org; Thu, 23 May 2019 04:43:44 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4N4bQ2s024753
 for <kexec@lists.infradead.org>; Thu, 23 May 2019 00:43:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2snkcqtp0c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Thu, 23 May 2019 00:43:41 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Thu, 23 May 2019 05:43:40 +0100
References: <20190522220158.18479-1-bauerman@linux.ibm.com>
 <20190523032302.GD8174@dhcp-128-65.nay.redhat.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with
 kexec_file_load()
In-reply-to: <20190523032302.GD8174@dhcp-128-65.nay.redhat.com>
Date: Thu, 23 May 2019 01:43:29 -0300
MIME-Version: 1.0
Message-Id: <87zhndzspa.fsf@morokweng.localdomain>
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
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, linuxppc-dev@lists.ozlabs.org


Dave Young <dyoung@redhat.com> writes:

> On 05/22/19 at 07:01pm, Thiago Jung Bauermann wrote:
>> Commit b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
>> changed kexec_add_buffer() to skip searching for a memory location if
>> kexec_buf.mem is already set, and use the address that is there.
>> 
>> In powerpc code we reuse a kexec_buf variable for loading both the kernel
>> and the initramfs by resetting some of the fields between those uses, but
>> not mem. This causes kexec_add_buffer() to try to load the kernel at the
>> same address where initramfs will be loaded, which is naturally rejected:
>> 
>>   # kexec -s -l --initrd initramfs vmlinuz
>>   kexec_file_load failed: Invalid argument
>> 
>> Setting the mem field before every call to kexec_add_buffer() fixes this
>> regression.
>> 
>> Fixes: b6664ba42f14 ("s390, kexec_file: drop arch_kexec_mem_walk()")
>> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
>> ---
>>  arch/powerpc/kernel/kexec_elf_64.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
