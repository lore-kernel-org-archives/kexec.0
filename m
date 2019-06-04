Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hY5cG-0002Md-MW
 for kexec@lists.infradead.org; Tue, 04 Jun 2019 09:20:26 +0000
Date: Tue, 4 Jun 2019 11:20:17 +0200
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] x86: Clear isVGA flag if current fb driver is mimicking
 VGA
Message-ID: <20190604092017.7gdsla2ey3l77edj@verge.net.au>
References: <20181123092801.16411-1-kasong@redhat.com>
 <20190531092923.ytuwwmmmmteh77cw@verge.net.au>
 <CACPcB9fcrQybChtt1GHEYOQ1K2hOWJANJP3sH5kxwpEC9RbRnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9fcrQybChtt1GHEYOQ1K2hOWJANJP3sH5kxwpEC9RbRnw@mail.gmail.com>
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
To: Kairui Song <kasong@redhat.com>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

On Fri, May 31, 2019 at 05:38:25PM +0800, Kairui Song wrote:
> On Fri, May 31, 2019 at 5:29 PM Simon Horman <horms@verge.net.au> wrote:
> >
> > On Fri, Nov 23, 2018 at 05:28:01PM +0800, Kairui Song wrote:
> > > Some device (eg. hyperv_fb) will mimic EFI (or VESA) VGA on first boot
> > > up, but after the real driver is loaded, it will switch to new mode
> > > and no longer compatible with EFI/VESA VGA. Keep setting
> > > orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> > > try to manipulate the framebuffer in a wrong way.
> > >
> > > As we have already take care of "VESA VGA" and "EFI VGA", just set the
> > > orig_video_isVGA to 0 for any other driver reports as EFI/VESA VGA but
> > > is not EFI/VESA VGA.
> > >
> > > Signed-off-by: Kairui Song <kasong@redhat.com>
> >
> > Sorry for letting this slip through the cracks.
> > Please let me know if this is still relevant.
> 
> Hi Simon, after fb5a879 ("x86: Introduce a new option
> --reuse-video-type") in kexec-tools, this patch is no longer needed.

Hi Kairui,

thanks for the clarification.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
