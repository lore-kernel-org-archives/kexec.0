Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SzMVb-00023M-E3
 for kexec@lists.infradead.org; Thu, 09 Aug 2012 06:46:17 +0000
Date: Thu, 9 Aug 2012 15:44:40 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-Id: <20120809154440.070492b7cff2eef5a30facaa@mxc.nes.nec.co.jp>
In-Reply-To: <20120808132510.GB15623@redhat.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120806204731.GJ25559@redhat.com>
 <20120808141400.d4c65848973b62e191573795@mxc.nes.nec.co.jp>
 <20120808132510.GB15623@redhat.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com
Cc: kexec@lists.infradead.org

Hello Vivek,

On Wed, 8 Aug 2012 09:25:10 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Wed, Aug 08, 2012 at 02:14:00PM +0900, Atsushi Kumagai wrote:
> > Hello Vivek,
> > 
> > On Mon, 6 Aug 2012 16:47:31 -0400
> > Vivek Goyal <vgoyal@redhat.com> wrote:
> > 
> > > On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
> > > > Hello,
> > > > 
> > > > I improved prototype of cyclic processing as version 2.
> > > > If there is no objection to basic idea, I want to consider the things
> > > > related to performance as next step. (Concretely, buffer size and the patch set
> > > > HATAYAMA-san sent a short time ago.) 
> > > 
> > > Hi Atsushi San,
> > > 
> > > Just checking that what's the state of these patches now. Are they ready
> > > to be included in makedumpfile?
> > 
> > Yes, v2 patches with some fixes are ready to be merged into mainline.
> > At this time, makedumpfile can work in constant memory space.
> > (To make sure it's correct, we need to see the result of HATAYAMA-san's benchmark.)
> > 
> > > I would love to see new makedumpfile where memory usage does not grow
> > > by physical memory present in the system. (Assuming computig overhead
> > > of cycles is bearable).
> > 
> > I planed to release the next version with the new method to exclude free pages
> > (based on HATAYAMA-san's RFC patches). This method looks up members of each page
> > instead of free_list, it's only for performance.
> > 
> >   http://lists.infradead.org/pipermail/kexec/2012-June/006441.html
> > 
> > But, this method need more time for consideration, review and test.
> > 
> > 
> > If you need the new makedumpfile which can work in constant memory space soon,
> > shall I release the new version as soon as possible ? 
> > (But, this version still looks up free_list to exclude free pages same as v1.4.4.)
> > 
> 
> I think once Hatayama's testing is done, it is a good idea to merge cyclic
> patches and make a release. And soon after review and testing, merge
> hatayama's other patches of walking through mem_map array. My understanding
> is that walking through mem_map array will save us cpu cycles in fixed
> memory usage mode.

OK, I start to prepare for the release of the next version with cyclic patches.

Your understanding of walking through mem_map array is correct, it's expected
to reduce wasteful process in fixed memory usage mode.

  http://lists.infradead.org/pipermail/kexec/2012-July/006543.html


Thanks 
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
