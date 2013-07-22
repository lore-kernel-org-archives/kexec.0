Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V1Nac-0006mg-OA
 for kexec@lists.infradead.org; Mon, 22 Jul 2013 21:24:19 +0000
Date: Mon, 22 Jul 2013 23:23:50 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 4/7] xen: Enforce page size only when xen-syms file is
 used
Message-ID: <20130722212350.GE14451@debian70-amd64.local.net-space.pl>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-5-git-send-email-daniel.kiper@oracle.com>
 <20130719182024.7695f88a6e4fe1160a10c74c@mxc.nes.nec.co.jp>
 <20130719134451.GF11233@debian70-amd64.local.net-space.pl>
 <20130722163529.39ce6b1903324f8c3a0e7a44@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130722163529.39ce6b1903324f8c3a0e7a44@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Mon, Jul 22, 2013 at 04:35:29PM +0900, Atsushi Kumagai wrote:
> On Fri, 19 Jul 2013 15:44:51 +0200
> Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> > On Fri, Jul 19, 2013 at 06:20:24PM +0900, Atsushi Kumagai wrote:

[...]

> > > makedumpfile.c::initial()
> > >
> > >    2972         if (!info->page_size) {
> > >    2973                 /*
> > >    2974                  * If we cannot get page_size from a vmcoreinfo file,
> > >    2975                  * fall back to the current kernel page size.
> > >    2976                  */
> > >    2977                 if (!fallback_to_current_page_size())
> > >    2978                         return FALSE;
> > >    2979         }
> >
> > Sure. Should I repost whole series or just only this patch?
> >
> > Daniel
>
> Please repost only this patch.

Done.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
