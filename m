Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wcv51-00050f-EI
 for kexec@lists.infradead.org; Wed, 23 Apr 2014 11:11:08 +0000
Date: Wed, 23 Apr 2014 19:09:44 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140423110944.GC1607@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140418142912.GA2023@dhcp-17-102.nay.redhat.com>
 <20140421151429.GC4367@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140421151429.GC4367@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>


> > 
> > Well, we have done some experiments to try to get the statistical memory
> > range which kdump really need. Then a final reservation will be
> > calculated automatically as (base_value + linear growth of total memory). 
> > If one machine has 200GB memory, its reservation will grow too. Since
> > except of the bitmap cost, other memory cost is almost fixed. 
> > 
> > Per this scheme things should be go well, if memory always goes to the
> > edge of OOM, an adjust of base_value is needed. So a constant value as
> > you said may not be needed.
> 
> That logic is old and we probably should get rid of at some point. We
> don't want makedumpfile's memory usage to go up because system has
> more physical RAM. That's why cyclic mode was introduced.


> 
> > 
> > Instead, I am wondering how the 80% comes from, and why 20% of free
> > memory must be safe.
> 
> I had come up with this 80% number randomly. So you think that's the
> problem?


As Astushi said, when memory amount goes up, the bitmap also goes up.
The cyclic should solve this problem, but seems it doesn't. In the bug
we found, it always get the whole bitmap size to cyclic_bugsize. And
that is because 80% number.

We are try to add debug code to see what is going on during makedumpfile
running.

> 
> I am still scratching my head that why 30MB is not sufficient for
> makdumpfile.
> 
> Thanks
> Vivek
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
