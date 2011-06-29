Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QblCe-0001xC-4E
	for kexec@lists.infradead.org; Wed, 29 Jun 2011 03:12:37 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 88F3B3EE0B6
	for <kexec@lists.infradead.org>; Wed, 29 Jun 2011 12:12:29 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
	by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 6D93A45DE5E
	for <kexec@lists.infradead.org>; Wed, 29 Jun 2011 12:12:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
	by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 48BF045DE5B
	for <kexec@lists.infradead.org>; Wed, 29 Jun 2011 12:12:29 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3C7941DB804E
	for <kexec@lists.infradead.org>; Wed, 29 Jun 2011 12:12:29 +0900 (JST)
Received: from ml13.s.css.fujitsu.com (ml13.s.css.fujitsu.com [10.240.81.133])
	by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 088BD1DB804D
	for <kexec@lists.infradead.org>; Wed, 29 Jun 2011 12:12:29 +0900 (JST)
Date: Wed, 29 Jun 2011 12:12:18 +0900 (   )
Message-Id: <20110629.121218.488339383.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFI] Support Fujitsu's sadump dump format
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <1035209833.226401.1309265862792.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
References: <20110628.164425.39157342.d.hatayama@jp.fujitsu.com>
	<1035209833.226401.1309265862792.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
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
Date: Tue, 28 Jun 2011 08:57:42 -0400 (EDT)

> 
> 
> ----- Original Message -----
>> Fujitsu has stand-alone dump mechanism based on firmware level
>> functionality, which we call SADUMP, in short.
>> 
>> We've maintained utility tools internally but now we're thinking that
>> the best is crash utility and makedumpfile supports the sadump format
>> for the viewpoint of both portability and maintainability.
>> 
>> We'll be of course responsible for its maintainance in a continuous
>> manner. The sadump dump format is very similar to diskdump format and
>> so kdump (compressed) format, so we estimate patch set would be a
>> relatively small size.
>> 
>> Could you tell me whether crash utility and makedumpfile can support
>> the sadump format? If OK, we'll start to make patchset.
> 
> Sure, yes, the crash utility can always support another dumpfile format.
> 

Thanks. It helps a lot.

> It's unclear to me how similar SADUMP is to diskdump/compressed-kdump.
> Does your internal version patch diskdump.c, or do you maintain your
> own "sadump.c"?  I ask because if your patchset is at all intrusive,
> I'd prefer it be kept in its own file, primarily for maintainability,
> but also because SADUMP is essentially a black-box to anybody outside
> Fujitsu.

What I meant when I used ``similar'' is both literally and
logically. The format consists of diskdump header-like header, two
kinds of bitmaps used for the same purpose as those in diskump format,
and memory data. They can be handled in common with the existing data
structure, diskdump_data, non-intrusively, so I hope they are placed
in diskdump.c.

On the other hand, there's a code to be placed at such specific
area. sadump is triggered depending on kdump's progress and so
register values to be contained in vmcore varies according to the
progress: If crash_notes has been initialized when sadump is
triggered, sadump packs the register values in crash_notes; if not
yet, packs registers gathered by firmware. This is sadump specific
processing, so I think putting it in specific sadump.c file is a
natural and reasonable choise.

Anyway, I have not made any patch set for this. I'll post a patch set
when I complete.

Again, thanks a lot for the positive answer.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
