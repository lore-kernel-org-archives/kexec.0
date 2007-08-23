Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IO5XD-0005dH-Jr
	for kexec@lists.infradead.org; Thu, 23 Aug 2007 01:47:13 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7N5l3VO012865
	for <kexec@lists.infradead.org>; Thu, 23 Aug 2007 01:47:03 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7N5l3xp142604
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 23:47:03 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7N5l3sG031722
	for <kexec@lists.infradead.org>; Wed, 22 Aug 2007 23:47:03 -0600
Date: Thu, 23 Aug 2007 11:17:09 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: [PATCH 0/3] vmcoreinfo support for dump filtering
Message-ID: <20070823054709.GC365@in.ibm.com>
References: <20070822210838oomichi@mail.jp.nec.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070822210838oomichi@mail.jp.nec.com>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: Don Zickus <dzickus@redhat.com>, Neil Horman <nhorman@redhat.com>, Dan Aloni <da-x@monatomic.org>, Bernhard Walle <bwalle@suse.de>, kexec-ml <kexec@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Aug 22, 2007 at 09:08:38PM +0900, Ken'ichi Ohmichi wrote:
> 
> Hi Andrew,
> 
> This patch set frees the restriction that makedumpfile users should
> install a vmlinux file (including the debugging information) into
> each system.
> 
> makedumpfile command is the dump filtering feature for kdump.
> It creates a small dumpfile by filtering unnecessary pages for the
> analysis. To distinguish unnecessary pages, it needs a vmlinux file
> including the debugging information. These days, the debugging package
> becomes a huge file, and it is hard to install it into each system.
> 
> To solve the problem, kdump developers discussed it at lkml and kexec-ml.
> As the result, we reached the conclusion that necessary information
> for dump filtering (called "vmcoreinfo") should be embedded into the
> first kernel file and it should be accessed through /proc/vmcore
> during the second kernel.
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.0/1806.html) 
> 
> Dan Aloni created the patch set for the above implementation.
> (http://www.uwsg.iu.edu/hypermail/linux/kernel/0707.1/1053.html)
> 
> And I updated it for multi architectures and memory models.
> (http://lists.infradead.org/pipermail/kexec/2007-August/000479.html)
> 
> 
> PATCH SET:
> [1/3] [linux] Add vmcoreinfo
>   The patch is for linux-2.6.22.
>   The patch adds the vmcoreinfo data. Its address and size are output
>   to /sys/kernel/vmcoreinfo.
> 

Looks good to me.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
