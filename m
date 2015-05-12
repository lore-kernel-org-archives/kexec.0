Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mgwkm02.jp.fujitsu.com ([202.219.69.169])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Ys5RA-0003Oo-Tr
 for kexec@lists.infradead.org; Tue, 12 May 2015 08:21:13 +0000
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
 by yt-mxoi1.gw.nic.fujitsu.com (Postfix) with ESMTP id 7FDA7AC0331
 for <kexec@lists.infradead.org>; Tue, 12 May 2015 17:20:45 +0900 (JST)
Date: Tue, 12 May 2015 17:20:35 +0900 (JST)
Message-Id: <20150512.172035.461774614.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using
 bitmap file.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA325@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE9701DAA325@BPXM01GP.gisp.nec.co.jp>
Mime-Version: 1.0
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
To: ats-kumagai@wm.jp.nec.com
Cc: kexec@lists.infradead.org

Hello Kumagai-san,

From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: [PATCH 0/13] makedumpfile: Avoid two pass filtering by using bitmap file.
Date: Mon, 11 May 2015 06:13:51 +0000

> Hello,
> 
> This is the patch set to avoid two pass filtering, it is the
> finished version of the previous patch set below:
> 
>   http://lists.infradead.org/pipermail/kexec/2015-March/013497.html
> 
> 
> cyclic mode has to take a two-pass approach for filtering to save on the
> memory consumption, it's a disadvantage of the cyclic mode and it's basically
> unavoidable. However, even the cyclic mode can avoid two-pass filtering if free
> memory space is enough to store the whole 1st and 2nd bitmaps, but the current
> version doesn't it.
> The main purpose of this patch set is avoiding that useless filtering,
> but before that, I merged non-cyclic mode into cyclic mode as code clean up 
> because the codes are almost the same. Instead, I introduce another way to
> guarantee one-pass filtering by using disk space.
> 

How about compromising progress information to some extent? The first
pass is intended to count up the exact number of dumpable pages just
to provide precise progress information. Is such prcision really
needed?

For example, how about another simple progress information:

   pfn / max_mapnr

where pfn is the number of a page frame that is currently
processed. We know max_mapnr from the beginning, so this is possible
within one pass. It's less precise but might be precise enough.

--
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
