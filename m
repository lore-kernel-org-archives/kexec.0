Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-it1-f196.google.com ([209.85.166.196])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWdzj-0003yh-FG
 for kexec@lists.infradead.org; Fri, 31 May 2019 09:38:46 +0000
Received: by mail-it1-f196.google.com with SMTP id j204so8884105ite.4
 for <kexec@lists.infradead.org>; Fri, 31 May 2019 02:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181123092801.16411-1-kasong@redhat.com>
 <20190531092923.ytuwwmmmmteh77cw@verge.net.au>
In-Reply-To: <20190531092923.ytuwwmmmmteh77cw@verge.net.au>
From: Kairui Song <kasong@redhat.com>
Date: Fri, 31 May 2019 17:38:25 +0800
Message-ID: <CACPcB9fcrQybChtt1GHEYOQ1K2hOWJANJP3sH5kxwpEC9RbRnw@mail.gmail.com>
Subject: Re: [PATCH] x86: Clear isVGA flag if current fb driver is mimicking
 VGA
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
To: Simon Horman <horms@verge.net.au>
Cc: Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org

On Fri, May 31, 2019 at 5:29 PM Simon Horman <horms@verge.net.au> wrote:
>
> On Fri, Nov 23, 2018 at 05:28:01PM +0800, Kairui Song wrote:
> > Some device (eg. hyperv_fb) will mimic EFI (or VESA) VGA on first boot
> > up, but after the real driver is loaded, it will switch to new mode
> > and no longer compatible with EFI/VESA VGA. Keep setting
> > orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> > try to manipulate the framebuffer in a wrong way.
> >
> > As we have already take care of "VESA VGA" and "EFI VGA", just set the
> > orig_video_isVGA to 0 for any other driver reports as EFI/VESA VGA but
> > is not EFI/VESA VGA.
> >
> > Signed-off-by: Kairui Song <kasong@redhat.com>
>
> Sorry for letting this slip through the cracks.
> Please let me know if this is still relevant.

Hi Simon, after fb5a879 ("x86: Introduce a new option
--reuse-video-type") in kexec-tools, this patch is no longer needed.


--
Best Regards,
Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
