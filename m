Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Utgd2-0001Qj-V0
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 16:07:01 +0000
Date: Mon, 1 Jul 2013 12:06:36 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: 32TB kdump
Message-ID: <20130701160635.GB9840@redhat.com>
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com>
 <51D0D399.1070501@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51D0D399.1070501@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

On Mon, Jul 01, 2013 at 09:55:53AM +0900, HATAYAMA Daisuke wrote:
> (2013/06/28 6:17), Vivek Goyal wrote:
> >On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:
> 
> >
> >Try using snappy or lzo for faster compression.
> >
> >>   So a good workaround for a very large system might be to dump uncompressed
> >>   to an SSD.
> >
> >Interesting.
> >
> >>   The multi-threading of the crash kernel would produce a big gain.
> >
> >Hatayama once was working on patches to bring up multiple cpus in second
> >kernel. Not sure what happened to those patches.
> >
> >>- Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
> >>   to 3 minutes.  It also increased data copying speed (unexpectedly) from
> >>   38min. to 35min.
> >
> >Hmm.., so on large memory systems, mmap() will not help a lot? In those
> >systems dump times are dominidated by disk speed and compression time.
> >
> >So far I was thinking that ioremap() per page was big issue and you
> >also once had done the analysis that passing page list to kernel made
> >things significantly faster.
> >
> >So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
> >it by only few minutes, it really is not significant win.
> >
> 
> Sorry, I've explained this earlier in this ML.
> 
> Some patches have been applied on makedumpfile to improve the filtering speed.
> Two changes that were useful for the improvement are the one implementing
> a 8-slot cache for physical page for the purpose of reducing the number of
> /proc/vmcore access for paging (just as TLB), and the one that cleanups
> makedumpfile's filtering path.

So biggest performance improvement came from implementing some kind of
TLB cache in makedumpfile?

> 
> Performance degradation by ioremap() is now being hided on a single cpu, but
> it would again occur on multiple cpus. Sorry, but I have yet to do benchmark
> showing the fact cleanly as numeral values.

IIUC, are you saying that now ioremap() overhead per page is not very
significant on single cpu system (after above makeudmpfile changes). And
that's the reason using mmap() does not show a very significant
improvement in overall scheme of things. And these overheads will become
more important when multiple cpus are brought up in kdump environment.

Please correct me if I am wrong, I just want to understand it better. So
most of our performance problems w.r.t to scanning got solved by
makeumpdfile changes and mmap() changes bring us only little bit of
improvements in overall scheme of things on large machines?

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
