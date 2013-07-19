Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V0Azz-0008VF-9A
 for kexec@lists.infradead.org; Fri, 19 Jul 2013 13:45:32 +0000
Date: Fri, 19 Jul 2013 15:44:51 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 4/7] xen: Enforce page size only when xen-syms file is
 used
Message-ID: <20130719134451.GF11233@debian70-amd64.local.net-space.pl>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-5-git-send-email-daniel.kiper@oracle.com>
 <20130719182024.7695f88a6e4fe1160a10c74c@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130719182024.7695f88a6e4fe1160a10c74c@mxc.nes.nec.co.jp>
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

On Fri, Jul 19, 2013 at 06:20:24PM +0900, Atsushi Kumagai wrote:
> On Tue, 16 Jul 2013 14:32:06 +0200
> Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> > Enforce page size only when xen-syms file is used.
> > Otherwise its size could be read from VMCOREINFO
> > file or /proc/vmcore file.
> >
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
> > ---
> >  makedumpfile.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/makedumpfile.c b/makedumpfile.c
> > index b42565c..b4abbe5 100644
> > --- a/makedumpfile.c
> > +++ b/makedumpfile.c
> > @@ -7324,8 +7324,6 @@ initial_xen(void)
> >  #endif
> >  	if (!init_xen_crash_info())
> >  		return FALSE;
> > -	if (!fallback_to_current_page_size())
> > -		return FALSE;
> >  	/*
> >  	 * Get the debug information for analysis from the vmcoreinfo file
> >  	 */
> > @@ -7340,6 +7338,8 @@ initial_xen(void)
> >  		set_dwarf_debuginfo("xen-syms", NULL,
> >  				    info->name_xen_syms, info->fd_xen_syms);
> >
> > +		if (!fallback_to_current_page_size())
> > +			return FALSE;
> >  		if (!get_symbol_info_xen())
> >  			return FALSE;
> >  		if (!get_structure_info_xen())
>
> This patch has no problem, but I would like to fix a bit for readability.
> So could you move the position of fallback_to_current_page_size() to after
> this block like initial() ?
>
> makedumpfile.c::initial()
>
>    2972         if (!info->page_size) {
>    2973                 /*
>    2974                  * If we cannot get page_size from a vmcoreinfo file,
>    2975                  * fall back to the current kernel page size.
>    2976                  */
>    2977                 if (!fallback_to_current_page_size())
>    2978                         return FALSE;
>    2979         }

Sure. Should I repost whole series or just only this patch?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
