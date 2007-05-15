Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HnrsJ-0006mJ-Nj
	for kexec@lists.infradead.org; Tue, 15 May 2007 03:55:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4F6rFra000984
	for <kexec@lists.infradead.org>; Tue, 15 May 2007 02:53:15 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4F7t4aM559408
	for <kexec@lists.infradead.org>; Tue, 15 May 2007 03:55:04 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4F7t3Os003823
	for <kexec@lists.infradead.org>; Tue, 15 May 2007 03:55:04 -0400
Date: Tue, 15 May 2007 13:24:50 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kexec and kdb
Message-ID: <20070515075450.GD8544@in.ibm.com>
References: <20070511042300.GA16944@in.ibm.com>
	<4E022DDAB8F45741914ACD6EDFE2309B041EB5E9@BIGFOOT.kazeon.local>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4E022DDAB8F45741914ACD6EDFE2309B041EB5E9@BIGFOOT.kazeon.local>
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

On Mon, May 14, 2007 at 04:20:29PM -0700, Preetesh Parekh wrote:
> Hi Vivek,
> 
> I did modify "arch/i386/kernel/traps.c" file at 2 places as per your
> suggestion but still problem is not solved. Please let us know.
> 

This should have worked. What method are you using to simulate a crash.
If you are using "echo c > /proc/sysrq-trigger" then you also need
to modify drivers/char/sysrq.c file.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
