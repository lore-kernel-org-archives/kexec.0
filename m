Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo161.gate.nec.co.jp ([114.179.232.161])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1haIAG-0000qQ-5g
 for kexec@lists.infradead.org; Mon, 10 Jun 2019 11:08:38 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH] x86/kexec: Add ACPI NVS region to the ident map
Date: Mon, 10 Jun 2019 11:07:05 +0000
Message-ID: <1555938c-e00f-d40f-5f24-146aec7a67eb@ce.jp.nec.com>
References: <20190610073617.19767-1-kasong@redhat.com>
 <20190610095150.GA5488@zn.tnic>
 <CACPcB9f-sussXaOuOau6=CD85pS2KhcsknpJDQH_aEkwvLfvVA@mail.gmail.com>
 <20190610105959.GB5488@zn.tnic>
In-Reply-To: <20190610105959.GB5488@zn.tnic>
Content-Language: ja-JP
Content-ID: <A92E1697A0430C4EB905863A22704E42@gisp.nec.co.jp>
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
To: Borislav Petkov <bp@alien8.de>, Kairui Song <kasong@redhat.com>
Cc: the arch/x86 maintainers <x86@kernel.org>, Baoquan He <bhe@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dirk van der Merwe <dirk.vandermerwe@netronome.com>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@kernel.org>

Hi Kairui, Boris,

On 6/10/19 7:59 PM, Borislav Petkov wrote:
> On Mon, Jun 10, 2019 at 06:18:50PM +0800, Kairui Song wrote:
>> Hi Boris, unfortunately I don't have a real machine which only have
>> the NVS region. I did fake the memmap to emulate such problem but
>> can't really promise this will fix the real case. So just declare it
>> won't break anything that is already working. And I'm asking Junichi
>> to have a try as he reported this issue on the machines he has.
> 
> Yes, this is how you should do it. First you test on a real hardware -
> if the issue is such that needs a real hardware to verify - and if it
> passes, *then* you send the patch.
> 
> If you don't have access to the box, then ask someone who has.
> 
> But for the future, please do not send untested patches in a hurry,
> hoping that they would work. This could cause more trouble than the
> little time you might save speculating it'll all go fine.

I tested the patch on such a machine on top of the current tip/master
f9818950848 ("Marge branch 'linus'") and it works fine.
Without the patch, kexec -l fails.

I had tested the version I posted here on bunch of physical machines
I had access and confirmed it didn't broke working setups:
https://lore.kernel.org/lkml/20190515051717.GA13703@jeru.linux.bs1.fc.nec.co.jp/

Since the logic in the patch seems unchanged, I'm very sure it's ok.

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.
_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
