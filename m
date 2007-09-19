Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IXrAy-000207-90
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 00:28:40 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8J4SWLh014814
	for <kexec@lists.infradead.org>; Wed, 19 Sep 2007 00:28:32 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8J4SWoP511054
	for <kexec@lists.infradead.org>; Wed, 19 Sep 2007 00:28:32 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8J4SWIG018119
	for <kexec@lists.infradead.org>; Wed, 19 Sep 2007 00:28:32 -0400
Date: Wed, 19 Sep 2007 09:58:40 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: kdump info request
Message-ID: <20070919042840.GB7068@in.ibm.com>
References: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com>
	<20070919035337.GA7068@in.ibm.com>
	<9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com>
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
Cc: Kexec Mailing List <kexec@lists.infradead.org>

On Tue, Sep 18, 2007 at 10:04:21PM -0600, Mukker, Atul wrote:
> Thanks for the reply. I guess we have pretty much nailed down device bringup sequence when loading under capture kernel. Our concern is: the capture kernel has a significant smaller memory footprint. Our RAID driver itself has a large memory requirement, some of which could fail allocation when loaded under the capture kernel.
> 
> If we could somehow determine that we are being called in context of capture kernel, we can dynamically lower driver memory requirement (at cost of lower IO throughout of-course, which is ok for this brief context).

You can parse the command line and look for presence of elfcorehdr= option.
This is internally appended to command line by kexec tools to tell capture
kernel the address of ELF core headers.

What's the memory allocation requirement of current RAID driver? How much
memory you are reserving for capture kernel? Are you already seeing the
memory allocation failure?

I feel until and unless memory requirements are huge, we should not
compromise with IO throughput. Capability to save the dump to disk as fast
as possible to reduce the down time is also an important consideration.

Thanks
Vivek

> 
> Thanks
> -Atul
> 
> -----Original Message-----
> From: Vivek Goyal [mailto:vgoyal@in.ibm.com]
> Sent: Tue 9/18/2007 9:53 PM
> To: Mukker, Atul
> Cc: vgoyal@in.ibm.com; Kexec Mailing List
> Subject: Re: kdump info request
>  
> On Tue, Sep 18, 2007 at 03:13:42PM -0600, Mukker, Atul wrote:
> > Hello Vivek, Hari:
> > 
> >  
> > 
> > Excuse me for contacting you direct, but seems like you 2 can point me
> > to a right direction for a kdump question we have.
> > 
> >  
> > 
> > We are trying to make sure our RAID driver works ok when kernel is
> > loaded with kdump. Is there a way for driver to detect this condition;
> > that is, current kernel is running with kdump. We need this information
> > so we can scale down certain operations in the driver.
> > 
> 
> Hi Atul,
> 
> What do you mean by detecting if current kernel is running with kdump? Do 
> you mean that you want to know the moment somebody loads a capture kernel
> by kexec -p and driver will change some of its behaviour?
> 
> I think that's not the right way to go about. Explain the issue
> a little bit in detail.
> 
> Generally drivers run into issues while initializing in second kernel and
> one of the way to handle it is reset the device before going further with
> initialization. I am hoping your RAID controller provides some kind of
> reset mechanism from software.
> 
> Thanks
> Vivek
> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
