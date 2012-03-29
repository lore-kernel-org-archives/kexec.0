Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1SDFM9-0006uf-Uj
 for kexec@lists.infradead.org; Thu, 29 Mar 2012 13:25:39 +0000
Date: Thu, 29 Mar 2012 09:25:33 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: makedumpfile memory usage grows with system memory size
Message-ID: <20120329132533.GM18218@redhat.com>
References: <20120328212204.GI18218@redhat.com>
 <20120329170918.4223e816.oomichi@mxs.nes.nec.co.jp>
 <20120329.215646.28793982.d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120329.215646.28793982.d.hatayama@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: oomichi@mxs.nes.nec.co.jp, kexec@lists.infradead.org

Hello Daisuke,

On Thu, Mar 29, 2012 at 09:56:46PM +0900, HATAYAMA Daisuke wrote:
> Hello Don,
> 
> I'm missing your mail somehow so replying Oomichi-san's mail...
> 
> From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
> Subject: Re: makedumpfile memory usage grows with system memory size
> Date: Thu, 29 Mar 2012 17:09:18 +0900
> 
> > 
> > On Wed, 28 Mar 2012 17:22:04 -0400
> > Don Zickus <dzickus@redhat.com> wrote:
> 
> >> I was curious if that was true and if it was, would it be possible to only
> >> process memory in chunks instead of all at once.
> >> 
> >> The idea is that a machine with 4Gigs of memory should consume the same
> >> the amount of kdump runtime memory as a 1TB memory system.
> >> 
> >> Just trying to research ways to keep the memory requirements consistent
> >> across all memory ranges.
> 
> I think this is possible in constant memory space by creating bitmaps
> and writing pages in a certain amount of memory. That is, if choosing
> 4GB, do [0, 4GB) space processing, [4GB, 8GB) space processing, [8GB,
> 12GB) ... in order. The key is to restrict the target memory range of
> filtering.

Yes, that was what I was thinking.  I am glad to hear that is possible.
Is there some place in the code that I can help try out that idea?  I
would also be curious if there is a 'time' impact on how long it takes to
process this (for example, would it add a couple of milliseconds overhead
or seconds overhead).

Thanks,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
