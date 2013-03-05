Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UChZL-0002PH-Jc
 for kexec@lists.infradead.org; Tue, 05 Mar 2013 02:25:32 +0000
Date: Tue, 5 Mar 2013 11:25:28 +0900
From: Simon Horman <simon@horms.net>
Subject: Re: [PATCH] kexec,x86: code optimization and adjustment for
 add_memmap and delete_memmap
Message-ID: <20130305022528.GA28868@verge.net.au>
References: <512B5B51.2060209@cn.fujitsu.com>
 <20130226.095814.331287795.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130226.095814.331287795.d.hatayama@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, zhangyanfei@cn.fujitsu.com

On Tue, Feb 26, 2013 at 09:58:14AM +0900, HATAYAMA Daisuke wrote:
> From: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> Subject: [PATCH] kexec,x86: code optimization and adjustment for add_memmap and delete_memmap
> Date: Mon, 25 Feb 2013 20:38:41 +0800
> 
> > The code in the two functions seems a little messy, So I modify
> > some of them, trying to make the logic more clearly.
> > 
> > For example,
> > code before:
> > 
> >          for (i = 0; i < CRASH_MAX_MEMMAP_NR;  i++) {
> >                  mstart = memmap_p[i].start;
> >                  mend = memmap_p[i].end;
> >                  if (mstart == 0 && mend == 0)
> >                          break;
> > 
> > for we already have nr_entries for this memmap_p array, so we needn't
> > have a check in every loop to see if we have go through the whole array.
> > code after:
> > 
> >          for (i = 0; i < nr_entries; i++) {
> >  		mstart = memmap_p[i].start;
> >  		mend = memmap_p[i].end;
> > 
> 
> Then, but even if doing so, times of the loop is unchanged after your
> fix. The loop doesn't always look up a whole part of memmap_p; it
> looks up until it reaches the end of elements with 0 in their members.
> Also, CRASH_MAX_MEMMAP_NR is 17 on i386. Is it problematic in
> performance?
> 
> Rather, it seems problematic to me how length of memmap_p is handled
> here. It is initialized first here:
> 
>         /* Memory regions which panic kernel can safely use to boot into */
>         sz = (sizeof(struct memory_range) * (KEXEC_MAX_SEGMENTS + 1));
>         memmap_p = xmalloc(sz);
>         memset(memmaSp_p, 0, sz);
> 
> and then it is passed to add_memmap,
> 
>         add_memmap(memmap_p, info->backup_src_start, info->backup_src_size);
> 
> and there the passed memmap_p is assumed to have length of
> CRASH_MAX_MEMMAP_NR that is defined as (KEXEC_MAX_SEGMENTS + 1)
> according to the condition of the for loop above. (The
> (KEXEC_MAX_SEGMENTS + 1) in the allocation should also be
> CRASH_MAX_MEMMAP_NR for clarification?)
> 
> The ideas I have for cleaning up here, are for example:
> 
> - introduce specific for-each statement to iterate memmap_p just like:
> 
>   for_each_memmap(memmap_p, start, end) {
>     ...
>   }
> 
>   or
> 
> - use struct memory_ranges instead of struct memory_range and pass it
>   to add_memmap; the former has size member in addition to ranges
>   member, and then in add_memmap:
> 
>   for (i = 0; i < ranges.size; i++) {
>     mstart = ranges.ranges[i].start;
>     mend = ranges.ranges[i].end;
>   }
> 
> The former hides actual length of memmap_p from users because they
> don't need to care about it, while the latter makes length of memmap_p
> explicitly handled even in add_memmp.
> 
> But sorry, this idea comes from some minuts look on the code around.
> 
> Also, you should have divided the patch into two: nr_entires part and
> the others.

For the record, I am not taking this change unless some
consensus is reached.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
