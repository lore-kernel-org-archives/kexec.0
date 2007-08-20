Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mailout1.samsung.com ([203.254.224.24])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IN5fj-00039M-5i
	for kexec@lists.infradead.org; Mon, 20 Aug 2007 07:43:53 -0400
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
	by mailout1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTP id <0JN200FQPLWJ0U@mailout1.samsung.com> for
	kexec@lists.infradead.org; Mon, 20 Aug 2007 20:43:31 +0900 (KST)
Received: from [107.108.71.71] by mmp1.samsung.com
	(iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
	with ESMTPA id <0JN2000FOLWOPO@mmp1.samsung.com> for
	kexec@lists.infradead.org; Mon, 20 Aug 2007 20:43:37 +0900 (KST)
Date: Mon, 20 Aug 2007 17:21:05 +0530
From: Indraneel <indraneel.m@samsung.com>
Subject: Re: Kdump for ARM (vmcore generation problem)
In-reply-to: <20070816030251.GA20860@in.ibm.com>
Message-id: <46C98029.2000800@samsung.com>
MIME-version: 1.0
References: <46C1AA1A.6050907@samsung.com> <20070816030251.GA20860@in.ibm.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: kexec@lists.infradead.org

Hi Vivek/Bernhard,

Vivek Goyal wrote:
> On Tue, Aug 14, 2007 at 06:41:54PM +0530, Indraneel wrote:
>> Hi,
>> I'm trying to make Kdump work for ARM. Till now i've managed to get the 
>> /dev/oldmem interface working for taking dumps. Now i want to get the 
>> /proc/vmcore interface working.
>> I'm unclear how to generate the elfcore headers required by routines in 
>> vmcore.c.
>>
> 
> Hi Indraneel,
> 
> kexec-tools in user space generates those headers. Have a loot at
> kexec-tools code.

Thanks for the lead. I'm looking into kexec-tools and trying to do 
changes for ARM. I'm unable to interpret one of the comments in 
kexec/crashdump-elf.c which says,
" The separate PT_LOAD program header is required either because the
   kernel is mapped at a different location than the rest of the
   physical memory or because we need to support relocatable kernels.
   Or both as on x86_64. "

Can you please provide some more clarification for this so that i can 
figure out whether a separate PT_LOAD header is required for ARM 
architecture as well (esp. the "kernel mapped to diff. loc. part of the 
comment").

TIA,
Indro

> 
> Thanks
> Vivek
> 
> 
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
