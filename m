Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMo1Y-0003j5-PH
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 23:52:43 +0000
Date: Thu, 19 Sep 2013 14:00:37 -0700
From: Simon Horman <horms@verge.net.au>
Subject: Re: Preliminary kexec support for Linux/m68k
Message-ID: <20130919210037.GG2918@verge.net.au>
References: <1379412095-7213-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdW8y9_=LXQ1PXjFaPyq-nYTPe+FodE5hQh4P3QSdnP_dg@mail.gmail.com>
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kexec@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Anton Blanchard <anton@samba.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On Thu, Sep 19, 2013 at 11:20:22AM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 17, 2013 at 12:01 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > This is a preliminary set of patches to add kexec support for m68k.
> 
> >   - [PATCH 1/3] m68k: Add preliminary kexec support
> >   - [PATCH 2/3] m68k: Add support to export bootinfo in procfs
> >   - [PATCH 3/3] [RFC] m68k: Add System RAM to /proc/iomem
> >
> > Notes:
> >   - The bootinfo is now saved and exported to /proc/bootinfo, so kexec-tools
> >     can read it and pass it (possibly after modification) to the new kernel.
> >     This is similar to /proc/atags on ARM.
> 
> >   - I based [PATCH 3/3] on the PowerPC version, but it's no longer needed as we
> >     now get this information from the bootinfo.
> >     Does anyone think this is nice to have anyway?
> 
> It seems kexec/kdump on ppc don't use /proc/iomem anymore, and only rely on
> /proc/device-tree these days?

I think thats entirely a matter for the m68k kernel maintainers to decide.
But my personal opinion is that it is nice not to add it if it isn't needed.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
