Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140])
	by bombadil.infradead.org with esmtps (Exim 4.69 #1 (Red Hat Linux))
	id 1NDcGn-0001yo-CY
	for kexec@lists.infradead.org; Thu, 26 Nov 2009 11:12:21 +0000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nAQBCEB3006409
	for <kexec@lists.infradead.org>; Thu, 26 Nov 2009 22:12:14 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAQBCDTX1896702
	for <kexec@lists.infradead.org>; Thu, 26 Nov 2009 22:12:13 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAQBCDjS008825
	for <kexec@lists.infradead.org>; Thu, 26 Nov 2009 22:12:13 +1100
Message-ID: <4B0E628A.9070009@in.ibm.com>
Date: Thu, 26 Nov 2009 16:42:10 +0530
From: "M. Mohan Kumar" <mohan@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Reserve memory for kdump kernel within RMO region
References: <20091125131747.GA28857@in.ibm.com> <4B0D7CF4.8040402@bwalle.de>
In-Reply-To: <4B0D7CF4.8040402@bwalle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bernhard@bwalle.de>
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, kexec@lists.infradead.org, ppcdev <linuxppc-dev@ozlabs.org>

On 11/26/2009 12:22 AM, Bernhard Walle wrote:
> M. Mohan Kumar schrieb:
>> Reserve memory for kdump kernel within RMO region
>>
>> When the kernel size exceeds 32MB(observed with some distros), memory
>> for kdump kernel can not be reserved as kdump kernel base is assumed to
>> be 32MB always. When the kernel has CONFIG_RELOCATABLE option enabled,
>> provide the feature to reserve the memory for kdump kernel anywhere in
>> the RMO region.
>

Hi Bernhard,

> Correct me if I'm wrong, but: CONFIG_RELOCATABLE is for the kernel that
> gets loaded as crashkernel, not for the kernel that loads the
> crashkernel. So it would be perfectly fine that a kernel that has not
> CONFIG_RELOCATABLE set would load another kernel that has
> CONFIG_RELOCATABLE set on an address != 32 M.

No, with relocatable option, the same kernel is used as both production 
and kdump kernel. If the kernel is not relocatable, kdump kernel can be 
loaded *only at* 32MB. So if a kernel has RELOCATABLE option enabled and 
by chance if the production kernel size is beyond 32MB, current code 
will not load the kdump kernel at 32MB as current kernel overlaps with 
kdump kernel region. So if the kernel has RELOCATABLE option, we could 
reserve memory for kdump kernel within RMO region.

>
> So it would be part of the command line to determine whether a fixed or
> a variable address is used. The system configuration (or the admin)
> knows both: if the kernel that should be loaded is relocatable (can be
> detected with the x86 bzImage header or with the ELF type for vmlinux)
> and it can also influence the boot command line.
>
> To sum it up: I'm not against reserving it anywhere, I'm only against
> making it dependent on CONFIG_RELOCATABLE which has another function.
>
>
>
> Regards,
> Bernhard
>
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
