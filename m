Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WHx0N-0007Qn-68
 for kexec@lists.infradead.org; Mon, 24 Feb 2014 14:59:40 +0000
Date: Mon, 24 Feb 2014 09:59:17 -0500 (EST)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1890371822.15122719.1393253957343.JavaMail.zimbra@redhat.com>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE971EC432@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE971EAF68@BPXM01GP.gisp.nec.co.jp>
 <1347294540.11438228.1392821415316.JavaMail.zimbra@redhat.com>
 <1598236100.13279715.1392929150735.JavaMail.zimbra@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE971EC432@BPXM01GP.gisp.nec.co.jp>
Subject: Re: [Crash-utility] crash: struct command can read irrelevant pages.
MIME-Version: 1.0
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
To: "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>
Cc: kexec@lists.infradead.org



----- Original Message -----
> >Hello Atsushi,
> >
> >I've committed a SLAB/SLUB kmem_cache-specific fix for this issue:
> >
> >  https://github.com/crash-utility/crash/commit/c0b7a74fc13121203810d06d163550436b2d5476
> >
> >which is queued for crash-7.0.6.
> 
> Thanks Dave, I made sure that this patch solved my problem.

OK good, thanks.
 
> >> This is a "known" issue has been discussed on the crash-utility list in the
> >> past, at least with respect to the kmem_cache data structure.  But for any random
> >> data structure that has such a construct, I'm not sure what can be done.
> 
> I also have no ideas how to solve it, but it seems that it hasn't been a
> practical problem yet. So I think your patch is enough for now.

At least with compressed kdumps, the "crash --zero_excluded" command line option,
or "set zero_excluded on" during runtime, should handle 99% of the cases.

Dave
 
 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
