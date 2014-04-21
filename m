Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcFu6-00016B-AT
 for kexec@lists.infradead.org; Mon, 21 Apr 2014 15:13:06 +0000
Date: Mon, 21 Apr 2014 11:12:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140421151240.GB4367@redhat.com>
References: <20140410214433.GF18808@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

On Fri, Apr 18, 2014 at 09:22:26AM +0000, Atsushi Kumagai wrote:
> >On 04/17/14 at 12:52pm, Baoquan He wrote:
> >> On 04/17/14 at 04:01am, Atsushi Kumagai wrote:
> >> > Hello Baoquan,
> >> >
> >> > >Hi Atsushi,
> >> > >
> >> > >I have got the test machine where bug reported and did a test. The
> >> > >changed code can make elf dump successful.
> >> >
> >> > Great, thanks for your help!
> >> > However, I still have questions.
> >> >
> >> > First, what is the difference between yours and mine?
> >> >
> >> > http://lists.infradead.org/pipermail/kexec/2014-April/011535.html
> >>
> >> Yeah, you are right, it's the same on changing the code bug. I mush
> >> haven't read your patch carefully.
> >                                                          must<--
> >>
> >> >
> >> > My patch includes renaming some values, but the purpose looks
> >> > the same as yours.
> >> > Further, you described as below,
> >> >
> >> > >On 04/14/14 at 04:02pm, Baoquan He wrote:
> >> > but I still don't think this bug causes OOM.
> >> > Even if needed_size is calculated as so much size wrongly, bufsize_cyclic
> >> > will not exceed 40% of free memory by the check below:
> >> >
> >> >     info->bufsize_cyclic = (free_size <= needed_size) ? free_size : needed_size;
> >> >
> >> > So it looks that bitmap1(40%) and bitmap2(40%) will fit in 80% of free
> >> > memory in any case.
> >> >
> >> > I may misunderstand something since your patch has an effect on this
> >> > issue in practice, could you correct me?
> >>
> >> It definitely will cause OOM. On my test machine, it has 100G memory. So
> >> per old code, its needed_size is 3200K*2 == 6.4M, if currently free
> >> memory is only 15M left, the free_size will be 15M*0.4 which is 6M. So
> >> info->bufsize_cyclic is assigned to be 6M. and only 3M is left for other
> >> use, e.g page cache, dynamic allocation. OOM will happen.
> >>
> >
> >BTW, in our case, there's about 30M free memory when we started saving
> >dump. It should be caused by my coarse estimation above.
> 
> Thanks for your description, I understand that situation and
> the nature of the problem.
> 
> That is, the assumption that 20% of free memory is enough for
> makedumpfile can be broken if free memory is too small.
> If your machine has 200GB memory, OOM will happen even after fix
> the too allocation bug.

Why? In cyclic mode, shouldn't makedumpfile's memory usage be fixed
and should not be dependent on amount of RAM present in the system?

Also, so even 30MB is not sufficient to run makedumpfile. That looks
like a lot of free memory to me. 

> 
> I don't think this is a problem, it's natural that a lack of memory
> causes OOM. However, there is a thing we can do for improvement. 
> 
> What I think is:
> 
>   1. Use a constant value as safe limit to calculate bufsize_cyclic
>      instead of 80% of free memory. This value must be enough for
>      makedumpfile's work except bitmap.
> 
>   2. If free memory is smaller than the value, makedumpfile gives up
>      to work early.

What do we gain by makedumpfile giving up. System will reboot. System
will reboot anyway after OOM.

> 
> This change may reduce the possibility of lack of memory, but the
> required memory size will be changing every version, so maintaining
> it sounds tough to me.

I think we need to dive deeper to figure out why 30MB of free memory
is not sufficient. To me something looks wrong here.

Secondly, I think using absolute values is not a good idea. It will be
very hard to keep track and udpate that value. 

At max we can warn saying makedumpfile needs X MB of memory and only
Y MB of free memory is available.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
