Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JEpLj-0004C9-FL
	for kexec@lists.infradead.org; Tue, 15 Jan 2008 17:13:19 +0000
Date: Tue, 15 Jan 2008 12:09:50 -0500
From: Neil Horman <nhorman@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080115170950.GA24359@hmsendeavour.rdu.redhat.com>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
	<20080115152710.GA24435@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080115152710.GA24435@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Neil Horman <nhorman@tuxdriver.com>

On Tue, Jan 15, 2008 at 10:27:10AM -0500, Vivek Goyal wrote:
> On Mon, Jan 14, 2008 at 08:43:03AM -0500, Neil Horman wrote:
> > Hey all-
> > 	Regarding this bug:
> > 	http://bugzilla.kernel.org/show_bug.cgi?id=9641
> > 	I'd like to look into putting together a patch for it, and wanted to
> > solicit comments for the best way to go about doing it.  Currently I've got it
> > fixed up in the Red Hat tree by bumping COMMAND_LINE_SIZE to 2048 and
> > eliminating the reserved buffer of the x86_linux_faked_param_header, which works
> > well, but isn't backwards compatible as Bernhard pointed out.  Given that extra
> > constraint, I thought it woudl e best to unify the command line and reserved
> > buffers in x86_linux_faked_param_header to one contiguour 2048 byte block and
> > maintain a separate variable that defines the command line length based on a
> > parsing of the UTS_VERSION.  Does that sound reasonable to everyone, or is there
> > a better way that someone has in mind?
> > 
> 
> Hi Neil,
> 
> Looking at UTS_VERSION and then deciding the command line length seems
> ok. 
> 
> When I look at inclue/asm-x86/bootparam.h in kernel, area starting from
> 0x2d0 to all the way up to 4K has been reserved for e820 maps and EDD buf.
> 
> Does that mean newer boot loaders are putting command line outside of 
> 4K page and only putting the pointer to cmdline in 4K page. If that's the
> case then we might have to do the same for kexec.
> 

That would seem to be the case yes, although it appears the kernel still
supports the old boot protocol if you want to restrict the command line length
to the old 256 chars (see copy_boot_data)

Regards
Neil

> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
