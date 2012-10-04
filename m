Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1TJaMa-0001M4-D3
 for kexec@lists.infradead.org; Thu, 04 Oct 2012 01:36:32 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4A5153EE0AE
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:36:29 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 2BD7445DEBA
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:36:29 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 128E745DEB6
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:36:29 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0630F1DB803E
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:36:29 +0900 (JST)
Received: from m022.s.css.fujitsu.com (m022.s.css.fujitsu.com [10.0.81.62])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id B68A01DB803F
 for <kexec@lists.infradead.org>; Thu,  4 Oct 2012 10:36:28 +0900 (JST)
Date: Thu, 04 Oct 2012 10:36:16 +0900 (JST)
Message-Id: <20121004.103616.510493732.d.hatayama@jp.fujitsu.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20121003124813.GB20376@redhat.com>
References: <20120924145157.GA14886@redhat.com>
 <20121003163835.c4be2b609deb385aab247beb@mxc.nes.nec.co.jp>
 <20121003124813.GB20376@redhat.com>
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
To: vgoyal@redhat.com
Cc: dyoung@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org, chaowang@redhat.com

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: makedumpfile 1.5.0 takes much more time to dump
Date: Wed, 3 Oct 2012 08:48:13 -0400

> On Wed, Oct 03, 2012 at 04:38:35PM +0900, Atsushi Kumagai wrote:
> 
> [..]
>> > > If that's going to take time, can we make using of new logic conditional
>> > > on a command line option. So that user has the option of using old
>> > > logic.
>> > > 
>> > 
>> > Kumagai-san should decide this. 
>> 
>> I'm not planning to make the cyclic mode optional.
>> However, I think the performance issue should be improved even without
>> mem_map array logic.
>> 
>> So, I will try to reduce the number of cycles as few times as possible for v1.5.1,
>> the performance issue will be improved.
>> To make sure of it, would you re-test with --cyclic-buffer 32768 (32MB), Vivek ?
>> Then the result of v1.5.0 is still too bad, I will consider using the old logic 
>> as default logic.
> 
> Actually chaowang did the testing. In the bug he provided data for 16MB
> buffer.
> 
> makedumpfile with 16M cyclic buffer,
> #1. makedumpfile-1.5.0 -c --message-level 1 -d 31 --cyclic-buffer 16384
> real     12m51.886s
> user     6m30.710s
> sys      6m11.642s
> #2. makedumpfile-1.5.0 -E --message-level 1 -d 31 --cyclic-buffer 16384
> real     11m24.141s
> user     4m25.897s
> sys      6m38.116s
> 
> Which looks much better than default numbers. Chao, can you please do the
> testing with 32MB buffer size and provide the data here.
> 

This 32MB setting is identical to the old logic in 1TB case except
that the cyclic buffer is on memory, not treated via temporary
file. So, free list filtering is done at most 1 time even on the worst
case. But it's necessary to specify proper sizes for dumpfiles of
other sizes.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
