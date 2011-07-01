Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QcSEj-0000sB-UM
	for kexec@lists.infradead.org; Fri, 01 Jul 2011 01:09:39 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 360E33EE0AE
	for <kexec@lists.infradead.org>; Fri,  1 Jul 2011 10:09:32 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1C73F45DE5F
	for <kexec@lists.infradead.org>; Fri,  1 Jul 2011 10:09:32 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id EF25345DE5C
	for <kexec@lists.infradead.org>; Fri,  1 Jul 2011 10:09:31 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id D113B1DB804E
	for <kexec@lists.infradead.org>; Fri,  1 Jul 2011 10:09:31 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 8B65A1DB804D
	for <kexec@lists.infradead.org>; Fri,  1 Jul 2011 10:09:31 +0900 (JST)
Date: Fri, 01 Jul 2011 10:09:21 +0900 (   )
Message-Id: <20110701.100921.193693774.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1238053244.265377.1309441249859.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <20110630.173820.246507825.d.hatayama@jp.fujitsu.com>
	<1238053244.265377.1309441249859.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: crash-utility@redhat.com
Cc: kexec@lists.infradead.org

From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
Date: Thu, 30 Jun 2011 09:40:49 -0400 (EDT)

> 
> 
> ----- Original Message -----
> 
> Now I am confused...
> 
> You stated this earlier:
> 
>> What I meant when I used ``similar'' is both literally and
>> logically. The format consists of diskdump header-like header, two
>> kinds of bitmaps used for the same purpose as those in diskump format,
>> and memory data. They can be handled in common with the existing data
>> structure, diskdump_data, non-intrusively, so I hope they are placed
>> in diskdump.c.
> 
> which made it sound like the sadump dumpfile format is already similar
> to the compressed kdump format.
> 
> But this makes it sound like the sadump native-format is unique:
> 
>> >> The first is to translate sadump format into the one crash utility can
>> >> recognize. makedumpfile is the standard tool to do it, and if
>> >> makdumpfile can support sadump format, I think it is the best.
>> >>
>> >> > - It isn't possible to support the same form as kdump-compressed format
>> >> >   now, is it?
>> >>
>> >> I think it's technically possible but practically impossible.  sadump is
>> >> a firmware and it is maintained by firmware team.
> 
> Is this how it would work?:
> 
>  (1) kernel crashes
>  (2) sadump creates a native-format dumpfile 
>  (3) (patched) makedumpfile takes the native-format sadump dumpfile and
>      translates into a format that is similar to a compressed kdump
>  (4) (patched) crash utility reads the translated sadump dumpfile
> 
> Or will the (patched) crash utility be able to read the sadump dumpfile
> in its native form if it is not pre-processed by makedumpfile?
> 
> Dave

Yes, the procedure (1)-(4) you wrote is exactly correct. But in addition,

 (1) kernel crashes
 (2) sadump creates a native-format dumpfile 
+(2.5) (patched) crash utility reads the native-format dumpfile and creates a dump summary.
 (3) (patched) makedumpfile takes the native-format sadump dumpfile and
     translates into a format that is similar to a compressed kdump
 (4) (patched) crash utility reads the translated sadump dumpfile

requires crash utility to be able to recognize sadump dump format
directly.

The dump sammary information is an output of crash utility including
startup information, bt -a, log, mod etc. For this, crash utility can
recognize the dump data.

But if we translates the dump data into vmcore, such as using
makedumpfile, to have crash utility read it, not a little disk space
and time must be consumed since dump size tends to be huge.

On the other hand, translating the data into kdump-compressed format
is better for carrying the data to another place.

And, sorry. the below I wrote earlier is not precisely correct. I need
to have crash utility can recognize the sadump format too. I'm
intending that crash reads the sadump dump format only for a dump
summary.

>> >> The first is to translate sadump format into the one crash utility can
>> >> recognize. makedumpfile is the standard tool to do it, and if
>> >> makdumpfile can support sadump format, I think it is the best.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
