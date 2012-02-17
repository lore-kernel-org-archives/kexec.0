Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp06.in.ibm.com ([122.248.162.6])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RyGnE-0005NV-K0
 for kexec@lists.infradead.org; Fri, 17 Feb 2012 05:55:41 +0000
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Fri, 17 Feb 2012 11:25:35 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1H5tVJZ3137650
 for <kexec@lists.infradead.org>; Fri, 17 Feb 2012 11:25:31 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1H5tUTg000409
 for <kexec@lists.infradead.org>; Fri, 17 Feb 2012 16:55:30 +1100
Message-ID: <4F3DEBCF.8000201@in.ibm.com>
Date: Fri, 17 Feb 2012 11:25:27 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Josh Boyer <jwboyer@gmail.com>, kexec@lists.infradead.org, Kumar Gala <galak@kernel.crashing.org>

On 02/17/2012 06:02 AM, Atsushi Kumagai wrote:
> Hi, Suzuki
>
> On Thu, 16 Feb 2012 09:05:17 +0530
> "Suzuki K. Poulose"<suzuki@in.ibm.com>  wrote:
>
>> The series introduces an infrastructure to define platform specific
>> bits for page translation for PPC and PPC44x support for vmalloc
>> translation.
>>
>> This is similar to what we have implemented for Crash-utility.
>>
>> The patches are based makedumpfile-1.4.2 + PPC32 support patches
>> which is queued in for 1.4.3.
>>
>> ---
>>
>> Suzuki K. Poulose (4):
>>        [makedumpfile][ppc] PPC44x page translation definitions
>>        [makedumpfile][ppc] Define platform descriptors for page translation
>>        [makedumpfile][ppc] Generic vmalloc translation support
>>        [makedumpfile] Add read_string routine
>>
>>
>>   arch/ppc.c     |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>>   makedumpfile.c |   14 +++++++
>>   makedumpfile.h |   21 +++++++++++
>>   3 files changed, 139 insertions(+), 4 deletions(-)
>>
>> --
>> Suzuki Poulose
>
> Could you tell me what kind of data is stored in vmalloc region in PPC ?
> I want to estimate importance of your patches for makedumpfile.
I know at least the modules are loaded in the vmalloc'd region. I have
Cc'ed linux-ppc dev. We should be able to get enough info from the experts here.

Josh / Kumar / Others,

Could you please let us know your thoughts ?

Thanks

Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
