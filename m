Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pz0-f49.google.com ([209.85.210.49])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SbSez-0007oE-Qc
 for kexec@lists.infradead.org; Mon, 04 Jun 2012 08:29:10 +0000
Received: by dadm1 with SMTP id m1so6022034dad.36
 for <kexec@lists.infradead.org>; Mon, 04 Jun 2012 01:29:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20120604165449.e7236889.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120531135358.c1fc797f.kumagai-atsushi@mxc.nes.nec.co.jp>
 <CAJGZr0LSC3GKKTSDm9zH4YiY3V3B27O1t0v7YQWNho_Q+s3msw@mail.gmail.com>
 <20120604165449.e7236889.kumagai-atsushi@mxc.nes.nec.co.jp>
Date: Mon, 4 Jun 2012 12:29:07 +0400
Message-ID: <CAJGZr0L2OTA_Qv9hqXLGhK-Hs++ev+xHLZ9-OK8HbhON-CbSAQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] makedumpfile: cyclic processing to keep memory
 consumption.
From: Maxim Uvarov <muvarov@gmail.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3822852643763532170=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

--===============3822852643763532170==
Content-Type: multipart/alternative; boundary=047d7b33d664dd87fd04c1a15341

--047d7b33d664dd87fd04c1a15341
Content-Type: text/plain; charset=ISO-8859-1

2012/6/4 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>

> Hello Maxim,
>
> On Thu, 31 May 2012 10:50:39 +0400
> Maxim Uvarov <muvarov@gmail.com> wrote:
>
> > Atsushi,
> >
> > do you have speed measurements for saving vmcore with this patches and
> > without them?
> > How much is speed up?
> >
> > Thanks,
> > Maxim.
>
> After received your mail, I measured executing time with the patch below.
> The result below was measured in 5GB memory machine.
>
> Result:
>  a. makedumpfile -Kcd31
>    excluding time:   6.55 [sec]
>    writing time:     5.89 [sec]
>
>  b. makedumpfile -cd31
>    excluding time:   0.21 [sec]
>    writing time:     5.82 [sec]
>
> I don't think this result is good, the prototype has some points to be
> improved for performance.
> (e.g. buffer size, the way to exclude free pages, etc...)
>
> However, I think getting a bit of speed down can't be helped to keep
> memory consumption.
>
>
I'm asking because I have machines with several TBs of ram. And filtering
and saving data from vmcore takes long time. (more then 30 minutes). I
wonder if somebody already work on performance. Probably we can do SMP
optimizations.

Maxim.


