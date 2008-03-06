Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JX6im-0003X0-1D
	for kexec@lists.infradead.org; Thu, 06 Mar 2008 03:24:40 +0000
Date: Thu, 6 Mar 2008 12:24:34 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: bug/patch for i386 EFI boot
Message-ID: <20080306032432.GA14808@verge.net.au>
References: <p0623090ac3f3b6cfa8b9@[192.168.9.5]>
	<20080305092731.GB3979@verge.net.au>
	<p06230913c3f4655358a8@[192.168.9.5]>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <p06230913c3f4655358a8@[192.168.9.5]>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Scott D. Davilla" <davilla@4pi.com>
Cc: kexec@lists.infradead.org

On Wed, Mar 05, 2008 at 10:08:25AM -0500, Scott D. Davilla wrote:
> >this looks good to me, though there is no need
> >to comment out unneeded lines, just remove them.
> >
> >Also, if you could provide a sign-off line, as
> >per Section 5 of http://linux.yyz.us/patch-format.html
> >that would be great.
> >
> >Finally, your mail reader (or something else) seems
> >to have mangled the patch such that leading <space><tab>
> >has been turned into <space><space><tab>. This isn't a bit
> >deal as its is easy enough for me to un-mangle it by hand.
> >But just so you know.
> >
> >Thanks
> >
> >--
> >Horms
> 
> Done and resubmitted with a proper subject line with commented out 
> lines removed. VMware was mangling the leading tabs on the drag and 
> drop from Linux to OS X ???

Thanks that looks great. I'll merge it.

Just for reference, the sign-off line should go at the bottom
of your description, not underneath the patch. But I'll fix that
up when I add my sign-off.

> And as follow up question. It there any access to 
> screen_info.orig_video_isVGA besides linking to the kernel? If there 
> is access to orig_video_isVGA then kexec can setup the screen boot 
> params as the bootloader intended instead of assuming a default VGA 
> config. The orig_video_isVGA is the only parameter missing to clone 
> the initial screen_info information.

I'm sorry but I'm really not the person to ask about that.
But it does sound like a good idea if it were possible to
implement.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
