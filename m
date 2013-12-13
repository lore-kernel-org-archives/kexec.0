Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VrGzv-0006TX-Px
 for kexec@lists.infradead.org; Fri, 13 Dec 2013 00:52:56 +0000
Date: Fri, 13 Dec 2013 09:51:11 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
Message-ID: <20131213005111.GI32101@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <20131016072236.GB29696@verge.net.au>
 <CAMuHMdVsKLBt8MiZ-dpX7expx+37XfO2kUjbRA_h5eMcsWJ1VQ@mail.gmail.com>
 <20131105070513.GB16448@verge.net.au>
 <CAMuHMdUVwYGemL=V3+C=JsR0QOqtASvc6Xte57EdPhPPLDFWXg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdUVwYGemL=V3+C=JsR0QOqtASvc6Xte57EdPhPPLDFWXg@mail.gmail.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, kexec@lists.infradead.org

On Sun, Dec 01, 2013 at 12:40:27PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Tue, Nov 5, 2013 at 8:05 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Sun, Nov 03, 2013 at 03:08:50PM +0100, Geert Uytterhoeven wrote:
> >> On Wed, Oct 16, 2013 at 9:22 AM, Simon Horman <horms@verge.net.au> wrote:
> >> > I've taken a quick look over this and it seems reasonable to me.
> >>
> >> Thanks!
> >>
> >> > However, I wonder if I should wait for review of the kernel-side
> >> > to be completed before applying the kexec-tools patches.
> >> >
> >> > Let me know what you think.
> >>
> >> The kexec-tools part seems to be stable. The issues to be sorted out are on
> >> the kernel side.
> >
> > As the kexec-tools portion of this change isn't useful without the
> > kernel portion I think I would like to wait before applying this series.
> > Please repost once the kernel changes have been merged or if you
> > would like them re-considered for any other reason.
> 
> The kernel part is working now.
> 
> I didn't make any changes to kexec-tools for v3.
> Do you want me to resend them anyway, or can you just take v2?

Sorry for being slow, I will take v2.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
