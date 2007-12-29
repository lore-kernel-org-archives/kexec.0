Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1J8UDg-0000bs-BF
	for kexec@lists.infradead.org; Sat, 29 Dec 2007 05:26:55 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id lBT5QiwC031412
	for <kexec@lists.infradead.org>; Sat, 29 Dec 2007 10:56:44 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBT5QiWD1142944
	for <kexec@lists.infradead.org>; Sat, 29 Dec 2007 10:56:44 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id lBT5QiY6007727
	for <kexec@lists.infradead.org>; Sat, 29 Dec 2007 05:26:44 GMT
Date: Sat, 29 Dec 2007 10:56:38 +0530
From: Dhaval Giani <dhaval@linux.vnet.ibm.com>
Subject: Re: kexec refuses to boot latest -mm
Message-ID: <20071229052638.GA17426@linux.vnet.ibm.com>
References: <20071228124532.GB32643@linux.vnet.ibm.com>
	<20071228195445.GA6245@hmsendeavour.rdu.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071228195445.GA6245@hmsendeavour.rdu.redhat.com>
Reply-To: Dhaval Giani <dhaval@linux.vnet.ibm.com>
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
To: Neil Horman <nhorman@redhat.com>
Cc: hbabu@us.ibm.com, kexec@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, vgoyal@redhat.com

On Fri, Dec 28, 2007 at 02:54:45PM -0500, Neil Horman wrote:
> On Fri, Dec 28, 2007 at 06:15:32PM +0530, Dhaval Giani wrote:
> > Hi Vivek,
> > 
> > I can't seem to get the latest -mm (2.6.24-rc6-mm1) to boot with
> > kexec. It just gets stuck at "Starting new kernel".
> > 
> > It does boot normally when booted as the first kernel.
> > 
> > Any hints debugging? (x86 architecture)
> > 
> > -- 
> > regards,
> > Dhaval
> > 
> Out of curiosity, how are you booting the kexec kernel?  Are you doing a kexec
> -l, or a kexec -p, followed by a system panic?  If its the later, what are you
> doing to panic the system?  sysrq-c, custom module executing explicit
> crash-code, hang followed by nmi panic?
> 

kexec -l, followed by a normal reboot.

-- 
regards,
Dhaval

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
