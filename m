Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S0WKc-0001V6-Az
 for kexec@lists.infradead.org; Thu, 23 Feb 2012 10:55:28 +0000
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <arunabal@linux.vnet.ibm.com>;
 Thu, 23 Feb 2012 10:39:06 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1NAbVjH2486290
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 21:37:31 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1NAgo1u006805
 for <kexec@lists.infradead.org>; Thu, 23 Feb 2012 21:42:50 +1100
Message-ID: <4F461828.8020601@linux.vnet.ibm.com>
Date: Thu, 23 Feb 2012 16:12:48 +0530
From: Aruna Balakrishnaiah <arunabal@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Fix segmentation fault for makedumpfile -x/--split
References: <20120131102456.17966.37854.stgit@aruna-ThinkPad-T420>
 <20120201131518.7764c710.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120223183505.2ab30cfd.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <20120223183505.2ab30cfd.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Cc: tachibana@mxm.nes.nec.co.jp, kexec@lists.infradead.org, aruna@linux.vnet.ibm.com

On Thursday 23 February 2012 03:05 PM, Atsushi Kumagai wrote:
Hi Atsushi,

> Hi Aruna,
>
> On Wed, 1 Feb 2012 13:15:18 +0900
> Atsushi Kumagai<kumagai-atsushi@mxc.nes.nec.co.jp>  wrote:
>
>> Hi Aruna,
>>
>> On Tue, 31 Jan 2012 15:56:33 +0530
>> Aruna Balakrishnaiah<aruna@linux.vnet.ibm.com>  wrote:
>>
>>> The patch fixes the segmentation fault issue of makedumpfile when a
>>> user specifies an invalid file name with -x/--split option.
>>> The patch takes care of such a scenario by setting .find_debuginfo to
>>> a function pointer which returns -1 and throws error messages against
>>> invalid vmlinux file input. With a valid vmlinux file .find_debuginfo
>>> was never invoked since the absolute path of debuginfo was known by the
>>> time we call init_dwarf_info.
>>>
>>> Signed-off-by: Aruna Balakrishnaiah<aruna@linux.vnet.ibm.com>
>>> ---
>>>   dwarf_info.c |   25 +++++++++++++++++++++++++
>>>   1 files changed, 25 insertions(+), 0 deletions(-)
> I'm reviewing your patch and it looks good.
>
> However, I can't guess that the segmentation fault caused
> by --split option because --split option doesn't require an argument.
>
> Would you tell me the case that you thought.
This is the case,

makedumpfile --split -x /boot/vmlinuz vmcore vm1 vm2

when used compressed vmlinux with -x.

Thanks,
Aruna


> Thanks
> Atsushi Kumagai
>


-- 
Regards,
Aruna Balakrishnaiah<aruna@linux.vnet.ibm.com>
Linux Technology Center,
IBM India Systems and Technology Lab


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
