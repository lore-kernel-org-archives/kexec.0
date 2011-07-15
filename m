Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1QhjED-0003gq-I0
	for kexec@lists.infradead.org; Fri, 15 Jul 2011 14:18:55 +0000
Date: Fri, 15 Jul 2011 10:18:47 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [patch 0/9] kdump: Patch series for s390 support
Message-ID: <20110715141847.GD3428@redhat.com>
References: <20110707193321.GE28850@redhat.com>
	<20110708110121.5acfc3c9@mschwide>
	<20110711144255.GE30674@redhat.com>
	<20110711175626.121dcc58@mschwide>
	<20110713160239.GE4426@redhat.com>
	<20110713184611.6dcb09b4@mschwide>
	<20110713200004.GG4426@redhat.com>
	<20110714091800.720da848@mschwide>
	<20110714175532.GE6672@redhat.com>
	<1310738181.10789.16.camel@br98xy6r>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1310738181.10789.16.camel@br98xy6r>
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
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, kexec@lists.infradead.org

On Fri, Jul 15, 2011 at 03:56:21PM +0200, Michael Holzheu wrote:
> Hello Vivec,
> 
> On Thu, 2011-07-14 at 13:55 -0400, Vivek Goyal wrote:
> 
> [snip]
> 
> > > The first thing we want to do is to check if
> > > the purgatory is still fine, that is do a checksum. If we have the
> > > infrastructure in place to do one checksum then we can easily do the
> > > other checksums as well.
> > 
> > Some piece of code you have to assume is fine. Are you not already
> > assuming that IPL code you have in first 64K bytes is fine and no
> > body has overwritten it.
> 
> We can assume that the IPL dump code is fine, because it is freshly
> loaded into memory. Only when the disk is somehow corrupted we have a
> problem.
> 
> > Are you not assuming that hook in panic()
> > (I think you are calling it shutdown trigger) is fine so that it
> > can help you jump to right place.
> 
> Yes, that is correct for automatic dump in case of panic(). The panic()
> path can fail.
> 
> But there are two other options where really *no* code that was in
> memory, when the system crashed, is used for the dump process or
> verification of kdump:
> 1) Manual IPL/boot of stand-alone dump by the operator via the virtual
> guest console
> 2) Automatic IPL/boot of stand-alone dump by our z/VM hypervisor
> watchdog

Hi Michael,

Ok. So IIUC, then purgatory code corruption is equivalent of panic() code
corruption and in that case above two options will help an admin capture
the dump.

That's precisely the point I am trying to make that stand alone dump
tools still remains the backup mechanism when kdump fails. Kdump can
fail ether because checksum of loaded kernel is bad or because purgatory
code itself got corrupted. In first case, purgatory itself can make
sure of jumping to location to IPL the dump tools and in second case
above two options will come into picture (manual dump via operator or
hypervisor watchdog initiated IPL).

If we go this path, this will should simplify the design a lot. dump
tools don't have to know anything about kdump kernel and there is no
need to pass any information. 

And in common case kdump should be able to capture the dump and filter
it. Only in extreme corner cases, we need to trigger this dump tool
mechanism and capture full memory dump.

How about doing it that way. This should not require much chagens in
common kexec code. Will require some changes in kexec-tools though, 
as you shall have to create a mechanism for purgatory to jump to in
case kdump kernel checksum fails.

Thanks
Vivek 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
