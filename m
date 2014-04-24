Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Wd93z-0002JZ-8t
 for kexec@lists.infradead.org; Thu, 24 Apr 2014 02:06:59 +0000
Date: Thu, 24 Apr 2014 10:05:34 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140424020534.GE1607@dhcp-16-105.nay.redhat.com>
References: <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
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
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, "zzou@redhat.com" <zzou@redhat.com>

On 04/24/14 at 07:50am, Baoquan He wrote:
> On 04/23/14 at 01:08pm, Vivek Goyal wrote:
>  
> > >  - bitmap size: used for 1st and 2nd bitmaps
> > >  - remains: can be used for the other works of makedumpfile (e.g. I/O buffer)
> > > 
> > >                  pattern                      |  bitmap size  |   remains
> > > ----------------------------------------------+---------------+-------------
> > >   A. 100G memory with the too allocation bug  |    12.8 MB    |   17.2 MB
> > >   B. 100G memory with fixed makedumpfile      |     6.4 MB    |   23.6 MB
> > >   C. 200G memory with fixed makedumpfile      |    12.8 MB    |   17.2 MB
> > >   D. 300G memory with fixed makedumpfile      |    19.2 MB    |   10.8 MB
> > >   E. 400G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
> > >   F. 500G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
> > >   ...
> > > 
> > > Baoquan got OOM in A pattern and didn't get it in B, so C must also
> > > fail due to OOM. This is just what I wanted to say.
> > 
> > ok, So here bitmap size is growing because we have not hit the 80% of 
> > available memory limit yet. But it gets limited at 24MB once we hit
> > 80% limit. I think that's fine. That's what I was looking for.
> > 
> > Now key question will remain is that is using 80% of free memory by
> > bitmaps too much. Are other things happening in system which consume
> > memory and because memory is not available OOM hits. If that's the
> > case we probably need to lower the amount of memory allocated to
> > bit maps. Say 70% or 60% or may be 50%. But this should be data driven.
> 
> How about add anoter limit, say left memory safety limit, e.g 20M. If
> the remaining memory which is 20% of free memory is bigger than 20M, 80%
> can be taken to calculate the bitmap size. If smaller than 20M, we just
> take (total memory - safety limit) for bitmap size.

Oh, this is what Astushi suggested earlier in his comments.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
