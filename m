Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([210.143.35.51])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WidVO-0005iP-TI
 for kexec@lists.infradead.org; Fri, 09 May 2014 05:37:59 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Date: Fri, 9 May 2014 05:35:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720F921@BPXM01GP.gisp.nec.co.jp>
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
 <20140423170818.GE24651@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE38@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9720DE38@BPXM01GP.gisp.nec.co.jp>
Content-Language: ja-JP
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "bhe@redhat.com" <bhe@redhat.com>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

>>I am wondering if we are doing anything which requires kernel to allocate
>>memory and that leads to OOM.
>
>max_usage_in_bytes seems to include page cache, so I used simpler way
>like the patch at the bottom of this mail instead.
>
>Here is the result:
>
>            parameter                  |      result
> dump_lv | buffer[KiB] |  mmap (=4MiB) |    VmHWM [KiB]
> --------+-------------+---------------+------------------
>    d31  |       1     |       on      |        5872
>   Ed31  |       1     |       on      |        5804
>    d31  |       1     |      off      |        1784
>   Ed31  |       1     |      off      |        1720
>    d31  |    1000     |       on      |        8884  (*1)
>   Ed31  |    1000     |       on      |        7812
>    d31  |    1000     |      off      |        4788  (*1)
>   Ed31  |    1000     |      off      |        3720
>
>  *1. 2nd bitmap is allocated twice by the bug found by Arthur Zou.
>
>According to this result and the estimation below produced from the
>design of makedumpfile,
>
>  base size + (buffer size * 2) + (for mmap size) = VmHWM
>
>the base size may be about 2 MB, so about 6MB (base + mmap) will
>be the deadline. If 20% of the available memory is less than 6MB,
>OOM will happen.
>As for Baoquan's case, remained 17.2MB sounds enough even if
>makedumpfile consumes 6MB as for the other works.
>So I don't know why OOM happened yet, but the current safety
>limit looks still reasonable to me at least.
>
>By the way, I noticed it's better to remove 4MB(for mmap)
>from the available memory before calculate the bitmap buffer
>size. I'll do this anyway.

Sorry, I did my test on a 1st kernel environment.
The dump file was on a disk and I used mmap() for it, so __do_fault()
occurred and the VmHWM (MAX(MM_FILEPAGES + MM_ANONPAGES)) increased
by 4MB.

Here is the result on a 2nd kernel environment:

             parameter                  |      result
  dump_lv | buffer[KiB] |  mmap (=4MiB) |    VmHWM [KiB]
  --------+-------------+---------------+------------------
     d31  |       1     |       on      |         776
    Ed31  |       1     |       on      |         712
     d31  |       1     |      off      |         704
    Ed31  |       1     |      off      |         708
     d31  |    1000     |       on      |        1776
    Ed31  |    1000     |       on      |        2716
     d31  |    1000     |      off      |        1660
    Ed31  |    1000     |      off      |        2556


According to this, I think there is no need to take care of the memory
usage of mmap() because the actual memory usage is small enough.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
