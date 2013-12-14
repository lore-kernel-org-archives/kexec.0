Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vrd9W-0003sK-2o
 for kexec@lists.infradead.org; Sat, 14 Dec 2013 00:32:18 +0000
Date: Sat, 14 Dec 2013 09:31:55 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 0/3] kexec support for Linux/m68k (tools part)
Message-ID: <20131214003155.GA12584@verge.net.au>
References: <1381859460-13645-1-git-send-email-geert@linux-m68k.org>
 <20131213005322.GJ32101@verge.net.au>
 <CAMuHMdW8cSLXy36fD1QaSjHoFsM5B4ZK4JVwLY-OefX+wFOtiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8cSLXy36fD1QaSjHoFsM5B4ZK4JVwLY-OefX+wFOtiQ@mail.gmail.com>
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

On Fri, Dec 13, 2013 at 09:03:45AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Dec 13, 2013 at 1:53 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Oct 15, 2013 at 07:50:57PM +0200, Geert Uytterhoeven wrote:
> >> kexec support for Linux/m68k (tools part)
> >>
> >> This is a set of patches to add kexec support for m68k to kexec-tools.
> >>
> >>   - Kexec only, no kdump support yet (do you have enough RAM to keep a
> >>     crashdump kernel in memory at all times? ;-)
> >
> > Thanks, applied.
> 
> Thanks, I have queued the kernel counterpart for 3.14.

Great. It sounds like it would be ideal if a new kexec-tools release
coincided with the release of v3.14 of the kernel.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
