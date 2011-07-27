Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1Qlz8z-000242-Vp
	for kexec@lists.infradead.org; Wed, 27 Jul 2011 08:07:08 +0000
Subject: Re: [PATCH]: fix makedumpfile cache page exclusion dump levels.
In-reply-to: <CANaZ7Nx_GuBFkKw6O_gSqOGC0fVDX0MT959sSPyDTb1u+yFPhg@mail.gmail.com>
References: <CANaZ7Nx_GuBFkKw6O_gSqOGC0fVDX0MT959sSPyDTb1u+yFPhg@mail.gmail.com>
Message-Id: <20110727170416tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Wed, 27 Jul 2011 17:04:16 +0900
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Thayumanavar S <thayumker@gmail.com>
Cc: kexec@lists.infradead.org, tachibana@mxm.nes.nec.co.jp, kumagai-atsushi@mxc.nes.nec.co.jp

Hi Thayumanavar,

On 2011/07/25 22:55:35 +0530, Thayumanavar S <thayumker@gmail.com> wrote:
> Looking at the code in depth the condition for exclusion of cache
> private seem to exclude cache pages including private pages. The
> levels cache page ( exclude private ) and cache private (cache page
> with private) need to be mutually exclusive.The following patch fixes
> this:

Thank you for the patches.
Your idea is reasonable. But we made the dump level 4 (excluding cache 
pages including private pages) for diskdump compatibility. And I worry about 
influence of changing the meaning of the dump level.
So I'd like to correct man data at the next version.

Thanks
tachibana


