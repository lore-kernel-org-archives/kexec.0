Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([210.143.35.52])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aZ6OH-0001SI-Ek
 for kexec@lists.infradead.org; Fri, 26 Feb 2016 00:36:18 +0000
From: Atsushi Kumagai <ats-kumagai@wm.jp.nec.com>
Subject: RE: [Crash-utility] makedumpfile: 4.5 kernel commit breaks page
 filtering
Date: Fri, 26 Feb 2016 00:35:25 +0000
Message-ID: <0910DD04CBD6DE4193FCF86B9C00BE9701E24FD4@BPXM01GP.gisp.nec.co.jp>
References: <349750156.30030224.1455814657685.JavaMail.zimbra@redhat.com>
 <649995246.30033929.1455815111557.JavaMail.zimbra@redhat.com>
 <0910DD04CBD6DE4193FCF86B9C00BE9701E21775@BPXM01GP.gisp.nec.co.jp>
In-Reply-To: <0910DD04CBD6DE4193FCF86B9C00BE9701E21775@BPXM01GP.gisp.nec.co.jp>
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
To: "anderson@redhat.com" <anderson@redhat.com>
Cc: Joe Lawrence <joe.lawrence@stratus.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Laurence Oberman <loberman@redhat.com>, "Discussion list for crash utility usage,
 maintenance and development" <crash-utility@redhat.com>

Hello Dave,

>>Note that PAGE_MAPPING_ANON is now only set in the compound_head page,
>>so when makedumpfile walks though the pages, it will have to look
>>at each page's head page for the bit setting.
>
>Thanks for your report.
>As you said, it seems checking the head page like kernel does is necessary.
>I'll try to work it out, please give me some time.

Reading head page's page->mapping for each tail page will take extra time,
so I contrived another way.

It's just skipping compound tail pages for filtering.
If makedumpfile excludes compound pages, it will be done at a time by
exclude_range() at the time of checking the compound head page. We don't
need to check compound tail pages individually.

I made the patch, could you test the *compound* branch below ?
This version requires a new unexported symbol, you need to specify
-x vmlinux for now.

  https://sourceforge.net/p/makedumpfile/code/ci/compound/tree/


Thanks,
Atsushi Kumagai

>>As it is now, makedumpfile runs amok filtering pages that still have
>>stuff left in page->mapping.  For example, all of the addresses in
>>my "filtered.list" input file are those of legitimate kernel data
>>structures that have been incorrectly filtered because PAGE_MAPPING_ANON
>>(bit 1) has been left set:
>>
>>crash> kmem -p < filtered.list
>>      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>>ffffea0011b29040 46ca41000 dead0000ffffffff        0  0 3ffff800000000
>>      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>>ffffea0011b29040 46ca41000 dead0000ffffffff        0  0 3ffff800000000
>>      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>>ffffea0011b29640 46ca59000 dead0000ffffffff        0  0 3ffff800000000
>>      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>>ffffea0011b29640 46ca59000 dead0000ffffffff        0  0 3ffff800000000
>>      PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
>>ffffea0001d51640  75459000 dead0000ffffffff        0  0 1ffff800000000
>>...
>>
>>In earlier kernels, the page->mapping fields above would not have
>>their PAGE_MAPPING_ANON set.
>>
>>Dave
>
>--
>Crash-utility mailing list
>Crash-utility@redhat.com
>https://www.redhat.com/mailman/listinfo/crash-utility
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
