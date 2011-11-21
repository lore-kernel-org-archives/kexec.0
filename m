Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gy0-f177.google.com ([209.85.160.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RSWbR-0006Dm-BM
 for kexec@lists.infradead.org; Mon, 21 Nov 2011 16:20:21 +0000
Received: by ghbg15 with SMTP id g15so3425051ghb.36
 for <kexec@lists.infradead.org>; Mon, 21 Nov 2011 08:20:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4EC9AD4F.3050404@redhat.com>
References: <4EC31E55.6040809@redhat.com> <1321467647.2137.4.camel@boudreau>
 <4EC47FCA.5090908@redhat.com>
 <CAOS58YMOuJrvGxE1VxsU=ZPTLgY60HDJoLFjTowx9ZApUQ3tTw@mail.gmail.com>
 <4EC491B3.705@redhat.com>
 <CAMMEr5k_ynqg5-7Looar2DxXTGZcMqi5Lo+jtETn9awO_bsaGg@mail.gmail.com>
 <4EC4B60C.3030706@redhat.com> <1321548033.12208.12.camel@boudreau>
 <4EC61AB6.4090808@redhat.com> <4EC61B2A.7010000@redhat.com>
 <20111118185535.GA27152@google.com> <4EC9AD4F.3050404@redhat.com>
Date: Mon, 21 Nov 2011 11:20:15 -0500
Message-ID: <CAMMEr5my3pt0HXWd1EdwAeZKAJ8JP04tM_WqvHdCNvW=Q3ifvg@mail.gmail.com>
Subject: Re: [PATCH] percpu: fix chunk range calculation
From: Tim Hartrick <tim@edgecast.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7902090120405651089=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, WANG Cong <xiyou.wangcong@gmail.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

--===============7902090120405651089==
Content-Type: multipart/alternative; boundary=20cf303f63a6da7d8104b2410fb3

--20cf303f63a6da7d8104b2410fb3
Content-Type: text/plain; charset=ISO-8859-1

Dave,

I will give it a try ASAP.  Unfortunately, ASAP won't be until Friday.

tim
On Nov 20, 2011 6:43 PM, "Dave Young" <dyoung@redhat.com> wrote:

> On 11/19/2011 02:55 AM, Tejun Heo wrote:
>
> > Percpu allocator recorded the cpus which map to the first and last
> > units in pcpu_first/last_unit_cpu respectively and used them to
> > determine the address range of a chunk - e.g. it assumed that the
> > first unit has the lowest address in a chunk while the last unit has
> > the highest address.
> >
> > This simply isn't true.  Groups in a chunk can have arbitrary positive
> > or negative offsets from the previous one and there is no guarantee
> > that the first unit occupies the lowest offset while the last one the
> > highest.
> >
> > Fix it by actually comparing unit offsets to determine cpus occupying
> > the lowest and highest offsets.  Also, rename pcu_first/last_unit_cpu
> > to pcpu_low/high_unit_cpu to avoid confusion.
> >
> > The chunk address range is used to flush cache on vmalloc area
> > map/unmap and decide whether a given address is in the first chunk by
> > per_cpu_ptr_to_phys() and the bug was discovered by invalid
> > per_cpu_ptr_to_phys() translation for crash_note.
> >
> > Kudos to Dave Young for tracking down the problem.
>
>
> Tejun, thanks
>
> Now that if addr is not in first trunk it must be in vmalloc area, below
> logic should be right:
>        if (in_first_chunk) {
>                if (!is_vmalloc_addr(addr))
>                        return __pa(addr);
>                else
>                        return page_to_phys(vmalloc_to_page(addr));
>        } else
>                if (!is_vmalloc_addr(addr)) /* not possible */
>                        return __pa(addr);
>                else
>                        return page_to_phys(pcpu_addr_to_page(addr));
>
> So how about just simply remove in first chunk checking to simplify the
> code as followging:
>
> phys_addr_t per_cpu_ptr_to_phys(void *addr)
> {
>        if (!is_vmalloc_addr(addr))
>                return __pa(addr);
>        else
>                return page_to_phys(pcpu_addr_to_page(addr));
> }
>
> >
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Reported-by: WANG Cong <xiyou.wangcong@gmail.com>
> > Reported-by: Dave Young <dyoung@redhat.com>
> > LKML-Reference: <4EC21F67.10905@redhat.com>
> > Cc: stable @kernel.org
> > ---
> > Heh, that's a stupid bug.  Can you please verify this fixes the
> > problem?
>
>
> I can confirm that the per cpu translation works with this patch, but I
> have not managed to finished kdump test because kexec tools refuse
>  to load the crash kernel. I need more debugging on kexec tools.
>
> Tim, could you help to test if this patch works for your kdump case?
>
> >
> > Thank you very much.
> >
> >  mm/percpu-vm.c |   12 ++++++------
> >  mm/percpu.c    |   34 ++++++++++++++++++++--------------
> >  2 files changed, 26 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> > index ea53496..bfad724 100644
> > --- a/mm/percpu-vm.c
> > +++ b/mm/percpu-vm.c
> > @@ -143,8 +143,8 @@ static void pcpu_pre_unmap_flush(struct pcpu_chunk
> *chunk,
> >                                int page_start, int page_end)
> >  {
> >       flush_cache_vunmap(
> > -             pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
> > -             pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
> > +             pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
> > +             pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
> >  }
> >
> >  static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)
> > @@ -206,8 +206,8 @@ static void pcpu_post_unmap_tlb_flush(struct
> pcpu_chunk *chunk,
> >                                     int page_start, int page_end)
> >  {
> >       flush_tlb_kernel_range(
> > -             pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
> > -             pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
> > +             pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
> > +             pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
> >  }
> >
> >  static int __pcpu_map_pages(unsigned long addr, struct page **pages,
> > @@ -284,8 +284,8 @@ static void pcpu_post_map_flush(struct pcpu_chunk
> *chunk,
> >                               int page_start, int page_end)
> >  {
> >       flush_cache_vmap(
> > -             pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, page_start),
> > -             pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, page_end));
> > +             pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, page_start),
> > +             pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, page_end));
> >  }
> >
> >  /**
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index bf80e55..93b5a7c 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -116,9 +116,9 @@ static int pcpu_atom_size __read_mostly;
> >  static int pcpu_nr_slots __read_mostly;
> >  static size_t pcpu_chunk_struct_size __read_mostly;
> >
> > -/* cpus with the lowest and highest unit numbers */
> > -static unsigned int pcpu_first_unit_cpu __read_mostly;
> > -static unsigned int pcpu_last_unit_cpu __read_mostly;
> > +/* cpus with the lowest and highest unit addresses */
> > +static unsigned int pcpu_low_unit_cpu __read_mostly;
> > +static unsigned int pcpu_high_unit_cpu __read_mostly;
> >
> >  /* the address of the first chunk which starts with the kernel static
> area */
> >  void *pcpu_base_addr __read_mostly;
> > @@ -984,19 +984,19 @@ phys_addr_t per_cpu_ptr_to_phys(void *addr)
> >  {
> >       void __percpu *base = __addr_to_pcpu_ptr(pcpu_base_addr);
> >       bool in_first_chunk = false;
> > -     unsigned long first_start, first_end;
> > +     unsigned long first_low, first_high;
> >       unsigned int cpu;
> >
> >       /*
> > -      * The following test on first_start/end isn't strictly
> > +      * The following test on unit_low/high isn't strictly
> >        * necessary but will speed up lookups of addresses which
> >        * aren't in the first chunk.
> >        */
> > -     first_start = pcpu_chunk_addr(pcpu_first_chunk,
> pcpu_first_unit_cpu, 0);
> > -     first_end = pcpu_chunk_addr(pcpu_first_chunk, pcpu_last_unit_cpu,
> > -                                 pcpu_unit_pages);
> > -     if ((unsigned long)addr >= first_start &&
> > -         (unsigned long)addr < first_end) {
> > +     first_low = pcpu_chunk_addr(pcpu_first_chunk, pcpu_low_unit_cpu,
> 0);
> > +     first_high = pcpu_chunk_addr(pcpu_first_chunk, pcpu_high_unit_cpu,
> > +                                  pcpu_unit_pages);
> > +     if ((unsigned long)addr >= first_low &&
> > +         (unsigned long)addr < first_high) {
> >               for_each_possible_cpu(cpu) {
> >                       void *start = per_cpu_ptr(base, cpu);
> >
> > @@ -1233,7 +1233,9 @@ int __init pcpu_setup_first_chunk(const struct
> pcpu_alloc_info *ai,
> >
> >       for (cpu = 0; cpu < nr_cpu_ids; cpu++)
> >               unit_map[cpu] = UINT_MAX;
> > -     pcpu_first_unit_cpu = NR_CPUS;
> > +
> > +     pcpu_low_unit_cpu = NR_CPUS;
> > +     pcpu_high_unit_cpu = NR_CPUS;
> >
> >       for (group = 0, unit = 0; group < ai->nr_groups; group++, unit +=
> i) {
> >               const struct pcpu_group_info *gi = &ai->groups[group];
> > @@ -1253,9 +1255,13 @@ int __init pcpu_setup_first_chunk(const struct
> pcpu_alloc_info *ai,
> >                       unit_map[cpu] = unit + i;
> >                       unit_off[cpu] = gi->base_offset + i *
> ai->unit_size;
> >
> > -                     if (pcpu_first_unit_cpu == NR_CPUS)
> > -                             pcpu_first_unit_cpu = cpu;
> > -                     pcpu_last_unit_cpu = cpu;
> > +                     /* determine low/high unit_cpu */
> > +                     if (pcpu_low_unit_cpu == NR_CPUS ||
> > +                         unit_off[cpu] < unit_off[pcpu_low_unit_cpu])
> > +                             pcpu_low_unit_cpu = cpu;
> > +                     if (pcpu_high_unit_cpu == NR_CPUS ||
> > +                         unit_off[cpu] > unit_off[pcpu_high_unit_cpu])
> > +                             pcpu_high_unit_cpu = cpu;
> >               }
> >       }
> >       pcpu_nr_units = unit;
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
>
>
> --
> Thanks
> Dave
>

--20cf303f63a6da7d8104b2410fb3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Dave,</p>
<p>I will give it a try ASAP.=A0 Unfortunately, ASAP won&#39;t be until Fri=
day.</p>
<p>tim<br></p>
<div class=3D"gmail_quote">On Nov 20, 2011 6:43 PM, &quot;Dave Young&quot; =
&lt;<a href=3D"mailto:dyoung@redhat.com">dyoung@redhat.com</a>&gt; wrote:<b=
r type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On 11/19/2011 02:55 AM, Tejun Heo wrote:<br>
<br>
&gt; Percpu allocator recorded the cpus which map to the first and last<br>
&gt; units in pcpu_first/last_unit_cpu respectively and used them to<br>
&gt; determine the address range of a chunk - e.g. it assumed that the<br>
&gt; first unit has the lowest address in a chunk while the last unit has<b=
r>
&gt; the highest address.<br>
&gt;<br>
&gt; This simply isn&#39;t true. =A0Groups in a chunk can have arbitrary po=
sitive<br>
&gt; or negative offsets from the previous one and there is no guarantee<br=
>
&gt; that the first unit occupies the lowest offset while the last one the<=
br>
&gt; highest.<br>
&gt;<br>
&gt; Fix it by actually comparing unit offsets to determine cpus occupying<=
br>
&gt; the lowest and highest offsets. =A0Also, rename pcu_first/last_unit_cp=
u<br>
&gt; to pcpu_low/high_unit_cpu to avoid confusion.<br>
&gt;<br>
&gt; The chunk address range is used to flush cache on vmalloc area<br>
&gt; map/unmap and decide whether a given address is in the first chunk by<=
br>
&gt; per_cpu_ptr_to_phys() and the bug was discovered by invalid<br>
&gt; per_cpu_ptr_to_phys() translation for crash_note.<br>
&gt;<br>
&gt; Kudos to Dave Young for tracking down the problem.<br>
<br>
<br>
Tejun, thanks<br>
<br>
Now that if addr is not in first trunk it must be in vmalloc area, below<br=
>
logic should be right:<br>
 =A0 =A0 =A0 =A0if (in_first_chunk) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_vmalloc_addr(addr))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __pa(addr);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(vmalloc=
_to_page(addr));<br>
 =A0 =A0 =A0 =A0} else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!is_vmalloc_addr(addr)) /* not possible=
 */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __pa(addr);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(pcpu_ad=
dr_to_page(addr));<br>
<br>
So how about just simply remove in first chunk checking to simplify the<br>
code as followging:<br>
<br>
phys_addr_t per_cpu_ptr_to_phys(void *addr)<br>
{<br>
 =A0 =A0 =A0 =A0if (!is_vmalloc_addr(addr))<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return __pa(addr);<br>
 =A0 =A0 =A0 =A0else<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return page_to_phys(pcpu_addr_to_page(addr)=
);<br>
}<br>
<br>
&gt;<br>
&gt; Signed-off-by: Tejun Heo &lt;<a href=3D"mailto:tj@kernel.org">tj@kerne=
l.org</a>&gt;<br>
&gt; Reported-by: WANG Cong &lt;<a href=3D"mailto:xiyou.wangcong@gmail.com"=
>xiyou.wangcong@gmail.com</a>&gt;<br>
&gt; Reported-by: Dave Young &lt;<a href=3D"mailto:dyoung@redhat.com">dyoun=
g@redhat.com</a>&gt;<br>
&gt; LKML-Reference: &lt;<a href=3D"mailto:4EC21F67.10905@redhat.com">4EC21=
F67.10905@redhat.com</a>&gt;<br>
&gt; Cc: stable @<a href=3D"http://kernel.org" target=3D"_blank">kernel.org=
</a><br>
&gt; ---<br>
&gt; Heh, that&#39;s a stupid bug. =A0Can you please verify this fixes the<=
br>
&gt; problem?<br>
<br>
<br>
I can confirm that the per cpu translation works with this patch, but I<br>
have not managed to finished kdump test because kexec tools refuse<br>
=A0to load the crash kernel. I need more debugging on kexec tools.<br>
<br>
Tim, could you help to test if this patch works for your kdump case?<br>
<br>
&gt;<br>
&gt; Thank you very much.<br>
&gt;<br>
&gt; =A0mm/percpu-vm.c | =A0 12 ++++++------<br>
&gt; =A0mm/percpu.c =A0 =A0| =A0 34 ++++++++++++++++++++--------------<br>
&gt; =A02 files changed, 26 insertions(+), 20 deletions(-)<br>
&gt;<br>
&gt; diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c<br>
&gt; index ea53496..bfad724 100644<br>
&gt; --- a/mm/percpu-vm.c<br>
&gt; +++ b/mm/percpu-vm.c<br>
&gt; @@ -143,8 +143,8 @@ static void pcpu_pre_unmap_flush(struct pcpu_chunk=
 *chunk,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int pag=
e_start, int page_end)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 flush_cache_vunmap(<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, =
page_start),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, p=
age_end));<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, pa=
ge_start),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, p=
age_end));<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0static void __pcpu_unmap_pages(unsigned long addr, int nr_pages)<br=
>
&gt; @@ -206,8 +206,8 @@ static void pcpu_post_unmap_tlb_flush(struct pcpu_=
chunk *chunk,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 int page_start, int page_end)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 flush_tlb_kernel_range(<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, =
page_start),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, p=
age_end));<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, pa=
ge_start),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, p=
age_end));<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0static int __pcpu_map_pages(unsigned long addr, struct page **pages=
,<br>
&gt; @@ -284,8 +284,8 @@ static void pcpu_post_map_flush(struct pcpu_chunk =
*chunk,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int page_s=
tart, int page_end)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 flush_cache_vmap(<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_first_unit_cpu, =
page_start),<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_last_unit_cpu, p=
age_end));<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_low_unit_cpu, pa=
ge_start),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pcpu_chunk_addr(chunk, pcpu_high_unit_cpu, p=
age_end));<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0/**<br>
&gt; diff --git a/mm/percpu.c b/mm/percpu.c<br>
&gt; index bf80e55..93b5a7c 100644<br>
&gt; --- a/mm/percpu.c<br>
&gt; +++ b/mm/percpu.c<br>
&gt; @@ -116,9 +116,9 @@ static int pcpu_atom_size __read_mostly;<br>
&gt; =A0static int pcpu_nr_slots __read_mostly;<br>
&gt; =A0static size_t pcpu_chunk_struct_size __read_mostly;<br>
&gt;<br>
&gt; -/* cpus with the lowest and highest unit numbers */<br>
&gt; -static unsigned int pcpu_first_unit_cpu __read_mostly;<br>
&gt; -static unsigned int pcpu_last_unit_cpu __read_mostly;<br>
&gt; +/* cpus with the lowest and highest unit addresses */<br>
&gt; +static unsigned int pcpu_low_unit_cpu __read_mostly;<br>
&gt; +static unsigned int pcpu_high_unit_cpu __read_mostly;<br>
&gt;<br>
&gt; =A0/* the address of the first chunk which starts with the kernel stat=
ic area */<br>
&gt; =A0void *pcpu_base_addr __read_mostly;<br>
&gt; @@ -984,19 +984,19 @@ phys_addr_t per_cpu_ptr_to_phys(void *addr)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 void __percpu *base =3D __addr_to_pcpu_ptr(pcpu_base_addr)=
;<br>
&gt; =A0 =A0 =A0 bool in_first_chunk =3D false;<br>
&gt; - =A0 =A0 unsigned long first_start, first_end;<br>
&gt; + =A0 =A0 unsigned long first_low, first_high;<br>
&gt; =A0 =A0 =A0 unsigned int cpu;<br>
&gt;<br>
&gt; =A0 =A0 =A0 /*<br>
&gt; - =A0 =A0 =A0* The following test on first_start/end isn&#39;t strictl=
y<br>
&gt; + =A0 =A0 =A0* The following test on unit_low/high isn&#39;t strictly<=
br>
&gt; =A0 =A0 =A0 =A0* necessary but will speed up lookups of addresses whic=
h<br>
&gt; =A0 =A0 =A0 =A0* aren&#39;t in the first chunk.<br>
&gt; =A0 =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 first_start =3D pcpu_chunk_addr(pcpu_first_chunk, pcpu_first=
_unit_cpu, 0);<br>
&gt; - =A0 =A0 first_end =3D pcpu_chunk_addr(pcpu_first_chunk, pcpu_last_un=
it_cpu,<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcpu=
_unit_pages);<br>
&gt; - =A0 =A0 if ((unsigned long)addr &gt;=3D first_start &amp;&amp;<br>
&gt; - =A0 =A0 =A0 =A0 (unsigned long)addr &lt; first_end) {<br>
&gt; + =A0 =A0 first_low =3D pcpu_chunk_addr(pcpu_first_chunk, pcpu_low_uni=
t_cpu, 0);<br>
&gt; + =A0 =A0 first_high =3D pcpu_chunk_addr(pcpu_first_chunk, pcpu_high_u=
nit_cpu,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p=
cpu_unit_pages);<br>
&gt; + =A0 =A0 if ((unsigned long)addr &gt;=3D first_low &amp;&amp;<br>
&gt; + =A0 =A0 =A0 =A0 (unsigned long)addr &lt; first_high) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 for_each_possible_cpu(cpu) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *start =3D per_cpu_pt=
r(base, cpu);<br>
&gt;<br>
&gt; @@ -1233,7 +1233,9 @@ int __init pcpu_setup_first_chunk(const struct p=
cpu_alloc_info *ai,<br>
&gt;<br>
&gt; =A0 =A0 =A0 for (cpu =3D 0; cpu &lt; nr_cpu_ids; cpu++)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 unit_map[cpu] =3D UINT_MAX;<br>
&gt; - =A0 =A0 pcpu_first_unit_cpu =3D NR_CPUS;<br>
&gt; +<br>
&gt; + =A0 =A0 pcpu_low_unit_cpu =3D NR_CPUS;<br>
&gt; + =A0 =A0 pcpu_high_unit_cpu =3D NR_CPUS;<br>
&gt;<br>
&gt; =A0 =A0 =A0 for (group =3D 0, unit =3D 0; group &lt; ai-&gt;nr_groups;=
 group++, unit +=3D i) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct pcpu_group_info *gi =3D &amp;=
ai-&gt;groups[group];<br>
&gt; @@ -1253,9 +1255,13 @@ int __init pcpu_setup_first_chunk(const struct =
pcpu_alloc_info *ai,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unit_map[cpu] =3D unit + i=
;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unit_off[cpu] =3D gi-&gt;b=
ase_offset + i * ai-&gt;unit_size;<br>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pcpu_first_unit_cpu =3D=
=3D NR_CPUS)<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcpu_first_u=
nit_cpu =3D cpu;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcpu_last_unit_cpu =3D cpu;<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* determine low/high unit_c=
pu */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pcpu_low_unit_cpu =3D=3D=
 NR_CPUS ||<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unit_off[cpu] &lt; u=
nit_off[pcpu_low_unit_cpu])<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcpu_low_uni=
t_cpu =3D cpu;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pcpu_high_unit_cpu =3D=
=3D NR_CPUS ||<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unit_off[cpu] &gt; u=
nit_off[pcpu_high_unit_cpu])<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcpu_high_un=
it_cpu =3D cpu;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 pcpu_nr_units =3D unit;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; kexec mailing list<br>
&gt; <a href=3D"mailto:kexec@lists.infradead.org">kexec@lists.infradead.org=
</a><br>
&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/kexec" target=
=3D"_blank">http://lists.infradead.org/mailman/listinfo/kexec</a><br>
<br>
<br>
<br>
--<br>
Thanks<br>
Dave<br>
</blockquote></div>

--20cf303f63a6da7d8104b2410fb3--


--===============7902090120405651089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============7902090120405651089==--

