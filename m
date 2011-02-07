Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from xenotime.net ([2001:470:0:13c::4834:7338])
	by canuck.infradead.org with smtp (Exim 4.72 #1 (Red Hat Linux))
	id 1PmIV6-0004y8-UP
	for kexec@lists.infradead.org; Mon, 07 Feb 2011 04:14:58 +0000
Received: from chimera.site ([173.50.240.230]) by xenotime.net for
	<kexec@lists.infradead.org>; Sun, 6 Feb 2011 20:14:49 -0800
Date: Sun, 6 Feb 2011 20:14:48 -0800
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH -next] Documentation: Improve crashkernel= description
Message-Id: <20110206201448.4a259575.rdunlap@xenotime.net>
In-Reply-To: <20110206215733.GB26233@verge.net.au>
References: <20110206154108.GA16542@laptop>
	<20110206215733.GB26233@verge.net.au>
Mime-Version: 1.0
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
To: Simon Horman <horms@verge.net.au>
Cc: linux-doc@vger.kernel.org, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Haren Myneni <hbabu@us.ibm.com>, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>

On Mon, 7 Feb 2011 06:57:33 +0900 Simon Horman wrote:

> On Sun, Feb 06, 2011 at 05:41:08PM +0200, Ahmed S. Darwish wrote:
> > (Also applicable over 2.6.38-rc3)
> > 
> > Had to explore two C code files to make sense of the 'crashkernel='
> > kernel parameter values.  Improve the situation.
> > 
> > Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
> > ---
> > 
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 89835a4..8f26b42 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -545,9 +545,12 @@ and is between 256 and 4096 characters. It is defined in the file
> >  			Format:
> >  			<first_slot>,<last_slot>,<port>,<enum_bit>[,<debug>]
> >  
> > -	crashkernel=nn[KMG]@ss[KMG]
> > -			[KNL] Reserve a chunk of physical memory to
> > -			hold a kernel to switch to with kexec on panic.
> > +	crashkernel=size[KMG][@offset[KMG]]
> > +			[KNL] Using kexec, Linux can switch to a 'crash kernel'
> > +			upon panic. This parameter reserves the physical
> > +			memory region [offset, offset + size] for that kernel
> > +			image. If the '@offset' part was ignored, Linux finds
> > +			a suitable crash image start address automatically.
> 
> I think this would be further improved as:
> 
> 			... If '@offset' is omitted then a suitable
> 			offset is selected automatically.
> 
> >  
> >  	crashkernel=range1:size1[,range2:size2,...][@offset]
> >  			[KNL] Same as above, but depends on the memory

Hi,

I also prefer Simon's change.  Can you please resend an updated patch?

thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
