Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wirjo-0004x7-LY
 for kexec@lists.infradead.org; Fri, 09 May 2014 20:49:49 +0000
Date: Fri, 9 May 2014 16:49:24 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140509204924.GA9918@redhat.com>
References: <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
 <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
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

On Fri, May 09, 2014 at 05:36:13AM +0000, Atsushi Kumagai wrote:

[..]
> I tried to reproduce OOM in my environment.
> Unfortunately, I couldn't get a chance to use a large memory machine,
> so I controlled the bitmap buffer size with --cyclic-buffer like below:
> 
> / # free
>               total         used         free       shared      buffers
>   Mem:        37544        19796        17748            0           56
>  Swap:            0            0            0
> Total:        37544        19796        17748
> / # /mnt/usr/sbin/makedumpfile_static -E --cyclic-buffer=8000 /proc/vmcore /mnt/tmp/dumpfile.E
> Copying data                       : [100.0 %] |
> 
> The dumpfile is saved to /mnt/tmp/dumpfile.E.
> 
> makedumpfile Completed.
> VmHWM:     16456 kB
> / #
> 
> As above, OOM didn't happen even when makedumpfile consumed most of the
> available memory (the remains were only 1MB).
> 
> Of course, OOM happened when the memory usage exceeded the limit:

Hi Atsushi,

I think this is the key point. How did makedumpfile exceed the limit. So
if you don't specify --cyclic-buffer=X, then makedumpfile will allocate
80% of available memory. That would be roughly 16MB of cyclic buffer
(instead of 8MB).

In your test case looks like makeudmpfile used 16MB of memory. Out of
which 8MB must have been used for bitmaps and rest 8MB for other purposes.

So clearly our calculation of using 80% of available memory for bitmaps
is not right. Rest of the 20% memory might not be enough for fulfilling
the needs of makeudmpfile.

We don't have a good way to determine how much *non-bitmap* memory
allocation makedumpfile requires. I am wondering how about making
some assumtions and modify the formula for bitmap memory.

- Assume makedumpfile requires 16MB of free memory for various purposes.
- Subtract 16MB from available memory and take 80% of remaining memory
  to calculate the bitmap memory size.
- Keep 4MB as minimum for bitmap buffer size.

One more person has reported makedumpfile OOM (even without -E option), 
on a machine. There also 30MB of memory is free. I think it has the
same issue that 24MB must have been allocated in bitmaps and remainig
6MB is not sufficient to satisfy makedumpfile's needs.

What do you think?

Also, does anybody know what's the impact of bitmap buffer size on dump
speed. Does dump speed change significantly with bitmap buffer size?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
