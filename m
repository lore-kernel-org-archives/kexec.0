Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UeaaH-0004T9-Gs
 for kexec@lists.infradead.org; Tue, 21 May 2013 00:37:46 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 62C253EE0BD
 for <kexec@lists.infradead.org>; Tue, 21 May 2013 09:37:15 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5061245DE5B
 for <kexec@lists.infradead.org>; Tue, 21 May 2013 09:37:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 365DD45DE5A
 for <kexec@lists.infradead.org>; Tue, 21 May 2013 09:37:15 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1FC7F1DB8047
 for <kexec@lists.infradead.org>; Tue, 21 May 2013 09:37:15 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id CB9681DB8048
 for <kexec@lists.infradead.org>; Tue, 21 May 2013 09:37:14 +0900 (JST)
Message-ID: <519AC18C.1070705@jp.fujitsu.com>
Date: Tue, 21 May 2013 09:36:28 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: non-cyclic default
References: <E1UcggB-0005h5-8e@eag09.americas.sgi.com>
In-Reply-To: <E1UcggB-0005h5-8e@eag09.americas.sgi.com>
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
To: Cliff Wickman <cpw@sgi.com>
Cc: kumagai-atsushi@mxc.nes.nec.co.jp, kexec@lists.infradead.org

(2013/05/16 3:43), Cliff Wickman wrote:
> From: Cliff Wickman <cpw@sgi.com>
>
> Make non-cyclic the default, as it is faster.
>

Default behaviour should not be changed so easily, and I think 
performance of cyclic mode can be improved to some amount because 
cyclic-mode shows slow result even if the number of cycles is 1...

> Dumping a 1TB memory is successful with a crashkernel=512M.
> And allow -Y on the command line, as well as --non-cylic.

Is the '-Y' definitely necessary? I'm thinking this is hideded 
intentionally.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
