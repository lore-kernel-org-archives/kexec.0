Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WidW6-0005xi-7w
 for kexec@lists.infradead.org; Fri, 09 May 2014 05:38:43 +0000
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: RE: [PATCH] makedumpfile: change the wrong code to calculate
 bufsize_cyclic for elf dump
Date: Fri, 9 May 2014 05:36:13 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9720F928@BPXM01GP.gisp.nec.co.jp>
References: <0910DD04CBD6DE4193FCF86B9C00BE972048E6@BPXM01GP.gisp.nec.co.jp>
 <20140417045208.GE8084@dhcp-16-105.nay.redhat.com>
 <20140417050219.GF8084@dhcp-16-105.nay.redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720542E@BPXM01GP.gisp.nec.co.jp>
 <20140421151240.GB4367@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720CBBE@BPXM01GP.gisp.nec.co.jp>
 <20140423170818.GE24651@redhat.com>
 <20140423235041.GB1530@dhcp-17-102.nay.redhat.com>
 <20140425132214.GB10674@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9720DE3D@BPXM01GP.gisp.nec.co.jp>
 <20140428125025.GA4751@redhat.com>
In-Reply-To: <20140428125025.GA4751@redhat.com>
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
To: "vgoyal@redhat.com" <vgoyal@redhat.com>
Cc: "d.hatayama@jp.fujitsu.com" <d.hatayama@jp.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "zzou@redhat.com" <zzou@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>

>On Mon, Apr 28, 2014 at 05:05:00AM +0000, Atsushi Kumagai wrote:
>> >On Thu, Apr 24, 2014 at 07:50:41AM +0800, bhe@redhat.com wrote:
>> >> On 04/23/14 at 01:08pm, Vivek Goyal wrote:
>> >>
>> >> > >  - bitmap size: used for 1st and 2nd bitmaps
>> >> > >  - remains: can be used for the other works of makedumpfile (e.g. I/O buffer)
>> >> > >
>> >> > >                  pattern                      |  bitmap size  |   remains
>> >> > > ----------------------------------------------+---------------+-------------
>> >> > >   A. 100G memory with the too allocation bug  |    12.8 MB    |   17.2 MB
>> >> > >   B. 100G memory with fixed makedumpfile      |     6.4 MB    |   23.6 MB
>> >> > >   C. 200G memory with fixed makedumpfile      |    12.8 MB    |   17.2 MB
>> >> > >   D. 300G memory with fixed makedumpfile      |    19.2 MB    |   10.8 MB
>> >> > >   E. 400G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>> >> > >   F. 500G memory with fixed makedumpfile      |    24.0 MB    |    6.0 MB
>> >> > >   ...
>> >> > >
>> >> > > Baoquan got OOM in A pattern and didn't get it in B, so C must also
>> >> > > fail due to OOM. This is just what I wanted to say.
>> >> >
>> >> > ok, So here bitmap size is growing because we have not hit the 80% of
>> >> > available memory limit yet. But it gets limited at 24MB once we hit
>> >> > 80% limit. I think that's fine. That's what I was looking for.
>> >> >
>> >> > Now key question will remain is that is using 80% of free memory by
>> >> > bitmaps too much. Are other things happening in system which consume
>> >> > memory and because memory is not available OOM hits. If that's the
>> >> > case we probably need to lower the amount of memory allocated to
>> >> > bit maps. Say 70% or 60% or may be 50%. But this should be data driven.
>> >>
>> >> How about add anoter limit, say left memory safety limit, e.g 20M. If
>> >> the remaining memory which is 20% of free memory is bigger than 20M, 80%
>> >> can be taken to calculate the bitmap size. If smaller than 20M, we just
>> >> take (total memory - safety limit) for bitmap size.
>> >
>> >I think doing another internal limit for makedumpfile usage sounds fine.
>> >So say, if makedumpfile needs 5MB of memory for purposes other than
>> >bitmap, then remove 5MB from total memory and then take 80% of remaining
>> >memory to calculate bitmap size. I think that should be reasonable.
>> >
>> >Tricky bit here is to figure out how much memory does makedumpfile need.
>>
>> Did you said using such value is bad idea since it's hard to update it?
>> If we got the needed memory size, it would be changing every version.
>> At least I think this may be an ideal way but not practical.
>
>Yep, I am not too convinced about fixing makedumpfile memory usage at
>a particular value.
>
>>
>> >A simpler solution will be to just reserve 60% of total memory for bitmaps
>> >and leave rest for makedumpfile and kernel and other components.
>>
>> That's just specific tuning for you and Baoquan.
>>
>> Now, I think this case is just lack of free memory caused by
>> inappropriate parameter setting for your environment. You should
>> increase crashkernel= to get enough free memory, 166M may be too
>> small for your environment.
>
>I don't think it is bad tuning from our side. makedumpfile has 30MB free
>memory when it was launched and still OOM happened.
>
>30MB should be more than enough to save dump.

There were more than 10 MB remain memory in your case (A pattern),
and probably they were used as page cache mostly, so it sounds OOM
couldn't happen since such pages are reclaimable.

I tried to reproduce OOM in my environment.
Unfortunately, I couldn't get a chance to use a large memory machine,
so I controlled the bitmap buffer size with --cyclic-buffer like below:

/ # free
              total         used         free       shared      buffers
  Mem:        37544        19796        17748            0           56
 Swap:            0            0            0
Total:        37544        19796        17748
/ # /mnt/usr/sbin/makedumpfile_static -E --cyclic-buffer=8000 /proc/vmcore /mnt/tmp/dumpfile.E
Copying data                       : [100.0 %] |

The dumpfile is saved to /mnt/tmp/dumpfile.E.

makedumpfile Completed.
VmHWM:     16456 kB
/ #

As above, OOM didn't happen even when makedumpfile consumed most of the
available memory (the remains were only 1MB).

Of course, OOM happened when the memory usage exceeded the limit:

/ # free
              total         used         free       shared      buffers
  Mem:        37544        21608        15936            0          368
 Swap:            0            0            0
Total:        37544        21608        15936
/ # /mnt/usr/sbin/makedumpfile_static -E --cyclic-buffer=8192 /proc/vmcore /mnt/tmp/dumpfile.E
Copying data                       : [  0.0 %] /Out of memory: Kill process 1389 (makedumpfile_st) score 428 or sacrifice child
Killed process 1389 (makedumpfile_st) total-vm:22196kB, anon-rss:16524kB, file-rss:8kB
KILL
/ #


I think we should investigate why OOM happened in your environment,
otherwise we can't decide a safety limit of a user process's memory usage.


Thanks
Atsushi Kumagai

>>
>> By the way, I'm going on holiday for 8 days, I can't reply
>> during that period. Thanks in advance.
>
>Sure, talk to you more about this once you are back.
>
>Thanks
>Vivek
>
>_______________________________________________
>kexec mailing list
>kexec@lists.infradead.org
>http://lists.infradead.org/mailman/listinfo/kexec

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
