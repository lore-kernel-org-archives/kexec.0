Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWQMU-0006oK-6S
 for kexec@lists.infradead.org; Mon, 10 Dec 2018 18:33:02 +0000
Date: Mon, 10 Dec 2018 19:32:21 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181210183221.GA5482@zn.tnic>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
 <20181203150809.GA4794@zn.tnic>
 <779dbae7-f6e2-e9e4-bdd0-0a9e6ec62487@redhat.com>
 <20181205113032.GF29510@zn.tnic>
 <3d1a7e68-34c5-d118-fe09-7c9bc14cce84@redhat.com>
 <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4AE2DC15AC0B8543882A74EA0D43DBEC0356426E@BPXM09GP.gisp.nec.co.jp>
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
To: Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Cc: lijiang <lijiang@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "dyoung@redhat.com" <dyoung@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

On Wed, Dec 05, 2018 at 08:29:14PM +0000, Kazuhito Hagio wrote:
> Please note that this VMCOREINFO is generated from the information in
> the vmlinux only, not from the running kernel and /proc/kcore. So if
> we add a command to dump it from running kernel, it's not suitable.

Sure, I used a vmlinux for that.

> makedumpfile doesn't have any switch which dumps VMCOREINFO from kcore
> for now. (I'm thinking to have makedumpfile dump it as debug message,
> though.)

Might be useful as people are looking into using VMCOREINFO when
debugging a live kernel...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
