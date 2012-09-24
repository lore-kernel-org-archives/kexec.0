Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TFwtp-00052X-Tt
 for kexec@lists.infradead.org; Mon, 24 Sep 2012 00:51:51 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 606603EE0AE
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 09:51:42 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 4A3D345DEBB
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 09:51:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 3212645DEB7
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 09:51:42 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2671DE18003
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 09:51:42 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D8322E18001
 for <kexec@lists.infradead.org>; Mon, 24 Sep 2012 09:51:41 +0900 (JST)
Date: Mon, 24 Sep 2012 09:51:12 +0900 (JST)
Message-Id: <20120924.095112.153507503.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120921133232.GC15909@redhat.com>
References: <20120920200633.GL4681@redhat.com>
 <20120921.092357.94103398.d.hatayama@jp.fujitsu.com>
 <20120921133232.GC15909@redhat.com>
Mime-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, dyoung@redhat.com, chaowang@redhat.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Date: Fri, 21 Sep 2012 09:32:32 -0400

> On Fri, Sep 21, 2012 at 09:23:57AM +0900, HATAYAMA Daisuke wrote:
>> From: Vivek Goyal <vgoyal@redhat.com>
>> Subject: makedumpfile 1.5.0 takes much more time to dump
>> Date: Thu, 20 Sep 2012 16:06:34 -0400
>> 
>> > Hi Atsushi san,
>> > 
>> > We tried makedumpfile 1.5.0 on a 1TB machine and it seems to regress
>> > badly. We reserved 192MB of memory and following are test results.
>> > 
>> > #1. makedumpfile-1.4.2 -E --message-level 1 -d 31
>> > real     3m47.520s
>> > user     0m56.543s
>> > sys	 2m41.631s
>> > 
>> > #2. makedumpfile-1.5.0 -E --message-level 1 -d 31
>> > real     52m25.262s
>> > user     32m51.310s
>> > sys	 18m53.265s
>> > 
>> > #3. makedumpfile-1.4.2 -c --message-level 1 -d 31
>> > real     8m49.107s
>> > user     4m34.180s
>> > sys	 4m8.691s
>> > 
>> > #4. makedumpfile-1.5.0 -c --message-level 1 -d 31
>> > real     46m48.985s
>> > user     29m35.203s
>> > sys	 16m43.149s
>> > 
>> 
>> Hello Vivek,
>> 
>> On v1.5.0 we cannot filter free pages in constant space becuase we
>> have yet to test it. Instead, the existing method is used here, which
>> repeats walking on a whole page frames the number of cycles times.
>> 
>> As Kumagai-san explains, the number of cycles can be calculated by the
>> following expression:
>> 
>>   N = physical memory size / (page size * bit per byte(8) * BUFSIZE_CYCLIC)
>> 
>> So,
>> 
>>   N = 2TB / (4KB * 8 * 1MB) = 64 cycles.
>> 
>> I guess on this environment, it took about 50 seconds to filter free
>> pages in one cycle.
> 
> Ok, so once we have your walking through page struct patches in, hopefully
> this problem will be gone?
> 

Yes, then free page filtering is integrated in other mem_map array
logics. You can see how it takes from the following message.

Excluding unnecessary pages        : [100 %] STEP [Excluding unnecessary pages] : 0.204574 seconds

New logic takes equal to or quicker than the total time indicated by
the above kind of messages now.

> If that's going to take time, can we make using of new logic conditional
> on a command line option. So that user has the option of using old
> logic.
> 

Kumagai-san should decide this. 

BTW, Kumagai-san, in what version do you plan release of this new
mem_map logic? Around v1.5.2? I want to re-send a new patch set to
which I add small changes and comments for maintainability.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
