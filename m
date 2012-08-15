Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1T1dgj-0001nH-3D
 for kexec@lists.infradead.org; Wed, 15 Aug 2012 13:31:10 +0000
Date: Wed, 15 Aug 2012 09:31:03 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-ID: <20120815133102.GA17033@redhat.com>
References: <20120807.163120.106259238.d.hatayama@jp.fujitsu.com>
 <20120810.173938.37160718.d.hatayama@jp.fujitsu.com>
 <20120810143655.GA5416@redhat.com>
 <20120814.205532.509440957.d.hatayama@jp.fujitsu.com>
 <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120815152710.982b745a50673defdf9aabd1@mxc.nes.nec.co.jp>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: d.hatayama@jp.fujitsu.com, kexec@lists.infradead.org

On Wed, Aug 15, 2012 at 03:27:10PM +0900, Atsushi Kumagai wrote:

[..]
> > >> 
> > >> STEP [Excluding free pages       ] : 49.846321 seconds
> > >> STEP [Excluding unnecessary pages] : 6.339228 seconds
> > >> STEP [Excluding free pages       ] : 48.595884 seconds
> > >> STEP [Excluding unnecessary pages] : 6.530479 seconds
> > >> STEP [Excluding free pages       ] : 48.598879 seconds
> > >> STEP [Excluding unnecessary pages] : 6.527133 seconds
> > >> STEP [Excluding free pages       ] : 48.602401 seconds
> > >> STEP [Excluding unnecessary pages] : 6.502681 seconds
> > >> STEP [Excluding free pages       ] : 48.602010 seconds
> > >> STEP [Excluding unnecessary pages] : 6.469853 seconds
> > >> STEP [Excluding free pages       ] : 48.601637 seconds
> > >> STEP [Excluding unnecessary pages] : 6.431381 seconds
> > >> STEP [Excluding free pages       ] : 48.601195 seconds
> > >> STEP [Excluding unnecessary pages] : 6.416676 seconds
> > >> STEP [Excluding free pages       ] : 48.602221 seconds
> > >> STEP [Excluding unnecessary pages] : 6.387611 seconds
> > >> STEP [Excluding free pages       ] : 48.589972 seconds
> > >> STEP [Excluding unnecessary pages] : 0.816955 seconds
> > > 
> > > So what does above represent. Each step is taking 48 seconds or total
> > > time taken to filter vmcore is 48 seconds? What's the buffer size used
> > > here.
> > > 
> > 
> > The free_list logic always filteres a whole memory range even if the
> > range we need to filter is only a cerntain part, so it took about 48
> > seconds at each cycle.
> 
> It seems that the mem_map array logic is effective especially in large machine.
> I'll review your mem_map array patchset after the next version is released.

Yes please review and merge mem_map array changes also. This seems to be
resulting in signifacnt saving. According to numbers above, looks like it cuts
down filtering time by 9 times.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
