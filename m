Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RYoDG-0004Ga-Fb
 for kexec@lists.infradead.org; Fri, 09 Dec 2011 00:21:20 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7C8063EE0B5
 for <kexec@lists.infradead.org>; Fri,  9 Dec 2011 09:21:13 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 658E345DE84
 for <kexec@lists.infradead.org>; Fri,  9 Dec 2011 09:21:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 4DC8145DE83
 for <kexec@lists.infradead.org>; Fri,  9 Dec 2011 09:21:13 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 3F3CA1DB804B
 for <kexec@lists.infradead.org>; Fri,  9 Dec 2011 09:21:13 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id ECD6B1DB8044
 for <kexec@lists.infradead.org>; Fri,  9 Dec 2011 09:21:12 +0900 (JST)
Date: Fri, 09 Dec 2011 09:21:01 +0900 (   )
Message-Id: <20111209.092101.193685899.d.hatayama@jp.fujitsu.com>
Subject: Re: [Crash-utility] [RFC] makedumpfile, crash: LZO compression support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <46c499bc-10b0-46ac-9cc8-9a83bde973b2@zmail15.collab.prod.int.phx2.redhat.com>
References: <20111207171833.7c84c0a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <46c499bc-10b0-46ac-9cc8-9a83bde973b2@zmail15.collab.prod.int.phx2.redhat.com>
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
To: anderson@redhat.com
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

From: Dave Anderson <anderson@redhat.com>
Subject: Re: [Crash-utility] [RFC] makedumpfile, crash: LZO compression support
Date: Wed, 07 Dec 2011 12:32:10 -0500 (EST)

> 
> 
> ----- Original Message -----
>> Hello Hatayama-san,
>> 
>> > How about the patch adding compression/IO time report?
>> > I intended it only for the presentation of this RFC.
>> 
>> I think the above patch was posted only for this discussion,
>> and I won't merge it into the makedumpfile.
>> 
>> 
>> > I'll post the corresponding patch in crash's side after crash 6.0.2 is
>> > released, waiting for new configuration editing feature as Dave has explained.
>> 
>> If the Crash supports LZO compression, I'll merge the feature into
>> the makedumpfile.
> 
> I suppose it's a chicken-and-egg situation, but despite the recent
> addition of the extra-library build feature added to the crash
> utility, I wasn't planning to accept LZO compression support until
> it was first supported in makedumpfile.  And even with crash support,
> it would still require a hand-rebuild of the crash utility sources.
> 
> If this is merged into makedumpfile and crash, will Fujitsu's next
> step will be to try to make it non-optional?  I'm still not convinced
> it's worth forcing the pre-installation of the additional packages
> and library by default.  
> 

I don't intend pre-instration of LZO-related libraries on the
community version because only relatively recent distributions
provides them as their packages and so making it requiring the
libraries by default seems to only irritate users for the
distributions not providing LZO-related libraries, such as RHEL.

Of course, I think it better to make them default if the libraries
exist on the distribution.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
