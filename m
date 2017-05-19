Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBYrJ-0000Hj-Rl
 for kexec@lists.infradead.org; Fri, 19 May 2017 03:45:48 +0000
Received: by mail-pg0-x231.google.com with SMTP id u187so31923479pgb.0
 for <kexec@lists.infradead.org>; Thu, 18 May 2017 20:45:24 -0700 (PDT)
Date: Fri, 19 May 2017 12:45:15 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH] kexec/kdump: Minor Documentation updates for arm64 and
 Image
Message-ID: <20170519034514.GA4283@fireball>
References: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
 <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: panand@redhat.com, bhe@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Bharat Bhushan <Bharat.Bhushan@nxp.com>, vgoyal@redhat.com

On Thu, May 18, 2017 at 01:59:14PM +0800, Dave Young wrote:
> Add Takahiro and Pratyush, they should be able to review the arm64 part.
> 
> On 05/18/17 at 11:03am, Bharat Bhushan wrote:
> > This patch have minor updates in Documentation for arm64i as
> > relocatable kernel.
> > Also this patch updates documentation for using uncompressed
> > image "Image" which is used for ARM64.
> > 
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  Documentation/kdump/kdump.txt | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/kdump/kdump.txt b/Documentation/kdump/kdump.txt
> > index 615434d..522ce13 100644
> > --- a/Documentation/kdump/kdump.txt
> > +++ b/Documentation/kdump/kdump.txt
> > @@ -112,8 +112,8 @@ There are two possible methods of using Kdump.
> >  2) Or use the system kernel binary itself as dump-capture kernel and there is
> >     no need to build a separate dump-capture kernel. This is possible
> >     only with the architectures which support a relocatable kernel. As
> > -   of today, i386, x86_64, ppc64, ia64 and arm architectures support relocatable
> > -   kernel.
> > +   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
> > +   relocatable kernel.
> >  
> >  Building a relocatable kernel is advantageous from the point of view that
> >  one does not have to build a second kernel for capturing the dump. But
> > @@ -361,6 +361,12 @@ to load dump-capture kernel.
> >     --dtb=<dtb-for-dump-capture-kernel> \
> >     --append="root=<root-dev> <arch-specific-options>"
> >  
> > +If you are using a uncompressed Image, then use following command
> 
> s/a/an
> 
> > +to load dump-capture kernel.
> > +
> > +   kexec -p <dump-capture-kernel-Image> \
> > +   --initrd=<initrd-for-dump-capture-kernel> \
> > +   --append="root=<root-dev> <arch-specific-options>"
> 
> For uncompressed Image, dtb is not necessary?

Just for clarification, dtb is optional for both vmlinux and Image
on arm64. (This means you can specify it if you want.)
But this is also true for initrd and append(command line) to some extent.

More precisely, whether these parameters are optional or not will
depend on architectures, not formats, I believe.

Thanks,
-Takahiro AKASHI

> >  
> >  Please note, that --args-linux does not need to be specified for ia64.
> >  It is planned to make this a no-op on that architecture, but for now
> > -- 
> > 1.9.3
> > 
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
