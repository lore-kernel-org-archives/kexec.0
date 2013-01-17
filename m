Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Tvlti-0001OE-32
 for kexec@lists.infradead.org; Thu, 17 Jan 2013 09:36:35 +0000
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 17 Jan 2013 19:30:27 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CBBCD2CE804A
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 20:36:25 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0H9aPr128704962
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 20:36:25 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0H9aPJB001177
 for <kexec@lists.infradead.org>; Thu, 17 Jan 2013 20:36:25 +1100
Message-ID: <50F7C617.4070300@linux.vnet.ibm.com>
Date: Thu, 17 Jan 2013 15:06:23 +0530
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: makedumpfile bug with ppc64 CONFIG_SPARSEMEM_EXTREME
References: <1268295784.3657868.1357852163361.JavaMail.root@redhat.com>
In-Reply-To: <1268295784.3657868.1357852163361.JavaMail.root@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, CAI Qian <caiqian@redhat.com>

On 01/11/2013 02:39 AM, Dave Anderson wrote:
> 
> 
> ----- Original Message -----
>>
>> Our QA group recently ran into a makedumpfile problem while
>> testing kdump/makedumpfile w/upstream 3.7.1 kernels, which
>> had to do with the filtering of pages on a 12GB ppc64 system.
>>
> ... [ cut ] ...
>>
>> I haven't checked why the original math fails in the case of the
>> ppc64 kernel, while it does not fail in a CONFIG_SPARSEMEM_EXTREME
>> x86_64 kernel, for example. (page size maybe?)  But obviously the
>> simpler dimemsion-check is a better way to do it.
>>
>> Of course, within the current constraints of makedumpfile, it's not
>> that easy.  Ideally the kernel could pass the configuration in
>> the vmcoreinfo with a VMCOREINFO_CONFIG(name).  But anyway, I'll leave
>> that up to you.
>>
>> Thanks,
>>   Dave
> 
> It's presumably being seen in 3.7.1 because of this commit:
> 
>   $ git log -p arch/powerpc/include/asm/sparsemem.h
>   commit 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4
>   Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>   Date:   Mon Sep 10 02:52:55 2012 +0000
> 
>       powerpc/mm: Add 64TB support
>     
>       Increase max addressable range to 64TB. This is not tested on
>       real hardware yet.
>     
>       Reviewed-by: Paul Mackerras <paulus@samba.org>
>       Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>       Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
>   diff --git a/arch/powerpc/include/asm/sparsemem.h b/arch/powerpc/include/asm/sparsemem.h
>   index 0c5fa31..f6fc0ee 100644
>   --- a/arch/powerpc/include/asm/sparsemem.h
>   +++ b/arch/powerpc/include/asm/sparsemem.h
>   @@ -10,8 +10,8 @@
>     */
>    #define SECTION_SIZE_BITS       24
> 
>   -#define MAX_PHYSADDR_BITS       44
>   -#define MAX_PHYSMEM_BITS        44
>   +#define MAX_PHYSADDR_BITS       46
>   +#define MAX_PHYSMEM_BITS        46
> 
>    #endif /* CONFIG_SPARSEMEM */
> 
>   $ git describe --contains 048ee0993ec8360abb0b51bdf8f8721e9ed62ec4
>   v3.7-rc1~108^2~32
>   $
>   
> Dave

Similar issue was seen on s390x last year
(http://lists.infradead.org/pipermail/kexec/2011-December/005905.html).
The change in
MAX_PHYSMEM_BITS define in kernel causes sparsemem extreme check to fail
in makedumpfile. This needs to be fixed in the same way as it was on
s390x. Will post a fix patch for makedumpfile after testing it on
upstream kernel.

Thanks,
-Mahesh.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
