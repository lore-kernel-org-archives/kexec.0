Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by casper.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bWgpL-0001DK-6r
 for kexec@lists.infradead.org; Mon, 08 Aug 2016 09:26:32 +0000
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u789OZe2040490
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 05:26:08 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbyqccm8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Mon, 08 Aug 2016 05:26:08 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 19:26:05 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C30782CE8054
 for <kexec@lists.infradead.org>; Mon,  8 Aug 2016 19:26:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u789Q2Fm27852898
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 19:26:02 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u789Q2q1005471
 for <kexec@lists.infradead.org>; Mon, 8 Aug 2016 19:26:02 +1000
Subject: Re: [RESEND][PATCH v2 2/2] powerpc/fadump: parse fadump reserve
 memory size based on memory range
References: <147025270324.29229.8322429758761407397.stgit@hbathini.in.ibm.com>
 <147025281599.29229.9962999599360876220.stgit@hbathini.in.ibm.com>
 <87h9b0g953.fsf@concordia.ellerman.id.au>
 <ef95923f-56b6-b4f1-94a2-555f7df32629@linux.vnet.ibm.com>
 <be3ba9ef-278e-63cd-8569-2d8228f83aac@linux.vnet.ibm.com>
 <87vazbskpe.fsf@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 14:55:59 +0530
MIME-Version: 1.0
In-Reply-To: <87vazbskpe.fsf@concordia.ellerman.id.au>
Message-Id: <94029a02-4357-ed77-5fb9-4ca3271e43ea@linux.vnet.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, rusty@rustcorp.com.au, ebiederm@xmission.com, vgoyal@redhat.com, linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>



On Monday 08 August 2016 02:26 PM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>> On Friday 05 August 2016 12:23 AM, Hari Bathini wrote:
>>> On Thursday 04 August 2016 03:15 PM, Michael Ellerman wrote:
>>>> The code already knows how to reserve 5% based on the size of the
>>>> machine's
>>>> memory, as long as no commandline parameter is passed. So why can't we
>>>> just use that logic?
>>> That is the default value reserved but not a good enough value for
>>> every case. It is a bit difficult to come up with a robust formula
>>> that works for every case as new kernel changes could make the
>>> values obsolete. But it won't be all that difficult to find values that
>>> work for different memory ranges for a given kernel version.
>>> Passing that as range based input with "fadump_reserve_mem"
>>> parameter would work for every memory configuration on a
>>> given system, which is what this patch is trying to provide..
>> You want me to add this to the changelog on respin?

Hi Michael,

> I'm not really convinced.
>
> Distros are going to want to specify a fixed set of values for different
> memory sizes, at least that's what I've seen in the past with kdump. So
> I don't see why we can't just do that in the kernel with a formula based
> on memory size, and maybe some other information.

Agreed. Such support would be great but this patch is adding support
for a new syntax for an existing parameter which should still be good
to have?

> Maybe the formula is more complicated than 5% of RAM, but it shouldn't
> be *that* much more complicated.

Depending on what all kernel versions that need support, this can
get ugly? I could be completely wrong though..

Thanks
Hari

> cheers
>
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
