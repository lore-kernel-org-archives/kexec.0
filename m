Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1I5agD-0005mk-HR
	for kexec@lists.infradead.org; Tue, 03 Jul 2007 06:12:02 +0100
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l635BcGX032586
	for <kexec@lists.infradead.org>; Tue, 3 Jul 2007 01:11:38 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l635BcFl262480
	for <kexec@lists.infradead.org>; Mon, 2 Jul 2007 23:11:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l635Bcx5029066
	for <kexec@lists.infradead.org>; Mon, 2 Jul 2007 23:11:38 -0600
Received: from bigbang2.in.ibm.com ([9.124.31.34])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l635BbVM029036
	for <kexec@lists.infradead.org>; Mon, 2 Jul 2007 23:11:37 -0600
Received: from bigbang2.in.ibm.com (localhost.localdomain [127.0.0.1])
	by bigbang2.in.ibm.com (Postfix) with ESMTP id 74573A8DBD
	for <kexec@lists.infradead.org>; Tue,  3 Jul 2007 10:42:29 +0530 (IST)
Received: (from maneesh@localhost)
	by bigbang2.in.ibm.com (8.13.1/8.13.1/Submit) id l635CSCj003301
	for kexec@lists.infradead.org; Tue, 3 Jul 2007 10:42:28 +0530
Date: Tue, 3 Jul 2007 10:42:28 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: ELF64 header on i386
Message-ID: <20070703051228.GA8394@in.ibm.com>
References: <20070702131541.GA6084@suse.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070702131541.GA6084@suse.de>
Reply-To: maneesh@in.ibm.com
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
To: kexec@lists.infradead.org

On Mon, Jul 02, 2007 at 03:15:41PM +0200, Bernhard Walle wrote:
> Hello,
> 
> why creates kexec-tools ELF64 headers per default on i386? Wouldn't it
> make more sense to look if a physical address exceeds the 32-bit limit
> and then switch to ELF64 automatically if the user doesn't have
> specified an option?
> 

I am aware of one issue, that gdb on i386 is not able to analyse ELF64 
formatted kdump though "crash" can. 

Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center,
IBM India Systems and Technology Lab, 
Bangalore, India

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
