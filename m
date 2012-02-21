Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzkfV-00076F-75
 for kexec@lists.infradead.org; Tue, 21 Feb 2012 08:01:53 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 218B33EE0B6
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2012 17:01:43 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 0999245DE4D
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2012 17:01:43 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id E574D45DD78
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2012 17:01:42 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D8EA21DB8038
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2012 17:01:42 +0900 (JST)
Received: from m107.s.css.fujitsu.com (m107.s.css.fujitsu.com [10.240.81.147])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 94EEC1DB802C
 for <kexec@lists.infradead.org>; Tue, 21 Feb 2012 17:01:42 +0900 (JST)
Date: Tue, 21 Feb 2012 17:01:25 +0900 (   )
Message-Id: <20120221.170125.347143815.d.hatayama@jp.fujitsu.com>
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120221165041.5ebd8a15.kumagai-atsushi@mxc.nes.nec.co.jp>
References: <20120220090528.30966.59163.stgit@localhost6.localdomain6>
 <20120221165041.5ebd8a15.kumagai-atsushi@mxc.nes.nec.co.jp>
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
Subject: Re: [PATCH makedumpfile 0/2] LZO Compression Support
Date: Tue, 21 Feb 2012 16:50:41 +0900

> Hello Hatayama-san,
> 
> On Mon, 20 Feb 2012 18:10:00 +0900
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
> 
>> The following series implements LZO compression support to
>> makedumpfile. LZO is as good as in size but by far better in speed
>> than ZLIB, readucing down time during generation of crash dump and
>> refiltering.
>> 
>> The RFC discussion:
>> 
>>   http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
>>   http://lists.infradead.org/pipermail/kexec/2011-December/005868.html
>> 
>> How to build:
>> 
>>   1. Get lzo libraries: lzo, lzo-devel and lzo-minilzo from either of
>>   the following:
>> 
>>     1) Original author's website:
>>        http://www.oberhumer.com/opensource/lzo/
>> 
>>     2) yum framework on fedora. Older releases don't have the packages.
>> 
>>   2. Apply the patch set to makedumpfile v1.4.2.
>> 
>>   3. Do make.
>> 
>> How to use:
>> 
>>   Introduce new -l option. If a user specify this, makedumpfile
>>   generates dumpfile compressed by pages with lzo compression.
>> 
>>   Example)
>>   $ makedumpfile -l vmcore dumpfile
>> 
>> Performance evaluation:
>> 
>>   - Kumagai-san's evaluation simulating actually working servers:
>>     http://lists.infradead.org/pipermail/kexec/2011-December/005868.html
>> 
>>   - My evaluation focusing on the worst cases:
>>     http://lists.infradead.org/pipermail/kexec/2011-November/005783.html
>> 
>> LZO Support for crash:
>> 
>>   I'll post LZO support patch for crash after makedumpfile merges
>>   these patches.
> 
> Thank you for your patches.
> 
> I'll review and merge them into v1.4.4 with making LZO support optional.
> I'll post the patch to make it optional after v1.4.3 is released.
> 
> Please wait for a while.
> 
> Thanks
> Atsushi Kumagai
> 

Thanks. But I'm OK if I'll repost the patch after you have decided how
you change Makefile to support optional building. Or is it more
effective for you to do them by yourself at the same time?

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
