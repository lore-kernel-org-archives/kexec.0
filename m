Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WkS19-0007gr-1b
 for kexec@lists.infradead.org; Wed, 14 May 2014 05:46:15 +0000
Date: Wed, 14 May 2014 13:44:13 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
Subject: Re: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Message-ID: <20140514054413.GC13787@dhcp-16-105.nay.redhat.com>
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
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "vgoyal@redhat.com" <vgoyal@redhat.com>

On 05/09/14 at 05:36am, Atsushi Kumagai wrote:
 
> There were more than 10 MB remain memory in your case (A pattern),
> and probably they were used as page cache mostly, so it sounds OOM
> couldn't happen since such pages are reclaimable.
> 
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

Hi Atsushi,

What is the dump target in your test? The OOM bugs happened if and only
if it nfs target. Other dump target including ssh/local fs/ didn't
happen ever though those cyclic buffer size code bugs existed.

We added some debug code and made test, the result shows the OOM
happened when the left memory is only about 2M. But when we drop page
caches every 1000 times of write, it's OK to complete the dump. And the
OOM happened when page cache need allocate page for writing.

So could you adjust your test to nfs dump with elf format or lzo
compression? I think nfs dump have heavy page cache affect which is
different with others.

I will take machines with 100G memory and 10G memory to test separately,
will paste the result with our configuration.

Thanks
Baoquan


> / #
> 
> As above, OOM didn't happen even when makedumpfile consumed most of the
> available memory (the remains were only 1MB).
> 
> Of course, OOM happened when the memory usage exceeded the limit:
> 
> / # free
>               total         used         free       shared      buffers
>   Mem:        37544        21608        15936            0          368
>  Swap:            0            0            0
> Total:        37544        21608        15936
> / # /mnt/usr/sbin/makedumpfile_static -E --cyclic-buffer=8192 /proc/vmcore /mnt/tmp/dumpfile.E
> Copying data                       : [  0.0 %] /Out of memory: Kill process 1389 (makedumpfile_st) score 428 or sacrifice child
> Killed process 1389 (makedumpfile_st) total-vm:22196kB, anon-rss:16524kB, file-rss:8kB
> KILL
> / #
> 
> 
> I think we should investigate why OOM happened in your environment,
> otherwise we can't decide a safety limit of a user process's memory usage.
> 
> 
> Thanks
> Atsushi Kumagai
> 
> >>
> >> By the way, I'm going on holiday for 8 days, I can't reply
> >> during that period. Thanks in advance.
> >

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
