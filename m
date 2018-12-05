Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo162.gate.nec.co.jp ([114.179.232.162])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUdpT-0001yf-MW
 for kexec@lists.infradead.org; Wed, 05 Dec 2018 20:31:33 +0000
From: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: RE: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Date: Wed, 5 Dec 2018 20:29:14 +0000
Message-ID: <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com> <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
 <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
In-Reply-To: <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
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
To: lijiang <lijiang@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "bhe@redhat.com" <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

> >> Generating VMCOREINFO is easy in the first kernel, for example:
> >> # makedumpfile -g VMCOREINFO -x vmlinux
> >
> > I get:
> >
> > $ makedumpfile -g VMCOREINFO -x vmlinux
> > The kernel version is not supported.
> > The makedumpfile operation may be incomplete.
> >
> > The vmcoreinfo is saved to VMCOREINFO.
> >
> > makedumpfile Completed.
> >
> > But the text file looks ok AFAICT. Please add that command to the
> > documentation file.
> >

Please note that this VMCOREINFO is generated from the information in
the vmlinux only, not from the running kernel and /proc/kcore. So if
we add a command to dump it from running kernel, it's not suitable.

(This switch is intended to make a data that is used instead of vmlinux
 when vmcore didn't have VMCOREINFO and makedumpfile is in a situation
 that we don't have vmlinux. Please see the explanation of the -i and
 -g options in makefumpfile(8).)

makedumpfile doesn't have any switch which dumps VMCOREINFO from kcore
for now. (I'm thinking to have makedumpfile dump it as debug message,
though.)

Thanks,
Kazu

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
