Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h1W1V-0008JL-2E
 for kexec@lists.infradead.org; Wed, 06 Mar 2019 12:51:50 +0000
Date: Wed, 6 Mar 2019 13:51:42 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] x86: Introduce a new option --reuse-video-type
Message-ID: <20190306125142.7rq3in5tgrjnhqzh@verge.net.au>
References: <20190305113433.20628-1-kasong@redhat.com>
 <20190306093423.GA6947@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190306093423.GA6947@dhcp-128-65.nay.redhat.com>
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
Cc: kexec@lists.infradead.org, Kairui Song <kasong@redhat.com>

On Wed, Mar 06, 2019 at 05:34:23PM +0800, Dave Young wrote:
> On 03/05/19 at 07:34pm, Kairui Song wrote:
> > After commit 060eee58 "x86: use old screen_info if needed", kexec-tools
> > will force use old screen_info and vga type if failed to determine
> > current vga type. But it is not always a good idea.
> > 
> > Currently kernel hanging is inspected on some hyper-v VMs after this
> > commit, because hyperv_fb will mimic EFI (or VESA) VGA on first boot
> > up, but after the real driver is loaded, it will switch to new mode
> > and no longer compatible with EFI/VESA VGA. Keep setting
> > orig_video_isVGA to EFI/VESA VGA flag will get wrong driver loaded and
> > try to manipulate the framebuffer in a wrong way.
> > 
> > We can't ensure this won't happen on other framebuffer drivers, But
> > it's a helpful feature if the framebuffer drivers just work. So this
> > patch introduce a --reuse-video-type options to let user decide if the
> > old screen_info hould be used unconditional or not.
> > 
> > Signed-off-by: Kairui Song <kasong@redhat.com>

...

> Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks, applied

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
