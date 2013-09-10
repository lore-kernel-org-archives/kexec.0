Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VJKho-00072B-BT
 for kexec@lists.infradead.org; Tue, 10 Sep 2013 09:57:57 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 533AF3EE102
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 18:57:26 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 016FA45DE4D
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 18:57:26 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id D6F3A45DE55
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 18:57:25 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id C6F5A1DB802C
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 18:57:25 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 5DF151DB803F
 for <kexec@lists.infradead.org>; Tue, 10 Sep 2013 18:57:25 +0900 (JST)
Message-ID: <522EECF5.2030004@jp.fujitsu.com>
Date: Tue, 10 Sep 2013 18:57:09 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: reverse -c and -p if using snappy
 compression
References: <E1VEnuJ-0000Js-Gl@eag09.americas.sgi.com>
 <20130830033450.GA12036@dhcp-16-252.nay.redhat.com>
 <CAJGZr0+fo-PhF7vbhR3qky_ab+jSLMF6JorAv+1+H2CBkijSMQ@mail.gmail.com>
 <522ECA5C.50204@mxc.nes.nec.co.jp>
 <CAJGZr0L207Qtv3KZHTH0iTAGZ42NTD13K9jtTsFGUWpFR8DwYA@mail.gmail.com>
In-Reply-To: <CAJGZr0L207Qtv3KZHTH0iTAGZ42NTD13K9jtTsFGUWpFR8DwYA@mail.gmail.com>
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
To: Maxim Uvarov <muvarov@gmail.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Cliff Wickman <cpw@sgi.com>, Baoquan He <bhe@redhat.com>

(2013/09/10 17:25), Maxim Uvarov wrote:
> 2013/9/10 Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>:
>> Hello Maxim,
>>
>>
>> (2013/08/30 18:52), Maxim Uvarov wrote:
>>>
>>> I think that better is to have:
>>>
>>> -cz zlib
>>> -cs snappy
>>> -cl zlo
>>
>>
>> They are main options for most users, so I don't want to change
>> them without any important reason.
>>
>>
>>> -ca - automatic selection of compression. Snappy if compiled in, then
>>> lzo. And if no snappy and lzo then zlib.
>>
>>
>> What is the selection standard ? Compression Speed ?
>> If some users prefer compression ratio to compression speed,
>> snappy isn't suitable for them.
>>
>> Each compression format has both good points and bad points,
>> so
>
>> each user should select the format manually based on the
>> purpose in any case.
>>
>
> That definitely does not work in real life. Nobody wants to set up
> something, read manual and understand all options.  More than that -
> if  you somehow updated configs and set up wrong option you will not
> receive any dump instead of receiving dump with different compression.
>
> BR,
> Maxim.

It's extreme logic. System administrator should configurate own system
with sufficient understanding, in particular on large mission critical
system. If he failed to get any dump due to wrong configuration,
it's his fault. For most systems with typical memory size, zlib still
works enough.

Also, snappy is not always better than lzo. For example, although lzo 2.0.3
is slower than snappy, lzo 2.0.6 is almost as quick as snappy, since recent
lzo is optimized enough for x86 use. Then, some distribution has lzo 2.0.3
while another lzo 2.0.6. Hence, in general, the quickest compression varies
on each systems. It's difficult for makedumpfile to choose quickest one
in general. Futhermore, makedumpfile might support more formats in the future,
the difficulty would get bigger. I don't think automation is good idea.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
