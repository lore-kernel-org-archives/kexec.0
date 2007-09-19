Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IXqdk-0005C0-4S
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 04:54:20 +0100
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8J3rN8r004747
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 23:53:23 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8J3rNhC400968
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 21:53:23 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8J3rMr8006974
	for <kexec@lists.infradead.org>; Tue, 18 Sep 2007 21:53:22 -0600
Date: Wed, 19 Sep 2007 09:23:37 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kdump info request
Message-ID: <20070919035337.GA7068@in.ibm.com>
References: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com>
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
To: "Mukker, Atul" <Atul.Mukker@lsi.com>
Cc: vgoyal@in.ibm.com, Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Sep 18, 2007 at 03:13:42PM -0600, Mukker, Atul wrote:
> Hello Vivek, Hari:
> 
>  
> 
> Excuse me for contacting you direct, but seems like you 2 can point me
> to a right direction for a kdump question we have.
> 
>  
> 
> We are trying to make sure our RAID driver works ok when kernel is
> loaded with kdump. Is there a way for driver to detect this condition;
> that is, current kernel is running with kdump. We need this information
> so we can scale down certain operations in the driver.
> 

Hi Atul,

What do you mean by detecting if current kernel is running with kdump? Do 
you mean that you want to know the moment somebody loads a capture kernel
by kexec -p and driver will change some of its behaviour?

I think that's not the right way to go about. Explain the issue
a little bit in detail.

Generally drivers run into issues while initializing in second kernel and
one of the way to handle it is reset the device before going further with
initialization. I am hoping your RAID controller provides some kind of
reset mechanism from software.

Thanks
Vivek


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
