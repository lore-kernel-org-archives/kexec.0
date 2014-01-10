Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W1YT3-0004Lk-S6
 for kexec@lists.infradead.org; Fri, 10 Jan 2014 09:33:30 +0000
Date: Fri, 10 Jan 2014 17:32:09 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: clean up draft patch
Message-ID: <20140110093209.GB14074@dhcp-16-105.nay.redhat.com>
References: <1388146378-25419-1-git-send-email-bhe@redhat.com>
 <20140107014948.GA32590@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971D9605@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971D9605@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>

 
> > +static void update_cycle(unsigned long long max, struct cycle *cycle)
> > +{
> > +	cycle->start_pfn= cycle->end_pfn + 1;
> > +	cycle->end_pfn=  cycle->start_pfn + info->pfn_cyclic;
> > +
> > +	if (cycle->end_pfn > max)
> > +		cycle->end_pfn = max;
> > +}
> 
> According to this function, you must treat a range of a cycle
> as below:
> 
>    |<----------------- a cycle ------------------->|
> ---+-----------+-----------+-----------+-----------+----
>    |   pfn:N   |  pfn:N+1  |  pfn:N+2  |  pfn:N+3  | ...
> ---+-----------+-----------+-----------+-----------+----
>          A                                   A
>          |                                   |
>      start_pfn                            end_pfn
> 
> However, the existing code treat it as:
> 
>    |<------------ a cycle ------------>|
> ---+-----------+-----------+-----------+-----------+----
>    |   pfn:N   |  pfn:N+1  |  pfn:N+2  |  pfn:N+3  | ...
> ---+-----------+-----------+-----------+-----------+----
>          A                                   A
>          |                                   |
>      start_pfn                            end_pfn
> 
> This can be implied from the current iterator like below:
> 
>      for (pfn = start_pfn; pfn < end_pfn; pfn++) {
>                            ^^^^^^^^^^^^^^
> In short, the existing code will not work correctly.

Yeah, you are quite right. This need be corrected. Will change in formal
patch.

> 
> You may feel this design is strange.
> This came from the fact that the end of the region's *address*
> is the head of pfn:N+1 while it can also be said the tail of pfn:N.
> (And this came from the initial version.)
> 
> BTW, info->cyclic_start_pfn and info->cyclic_end_pfn are no longer
> used, we can get rid of those from makedumpfile.h.

Ok, will change.



> 
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
