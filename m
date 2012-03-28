Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SCneZ-0002ZV-4V
 for kexec@lists.infradead.org; Wed, 28 Mar 2012 07:50:48 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 567193EE0B6
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 16:50:41 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 3D9D345DE4E
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 16:50:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 1021E45DE50
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 16:50:41 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 01F8F1DB803F
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 16:50:41 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id ACE8E1DB803B
 for <kexec@lists.infradead.org>; Wed, 28 Mar 2012 16:50:40 +0900 (JST)
Date: Wed, 28 Mar 2012 16:50:20 +0900 (   )
Message-Id: <20120328.165020.183027661.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120328141809.fac2af86.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120323163303.dee3795c.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120323.172608.488340508.d.hatayama@jp.fujitsu.com>
 <20120328141809.fac2af86.kumagai-atsushi@mxc.nes.nec.co.jp>
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
To: kumagai-atsushi@mxc.nes.nec.co.jp
Cc: kexec@lists.infradead.org, crash-utility@redhat.com

Hello Kumagai-san,

From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
Date: Wed, 28 Mar 2012 14:18:09 +0900

> Hello Hatayama-san,
> 
> On Fri, 23 Mar 2012 17:26:08 +0900 (   )
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>  
>> BTW, I have a question about future build option of LZO library. You
>> said previously you're going to introduce autotools. Then, do you
>> consider default enable if LZO library is present on the environment?
> 
> I'm afraid I decide not to introduce autotools for the following reasons.
> 

It's OK if you don't have plan to use autotools.

> First, because autotools cannot know whether LZO library is prepared in
> 2nd kernel environment, it cannot decide whether it should link LZO library
> dynamically even if LINKTYPE=dynamic is specified.
> 

Yes, I of course agree with the fact that makedumpfile for kdump 2nd
kernel should always be built in statically linked way.

But I think two problems are different, that is, the problem making
users easily able to choose build option by autotools, and the problem
guranteeing that the makedumpfile for kdump 2nd kernel be built always
statically.

> Second, if autotools behaves differently depending on LINKTYPE, it is difficult
> for users to understand.

If autotools were introduced, then I think we would no longer use
LINKTYPE and we would choose building option through autotools
features. For example, through new options in configure script such as
--enable-lzo-{static,dynamic} for example?

> 
> So, I think that current method is simpler and better than autotools.
> 

I agree. I think simpler one is better if it's enough for the purpose.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
