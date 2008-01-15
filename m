Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JEnkR-0001Ku-Un
	for kexec@lists.infradead.org; Tue, 15 Jan 2008 15:30:44 +0000
Date: Tue, 15 Jan 2008 10:27:10 -0500
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: Kexec command line length
Message-ID: <20080115152710.GA24435@redhat.com>
References: <20080114134303.GA947@hmsreliant.think-freely.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080114134303.GA947@hmsreliant.think-freely.org>
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

On Mon, Jan 14, 2008 at 08:43:03AM -0500, Neil Horman wrote:
> Hey all-
> 	Regarding this bug:
> 	http://bugzilla.kernel.org/show_bug.cgi?id=9641
> 	I'd like to look into putting together a patch for it, and wanted to
> solicit comments for the best way to go about doing it.  Currently I've got it
> fixed up in the Red Hat tree by bumping COMMAND_LINE_SIZE to 2048 and
> eliminating the reserved buffer of the x86_linux_faked_param_header, which works
> well, but isn't backwards compatible as Bernhard pointed out.  Given that extra
> constraint, I thought it woudl e best to unify the command line and reserved
> buffers in x86_linux_faked_param_header to one contiguour 2048 byte block and
> maintain a separate variable that defines the command line length based on a
> parsing of the UTS_VERSION.  Does that sound reasonable to everyone, or is there
> a better way that someone has in mind?
> 

Hi Neil,

Looking at UTS_VERSION and then deciding the command line length seems
ok. 

When I look at inclue/asm-x86/bootparam.h in kernel, area starting from
0x2d0 to all the way up to 4K has been reserved for e820 maps and EDD buf.

Does that mean newer boot loaders are putting command line outside of 
4K page and only putting the pointer to cmdline in 4K page. If that's the
case then we might have to do the same for kexec.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
