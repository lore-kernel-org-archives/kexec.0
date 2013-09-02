Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1VGQfU-0003Ex-O0
 for kexec@lists.infradead.org; Mon, 02 Sep 2013 09:43:34 +0000
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 4A6153EE1B9
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 18:43:06 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 36F8045DE5B
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 18:43:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 1DE6045DE59
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 18:43:06 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 09E74E08005
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 18:43:06 +0900 (JST)
Received: from m1000.s.css.fujitsu.com (m1000.s.css.fujitsu.com
 [10.240.81.136])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id B068D1DB803C
 for <kexec@lists.infradead.org>; Mon,  2 Sep 2013 18:43:05 +0900 (JST)
Message-ID: <52245D94.5050702@jp.fujitsu.com>
Date: Mon, 02 Sep 2013 18:42:44 +0900
From: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] x86, apic: Disable BSP if boot cpu is AP
References: <20130829092458.5476.10277.stgit@localhost6.localdomain6>
 <20130829092804.5476.95588.stgit@localhost6.localdomain6>
 <20130831052252.GC12617@x1.alien8.de> <5223F8DB.3040506@jp.fujitsu.com>
 <20130902071318.GA3406@x1.alien8.de>
In-Reply-To: <20130902071318.GA3406@x1.alien8.de>
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
Cc: jingbai.ma@hp.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ebiederm@xmission.com, akpm@linux-foundation.org, hpa@linux.intel.com, vgoyal@redhat.com

(2013/09/02 16:13), Borislav Petkov wrote:
> On Mon, Sep 02, 2013 at 11:32:59AM +0900, HATAYAMA Daisuke wrote:
>> As you suggest, boot_cpu seems more understandable also to me. BTW,
>> please notice that it doesn't denote that the CPU we're booting on
>> currently, but that the CPU with BSP flag set.
>
> Hmm, by "BSP flag set" you mean it is the first LAPIC entry in the MADT,
> correct? At least this is the case when you set isbsp to true. Because,
> there's also the BSC flag in APIC_BAR (MSR 0x1b) which denotes the
> bootstrapping core on node 0.
>

The reason why I don't lookup BSP flag in MSR is that it's impossible.
To read MSR of some CPU, we need to use rdmsr instruction on the CPU.
However, in case of this issue, the BSP is halting or running in
the kdump 1st kernel.

A whole explanation is written in the patch description.

-- 
Thanks.
HATAYAMA, Daisuke


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
