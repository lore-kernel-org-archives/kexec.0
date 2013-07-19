Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1V06tX-00027I-9E
 for kexec@lists.infradead.org; Fri, 19 Jul 2013 09:22:37 +0000
Date: Fri, 19 Jul 2013 18:20:01 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2 6/7] Mute some compiler warnings
Message-Id: <20130719182001.5a6ce765a62ccdc4237e9a33@mxc.nes.nec.co.jp>
In-Reply-To: <51E88265.1000005@jp.fujitsu.com>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-7-git-send-email-daniel.kiper@oracle.com>
 <51E88265.1000005@jp.fujitsu.com>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: daniel.kiper@oracle.com, d.hatayama@jp.fujitsu.com
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Tue, 16 Jul 2013 14:32:08 +0200
Daniel Kiper <daniel.kiper@oracle.com> wrote:

> This patch mutes follwing compiler warnings:
>   - warning: assignment discards ‘const’ qualifier from
>     pointer target type [enabled by default],
>   - warning: variable ‘page_offset’ set but not used
>     [-Wunused-but-set-variable].
> 
> v2 - suggestions/fixes:
>    - do not discard a const qualifier
>      (suggested by Andrew Cooper).
> 
> Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>

Good, I'll merge this patch into v1.5.5.
And thanks for your review, HATAYAMA-san.


Thanks
Atsushi Kumagai

On Fri, 19 Jul 2013 09:03:49 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

> (2013/07/16 21:32), Daniel Kiper wrote:
> <cut>
> > diff --git a/sadump_info.c b/sadump_info.c
> > index be6cf55..01cf5eb 100644
> > --- a/sadump_info.c
> > +++ b/sadump_info.c
> > @@ -948,7 +948,6 @@ int
> >   readpage_sadump(unsigned long long paddr, void *bufptr)
> >   {
> >   	unsigned long long pfn, block, whole_offset, perdisk_offset;
> > -	ulong page_offset;
> >   	int fd_memory;
> >
> >   	if (si->kdump_backed_up &&
> > @@ -957,7 +956,6 @@ readpage_sadump(unsigned long long paddr, void *bufptr)
> >   		paddr += si->backup_offset - si->backup_src_start;
> >
> >   	pfn = paddr_to_pfn(paddr);
> > -	page_offset = paddr % info->page_size;
> >
> >   	if (pfn >= si->sh_memory->max_mapnr)
> >   		return FALSE;
> >
> 
> It seems good to me. Thanks.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
