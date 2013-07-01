Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UtSPv-0004w9-Oz
 for kexec@lists.infradead.org; Mon, 01 Jul 2013 00:56:33 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id EBD5F3EE0BB
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:56:03 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DE6B645DE4E
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:56:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id C91A545DE4D
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:56:03 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id B94CD1DB803F
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:56:03 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 6CE651DB8040
 for <kexec@lists.infradead.org>; Mon,  1 Jul 2013 09:56:03 +0900 (JST)
Message-ID: <51D0D399.1070501@jp.fujitsu.com>
Date: Mon, 01 Jul 2013 09:55:53 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: 32TB kdump
References: <E1Uq29K-0004kW-Vd@eag09.americas.sgi.com>
 <20130627211725.GM4899@redhat.com>
In-Reply-To: <20130627211725.GM4899@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: kexec@lists.infradead.org, Cliff Wickman <cpw@sgi.com>

(2013/06/28 6:17), Vivek Goyal wrote:
> On Fri, Jun 21, 2013 at 09:17:14AM -0500, Cliff Wickman wrote:

>
> Try using snappy or lzo for faster compression.
>
>>    So a good workaround for a very large system might be to dump uncompressed
>>    to an SSD.
>
> Interesting.
>
>>    The multi-threading of the crash kernel would produce a big gain.
>
> Hatayama once was working on patches to bring up multiple cpus in second
> kernel. Not sure what happened to those patches.
>
>> - Use of mmap on /proc/vmcore increased page scanning speed from 4.4 minutes
>>    to 3 minutes.  It also increased data copying speed (unexpectedly) from
>>    38min. to 35min.
>
> Hmm.., so on large memory systems, mmap() will not help a lot? In those
> systems dump times are dominidated by disk speed and compression time.
>
> So far I was thinking that ioremap() per page was big issue and you
> also once had done the analysis that passing page list to kernel made
> things significantly faster.
>
> So on 32TB machines if it is taking 2hrs to save dump and mmap() shortens
> it by only few minutes, it really is not significant win.
>

Sorry, I've explained this earlier in this ML.

Some patches have been applied on makedumpfile to improve the filtering speed.
Two changes that were useful for the improvement are the one implementing
a 8-slot cache for physical page for the purpose of reducing the number of
/proc/vmcore access for paging (just as TLB), and the one that cleanups
makedumpfile's filtering path.

Performance degradation by ioremap() is now being hided on a single cpu, but
it would again occur on multiple cpus. Sorry, but I have yet to do benchmark
showing the fact cleanly as numeral values.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