> 
> Signed-off-by: thayumker@gmail.com
> diff --git a/makedumpfile.8 b/makedumpfile.8
> index b9a3bf0..dd7960b 100644
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -138,32 +138,32 @@ by dump_level 11, makedumpfile retries it by
> dump_level 31.
>       1 |  X   |      |       |      |
>       2 |      |  X   |       |      |
>       3 |  X   |  X   |       |      |
> -     4 |      |  X   |  X    |      |
> -     5 |  X   |  X   |  X    |      |
> +     4 |      |      |  X    |      |
> +     5 |  X   |      |  X    |      |
>       6 |      |  X   |  X    |      |
>       7 |  X   |  X   |  X    |      |
>       8 |      |      |       |  X   |
>       9 |  X   |      |       |  X   |
>      10 |      |  X   |       |  X   |
>      11 |  X   |  X   |       |  X   |
> -    12 |      |  X   |  X    |  X   |
> -    13 |  X   |  X   |  X    |  X   |
> +    12 |      |      |  X    |  X   |
> +    13 |  X   |      |  X    |  X   |
>      14 |      |  X   |  X    |  X   |
>      15 |  X   |  X   |  X    |  X   |
>      16 |      |      |       |      |  X
>      17 |  X   |      |       |      |  X
>      18 |      |  X   |       |      |  X
>      19 |  X   |  X   |       |      |  X
> -    20 |      |  X   |  X    |      |  X
> -    21 |  X   |  X   |  X    |      |  X
> +    20 |      |      |  X    |      |  X
> +    21 |  X   |      |  X    |      |  X
>      22 |      |  X   |  X    |      |  X
>      23 |  X   |  X   |  X    |      |  X
>      24 |      |      |       |  X   |  X
>      25 |  X   |      |       |  X   |  X
>      26 |      |  X   |       |  X   |  X
>      27 |  X   |  X   |       |  X   |  X
> -    28 |      |  X   |  X    |  X   |  X
> -    29 |  X   |  X   |  X    |  X   |  X
> +    28 |      |      |  X    |  X   |  X
> +    29 |  X   |      |  X    |  X   |  X
>      30 |      |  X   |  X    |  X   |  X
>      31 |  X   |  X   |  X    |  X   |  X
> 
> diff --git a/makedumpfile.c b/makedumpfile.c
> index 7d0c663..e117f31 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -5015,7 +5015,7 @@ __exclude_unnecessary_pages(unsigned long mem_map,
>                  */
>                 else if ((info->dump_level & DL_EXCLUDE_CACHE_PRI)
>                     && (isLRU(flags) || isSwapCache(flags))
> -                   && !isAnon(mapping)) {
> +                   && isPrivate(flags) && !isAnon(mapping)) {
>                         clear_bit_on_2nd_bitmap_for_kernel(pfn);
>                         pfn_cache_private++;
>                 }
> 
> 
> or
> Correct the makedumpfile man making it more explicit so that the
> end-users can understand.The following patch fixes this:
> --- a/makedumpfile.8
> +++ b/makedumpfile.8
> @@ -130,42 +130,43 @@ by dump_level 11, makedumpfile retries it by
> dump_level 31.
>  .br
>  # makedumpfile \-d 11,31 \-x vmlinux /proc/vmcore dumpfile
> 
> -  dump | zero | cache|cache  | user | free
> - level | page | page |private| data | page
> +  dump | zero | cache page   |cache page    | user | free
> + level | page | (exlude priv)|(include priv)| data | page
> +       |      |
>  .br
>  \-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-\-+\-\-\-\-\-\-+\-\-\-\-\-\-
> -     0 |      |      |       |      |
> -     1 |  X   |      |       |      |
> -     2 |      |  X   |       |      |
> -     3 |  X   |  X   |       |      |
> -     4 |      |  X   |  X    |      |
> -     5 |  X   |  X   |  X    |      |
> -     6 |      |  X   |  X    |      |
> -     7 |  X   |  X   |  X    |      |
> -     8 |      |      |       |  X   |
> -     9 |  X   |      |       |  X   |
> -    10 |      |  X   |       |  X   |
> -    11 |  X   |  X   |       |  X   |
> -    12 |      |  X   |  X    |  X   |
> -    13 |  X   |  X   |  X    |  X   |
> -    14 |      |  X   |  X    |  X   |
> -    15 |  X   |  X   |  X    |  X   |
> -    16 |      |      |       |      |  X
> -    17 |  X   |      |       |      |  X
> -    18 |      |  X   |       |      |  X
> -    19 |  X   |  X   |       |      |  X
> -    20 |      |  X   |  X    |      |  X
> -    21 |  X   |  X   |  X    |      |  X
> -    22 |      |  X   |  X    |      |  X
> -    23 |  X   |  X   |  X    |      |  X
> -    24 |      |      |       |  X   |  X
> -    25 |  X   |      |       |  X   |  X
> -    26 |      |  X   |       |  X   |  X
> -    27 |  X   |  X   |       |  X   |  X
> -    28 |      |  X   |  X    |  X   |  X
> -    29 |  X   |  X   |  X    |  X   |  X
> -    30 |      |  X   |  X    |  X   |  X
> -    31 |  X   |  X   |  X    |  X   |  X
> +     0 |      |              |              |      |
> +     1 |  X   |              |              |      |
> +     2 |      |              |  X           |      |
> +     3 |  X   |              |  X           |      |
> +     4 |      |  X           |  X           |      |
> +     5 |  X   |  X           |  X           |      |
> +     6 |      |  X           |  X           |      |
> +     7 |  X   |  X           |  X           |      |
> +     8 |      |              |              |  X   |
> +     9 |  X   |              |              |  X   |
> +    10 |      |              |  X           |  X   |
> +    11 |  X   |              |  X           |  X   |
> +    12 |      |  X           |  X           |  X   |
> +    13 |  X   |  X           |  X           |  X   |
> +    14 |      |  X           |  X           |  X   |
> +    15 |  X   |  X           |  X           |  X   |
> +    16 |      |              |              |      |  X
> +    17 |  X   |              |              |      |  X
> +    18 |      |              |  X           |      |  X
> +    19 |  X   |              |  X           |      |  X
> +    20 |      |  X           |  X           |      |  X
> +    21 |  X   |  X           |  X           |      |  X
> +    22 |      |  X           |  X           |      |  X
> +    23 |  X   |  X           |  X           |      |  X
> +    24 |      |              |              |  X   |  X
> +    25 |  X   |              |              |  X   |  X
> +    26 |      |              |  X           |  X   |  X
> +    27 |  X   |              |  X           |  X   |  X
> +    28 |      |  X           |  X           |  X   |  X
> +    29 |  X   |  X           |  X           |  X   |  X
> +    30 |      |  X           |  X           |  X   |  X
> +    31 |  X   |  X           |  X           |  X   |  X
> 
> 
>  .TP
> 
> 
> On Sat, Jul 9, 2011 at 9:49 AM, Thayumanavar S <thayumker@gmail.com> wrote:
> > I believe that makedumpfile man page which descirbe the dump file and
> > corressponding page exclusion table appears to have incorrect
> > inentries ( such as 5&7 having value,likewise 29&31) and not following
> > the bitmask as mentioned in the code.
> > Below code fixes this issue.
> >
> > Signed-off-by: thayumker@gmail.com
> > diff --git a/makedumpfile.8 b/makedumpfile.8
> > index b9a3bf0..dd7960b 100644
> > --- a/makedumpfile.8
> > +++ b/makedumpfile.8
> > @@ -138,32 +138,32 @@ by dump_level 11, makedumpfile retries it by
> > dump_level 31.
> > 　 　 　1 | 　X 　 | 　 　 　| 　 　 　 | 　 　 　|
> > 　 　 　2 | 　 　 　| 　X 　 | 　 　 　 | 　 　 　|
> > 　 　 　3 | 　X 　 | 　X 　 | 　 　 　 | 　 　 　|
> > - 　 　 4 | 　 　 　| 　X 　 | 　X 　 　| 　 　 　|
> > - 　 　 5 | 　X 　 | 　X 　 | 　X 　 　| 　 　 　|
> > + 　 　 4 | 　 　 　| 　 　 　| 　X 　 　| 　 　 　|
> > + 　 　 5 | 　X 　 | 　 　 　| 　X 　 　| 　 　 　|
> > 　 　 　6 | 　 　 　| 　X 　 | 　X 　 　| 　 　 　|
> > 　 　 　7 | 　X 　 | 　X 　 | 　X 　 　| 　 　 　|
> > 　 　 　8 | 　 　 　| 　 　 　| 　 　 　 | 　X 　 |
> > 　 　 　9 | 　X 　 | 　 　 　| 　 　 　 | 　X 　 |
> > 　 　 10 | 　 　 　| 　X 　 | 　 　 　 | 　X 　 |
> > 　 　 11 | 　X 　 | 　X 　 | 　 　 　 | 　X 　 |
> > - 　 　12 | 　 　 　| 　X 　 | 　X 　 　| 　X 　 |
> > - 　 　13 | 　X 　 | 　X 　 | 　X 　 　| 　X 　 |
> > + 　 　12 | 　 　 　| 　 　 　| 　X 　 　| 　X 　 |
> > + 　 　13 | 　X 　 | 　 　 　| 　X 　 　| 　X 　 |
> > 　 　 14 | 　 　 　| 　X 　 | 　X 　 　| 　X 　 |
> > 　 　 15 | 　X 　 | 　X 　 | 　X 　 　| 　X 　 |
> > 　 　 16 | 　 　 　| 　 　 　| 　 　 　 | 　 　 　| 　X
> > 　 　 17 | 　X 　 | 　 　 　| 　 　 　 | 　 　 　| 　X
> > 　 　 18 | 　 　 　| 　X 　 | 　 　 　 | 　 　 　| 　X
> > 　 　 19 | 　X 　 | 　X 　 | 　 　 　 | 　 　 　| 　X
> > - 　 　20 | 　 　 　| 　X 　 | 　X 　 　| 　 　 　| 　X
> > - 　 　21 | 　X 　 | 　X 　 | 　X 　 　| 　 　 　| 　X
> > + 　 　20 | 　 　 　| 　 　 　| 　X 　 　| 　 　 　| 　X
> > + 　 　21 | 　X 　 | 　 　 　| 　X 　 　| 　 　 　| 　X
> > 　 　 22 | 　 　 　| 　X 　 | 　X 　 　| 　 　 　| 　X
> > 　 　 23 | 　X 　 | 　X 　 | 　X 　 　| 　 　 　| 　X
> > 　 　 24 | 　 　 　| 　 　 　| 　 　 　 | 　X 　 | 　X
> > 　 　 25 | 　X 　 | 　 　 　| 　 　 　 | 　X 　 | 　X
> > 　 　 26 | 　 　 　| 　X 　 | 　 　 　 | 　X 　 | 　X
> > 　 　 27 | 　X 　 | 　X 　 | 　 　 　 | 　X 　 | 　X
> > - 　 　28 | 　 　 　| 　X 　 | 　X 　 　| 　X 　 | 　X
> > - 　 　29 | 　X 　 | 　X 　 | 　X 　 　| 　X 　 | 　X
> > + 　 　28 | 　 　 　| 　 　 　| 　X 　 　| 　X 　 | 　X
> > + 　 　29 | 　X 　 | 　 　 　| 　X 　 　| 　X 　 | 　X
> > 　 　 30 | 　 　 　| 　X 　 | 　X 　 　| 　X 　 | 　X
> > 　 　 31 | 　X 　 | 　X 　 | 　X 　 　| 　X 　 | 　X
> >
> 

---------------------------------------------------------------------

> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
