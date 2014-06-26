Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X08q4-0008T3-Ov
 for kexec@lists.infradead.org; Thu, 26 Jun 2014 12:31:41 +0000
Date: Thu, 26 Jun 2014 08:31:18 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] Makedumpfile: vmcore size estimate
Message-ID: <20140626123118.GB11136@redhat.com>
References: <1402490345-18656-1-git-send-email-bhe@redhat.com>
 <20140611135701.GA1592@dhcp-17-102.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9722440E@BPXM01GP.gisp.nec.co.jp>
 <20140623125723.GB29112@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9723992E@BPXM01GP.gisp.nec.co.jp>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>

On Thu, Jun 26, 2014 at 08:21:58AM +0000, Atsushi Kumagai wrote:
> >On Fri, Jun 20, 2014 at 01:07:52AM +0000, Atsushi Kumagai wrote:
> >> Hello Baoquan,
> >>
> >> >Forget to mention only x86-64 is processed in this patch.
> >> >
> >> >On 06/11/14 at 08:39pm, Baoquan He wrote:
> >> >> User want to get a rough estimate of vmcore size, then they can decide
> >> >> how much storage space is reserved for vmcore dumping. This can help them
> >> >> to deploy their machines better, possibly hundreds of machines.
> >>
> >> You suggested this feature before, but I don't still agree with this.
> >>
> >> No one can guarantee that the vmcore size will be below the estimated
> >> size every time. However, if makedumpfile provides "--vmcore-estimate",
> >> some users may trust it completely and disk overflow might happen.
> >> Ideally, users should prepare the disk which can store the possible
> >> maximum size of vmcore. Of course they can reduce the disk size on their
> >> responsibility, but makedumpfile can't help it as official feature.
> >
> >Hi Atsushi,
> >
> >Recently quite a few people have asked us for this feature. They manage
> >lots of system and have attached local disk or partition for saving
> >dump. Now say a system has few Tera bytes of memory and dedicating one
> >partition of size of few tera bytes per machine just for saving dump might
> >not be very practical.
> >
> >I was given the example that AIX supports this kind of estimates too and
> >in fact looks like they leave a message if they find that current dump
> >partition size will not be sufficient to save dump.
> >
> >I think it is a good idea to try to solve this problem. We might not be
> >accurate but it will be better than user guessing that by how much to
> >reduce the partition size.
> >
> >I am wondering what are the technical concerns. IIUC, biggest problem is that
> >number of pages dumped will vary as system continues to run. So
> >immediately after boot number of pages to be dumped might be small but
> >as more applications are launched, number of pages to be dumped will
> >incresae, most likely.
> 
> Yes, the actual dump size will be different from the estimated size, so 
> this feature sounds incomplete and irresponsible to me.
> The gap of size may be small in some cases especially when the dump level
> is 31, but it will be variable basically, therefore I don't want to show
> such an inaccurate value by makedumpfile.

Hi Atsushi,

I am wondering why it will not be accurate or atleast close to accurate.
Technically we should be able to walk through all the struct pages and
decide which ones will be dumped based on filtering level. And that should
give us pretty good idea of dump size. Isn't it.

So for a *given momment in time* our estimates should be pretty close for
all dump levels.

What is variable though is that this estimate will change as more
applications are launched and devices come and go as that will force
allocation of new memory hence size of dump.

And that we should be able to handle with the help of another service.

> 
> >We can try to mitigate above problem by creating a new service which can
> >run at configured interval and check the size of memory required for
> >dump and size of dump partition configured. And user can either disable
> >this service or configure it to run every hour or every day or every week
> >or any interval they like to.
> 
> I think it's too much work, why do you want to check the required disk
> size so frequently?

Interval can be dynamic. Checking estimate after fresh boot will not make
sense as system is not loaded at all.

May be run it once a month if you think once a week is too much.

> To get the order of magnitude once will be enough to
> prepare the disk for dump since we should include some space in the disk size
> to absorb the fluctuation of the vmcore size.

I think that's also fine. That can be first step and if that works we
don't have to create a service to check it regularly. I am only concerned
that estimate taken after boot can vary a lot on large machines once all
the applications are launched.

> However, it depends on the
> machine's work, makedumpfile can't provide the index for estimation which
> can be applied to everyone.

I still don't understand that why makedumpfile can't provide an estimate
* of that momement * reasonably.

I don't want to implement a separate utility for this as makedumpfile
already has all the logic to go through pages, prepare bitmaps and figure
out which ones will be dumped. It will be just duplication of code and
waste of effort.

We have a real problem at our hand. What do we tell customers that how
big your dump partition should be. They have a multi tera byte machine. Do
we tell them that create a multi tera byte dedicated dump partition.
That's not practical at all.

And asking them to guess is not reasonable either. makedumpfile can make
much more educated guesses. It is not perfect but it is still much better
than user making a wild guess.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
