Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIwKn-0006wq-VU
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 07:56:36 +0000
Message-ID: <522D7EDC.8070906@mxc.nes.nec.co.jp>
Date: Mon, 09 Sep 2013 16:55:08 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: use non-cyclic when possible
References: <E1VEnuJ-0000Jz-JI@eag09.americas.sgi.com>
 <521FE9BC.1090109@jp.fujitsu.com>
In-Reply-To: <521FE9BC.1090109@jp.fujitsu.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: d.hatayama@jp.fujitsu.com, cpw@sgi.com
Cc: kexec@lists.infradead.org

(2013/08/30 9:40), HATAYAMA Daisuke wrote:
> (2013/08/29 7:08), Cliff Wickman wrote:
>> From: Cliff Wickman <cpw@sgi.com>
>>
>> If there is plenty of memory use non-cyclic mode.
>>
> 
> If there is enough memory to use, the number of cycle is 1.
> Cyclic mode in 1-cycle is the same as non-cyclic mode in theory.
> If slow, it's better to improve cyclic mode implementation.
> 
> To be honest, I think the current non-cyclic mode should be implemented as 1-cycle case. 
> Then, makedumpfile can reduce amount of code at the same time. 

Yes, I hope to get rid of non-cyclic mode.
When v1.5.0 was released, I retained non-cyclic mode as just
workaround since cyclic mode has big performance issue.
However, we have done some improvement for cyclic mode and
we will continue it.

So please don't make the code depend on non-cyclic mode and
make efforts to get rid of it.


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
