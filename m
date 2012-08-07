Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SyeGR-0001H8-Jw
 for kexec@lists.infradead.org; Tue, 07 Aug 2012 07:31:43 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 0600C3EE0C1
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:31:34 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id DEF0545DE58
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:31:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id C73F845DE54
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:31:33 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B829D1DB804E
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:31:33 +0900 (JST)
Received: from m020.s.css.fujitsu.com (m020.s.css.fujitsu.com [10.0.81.60])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 741B21DB804F
 for <kexec@lists.infradead.org>; Tue,  7 Aug 2012 16:31:33 +0900 (JST)
Date: Tue, 07 Aug 2012 16:31:20 +0900 (JST)
Message-Id: <20120807.163120.106259238.d.hatayama@jp.fujitsu.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep
 memory consumption.
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
In-Reply-To: <20120806204731.GJ25559@redhat.com>
References: <20120629111320.694ec85b.kumagai-atsushi@mxc.nes.nec.co.jp>
 <20120806204731.GJ25559@redhat.com>
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
Cc: kexec@lists.infradead.org, kumagai-atsushi@mxc.nes.nec.co.jp

From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [RFC PATCH v2 0/10] makedumpfile: cyclic processing to keep memory consumption.
Date: Mon, 6 Aug 2012 16:47:31 -0400

> On Fri, Jun 29, 2012 at 11:13:20AM +0900, Atsushi Kumagai wrote:
>> Hello,
>> 
>> I improved prototype of cyclic processing as version 2.
>> If there is no objection to basic idea, I want to consider the things
>> related to performance as next step. (Concretely, buffer size and the patch set
>> HATAYAMA-san sent a short time ago.) 
> 
> Hi Atsushi San,
> 
> Just checking that what's the state of these patches now. Are they ready
> to be included in makedumpfile?
> 
> I would love to see new makedumpfile where memory usage does not grow
> by physical memory present in the system. (Assuming computig overhead
> of cycles is bearable).
> 
> Thanks
> Vivek
> 

Hello Vivek,

I'm just now benchmarking cycle processing on our machine. Please wait
for a while.

Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
