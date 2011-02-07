Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by canuck.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PmH3q-0004lH-Um
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 02:42:44 +0000
Date: Mon, 7 Feb 2011 11:42:38 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH -next] Documentation: Improve crashkernel= description
Message-ID: <20110207024238.GA22477@verge.net.au>
References: <20110206154108.GA16542@laptop>
	<20110206215733.GB26233@verge.net.au>
	<4D4F5810.3070300@parallels.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D4F5810.3070300@parallels.com>
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
To: Rob Landley <rlandley@parallels.com>
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, Randy Dunlap <rdunlap@xenotime.net>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Sun, Feb 06, 2011 at 08:25:20PM -0600, Rob Landley wrote:
> On 02/06/2011 03:57 PM, Simon Horman wrote:
> > On Sun, Feb 06, 2011 at 05:41:08PM +0200, Ahmed S. Darwish wrote:
> >> (Also applicable over 2.6.38-rc3)
> >>
> >> Had to explore two C code files to make sense of the 'crashkernel='
> >> kernel parameter values.  Improve the situation.
> >>
> >> Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> >> ---
> >>
> >> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> >> index 89835a4..8f26b42 100644
> >> --- a/Documentation/kernel-parameters.txt
> >> +++ b/Documentation/kernel-parameters.txt
> >> @@ -545,9 +545,12 @@ and is between 256 and 4096 characters. It is defined in the file
> >>  			Format:
> >>  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
> >>  
> >> -	crashkernel=nn[KMG]@ss[KMG]
> >> -			[KNL] Reserve a chunk of physical memory to
> >> -			hold a kernel to switch to with kexec on panic.
> >> +	crashkernel=size[KMG][@offset[KMG]]
> >> +			[KNL] Using kexec, Linux can switch to a 'crash kernel'
> >> +			upon panic. This parameter reserves the physical
> >> +			memory region [offset, offset + size] for that kernel
> >> +			image. If the '@offset' part was ignored, Linux finds
> >> +			a suitable crash image start address automatically.
> > 
> > I think this would be further improved as:
> > 
> > 			... If '@offset' is omitted then a suitable
> > 			offset is selected automatically.
> 
> Suitable offset as in parses a known image type (ELF, bzImage, etc) to
> find the start address?  Or just assumes the entry point and load
> address are the same?

As in it finds a large enough area of contiguous free memory.
I believe that originally it searched from the bottom of memory,
it may be slightly smarter now.

Suitable is perhaps too strong a term.

In terms of the start address. On x86 at least it used to be
important to make sure that the start address matched but
these days using a relocatable kernel is an easier option.

> Is this the size for just the kernel image, or also for the physical
> memory it uses so it won't overwrite the existing kernel's stuff on the
> way up?  (If a compressed kernel wants to decompress itself or extract
> an initramfs for itself, what happens?)

It is the memory that is used by the crash-kernel to avoid overwriting
the first-kernel's stuff. It is not the memory where the (usually
compressed) second-kernel is stored before it is kexeced.

If a compressed crash-kernel wants to decompress itself it does so in the
available memory which is the region reserved by the crash-kernel parameter
to the first-kernel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
