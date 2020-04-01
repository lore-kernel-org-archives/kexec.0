Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJiDk-0001PG-5r
 for kexec@lists.infradead.org; Wed, 01 Apr 2020 18:36:13 +0000
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 031IYT62090968
 for <kexec@lists.infradead.org>; Wed, 1 Apr 2020 14:36:09 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 304mcbn78m-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Wed, 01 Apr 2020 14:36:09 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.ibm.com>;
 Wed, 1 Apr 2020 19:35:56 +0100
Subject: Re: [PATCHv4] powerpc/crashkernel: take "mem=" option into account
References: <48c1b852-28e0-9c46-cafa-7c5992f966a7@linux.ibm.com>
 <1585749644-4148-1-git-send-email-kernelfans@gmail.com>
From: Hari Bathini <hbathini@linux.ibm.com>
Date: Thu, 2 Apr 2020 00:06:01 +0530
MIME-Version: 1.0
In-Reply-To: <1585749644-4148-1-git-send-email-kernelfans@gmail.com>
Content-Language: en-US
Message-Id: <2bfddcda-1187-5718-ce13-0c30d25337a9@linux.ibm.com>
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
To: Pingfan Liu <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, kexec@lists.infradead.org



On 01/04/20 7:30 PM, Pingfan Liu wrote:
> 'mem=" option is an easy way to put high pressure on memory during some
> test. Hence after applying the memory limit, instead of total mem, the
> actual usable memory should be considered when reserving mem for
> crashkernel. Otherwise the boot up may experience OOM issue.
> 
> E.g. it would reserve 4G prior to the change and 512M afterward, if passing
> crashkernel="2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G", and
> mem=5G on a 256G machine.
> 
> This issue is powerpc specific because it puts higher priority on fadump
> and kdump reservation than on "mem=". Referring the following code:
>     if (fadump_reserve_mem() == 0)
>             reserve_crashkernel();
>     ...
>     /* Ensure that total memory size is page-aligned. */
>     limit = ALIGN(memory_limit ?: memblock_phys_mem_size(), PAGE_SIZE);
>     memblock_enforce_memory_limit(limit);
> 
> While on other arches, the effect of "mem=" takes a higher priority and pass
> through memblock_phys_mem_size() before calling reserve_crashkernel().
>> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Hari Bathini <hbathini@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: kexec@lists.infradead.org
> ---
> v3 -> v4: fix total_mem_sz based on adjusted memory_limit


Thanks for the update.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