>
> Thanks
> Atsushi Kumagai
>
>
> From 56e807066b333e3ef26afe8745deab8c952b5ca6 Mon Sep 17 00:00:00 2001
> From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> Date: Mon, 4 Jun 2012 10:15:50 +0900
> Subject: [PATCH] [RFC PATCH] Add time report for cyclic processing.
>
> Signed-off-by: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
> ---
>  makedumpfile.c |   25 +++++++++++++++++++++++++
>  makedumpfile.h |   11 +++++++++++
>  2 files changed, 36 insertions(+)
>
> diff --git a/makedumpfile.c b/makedumpfile.c
> index f4b6f83..a211a89 100644
> --- a/makedumpfile.c
> +++ b/makedumpfile.c
> @@ -45,6 +45,9 @@ unsigned long long pfn_user;
>  unsigned long long pfn_free;
>  unsigned long long num_dumped;
>
> +double d_exclude_start, d_exclude_end, d_exclude_time;
> +double d_write_start, d_write_end, d_write_time;
> +
>  int retcd = FAILED;    /* return code */
>
>  #define INITIALIZE_LONG_TABLE(table, value) \
> @@ -4078,10 +4081,13 @@ create_dump_bitmap(void)
>        } else {
>                if (!prepare_bitmap_buffer())
>                        goto out;
> +               d_exclude_start = getdtime();
>                if (!create_1st_bitmap())
>                        goto out;
>                if (!create_2nd_bitmap())
>                        goto out;
> +               d_exclude_end = getdtime();
> +               d_exclude_time += d_exclude_end - d_exclude_start;
>        }
>
>        ret = TRUE;
> @@ -5500,12 +5506,15 @@ write_kdump_pages_and_bitmap_cyclic(struct
> cache_data *cd_header, struct cache_d
>        /*
>         * Get number of dumpable pages.
>         */
> +       d_exclude_start = getdtime();
>        for (info->split_start_pfn = 0, info->split_end_pfn = PFN_CYCLIC;
>             info->split_end_pfn <= info->max_mapnr;
>             info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn +=
> PFN_CYCLIC) {
>
>                info->num_dumpable += get_num_dumpable_cyclic();
>        }
> +       d_exclude_end = getdtime();
> +       d_exclude_time += d_exclude_end - d_exclude_start;
>
>        /*
>         * Reset counter for debug message.
> @@ -5540,26 +5549,35 @@ write_kdump_pages_and_bitmap_cyclic(struct
> cache_data *cd_header, struct cache_d
>             info->split_end_pfn <= info->max_mapnr;
>             info->split_start_pfn += PFN_CYCLIC, info->split_end_pfn +=
> PFN_CYCLIC) {
>
> +               d_exclude_start = getdtime();
>                if (!create_1st_bitmap_cyclic())
>                        return FALSE;
>
>                if (!exclude_unnecessary_pages_cyclic())
>                        return FALSE;
> +               d_exclude_end = getdtime();
> +               d_exclude_time += d_exclude_end - d_exclude_start;
>
> +               d_write_start = getdtime();
>                if (!write_kdump_pages_cyclic(cd_header, cd_page, &pd_zero,
> &offset_data))
>                        return FALSE;
>
>                if (!write_kdump_bitmap_cyclic())
>                        return FALSE;
> +               d_write_end = getdtime();
> +               d_write_time += d_write_end - d_write_start;
>        }
>
>        /*
>         * Write the remainder.
>         */
> +       d_write_start = getdtime();
>        if (!write_cache_bufsz(cd_page))
>                return FALSE;
>        if (!write_cache_bufsz(cd_header))
>                return FALSE;
> +       d_write_end = getdtime();
> +       d_write_time += d_write_end - d_write_start;
>
>        return TRUE;
>  }
> @@ -6310,6 +6328,10 @@ print_report(void)
>        REPORT_MSG("--------------------------------------------------\n");
>        REPORT_MSG("Total pages     : 0x%016llx\n", info->max_mapnr);
>        REPORT_MSG("\n");
> +
> +       MSG("\n");
> +       MSG("excluding time  %lf [sec]\n", d_exclude_time);
> +       MSG("writing time: %lf [sec]\n", d_write_time);
>  }
>
>  int
> @@ -6349,10 +6371,13 @@ writeout_dumpfile(void)
>                if (!write_kdump_eraseinfo(&cd_page))
>                        goto out;
>        } else {
> +               d_write_start = getdtime();
>                if (!write_kdump_header())
>                        goto out;
>                if (!write_kdump_pages(&cd_header, &cd_page))
>                        goto out;
> +               d_write_end = getdtime();
> +               d_write_time = d_write_end - d_write_start;
>                if (!write_kdump_eraseinfo(&cd_page))
>                        goto out;
>                if (!write_kdump_bitmap())
> diff --git a/makedumpfile.h b/makedumpfile.h
> index a8aab2a..ca9b100 100644
> --- a/makedumpfile.h
> +++ b/makedumpfile.h
> @@ -16,6 +16,7 @@
>  #ifndef _MAKEDUMPFILE_H
>  #define _MAKEDUMPFILE_H
>
> +#include <sys/time.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <fcntl.h>
> @@ -1502,4 +1503,14 @@ struct elf_prstatus {
>
>  #endif
>
> +static inline double
> +getdtime(void)
> +{
> +       struct timeval tv;
> +
> +       gettimeofday(&tv, NULL);
> +
> +       return (double)tv.tv_sec + (double)tv.tv_usec * 0.001 * 0.001;
> +}
> +
>  #endif /* MAKEDUMPFILE_H */
> --
> 1.7.9.2
>



-- 
Best regards,
Maxim Uvarov

--047d7b33d664dd87fd04c1a15341
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/6/4 Atsushi Kumagai <span dir=3D"lt=
r">&lt;<a href=3D"mailto:kumagai-atsushi@mxc.nes.nec.co.jp" target=3D"_blan=
k">kumagai-atsushi@mxc.nes.nec.co.jp</a>&gt;</span><br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
Hello Maxim,<br>
<div class=3D"im"><br>
On Thu, 31 May 2012 10:50:39 +0400<br>
Maxim Uvarov &lt;<a href=3D"mailto:muvarov@gmail.com">muvarov@gmail.com</a>=
&gt; wrote:<br>
<br>
&gt; Atsushi,<br>
&gt;<br>
&gt; do you have speed measurements for saving vmcore with this patches and=
<br>
&gt; without them?<br>
&gt; How much is speed up?<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Maxim.<br>
<br>
</div>After received your mail, I measured executing time with the patch be=
low.<br>
The result below was measured in 5GB memory machine.<br>
<br>
Result:<br>
 =A0a. makedumpfile -Kcd31<br>
 =A0 =A0excluding time: =A0 6.55 [sec]<br>
 =A0 =A0writing time: =A0 =A0 5.89 [sec]<br>
<br>
 =A0b. makedumpfile -cd31<br>
 =A0 =A0excluding time: =A0 0.21 [sec]<br>
 =A0 =A0writing time: =A0 =A0 5.82 [sec]<br>
<br>
I don&#39;t think this result is good, the prototype has some points to be<=
br>
improved for performance.<br>
(e.g. buffer size, the way to exclude free pages, etc...)<br>
<br>
However, I think getting a bit of speed down can&#39;t be helped to keep<br=
>
memory consumption.<br>
<br></blockquote><div><br>I&#39;m asking because I have machines with sever=
al TBs of ram. And filtering and saving data from vmcore takes long time. (=
more then 30 minutes). I wonder if somebody already work on performance. Pr=
obably we can do SMP optimizations.<br>
<br>Maxim.<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
t 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks<br>
Atsushi Kumagai<br>
<br>
<br>
From 56e807066b333e3ef26afe8745deab8c952b5ca6 Mon Sep 17 00:00:00 2001<br>
From: Atsushi Kumagai &lt;<a href=3D"mailto:kumagai-atsushi@mxc.nes.nec.co.=
jp">kumagai-atsushi@mxc.nes.nec.co.jp</a>&gt;<br>
Date: Mon, 4 Jun 2012 10:15:50 +0900<br>
Subject: [PATCH] [RFC PATCH] Add time report for cyclic processing.<br>
<br>
Signed-off-by: Atsushi Kumagai &lt;<a href=3D"mailto:kumagai-atsushi@mxc.ne=
s.nec.co.jp">kumagai-atsushi@mxc.nes.nec.co.jp</a>&gt;<br>
---<br>
=A0makedumpfile.c | =A0 25 +++++++++++++++++++++++++<br>
=A0makedumpfile.h | =A0 11 +++++++++++<br>
=A02 files changed, 36 insertions(+)<br>
<br>
diff --git a/makedumpfile.c b/makedumpfile.c<br>
index f4b6f83..a211a89 100644<br>
--- a/makedumpfile.c<br>
+++ b/makedumpfile.c<br>
@@ -45,6 +45,9 @@ unsigned long long pfn_user;<br>
=A0unsigned long long pfn_free;<br>
=A0unsigned long long num_dumped;<br>
<br>
+double d_exclude_start, d_exclude_end, d_exclude_time;<br>
+double d_write_start, d_write_end, d_write_time;<br>
+<br>
=A0int retcd =3D FAILED; =A0 =A0/* return code */<br>
<br>
=A0#define INITIALIZE_LONG_TABLE(table, value) \<br>
@@ -4078,10 +4081,13 @@ create_dump_bitmap(void)<br>
 =A0 =A0 =A0 =A0} else {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!prepare_bitmap_buffer())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!create_1st_bitmap())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!create_2nd_bitmap())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_end =3D getdtime();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_time +=3D d_exclude_end - d_exclude=
