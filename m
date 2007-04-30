Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HiSaC-0001im-JP
	for kexec@lists.infradead.org; Mon, 30 Apr 2007 10:54:13 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l3U9oZHm028013
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 05:50:35 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3U9rdQ2169092
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 03:53:39 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3U9rdkt011687
	for <kexec@lists.infradead.org>; Mon, 30 Apr 2007 03:53:39 -0600
Date: Mon, 30 Apr 2007 15:23:34 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH] aacraid: fails to initialize after a  kexec operation
Message-ID: <20070430095334.GA17186@in.ibm.com>
References: <20070424084444.GC22742@in.ibm.com>
	<AE4F746F2AECFC4DA4AADD66A1DFEF0188AF97@otce2k301.adaptec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AE4F746F2AECFC4DA4AADD66A1DFEF0188AF97@otce2k301.adaptec.com>
Reply-To: vgoyal@in.ibm.com
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
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Kexec Mailing List <kexec@lists.infradead.org>, Judith Lebzelter <judith@linux-foundation.org>, linux-scsi@vger.kernel.org, "Darrick J. Wong" <djwong@us.ibm.com>

On Tue, Apr 24, 2007 at 09:21:35AM -0400, Salyzyn, Mark wrote:
> The system BIOS sets up the card's PCI configuration and there is code
> in the kernel that is capable of picking up some of the BIOS'
> information from the BIOS Data Space (not sure if it is actively
> collected in your configuration, you need a kernel flag to pick this
> up). On kexec this BIOS Data Space information is missing (?) and if
> there was any reconfiguration of the PCI space going on (I think only
> the Linux BIOS project does this), kexec will inherit it. This issue
> strikes me as a corrupted PCI configuration inherited in the kexec case,
> such corrupted PCI configurations could be a motherboard specific issue
> and can be related to the BIOS' initial setup for the initial kernel. At
> least that is my thought process in questioning the motherboard BIOS or
> hardware.
> 
> Another possibility is that after you have patched over the interrupt
> routing issues (a PCI configuration problem), the card has a foreign
> array, and the reset and reconfiguration is taking arrays offline. Add
> 'aacraid.commit=1' to force the foreign arrays to be accepted by the
> card.
> 

Hi Mark,

So aacraid.commit=1 and irqpoll combination has done the trick. I can
kexec/kdump into second kernel. I am using an IBM x366 series machine.
There is one array and three disks behind it.

Now few queries.

- What is the concept of foreign arrays? 
- Should we pass aacraid.commit=1 all the time or this is only for
  some special cases? What's the point in resetting an adapter if it
  does not online the array it is managing?
- For kexec, it calls the device shutdown routine (aac_shutdown) in this
  case. If this is the case for normal kexec (not kdump) adapter should
  not be reset?
- Still needs to be found out why PCI configuration is getting corrupted
  and why irq routing is not proper and irqpoll is required.
 
Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
