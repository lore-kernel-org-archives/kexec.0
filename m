Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hVM1E-00056o-4M
 for kexec@lists.infradead.org; Mon, 27 May 2019 20:14:54 +0000
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x4RKBsn3036912
 for <kexec@lists.infradead.org>; Mon, 27 May 2019 16:14:49 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2srkvx64u9-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 27 May 2019 16:14:49 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.ibm.com>;
 Mon, 27 May 2019 21:14:48 +0100
References: <20190522220158.18479-1-bauerman@linux.ibm.com>
 <459lBd53mCz9sBr@ozlabs.org>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Fix loading of kernel + initramfs with
 kexec_file_load()
In-reply-to: <459lBd53mCz9sBr@ozlabs.org>
Date: Mon, 27 May 2019 17:14:17 -0300
MIME-Version: 1.0
Message-Id: <87pno3psdi.fsf@morokweng.localdomain>
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
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>


Michael Ellerman <patch-notifications@ellerman.id.au> writes:

> On Wed, 2019-05-22 at 22:01:58 UTC, Thiago Jung Bauermann wrote:
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
>> Reviewed-by: Dave Young <dyoung@redhat.com>
>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/8b909e3548706cbebc0a676067b81aad

Thanks!!

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
