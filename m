Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QJTR7-0003y5-Ed
	for kexec@lists.infradead.org; Mon, 09 May 2011 16:35:58 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp09.in.ibm.com (8.14.4/8.13.1) with ESMTP id p49GUxcG009320
	for <kexec@lists.infradead.org>; Mon, 9 May 2011 22:00:59 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p49GZjYe4288632
	for <kexec@lists.infradead.org>; Mon, 9 May 2011 22:05:45 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p49GZjXf011369
	for <kexec@lists.infradead.org>; Tue, 10 May 2011 02:35:45 +1000
Date: Mon, 9 May 2011 22:05:40 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Bug] Kdump does not work when panic triggered due to MCE
Message-ID: <20110509163540.GA1963@in.ibm.com>
References: <20110506165412.GB2719@in.ibm.com>
	<20110506173825.GK11636@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110506173825.GK11636@one.firstfloor.org>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andi Kleen <andi@firstfloor.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Vivek Goyal <vgoyal@redhat.com>, ying.huang@intel.com

On Fri, May 06, 2011 at 07:38:25PM +0200, Andi Kleen wrote:
> > Has anybody tested this before? Or have found kdump working when fatal
> > MCEs have actually occurred?
> 
> Ying did some testing. mce-test has test cases for kdump.
> 

We'd be glad to hear about any successful testcases with recent kernels.
My manual testing was quite similar to what the LTP kdump testcase would
do i.e. configure kdump service, trigger crash through
/proc/sysrq-trigger and watchout for kdump....but as you could see in
the logs, that did not happen.

> My guess is you injected the error into some area used by the kexec
> code or boot up path of the kexec kernel.
> 
> -Andi

The logs did not suggest that the second kernel was booted into. The
"Rebooting in ... seconds" message appeared from the first kernel. I
tried the kdump testcase in atleast two dissimilar machines but with
the same results, so it is not clear if the kexec code was affected by
the MCE injection in both the cases.

Thanks,
K.Prasad


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
