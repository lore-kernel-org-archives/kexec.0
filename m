Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from jack.tiscali.it ([213.205.33.53])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1I1HT2-0008IU-Ke
	for kexec@lists.infradead.org; Thu, 21 Jun 2007 03:52:39 -0400
From: francesco chiechi <francesco.chiechi@colibre.it>
Subject: Re: [PATCH] kexec tools mipsel port
Date: Thu, 21 Jun 2007 09:52:19 +0200
References: <200706020021.38658.francesco.chiechi@colibre.it>
	<20070604054034.GA6093@verge.net.au>
In-Reply-To: <20070604054034.GA6093@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200706210952.20232.francesco.chiechi@colibre.it>
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
To: kexec@lists.infradead.org
Cc: Alessandro Rubini <rubini@gnudd.com>, Horms <horms@verge.net.au>

On Monday 04 June 2007 07:40, Horms wrote:
> On Sat, Jun 02, 2007 at 12:21:38AM +0200, francesco chiechi wrote:
> > Hello,
> >
> > We developed a patch to port kexec-tools to mips arch and included
> > support for command line passing through elf boot notes.  We did it
> > for a customer of ours on a specific platform derived from toshiba
> > tx4938 (so we think it should work at least for tx4938 evaluation
> > board also).  We would like to contribute it in case somebody else
> > needs it or wants to improve it.  This patch works for us but the
> > assembler part in particular, should be considered as a starting point
> > because my assembly knowledge is not too deep.
> >
> > As this is the first time I submit a patch I tried to guess reading
> > tpp.txt if this is the right way to submit. Please let me know about
> > any mistakes I may have made.
>
> Hi Francesco,

Hi Horms,

sorry about the long delay in my reply

> thanks for the patch. Sending them to this list is indeed the right
> thing to do. You can also CC me (who makes the commits) to be sure
> to get my attention.
>
> I'm curious to about all the #ifdef __MIPSEL__ stuff in kexec.c.
> Is there no chance that couldn't be placed somewhere in /kexec/arch/mipsel
> somehow? kexec is a bit hapazard in parts, but generally there
> isn't much #ifdef ARCH foo in there and we try and keep
> architecture-specific and generic code separated.

I am aware of this problem but I did not find a more appropriate way to solve 
this. This has something to to with the way mips handles virtual addresses.
I will retry to fix this as soon as I have some time

> Two other minor things:
>
> * please patch configure.ac, not configure
>
> * please provide a signed-off-by line, which is described at
>   http://linux.yyz.us/patch-format.html amongst other places.

should I resend the patch or you say these for future reference?

thank you again

Francesco

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