_start;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0ret =3D TRUE;<br>
@@ -5500,12 +5506,15 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_da=
ta *cd_header, struct cache_d<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * Get number of dumpable pages.<br>
 =A0 =A0 =A0 =A0 */<br>
+ =A0 =A0 =A0 d_exclude_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0for (info-&gt;split_start_pfn =3D 0, info-&gt;split_end_pfn=
 =3D PFN_CYCLIC;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;split_end_pfn &lt;=3D info-&gt;max_mapnr;=
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;split_start_pfn +=3D PFN_CYCLIC, info-&gt=
;split_end_pfn +=3D PFN_CYCLIC) {<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0info-&gt;num_dumpable +=3D get_num_dumpable=
_cyclic();<br>
 =A0 =A0 =A0 =A0}<br>
+ =A0 =A0 =A0 d_exclude_end =3D getdtime();<br>
+ =A0 =A0 =A0 d_exclude_time +=3D d_exclude_end - d_exclude_start;<br>
<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * Reset counter for debug message.<br>
@@ -5540,26 +5549,35 @@ write_kdump_pages_and_bitmap_cyclic(struct cache_da=
ta *cd_header, struct cache_d<br>
 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;split_end_pfn &lt;=3D info-&gt;max_mapnr;=
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 info-&gt;split_start_pfn +=3D PFN_CYCLIC, info-&gt=
;split_end_pfn +=3D PFN_CYCLIC) {<br>
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!create_1st_bitmap_cyclic())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!exclude_unnecessary_pages_cyclic())<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_end =3D getdtime();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_exclude_time +=3D d_exclude_end - d_exclude=
_start;<br>
<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_pages_cyclic(cd_header, cd=
_page, &amp;pd_zero, &amp;offset_data))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_bitmap_cyclic())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_end =3D getdtime();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_time +=3D d_write_end - d_write_start=
;<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0/*<br>
 =A0 =A0 =A0 =A0 * Write the remainder.<br>
 =A0 =A0 =A0 =A0 */<br>
