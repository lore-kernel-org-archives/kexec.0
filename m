Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WcvnH-0000ag-Hy
 for kexec@lists.infradead.org; Wed, 23 Apr 2014 11:56:52 +0000
Date: Wed, 23 Apr 2014 19:55:29 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140423115529.GD1607@dhcp-16-105.nay.redhat.com>
References: <0910DD04CBD6DE4193FCF86B9C00BE97201A0F@BPXM01GP.gisp.nec.co.jp>
 <585335973.3025244.1397211578378.JavaMail.zimbra@redhat.com>
 <20140414080239.GA8084@dhcp-16-105.nay.redhat.com>
 <20140416064445.GC8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

> >> Thanks for your description, I understand that situation and
> >> the nature of the problem.
> >>
> >> That is, the assumption that 20% of free memory is enough for
> >> makedumpfile can be broken if free memory is too small.
> >> If your machine has 200GB memory, OOM will happen even after fix
> >> the too allocation bug.
> >
> >Why? In cyclic mode, shouldn't makedumpfile's memory usage be fixed
> >and should not be dependent on amount of RAM present in the system?
> 
> Strictly speaking, it's not fixed but just restricted by the safe
> limit(80% of free memory) like below:
> 
>  - bitmap size: used for 1st and 2nd bitmaps
>  - remains: can be used for the other works of makedumpfile (e.g. I/O buffer)
> 
>                  pattern                      |  bitmap size  |   remains
> ----------------------------------------------+---------------+-------------
>   A. 100G memory with the too allocation bug  |    12.8 MB    |   17.2 MB
>   B. 100G memory with fixed makedumpfile      |     6.4 MB    |   23.6 MB
>   C. 200G memory with fixed makedumpfile      |    12.8 MB    |   17.2 MB
>   D. 300G memory with fixed makedumpfile      |    19.2 MB    |   10.8 MB
>   E. 400G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>   F. 500G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>   ...
> 
> Baoquan got OOM in A pattern and didn't get it in B, so C must also
> fail due to OOM. This is just what I wanted to say.

Thanks Atsushi for this detailed table.

In fact in cyclic mode, the cyclic bugsize is the dynamic number which
need be grieved, not the remaining memory which always got to be
decreased. Since user set cyclic mode, they would like to accept the
fact that dumping could cost a longer time. But we give them a OOM,
that's not acceptable.

So I think we need think about how the cyclic_bufsize can be calculated
better. Maybe dynamically adjust the 80% number?

Thanks
Baoquan



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
