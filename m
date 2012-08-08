Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Syycc-0003WV-96
 for kexec@lists.infradead.org; Wed, 08 Aug 2012 05:15:56 +0000
Date: Wed, 8 Aug 2012 14:14:00 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
Message-Id: <20120808141400.d4c65848973b62e191573795@mxc.nes.nec.co.jp>
In-Reply-To: <20120806204731.GJ25559@redhat.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120806204731.GJ25559@redhat.com>
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

On Mon, 6 Aug 2012 16:47:31 -0400
Vivek Goyal <vgoyal@redhat.com> wrote:

> On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
> > Hello,
> > 
> > I improved prototype of cyclic processing as version 2.
> > If there is no objection to basic idea, I want to consider the things
> > related to performance as next step. (Concretely, buffer size and the patch set
> > HATAYAMA-san sent a short time ago.) 
> 
> Hi Atsushi San,
> 
> Just checking that what's the state of these patches now. Are they ready
> to be included in makedumpfile?

Yes, v2 patches with some fixes are ready to be merged into mainline.
At this time, makedumpfile can work in constant memory space.
(To make sure it's correct, we need to see the result of HATAYAMA-san's benchmark.)

> I would love to see new makedumpfile where memory usage does not grow
> by physical memory present in the system. (Assuming computig overhead
> of cycles is bearable).

I planed to release the next version with the new method to exclude free pages
(based on HATAYAMA-san's RFC patches). This method looks up members of each page
instead of free_list, it's only for performance.

  http://lists.infradead.org/pipermail/kexec/2012-June/006441.html

But, this method need more time for consideration, review and test.


If you need the new makedumpfile which can work in constant memory space soon,
shall I release the new version as soon as possible ? 
(But, this version still looks up free_list to exclude free pages same as v1.4.4.)


Thanks
Atsushi Kumagai

> Thanks
> Vivek
> 
> > 
> > 
> > Version 1:
> >  
> >   http://lists.infradead.org/pipermail/kexec/2012-May/006363.html
> > 
> > Introduction:
> > 
> >  - The purpose of cyclic processing is to fix memory consumption.
> >  - cyclic processing doesn't use temporary bitmap file, store partial bitmap data
> >    in memory only for each cycle instead.
> >  - The prototype was passed the regression test which is used by every release.
> > 
> > How to use:
> >   
> >   Specify '--cyclic' option, then makedumpfile works cyclically.
> > 
> > Example:
> > 
> >     $ makedumpfile --cyclic -cd31 vmcore testdump.cd31
> >     Copying data                       : [  5 %]
> >     Excluding free pages               : [100 %]
> >     ...
> >     Excluding free pages               : [100 %]
> >     Copying data                       : [100 %]
> > 
> >     The dumpfile is saved to testdump.cd31.
> > 
> >     makedumpfile Completed.
> > 
> > Changelog:
> > 
> >   v1 =>  v2:
> > 
> >     - Fix the process of increasing target region.
> >     - Change method for kdump-compressed format.
> >     - Add support for ELF format.
> >     - Add support for --split option.
> >  
> > Memory consumption:
> > 
> >   I measured the RSS of makedumpfile with ps(1) as memory consumption.
> > 
> >     a. working for 5G memory:
> >                  |                 RSS [KB]                
> >                  |  no option  |    -cd31    |    -Ed31
> >       -----------+-------------+-------------+-------------
> >         v1.4.4   |     1108    |     1184    |      868
> >         cyclic   |     2976    |     3252    |     2984
> > 
> >         
> >     b. working for 8G memory:
> >                  |                 RSS [KB]                
> >                  |  no option  |    -cd31    |    -Ed31
> >       -----------+-------------+-------------+-------------
> >         v1.4.4   |     1108    |     1180    |      864
> >         cyclic   |     2972    |     3256    |     2984
> > 
> > 
> >   This result seems to say that v1.4.4 is better than cyclic, but the size
> >   of temporary bitmap file grows based on memory size. The increasing rate 
> >   can be represented as (memory size / 4K / 8 ) * 2.
> > 
> >      memory size [GB] |  bitmap size [KB]
> >     ------------------+------------------
> >             5         |       320
> >             8         |       512
> >            ...        |       ...
> >           1,024       |      65,536
> > 
> >   Even above size will be counted as memory consumption, if the system 
> >   doesn't mount rootfs. This is the cause of the memory consumption issue
> >   we discussed.
> > 
> >   On the other hand, cyclic processing doesn't use temporary bitmap files,
> >   all memory consumption will be appeared in RSS.
> >   The memory consumption to store bitmap will be kept around 2MB(BUFSIZE_CYCLIC * 2).
> >   
> > 
> > Thanks
> > Atsushi Kumagai
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
