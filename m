Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ve1eur01on0046.outbound.protection.outlook.com
 ([104.47.1.46] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dBEhi-0004HO-F3
 for kexec@lists.infradead.org; Thu, 18 May 2017 06:14:32 +0000
From: Bharat Bhushan <bharat.bhushan@nxp.com>
Subject: RE: [PATCH] kexec/kdump: Minor Documentation updates for arm64 and
 Image
Date: Thu, 18 May 2017 06:14:07 +0000
Message-ID: <AM5PR0401MB25457242B7B685CB21D6F0759AE40@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1495085600-2645-1-git-send-email-Bharat.Bhushan@nxp.com>
 <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20170518055914.GC4059@dhcp-128-65.nay.redhat.com>
Content-Language: en-US
MIME-Version: 1.0
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
Cc: "panand@redhat.com" <panand@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "vgoyal@redhat.com" <vgoyal@redhat.com>



> -----Original Message-----
> From: Dave Young [mailto:dyoung@redhat.com]
> Sent: Thursday, May 18, 2017 11:29 AM
> To: Bharat Bhushan <bharat.bhushan@nxp.com>
> Cc: bhe@redhat.com; vgoyal@redhat.com; corbet@lwn.net;
> kexec@lists.infradead.org; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; takahiro.akashi@linaro.org; panand@redhat.com
> Subject: Re: [PATCH] kexec/kdump: Minor Documentation updates for
> arm64 and Image
> 
> Add Takahiro and Pratyush, they should be able to review the arm64 part.
> 
> On 05/18/17 at 11:03am, Bharat Bhushan wrote:
> > This patch have minor updates in Documentation for arm64i as
> > relocatable kernel.
> > Also this patch updates documentation for using uncompressed image
> > "Image" which is used for ARM64.
> >
> > Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> > ---
> >  Documentation/kdump/kdump.txt | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/kdump/kdump.txt
> > b/Documentation/kdump/kdump.txt index 615434d..522ce13 100644
> > --- a/Documentation/kdump/kdump.txt
> > +++ b/Documentation/kdump/kdump.txt
> > @@ -112,8 +112,8 @@ There are two possible methods of using Kdump.
> >  2) Or use the system kernel binary itself as dump-capture kernel and there
> is
> >     no need to build a separate dump-capture kernel. This is possible
> >     only with the architectures which support a relocatable kernel. As
> > -   of today, i386, x86_64, ppc64, ia64 and arm architectures support
> relocatable
> > -   kernel.
> > +   of today, i386, x86_64, ppc64, ia64, arm and arm64 architectures support
> > +   relocatable kernel.
> >
> >  Building a relocatable kernel is advantageous from the point of view
> > that  one does not have to build a second kernel for capturing the
> > dump. But @@ -361,6 +361,12 @@ to load dump-capture kernel.
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

Yes dtb is not necessary, it works for me without giving dtb.

Thanks
-Bharat

> 
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
