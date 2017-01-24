Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cW5XV-0000qD-Rv
 for kexec@lists.infradead.org; Tue, 24 Jan 2017 18:09:55 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0OI46Wk095060
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 13:09:32 -0500
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2865r02sjq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 24 Jan 2017 13:09:31 -0500
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 04:09:29 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F3B522BB0055
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 05:09:26 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0OI9Ikl19464242
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 05:09:26 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0OI8sTo001098
 for <kexec@lists.infradead.org>; Wed, 25 Jan 2017 05:08:54 +1100
Subject: Re: [PATCH v4 2/5] ia64: reuse append_elf_note() and final_note()
 functions
References: <148363729327.11570.6244765717789390817.stgit@hbathini.in.ibm.com>
 <148363740554.11570.4870634597647436827.stgit@hbathini.in.ibm.com>
 <87tw8umged.fsf@concordia.ellerman.id.au>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 24 Jan 2017 23:38:29 +0530
MIME-Version: 1.0
In-Reply-To: <87tw8umged.fsf@concordia.ellerman.id.au>
Message-Id: <145a745d-6035-d082-c088-432c7a918fcd@linux.vnet.ibm.com>
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
To: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-ia64@vger.kernel.org, kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, ebiederm@xmission.com, dyoung@redhat.com, vgoyal@redhat.com



On Friday 20 January 2017 11:17 AM, Michael Ellerman wrote:
> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>
>> Get rid of multiple definitions of append_elf_note() & final_note()
>> functions. Reuse these functions compiled under CONFIG_CRASH_CORE
>> Also, define Elf_Word and use it instead of generic u32 or the more
>> specific Elf64_Word.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>
>> Changes from v3:
>> * Dropped hard-coded values and used DIV_ROUND_UP().
>>
>> Changes from v2:
>> * Added a definition for Elf_Word.
>> * Used IA64 version of append_elf_note() and final_note() functions.
>>
>>
>>   arch/ia64/kernel/crash.c   |   22 ----------------------
>>   include/linux/crash_core.h |    4 ++++
>>   include/linux/elf.h        |    2 ++
>>   kernel/crash_core.c        |   34 ++++++++++++++--------------------
>>   kernel/kexec_core.c        |   28 ----------------------------
>>   5 files changed, 20 insertions(+), 70 deletions(-)
> Do the powerpc patches later in the series actually depend on this one?
> Or is this just an unrelated cleanup?
>
> As it is I can't merge the series until we at least get an ack on this
> from the ia64 folks.
>
> If you can just split this out as a separate patch that would make it a
> lot easier to get the rest merged.
>

Hi Michael,

append_elf_note() & final_note() functions were defined statically at 
three different places,
arch/powerpc/kernel/fadump.c being one of them. With my changes, I would 
need to add
a fourth static definition if I ignore this cleanup. So, I preferred to 
clean this up...

Let me ping IA64 folks one last time. Will do a respin without the 
cleanup if I don't get
any response from them by end of this week..

Thanks
Hari


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
