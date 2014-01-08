Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W0oYY-0006JG-MZ
 for kexec@lists.infradead.org; Wed, 08 Jan 2014 08:32:08 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH] makedumpfile: clean up draft patch
Date: Wed, 8 Jan 2014 08:29:42 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE971D9605@BPXM01GP.gisp.nec.co.jp>
References: <1388146378-25419-1-git-send-email-bhe@redhat.com>
 <20140107014948.GA32590@dhcp-16-105.nay.redhat.com>
In-Reply-To: <20140107014948.GA32590@dhcp-16-105.nay.redhat.com>
Content-Language: ja-JP
MIME-Version: 1.0
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
To: Baoquan He <bhe@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

Hello Baoquan,

Sorry for delay response, I entered a vacation just before
you posted this.

On 2014/01/07 10:51:29, kexec <kexec-bounces@lists.infradead.org> wrote:
> Hi Atsushi,
> 
> Could you please review this draft patch? As we discussed before,
> function update_cyclic_region not only update the cyclic region, but
> also handle the 1st bitmap and 2nd bitmap. For better understanding and
> process, it need be cleaned up. In this patch, struct cycle is
> introduced and can be passed down into functions, but not global. I
> think this clean up is helpful, and no risk.
> 
> What'a your opinion?

Thanks for your work, this idea looks good to me.
However, I found a mistake:

> +static void update_cycle(unsigned long long max, struct cycle *cycle)
> +{
> +	cycle->start_pfn= cycle->end_pfn + 1;
> +	cycle->end_pfn=  cycle->start_pfn + info->pfn_cyclic;
> +
> +	if (cycle->end_pfn > max)
> +		cycle->end_pfn = max;
> +}

According to this function, you must treat a range of a cycle
as below:

   |<----------------- a cycle ------------------->|
---+-----------+-----------+-----------+-----------+----
   |   pfn:N   |  pfn:N+1  |  pfn:N+2  |  pfn:N+3  | ...
---+-----------+-----------+-----------+-----------+----
         A                                   A
         |                                   |
     start_pfn                            end_pfn

However, the existing code treat it as:

   |<------------ a cycle ------------>|
---+-----------+-----------+-----------+-----------+----
   |   pfn:N   |  pfn:N+1  |  pfn:N+2  |  pfn:N+3  | ...
---+-----------+-----------+-----------+-----------+----
         A                                   A
         |                                   |
     start_pfn                            end_pfn

This can be implied from the current iterator like below:

     for (pfn = start_pfn; pfn < end_pfn; pfn++) {
                           ^^^^^^^^^^^^^^
In short, the existing code will not work correctly.

You may feel this design is strange.
This came from the fact that the end of the region's *address*
is the head of pfn:N+1 while it can also be said the tail of pfn:N.
(And this came from the initial version.)

BTW, info->cyclic_start_pfn and info->cyclic_end_pfn are no longer
used, we can get rid of those from makedumpfile.h.


Thanks
Atsushi Kumagai

> Baoquan
> Thanks
> 
> 
> On 12/27/13 at 08:12pm, Baoquan He wrote:
> > Introduce the struct cycle as below just as Hatamaya expected.
> > struct cycle {
> >         uint64_t start_pfn;
> >         uint64_t end_pfn;
> > };
> > 
> >   for (first_cycle(start, max, C); !end_cycle(max, C); \
> >        update_cycle(max, C))
> > 
> > Hi Atsushi and HATAYAMA,
> > 
> > Please help review this draft patch and check if there's any potentia
> > risk. If you think this is in the right way, I can post a formal
> > patchset. I just test the normal operation on kdump and elf format,
> > it works well.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