+ =A0 =A0 =A0 d_write_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0if (!write_cache_bufsz(cd_page))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
 =A0 =A0 =A0 =A0if (!write_cache_bufsz(cd_header))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return FALSE;<br>
+ =A0 =A0 =A0 d_write_end =3D getdtime();<br>
+ =A0 =A0 =A0 d_write_time +=3D d_write_end - d_write_start;<br>
<br>
 =A0 =A0 =A0 =A0return TRUE;<br>
=A0}<br>
@@ -6310,6 +6328,10 @@ print_report(void)<br>
 =A0 =A0 =A0 =A0REPORT_MSG(&quot;------------------------------------------=
--------\n&quot;);<br>
 =A0 =A0 =A0 =A0REPORT_MSG(&quot;Total pages =A0 =A0 : 0x%016llx\n&quot;, i=
nfo-&gt;max_mapnr);<br>
 =A0 =A0 =A0 =A0REPORT_MSG(&quot;\n&quot;);<br>
+<br>
+ =A0 =A0 =A0 MSG(&quot;\n&quot;);<br>
+ =A0 =A0 =A0 MSG(&quot;excluding time =A0%lf [sec]\n&quot;, d_exclude_time=
);<br>
+ =A0 =A0 =A0 MSG(&quot;writing time: %lf [sec]\n&quot;, d_write_time);<br>
=A0}<br>
<br>
=A0int<br>
@@ -6349,10 +6371,13 @@ writeout_dumpfile(void)<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_eraseinfo(&amp;cd_page))<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
 =A0 =A0 =A0 =A0} else {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_start =3D getdtime();<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_header())<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_pages(&amp;cd_header, &amp=
;cd_page))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_end =3D getdtime();<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 d_write_time =3D d_write_end - d_write_start;=
<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_eraseinfo(&amp;cd_page))<b=
r>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!write_kdump_bitmap())<br>
diff --git a/makedumpfile.h b/makedumpfile.h<br>
index a8aab2a..ca9b100 100644<br>
--- a/makedumpfile.h<br>
+++ b/makedumpfile.h<br>
@@ -16,6 +16,7 @@<br>
=A0#ifndef _MAKEDUMPFILE_H<br>
=A0#define _MAKEDUMPFILE_H<br>
<br>
+#include &lt;sys/time.h&gt;<br>
=A0#include &lt;stdio.h&gt;<br>
=A0#include &lt;stdlib.h&gt;<br>
=A0#include &lt;fcntl.h&gt;<br>
@@ -1502,4 +1503,14 @@ struct elf_prstatus {<br>
<br>
=A0#endif<br>
<br>
+static inline double<br>
+getdtime(void)<br>
+{<br>
+ =A0 =A0 =A0 struct timeval tv;<br>
+<br>
+ =A0 =A0 =A0 gettimeofday(&amp;tv, NULL);<br>
+<br>
+ =A0 =A0 =A0 return (double)tv.tv_sec + (double)tv.tv_usec * 0.001 * 0.001=
;<br>
+}<br>
+<br>
=A0#endif /* MAKEDUMPFILE_H */<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.7.9.2<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br>Best rega=
rds,<br>Maxim Uvarov<br>

--047d7b33d664dd87fd04c1a15341--


--===============3822852643763532170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============3822852643763532170==--

