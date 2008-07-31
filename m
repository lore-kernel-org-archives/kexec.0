Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KOVLO-00071O-9e
	for kexec@lists.infradead.org; Thu, 31 Jul 2008 10:25:14 +0000
Message-Id: <48919306.80103@mxs.nes.nec.co.jp>
Date: Thu, 31 Jul 2008 19:25:10 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>
	<20080731104726.035850be@halley.suse.de>
In-Reply-To: <20080731104726.035850be@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1185957872=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============1185957872==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-07-31 10:46]:
>> Bernhard Walle wrote:
>>> After debugging that, I didn't find an error code. That address is in
>>> fact the beginning of the mem_map of that node, and is in fact not
>>> mapped (I verified that in crash).
>>>
>>> With an older kernel and an older makedumpfile it succeeds.
>> I'd like to know whether this problem is due to the makedumpfile
>> regression or either the unsupported kernel. Could you please
>> fill the following items ?
>  
> * Problematic condition
>   kernel version: 2.6.26
>   makedumpfile version: 1.2.7
> 
> * Successful condition
>   kernel version: 2.6.16.60 (SLES kernel)
>   makedumpfile version: 1.1.4 (SLES 10 SP2 version, but in fact that is
>                                1.1.4 although -v displays something
>                                different ;-))
>
>> And could you please test the combination of successful kernel
>> and problematic makedumpfile(1.2.7) ?
> 
> That works. Seems to be some kernel change.

Thank you for quick response.

I tried to reproduce this problem on my machine by using an ia64 linux-2.6.26
discontigmem kernel, but it could not do it. makeudmpifle did not fail.
I want to know whether this problem depends on the kernel or either the machine.
Could you send me the kernel .config file ?


Thanks
Ken'ichi Ohmichi


--===============1185957872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1185957872==--
