Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h170e-0004nu-UL
 for kexec@lists.infradead.org; Tue, 05 Mar 2019 10:09:17 +0000
Date: Tue, 5 Mar 2019 18:09:07 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86: Introdudce a new option --force-vga
Message-ID: <20190305100907.GA8622@dhcp-128-65.nay.redhat.com>
References: <20190228100723.13780-1-kasong@redhat.com>
 <20190304063013.GB31037@dhcp-128-65.nay.redhat.com>
 <CACPcB9dqSH9DKJTCzJOW6asX0k5LsMCph27DD0hZFanppygZ0A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACPcB9dqSH9DKJTCzJOW6asX0k5LsMCph27DD0hZFanppygZ0A@mail.gmail.com>
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
Cc: Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org

On 03/05/19 at 04:24pm, Kairui Song wrote:
> On Mon, Mar 4, 2019 at 2:30 PM Dave Young <dyoung@redhat.com> wrote:
> >
> > On 02/28/19 at 06:07pm, Kairui Song wrote:
> > > After commit 060eee58 "x86: use old screen_info if needed", kexec-tools
> > > will force use old screen_info and vga type if failed to determine
> > > current vga type. But it is not always a good idea.
> > >
> > > Currently kernel hanging is inspected on some hyper-v VMs after this
> > > commit, because hyperv_fb will mimic EFI (or VESA) VGA on first boot
> > > up, but after the real driver is loaded, it will switch to new mode
> > > and no longer compatible with EFI/VESA VGA. Keep setting
> > > orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> > > try to manipulate the framebuffer in a wrong way.
> > >
> > > We can't ensure this won't happen on other framebuffer drivers, But
> > > it's a helpful feature if the framebuffer drivers just work. So this
> > > patch introduce a --force-vga options to let user decide if the
> > > old screen_info should be used unconditional or not.
> >
> > It looks good to me except the option name, because vga usually means
> > the specific vga video type.  But here you are enforcing to reuse the first
> > kernel original video type.
> >
> > It would be better to use --reuse-video-type or --force-orig-video, etc..
> >
> 
> Thanks for the review, the naming is not very good indeed, will update
> the patch. How about just --reuse-video? This should be general enough
> and clear.

Hmm, I feel --reuse-video-type is clearer,  --reuse-video seems not
clear :)

> 
> -- 
> Best Regards,
> Kairui Song

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
