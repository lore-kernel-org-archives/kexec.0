Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hIonk-0000HJ-DS
 for kexec@lists.infradead.org; Tue, 23 Apr 2019 06:21:10 +0000
From: Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: Re: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Date: Tue, 23 Apr 2019 06:20:09 +0000
Message-ID: <965f770a-b103-72fb-eaef-cb337ebe8290@ce.jp.nec.com>
References: <20190422092804.15534-1-kasong@redhat.com>
In-Reply-To: <20190422092804.15534-1-kasong@redhat.com>
Content-Language: ja-JP
Content-ID: <92F1F186A0F7274C960CCFCB661342A2@gisp.nec.co.jp>
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
To: Kairui Song <kasong@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "x86@kernel.org" <x86@kernel.org>, Baoquan He <bhe@redhat.com>, Chao Fan <fanc.fnst@cn.fujitsu.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Dave Young <dyoung@redhat.com>

On 4/22/19 6:28 PM, Kairui Song wrote:
> The reason is the systab region is not mapped by the identity mapping
> provided by kexec. Currently kexec only create identity mapping for
> mem regions, wihch won't cover the systab. So second kernel will be
> accessing a not mapped memory region and cause fault.
> But as kexec tend to pad the map region up to PUD size, the
> systab could be included in the map by accident, so it worked on
> some machines, but that will be broken easily and unstable.

Is the mapping of ACPI tables just by luck, too?

-- 
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
