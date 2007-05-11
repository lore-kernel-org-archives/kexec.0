Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HmMf9-0001Mz-IH
	for kexec@lists.infradead.org; Fri, 11 May 2007 00:23:28 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4B4NIaR028950
	for <kexec@lists.infradead.org>; Fri, 11 May 2007 00:23:18 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4B4NIWl559652
	for <kexec@lists.infradead.org>; Fri, 11 May 2007 00:23:18 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4B4NIbB018420
	for <kexec@lists.infradead.org>; Fri, 11 May 2007 00:23:18 -0400
Date: Fri, 11 May 2007 09:53:00 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kexec and kdb
Message-ID: <20070511042300.GA16944@in.ibm.com>
References: <20070510025553.GD30920@verge.net.au>
	<4E022DDAB8F45741914ACD6EDFE2309B041EAD74@BIGFOOT.kazeon.local>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E022DDAB8F45741914ACD6EDFE2309B041EAD74@BIGFOOT.kazeon.local>
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
To: Preetesh Parekh <preetesh@kazeon.com>
Cc: kexec@lists.infradead.org

On Thu, May 10, 2007 at 03:10:16PM -0700, Preetesh Parekh wrote:
> Hi,
> 
> I have a question about kexec and kdb. Please advice or point me to the
> right mailing list that can answer this.
> 
> I have a linux 2.6.20 kernel (patched with kdb patches) on i686 system.
> I have setup a crash kernel using "kexec -p" command which is working
> very well. I tested this by triggering a crash by using "echo c >
> /proc/sysrq-trigger" command. 
> 
> The requirement is to allow kdb to invoke first after the kernel crash
> which is not happening now (The system directly gets booted with the
> dump kernel). 
> 

crash_kexec() is the entry point for dump capture start process. I think
before that you need to put the KDB entry point so that upon a crash
control first goes to kdb.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
