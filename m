Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SAzpK-0006wn-2c
 for kexec@lists.infradead.org; Fri, 23 Mar 2012 08:26:30 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 7E5A73EE0C0
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2012 17:26:20 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 64EF245DE4E
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2012 17:26:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 4FA6745DD78
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2012 17:26:20 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 421CD1DB803C
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2012 17:26:20 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id ED10B1DB802C
 for <kexec@lists.infradead.org>; Fri, 23 Mar 2012 17:26:19 +0900 (JST)
Date: Fri, 23 Mar 2012 17:26:08 +0900 (   )
Message-Id: <20120323.172608.488340508.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile v2 0/4] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120323163303.dee3795c.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120223012940.5041.61104.stgit@localhost6.localdomain6>
 <20120323163303.dee3795c.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Date: Fri, 23 Mar 2012 16:33:03 +0900

> On Thu, 23 Feb 2012 10:33:54 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> The following series implements LZO compression support to
>> makedumpfile. LZO is as good as in size but by far better in speed
>> than ZLIB, readucing down time during generation of crash dump and
>> refiltering.
> 
> Sorry for late reply.
> 
> [PATCH v2 4/4] allows to use -l option even without USELZO but 
> lzo compression doesn't work without USELZO.
> I think that warning messages should be displayed when -l option is
> used on makedumpfile built without USELZO.
> 
> So I made v3 patches attached to this mail.
> ([PATCH v2 1/4] and [PATCH v2 2/4] look good and I didn't change them.)
> 
>   v2 => v3:
> 
>      - Add warning messages for invalid -l option.
>      - Show LZO support status with help messages.
>      - Add description of USELZO in README and man page.
>      - (and I will do some cleanups.)
> 
> What do you think, Hatayama-san ?

Thanks. I think the warning message very helpful for users.

BTW, I have a question about future build option of LZO library. You
said previously you're going to introduce autotools. Then, do you
consider default enable if LZO library is present on the environment?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
