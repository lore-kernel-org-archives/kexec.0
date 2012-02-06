Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp04.in.ibm.com ([122.248.162.4])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RuKXu-0000DN-Vj
 for kexec@lists.infradead.org; Mon, 06 Feb 2012 09:07:36 +0000
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <suzuki@in.ibm.com>;
 Mon, 6 Feb 2012 14:37:25 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1697Hgo3678248
 for <kexec@lists.infradead.org>; Mon, 6 Feb 2012 14:37:18 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1697H44027432
 for <kexec@lists.infradead.org>; Mon, 6 Feb 2012 20:07:17 +1100
Message-ID: <4F2F9843.9000108@in.ibm.com>
Date: Mon, 06 Feb 2012 14:37:15 +0530
From: "Suzuki K. Poulose" <suzuki@in.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v1 0/3][makedumpfile]Add support for  PPC32
References: <20120118100510.29422.93587.stgit@suzukikp.in.ibm.com>
 <20120119115852.588bf8bb.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120119115852.588bf8bb.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, usui@mxm.nes.nec.co.jp

On 01/19/2012 08:28 AM, Atsushi Kumagai wrote:

Atsushi-San,

> Hi Suzuki,
>
> On Wed, 18 Jan 2012 15:37:49 +0530
> "Suzuki K. Poulose"<suzuki@in.ibm.com>  wrote:
>
>> The following series implements makedumpfile support for PPC32.
>>
>> The implementation is heavily based on PPC64. This also introduces
>> cross build support which is required for Embedded PPC Boards.
>>
>> ---
>>
>> Suzuki K. Poulose (3):
>>        [makedumpfile] Add support for PPC32
>>        [ppc64] Rename the __powerpc__ macro to __powerpc64__ for PPC64
>>        [makedumpfile] Support building for cross build
>>
>>
>>   Makefile       |   26 ++++++++++++--
>>   README         |    5 +++
>>   arch/ppc.c     |  101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   makedumpfile.c |    4 +-
>>   makedumpfile.h |   28 +++++++++++++---
>>   5 files changed, 153 insertions(+), 11 deletions(-)
>>   create mode 100644 arch/ppc.c
>>
>> --
>> Suzuki Poulose


>
> Thank you for your patches.
> I will review them.

Did you get a chance to review my patches ?

Suzuki


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
