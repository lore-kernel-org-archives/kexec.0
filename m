Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1W7hzl-0006MY-0x
 for kexec@lists.infradead.org; Mon, 27 Jan 2014 08:56:42 +0000
Date: Mon, 27 Jan 2014 16:55:26 +0800
From: Baoquan He <bhe@redhat.com>
Subject: Re: [v2 2/3] makedumpfile: use struct cycle to update cyclic region
 and clean up
Message-ID: <20140127085526.GB1481@dhcp-16-105.nay.redhat.com>
References: <1390470454-14272-1-git-send-email-bhe@redhat.com>
 <1390470454-14272-3-git-send-email-bhe@redhat.com>
 <52E5DA76.7070702@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52E5DA76.7070702@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org

On 01/27/14 at 01:03pm, HATAYAMA Daisuke wrote:
> (2014/01/23 18:47), Baoquan He wrote:
> 
> > @@ -3301,18 +3301,15 @@ set_bitmap(struct dump_bitmap *bitmap, unsigned long long pfn,
> >   }
> >   
> >   int
> > -set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val)
> > +set_bitmap_cyclic(char *bitmap, unsigned long long pfn, int val, struct cycle *cycle)
> >   {
> >   	int byte, bit;
> >   
> > -	if (pfn < info->cyclic_start_pfn || info->cyclic_end_pfn <= pfn)
> > -		return FALSE;
> > -
> 
> Removing this check changes behaviour, not just clean up, so should be separated into another patch.
> 
> Further, this change seems buggy because, in addition to Kumaga-san's comment, memory outside of
> cycle region can be passed to here. Please look at the below.

Hi Both,

I understand your finding. How about put the pfn checking back to
set_bitmap_cyclic(). Maybe this is simpler and safer. Otherwise each
case need be taken care and adding the pfn checking.


> 
> > @@ -4782,10 +4780,10 @@ exclude_unnecessary_pages_cyclic(void)
> >   			if (mmd->mem_map == NOT_MEMMAP_ADDR)
> >   				continue;
> >   
> > -			if (mmd->pfn_end >= info->cyclic_start_pfn &&
> > -			    mmd->pfn_start <= info->cyclic_end_pfn) {
> > +			if (mmd->pfn_end >= cycle->start_pfn &&
> > +			    mmd->pfn_start <= cycle->end_pfn) {
> >   				if (!__exclude_unnecessary_pages(mmd->mem_map,
> > -								 mmd->pfn_start, mmd->pfn_end))
> > +								 mmd->pfn_start, mmd->pfn_end, cycle))
> >   					return FALSE;
> >   			}
> >   		}
> 
> After this clean up, __exclude_unnecessary_pages() processes memory within cycle region only.
> So, it's necessary to pass adjusted range, like:
> 
> if (MAX(mmd->pfn_start, cycle->start_pfn) < MIN(mmd->pfn_end, cycle->end_pfn))
>   __exclude_unnecessary_pages(mmd->mem_map, MAX(mmd->pfn_start, cycle->start_pfn), MIN(mmd->pfn_end, cycle->end_pfn))
> 
> -- 
> Thanks.
> HATAYAMA, Daisuke
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
