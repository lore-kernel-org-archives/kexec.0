Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VIur0-0005Rv-KV
 for kexec@lists.infradead.org; Mon, 09 Sep 2013 06:21:43 +0000
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id A343E3EE0BC
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:21:16 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 945D745DE6A
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:21:16 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 61A2C45DE67
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:21:16 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 462711DB8042
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:21:16 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id EE5431DB802C
 for <kexec@lists.infradead.org>; Mon,  9 Sep 2013 15:21:15 +0900 (JST)
Message-ID: <522D681E.1030809@jp.fujitsu.com>
Date: Mon, 09 Sep 2013 15:18:06 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
 <20130831052252.GC12617@x1.alien8.de> <5223F8DB.3040506@jp.fujitsu.com>
 <20130902071318.GA3406@x1.alien8.de> <52245D94.5050702@jp.fujitsu.com>
 <20130904061221.GA17791@x1.alien8.de>
In-Reply-To: <20130904061221.GA17791@x1.alien8.de>
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
To: Borislav Petkov <bp@alien8.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, jingbai.ma@hp.com

(2013/09/04 15:12), Borislav Petkov wrote:
> On Mon, Sep 02, 2013 at 06:42:44PM +0900, HATAYAMA Daisuke wrote:
>> The reason why I don't lookup BSP flag in MSR is that it's impossible.
>> To read MSR of some CPU, we need to use rdmsr instruction on the CPU.
>> However, in case of this issue, the BSP is halting or running in
>> the kdump 1st kernel.
>
> Yes, and on the AP, that flag would be cleared which makes it not a BSP.
>
>> A whole explanation is written in the patch description.
>
> Those tend to get lost in git history when a bunch of whitespace jerk
> offs appear ontop. So a nicely written comment in the code could be very
> helpful.
>
> Thanks.
>

Yes, that's the point this patch series misses. I'll describe the explanation
in Documentation/kexec/kexec.txt and point it in the comment of boot-up code.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
