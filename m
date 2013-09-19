Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VMTkC-0003PU-Fb
 for kexec@lists.infradead.org; Thu, 19 Sep 2013 02:13:26 +0000
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 6016C3EE1A3
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 11:12:59 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 51E1145DEBA
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 11:12:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 32E7E45DEBF
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 11:12:59 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 23CD5E08002
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 11:12:59 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id CDC231DB803F
 for <kexec@lists.infradead.org>; Thu, 19 Sep 2013 11:12:58 +0900 (JST)
Message-ID: <523A5D9A.7040509@jp.fujitsu.com>
Date: Thu, 19 Sep 2013 11:12:42 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: A few patches to consider
References: <E1VEnuJ-0000Jl-CC@eag09.americas.sgi.com>
 <521FF655.8000909@jp.fujitsu.com> <52391760.9000106@mxc.nes.nec.co.jp>
In-Reply-To: <52391760.9000106@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: kexec@lists.infradead.org, ptesarik@suse.cz, cpw@sgi.com

(2013/09/18 12:00), Atsushi Kumagai wrote:
> (2013/08/30 10:33), HATAYAMA Daisuke wrote:
>> (2013/08/29 7:08), Cliff Wickman wrote:
>>> From: Cliff Wickman <cpw@sgi.com>
>>>
>>> I am submitting 6 patches that I have found helpful in speeding the dump
>>> process or clarifying the progress report.
>>> They are not a series, and should not be interdependent.  But if you
>>> find any dependencies I apply them in this order:
>>> [PATCH] makedumpfile: reverse -c and -p if using snappy compression
>>> [PATCH] makedumpfile: use non-cyclic when possible
>>> [PATCH] makedumpfile: shorten cyclic exclude-unnecessary passes
>>> [PATCH] makedumpfile: shorten cyclic unnecessary-page scans
>>> [PATCH] makedumpfile: show needed memory
>>> [PATCH] makedumpfile: search for a debug vmlinux
>>>
>>> The last one (search for a debug vmlinux) is useful in identifying huge
>>> pages with the PG_head/PG-tail flags.  There was a patch from Petr Tesarik
>>> that enables that huge page filtering. I don't think you are taking that one
>>> as-is, but are reworking it. Seems like Hatayama-san was doing that work.
>>
>> No. If I have good memory, Kumagai-san was investigating how to integrate
>> huge page filtering into current memory types currently supported by
>> makedumpfile.
>
> Yes, I was investigating it but I'm not working for it now.
>
> I think main features should work without vmlinux,
> but it was impossible about his patch as said by himself:
>
>> This patch depends on exporting the relevant PG_* flags from the
>> kernel (in VMCOREINFO), and that's where I got stuck, because depending
>> on the number of available bits for the page flags, the kernel either
>> has PG_head and PG_tail, or only PG_compound, so I needed a #ifdef, and
>> the kernel maintainers didn't like the conditional.
>> I can restart the discussion with kernel maintainers and see what I can do
>
> Therefore, I waited that his work is finished and I was going to continue
> my work, but I didn't say my thinking definitely, sorry.
>
> Anyway, I should cooperate with Petr to develop huge page filtering,
> so could you let me know the status of your work ?
>

To whom do you make this question? It seems Cliff according to content of this question.
If so you should resend. If to me, I have not done huge page filtering work at all so far
as I already said in the previous mail in this thread.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
