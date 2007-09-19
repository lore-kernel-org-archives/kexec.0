Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail0.lsil.com ([147.145.40.20])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IXzZQ-0007WC-WD
	for kexec@lists.infradead.org; Wed, 19 Sep 2007 09:26:29 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: kdump info request
Date: Wed, 19 Sep 2007 07:26:19 -0600
Message-ID: <9738BCBE884FDB42801FAD8A7769C26501B2C4DA@NAMAIL1.ad.lsil.com>
In-Reply-To: <20070919042840.GB7068@in.ibm.com>
References: <9738BCBE884FDB42801FAD8A7769C26501B2C43C@NAMAIL1.ad.lsil.com>
	<20070919035337.GA7068@in.ibm.com>
	<9738BCBE884FDB42801FAD8A7769C2657E2A01@NAMAIL1.ad.lsil.com>
	<20070919042840.GB7068@in.ibm.com>
From: "Mukker, Atul" <Atul.Mukker@lsi.com>
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
To: vgoyal@in.ibm.com
Cc: Kexec Mailing List <kexec@lists.infradead.org>

Please see me response embedded below...

> Thanks for the reply. I guess we have pretty much nailed down device
bringup sequence when loading under capture kernel. Our concern is: the
capture kernel has a significant smaller memory footprint. Our RAID
driver itself has a large memory requirement, some of which could fail
allocation when loaded under the capture kernel.
> 
> If we could somehow determine that we are being called in context of
capture kernel, we can dynamically lower driver memory requirement (at
cost of lower IO throughout of-course, which is ok for this brief
context).

You can parse the command line and look for presence of elfcorehdr=
option.
This is internally appended to command line by kexec tools to tell
capture
kernel the address of ELF core headers.


[AM] Is this a standard way? Doesn't look like one. According to
kernel-parameters.txt, kexec would "generally" pass this option to
kernel command line. Can we look at "struct resource crashk_res" and
check if start and end member have different value, which indicates
capture kernel?

What's the memory allocation requirement of current RAID driver? How
much
memory you are reserving for capture kernel? Are you already seeing the
memory allocation failure?

[AM] Our normal runtime memory is about 20MB. For the test beds, we use
"crashkernel=192M@16M". We have not yet seen the allocation failure but
we would like to build the fallback mechanism if it does fail under
capture kernel. Only if we are not able to get the normal runtime
memory, we plan to switch to a lower memory model.

I feel until and unless memory requirements are huge, we should not
compromise with IO throughput. Capability to save the dump to disk as
fast
as possible to reduce the down time is also an important consideration.

[AM] We believe our normal runtime memory requirement is significant.
Also, even with the lower memory, there would not be a noticeable dump
time difference since lot of memory is for supporting multiple
outstanding commands in driver's raid core and other raid operations,
which will not be running under capture kernel. Thanks again for your
feedback.

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
> > Excuse me for contacting you direct, but seems like you 2 can point
me
> > to a right direction for a kdump question we have.
> > 
> >  
> > 
> > We are trying to make sure our RAID driver works ok when kernel is
> > loaded with kdump. Is there a way for driver to detect this
condition;
> > that is, current kernel is running with kdump. We need this
information
> > so we can scale down certain operations in the driver.
> > 
> 
> Hi Atul,
> 
> What do you mean by detecting if current kernel is running with kdump?
Do 
> you mean that you want to know the moment somebody loads a capture
kernel
> by kexec -p and driver will change some of its behaviour?
> 
> I think that's not the right way to go about. Explain the issue
> a little bit in detail.
> 
> Generally drivers run into issues while initializing in second kernel
and
> one of the way to handle it is reset the device before going further
with
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
