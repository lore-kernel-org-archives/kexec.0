Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I89Kb-0000oF-FC
	for kexec@lists.infradead.org; Tue, 10 Jul 2007 02:36:18 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6A6aFhJ021776
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 02:36:15 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6A6aFvK413524
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 02:36:15 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6A6aFdq008228
	for <kexec@lists.infradead.org>; Tue, 10 Jul 2007 02:36:15 -0400
Date: Tue, 10 Jul 2007 12:06:24 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: Determine version of kernel that produced vmcore
Message-ID: <20070710063624.GB5471@in.ibm.com>
References: <20070706132814.GA7079@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070706132814.GA7079@suse.de>
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
To: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bernhard Walle <bwalle@suse.de>

On Fri, Jul 06, 2007 at 03:28:14PM +0200, Bernhard Walle wrote:
> Hello,
> 
> does anybody know a _reliable_ way to determine the version the kernel
> that produced a vmcore file? This means not scanning for a specific
> string or something like that which can fail on random memory.
> 
> Would it make sense to add a ELF PT_NOTE section in the vmcore?
> 

To me it makes sense to append an ELF NOTE to vmcore which can uniquely
associate that vmcore with a particular vmlinux file (Some string
equivalent to the output of uname -a).

Interesting thing is that to find version of vmlinux, you will still be
doing <string | grep "some pattern">. Probably then we should append an
ELF note to vmlinux file also?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
