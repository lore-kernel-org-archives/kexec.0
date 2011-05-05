Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by canuck.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1QHuow-0003aX-SD
	for kexec@lists.infradead.org; Thu, 05 May 2011 09:26:08 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p451qlne007284
	for <kexec@lists.infradead.org>; Wed, 4 May 2011 19:52:47 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p459R59Y121944
	for <kexec@lists.infradead.org>; Thu, 5 May 2011 03:27:05 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p453PUvx015199
	for <kexec@lists.infradead.org>; Wed, 4 May 2011 21:25:30 -0600
Date: Thu, 5 May 2011 14:55:55 +0530
From: Srivatsa Vaddagiri <vatsa@linux.vnet.ibm.com>
Subject: Re: [RFC] Kdump and memory error handling
Message-ID: <20110505092555.GA17414@linux.vnet.ibm.com>
References: <20110504193509.GA5342@in.ibm.com>
	<20110504203914.GC1737@one.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110504203914.GC1737@one.firstfloor.org>
Reply-To: vatsa@linux.vnet.ibm.com
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
Cc: "Luck, Tony" <tony.luck@intel.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, kexec@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "K.Prasad" <prasad@linux.vnet.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, May 04, 2011 at 10:39:14PM +0200, Andi Kleen wrote:
> Handle dumps of corrupted memory regresions:
> 
> http://git.kernel.org/?p=linux/kernel/git/ak/linux-mce-2.6.git;a=shortlog;h=refs/heads/mce/crashdump

What happens when mce is disabled and capture kernel reads corrupted memory? 
Does that result in dump having erroneous data in dump?

- vatsa

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
