Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WpIgw-0006fS-Fy
 for kexec@lists.infradead.org; Tue, 27 May 2014 14:49:27 +0000
Date: Tue, 27 May 2014 10:49:01 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140527144901.GJ10994@redhat.com>
References: <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
 <20140509204924.GA9918@redhat.com>
 <20140515072249.GA2170@dhcp-16-116.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972110ED@BPXM01GP.gisp.nec.co.jp>
 <20140519111538.GD1661@dhcp-16-116.nay.redhat.com>
 <20140519151140.GF650@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE97214404@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE97214404@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "lwoodman@redhat.com" <lwoodman@redhat.com>

On Tue, May 27, 2014 at 05:34:05AM +0000, Atsushi Kumagai wrote:

[..]
> >So to me bottom line is that once the write out starts, kernel needs
> >memory for holding dirty and writeback pages in cache too. So we probably
> >are being too aggresive in allocating 80% of free memory for bitmaps. May
> >be we should drop it down to 50-60%  of free memory for bitmaps.
> 
> I don't disagree to changing the 80% limit but I prefer to remove such
> a percentage threshold because it's dependent on the environment.
> Actually, I think it makes this problem more complex.
> 
> Now, thanks to page_is_buddy(), the performance degradation caused by
> multi-cycle processing looks very small according to the benchmark on
> 2TB memory:
> 
>   https://lkml.org/lkml/2013/3/26/914
> 
> This result means we don't need to make an effort to allocate the bitmap
> buffer as large as possible. So how about just setting a small fixed value
> like 5MB as a safety limit?
> It may be safer, and it will be easier to estimate the total memory usage of
> makedumpfile, so I think it's better way if the most users especially large
> machine users accept it.

Hi Atsushi,

If increasing buffer size does not have any significant increase in dump
time, then it is reasonable to have fixed buffer size for bitmaps.
(instead of trying to maximize bitmap size).

We can probably go for 4MB as bitmap size (instead of 5MB).

Also can we modify the logic a bit so that we automatically shrhink the
size of bitmap if sufficient memory is not available. Say assume that 60%
of available memory can be used for bitmaps. If it is less then 4MB then
we drop the buffer size and that hopefully still makes makedumpfile
successful (instead of being OOMed).

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
