Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hQnf3-0006DE-Hg
 for kexec@lists.infradead.org; Wed, 15 May 2019 06:45:11 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH v6 1/2] x86/kexec: Build identity mapping for EFI systab
 and ACPI tables
Date: Wed, 15 May 2019 06:43:49 +0000
Message-ID: <19532243-e02a-838a-732a-a47c15339dde@ce.jp.nec.com>
References: <20190513014248.GA16774@MiWiFi-R3L-srv>
 <20190513070725.GA20105@zn.tnic> <20190513073254.GB16774@MiWiFi-R3L-srv>
 <20190513075006.GB20105@zn.tnic> <20190513080653.GD16774@MiWiFi-R3L-srv>
 <20190514032208.GA25875@dhcp-128-65.nay.redhat.com>
 <20190514084841.GA27876@dhcp-128-65.nay.redhat.com>
 <20190514113826.GM2589@hirez.programming.kicks-ass.net>
 <20190514125835.GA29045@dhcp-128-65.nay.redhat.com>
 <20190514140916.GA90245@gmail.com>
 <20190515010850.GA9159@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190515010850.GA9159@dhcp-128-65.nay.redhat.com>
Content-Language: ja-JP
Content-ID: <6C5001855D1CA0499D67A26346A777CB@gisp.nec.co.jp>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>
Cc: "fanc.fnst@cn.fujitsu.com" <fanc.fnst@cn.fujitsu.com>, "kasong@redhat.com" <kasong@redhat.com>, Baoquan He <bhe@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 5/15/19 10:08 AM, Dave Young wrote:
> On 05/14/19 at 04:09pm, Ingo Molnar wrote:
>>> Hmm, it seems caused by some WIP branch patches, I suspect below:
>>> commit 124d6af5a5f559e516ed2c6ea857e889ed293b43
>>> x86/paravirt: Standardize 'insn_buff' variable names
>>
>> This commit had a bug which I fixed - could you try the latest -tip?
> 
> Will do, but I do not use tip tree often, not sure which branch includes
> the fix.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/
> Is it tip/master or tip/tip?

Just in case, when I tried tip/master, one of test machines crashed
in the same way as:
  https://lkml.org/lkml/2019/5/9/182

and I found this patch was needed:
  [PATCH] x86: intel_epb: Take CONFIG_PM into account
  https://lore.kernel.org/lkml/3431308.1mSSVdqTRr@kreacher/

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
