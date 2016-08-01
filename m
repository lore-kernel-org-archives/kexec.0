Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
 by bombadil.infradead.org with esmtp (Exim 4.85_2 #1 (Red Hat Linux))
 id 1bU6xh-0008JB-Vq
 for kexec@lists.infradead.org; Mon, 01 Aug 2016 06:44:30 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 0/3] Fix dump-capture kernel hangs with notsc
Date: Mon, 1 Aug 2016 06:44:03 +0000
Message-ID: <1470033660.7811.99.camel@localhost>
References: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1469501995-2991-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Content-Language: en-US
Content-ID: <A2387A93CACDDC4E8D6A8E3B2567C127@fujitsu.local>
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
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bhe@redhat.com" <bhe@redhat.com>, "xpang@redhat.com" <xpang@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "mingo@redhat.com" <mingo@redhat.com>, "kernel@kyup.com" <kernel@kyup.com>, "ebiederm@xmission.com" <ebiederm@xmission.com>, "hpa@zytor.com" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

Ping ...
May I ask for some community attention to this series?
I purpose is fixing  the dump-capture kernel hangs in
calibrate_delay_converge() while specifying notsc.

Thanks in advance.
wei
On Tue, 2016-07-26 at 10:59 +0800, Wei Jiangang wrote:
> v2:
> Just about the commit ("x86/apic: Improved the setting of interrupt
>  mode for bsp")
> 
> - Unify the name
>   s/virtual_wire_via_*/virt_wire_through_*
> - Add check for PIC mode
>   suggested-by Baoquan He <bhe@redhat.com>
> - Add check enable/disable flag for IO-APIC
>   suggested-by Xunlei Pang <xpang@redhat.com>
> - Update comments
> 
> v1:
> The goal is to fix dump-capture kernel with notsc option hangs
> in calibrate_delay_converge()
> 
> Wei Jiangang (3):
>   x86/apic: Remove "focus disabled" for 64bit case
>   x86/apic: Update comment about disabling processor focus
>   x86/apic: Improved the setting of interrupt mode for bsp
> 
>  arch/x86/include/asm/io_apic.h |  5 ++++
>  arch/x86/kernel/apic/apic.c    | 63 +++++++++++++++++++++++++++++++++++++++---
>  arch/x86/kernel/apic/io_apic.c | 28 +++++++++++++++++++
>  3 files changed, 92 insertions(+), 4 deletions(-)
> 



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
