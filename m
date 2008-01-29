Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JJsdS-0002io-Rs
	for kexec@lists.infradead.org; Tue, 29 Jan 2008 15:44:31 +0000
Date: Tue, 29 Jan 2008 10:41:04 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080129154104.GA12219@redhat.com>
References: <20080125195058.GE28683@hmsendeavour.rdu.redhat.com>
	<20080125201305.GG13287@redhat.com>
	<20080125205450.GG28683@hmsendeavour.rdu.redhat.com>
	<20080128170811.GA1174@hmsreliant.think-freely.org>
	<20080128193741.GB32765@redhat.com>
	<20080128200702.GB1174@hmsreliant.think-freely.org>
	<20080128202041.GD32765@redhat.com>
	<20080128205324.GC1174@hmsreliant.think-freely.org>
	<20080128212910.GA21889@suse.de>
	<20080129010122.GA11935@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080129010122.GA11935@hmsreliant.think-freely.org>
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
To: Neil Horman <nhorman@tuxdriver.com>
Cc: kexec@lists.infradead.org

On Mon, Jan 28, 2008 at 08:01:22PM -0500, Neil Horman wrote:
> On Mon, Jan 28, 2008 at 10:29:10PM +0100, Bernhard Walle wrote:
> > * Neil Horman <nhorman@tuxdriver.com> [2008-01-28 21:53]:
> > >  		return -1;
> > >  	}
> > >  
> > > +	if (setup_header.protocol_version >= 0x0206) {
> > > +		if (command_line_len > setup_header.cmdline_size) {
> > > +			dbgprintf("Kernel command line too long for kernel!\n");
> > > +			return -1;
> > > +		}
> > > +	}
> > > +
> > >  	if (setup_header.protocol_version >= 0x0205) {
> > >  		relocatable_kernel = setup_header.relocatable_kernel;
> > >  		dbgprintf("bzImage is relocatable\n");
> > 
> > I know that there was a kernel release with 2048 _and_ still the old
> > boot protocol, but wouldn't it be better to warn the user if the size
> > is beyond 256 and the old kernel is used? I think new kexec-tools
> > should still support old kernels without problems ...
> > 
> 
> I don't know how important that really is, but I don't see a particular problem 
> with it either.  From my reading of i386/boot.txt, versions prior to boot 
> protocol 2.02 only supported a 256 bytes command line patch, so what if we just 
> add an extra check in do_bzImage_load.  If the protocol version of the boot 
> header is lexx than 0x0202, then we fail if the command line length is more than 
> 256 bytes.  Note there are two other locations where we use a linux boot 
> protocol header, but they are both constructed heders, not read headers, and use 
> protocol version 2.03, which support 2048 byte command lines.
> 

I think 2048 command line support came much later. I think it came between
version 2.05 and 2.06 (But somebody needs to dive into archive to verify).
Because command line size could go beyond 256, we introduced cmdline_size
parameter in version 2.06 to let a boot loader know.

What Bernanrd seems to be talking about a small window where boot protocol
was 2.05 but supported command line size was still 2048.

I think if we are loading any kernel older than 2.06 (and newer than
2.05?), and if command line size is greater than 256, we just might want to
give a debug warning to user, saying command line is great than 256 and kernel
does not tell me what's the supported command line size. (Somthing like that).

So it might look something like this.

if (protocol version > 2.06)
	error user depending on cmdline_size;
else if (protocol version > 2.05 && protocol version < 2.06)
	warn on cmdline being more than 256. We don't know for sure.
else
	error out if cmdline is greater than 256

I am not very sure about the boundary version 2.05, somebody needs to
verify.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
