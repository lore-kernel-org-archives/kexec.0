Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gIEWM-0003Tx-CX
 for kexec@lists.infradead.org; Thu, 01 Nov 2018 15:04:32 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH] kdump, vmcoreinfo: Export sme_me_mask value to vmcoreinfo
Date: Thu, 1 Nov 2018 15:01:02 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0355EDE8@BPXM09GP.gisp.nec.co.jp>
References: <15897206-c1a6-ced6-3a1b-f71da8fc9c83@redhat.com>
 <20181029114414.GA11408@MiWiFi-R3L-srv>
 <90385882-7fd1-a674-ec5a-19bd42471a5e@redhat.com>
 <20181029134918.GB32150@zn.tnic>
 <699ab34e-1373-582d-4e58-e76bd57ec34f@redhat.com>
 <20181030050900.GA25987@dhcp-128-65.nay.redhat.com>
 <20181030091542.GD32102@zn.tnic> <20181030092314.GC14493@MiWiFi-R3L-srv>
 <dcbc925f-6935-6a34-fde1-7aa1ea378891@redhat.com>
 <20181031024748.GA2058@dhcp-128-65.nay.redhat.com>
 <20181031101054.GB15955@zn.tnic>
In-Reply-To: <20181031101054.GB15955@zn.tnic>
Content-Language: en-US
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
To: Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, lijiang <lijiang@redhat.com>, Baoquan He <bhe@redhat.com>, Petr Tesarik <ptesarik@suse.cz>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kazuhito Hagio <khagio@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>

On 10/31/2018 6:10 AM, Borislav Petkov wrote:
> On Wed, Oct 31, 2018 at 10:47:48AM +0800, Dave Young wrote:
> > It is a mist only a few kdump people know them, documenting them will help
> > people to understand and review. It will also be clearer instead of
> > digging into code?
> 
> Wholeheartedly agreed. Especially if people start using vmcoreinfo for
> other stuff, like live debugging:
> 
> https://lkml.kernel.org/r/1540593788-28181-1-git-send-email-bhsharma@redhat.com

I also agree. If it can help reviewers and other users to understand
vmcoreinfo and can help itself to become more standard, it would be
better to write it.

One small thing as a vmcoreinfo user (not about the documentation),
I think it might be better to export each information to each variable
separately, not OR-ing them into a variable, because of code simpleness
of both kernel and tools, if there is no limitation in kernel.

Thanks,
Kazu



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
