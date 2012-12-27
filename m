Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1To8y4-0008K4-To
 for kexec@lists.infradead.org; Thu, 27 Dec 2012 08:37:34 +0000
Date: Thu, 27 Dec 2012 17:35:23 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v2] Add the values related to buddy system for filtering
 free pages.
Message-Id: <20121227173523.5e414c342fed3e59a887fa87@mxc.nes.nec.co.jp>
In-Reply-To: <87licsrwpg.fsf@xmission.com>
References: <20121210103913.020858db777e2f48c59713b6@mxc.nes.nec.co.jp>
 <20121219161856.e6aa984f.akpm@linux-foundation.org>
 <20121220112103.d698c09a9d1f27a253a63d37@mxc.nes.nec.co.jp>
 <33710E6CAA200E4583255F4FB666C4E20AB2DEA3@G01JPEXMBYT03>
 <87licsrwpg.fsf@xmission.com>
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
To: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, d.hatayama@jp.fujitsu.com, ebiederm@xmission.com, akpm@linux-foundation.org, cpw@sgi.com

Hello,

On Thu, 20 Dec 2012 18:00:11 -0800
ebiederm@xmission.com (Eric W. Biederman) wrote:

> "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com> writes:
> 
> >> From: kexec-bounces@lists.infradead.org
> >> [mailto:kexec-bounces@lists.infradead.org] On Behalf Of Atsushi Kumagai
> >> Sent: Thursday, December 20, 2012 11:21 AM
> >
> >> On Wed, 19 Dec 2012 16:18:56 -0800
> >> Andrew Morton <akpm@linux-foundation.org> wrote:
> >> 
> >> > On Mon, 10 Dec 2012 10:39:13 +0900
> >> > Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp> wrote:
> >> >
> >
> >> >
> >> > We might change the PageBuddy() implementation at any time, and
> >> > makedumpfile will break.  Or in this case, become less efficient.
> >> >
> >> > Is there any way in which we can move some of this logic into the
> >> > kernel?  In this case, add some kernel code which uses PageBuddy() on
> >> > behalf of makedumpfile, rather than replicating the PageBuddy() logic
> >> > in userspace?
> >> 
> >> In last month, Cliff Wickman proposed such idea:
> >> 
> >>   [PATCH v2] makedumpfile: request the kernel do page scans
> >>   http://lists.infradead.org/pipermail/kexec/2012-November/007318.html
> >> 
> >>   [PATCH] scan page tables for makedumpfile, 3.0.13 kernel
> >>   http://lists.infradead.org/pipermail/kexec/2012-November/007319.html
> >> 
> >> In his idea, the kernel does page scans to distinguish unnecessary pages
> >> (free pages and others) and returns the list of PFN's which should be
> >> excluded for makedumpfile.
> >> As a result, makedumpfile doesn't need to consider internal kernel
> >> behavior.
> >> 
> >> I think it's a good idea from the viewpoint of maintainability and
> >> performance.
> 
> > I also think wide part of his code can be reused in this work. But the bad
> > performance is caused by a lot of ioremap, not a lot of copying. See my
> > profiling result I posted some days ago. Two issues, ioremap one and filtering
> > maintainability, should be considered separately. Even on ioremap issue,
> > there is secondary one to consider in memory consumption on the 2nd
> > kernel.
> 
> Thanks.  I was wondering why moving the code into /proc/vmcore would
> make things faster.

Thanks HATAYAMA-san, I've understood the issues correctly.
We should continue improving the ioremap issue as Cliff and HATAYAMA-san
are doing now.

> 
> > Also, I have one question. Can we always think of 1st and 2nd kernels
> > are same?
> 
> Not at all.  Distros frequently implement it with the same kernel in
> both role but it should be possible to use an old crusty stable kernel
> as the 2nd kernel.
> 
> > If I understand correctly, kexec/kdump can use the 2nd kernel different
> > from the 1st's. So, differnet kernels need to do the same thing as makedumpfile
> > does. If assuming two are same, problem is mush simplified.
> 
> As a developer it becomes attractive to use a known stable kernel to
> capture the crash dump even as I experiment with a brand new kernel.

To allow to use the 2nd kernel different from the 1st's, I think we have
to take care of each kernel version with the logic included in makedumpfile
for them. That's to say, makedumpfile goes on as before.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
