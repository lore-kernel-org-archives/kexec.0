Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iWxgm-0000p7-VL
 for kexec@lists.infradead.org; Tue, 19 Nov 2019 07:12:45 +0000
Received: by mail-pg1-x541.google.com with SMTP id k32so5193552pgl.2
 for <kexec@lists.infradead.org>; Mon, 18 Nov 2019 23:12:40 -0800 (PST)
Date: Tue, 19 Nov 2019 16:13:42 +0900
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v4 0/3] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191119071341.GW22427@linaro.org>
References: <1573459282-26989-1-git-send-email-bhsharma@redhat.com>
 <20191113063858.GE22427@linaro.org>
 <CACi5LpP54d9DKW63G5W6X4euBjAm2NwkHOiM01dB7g8d60s=4w@mail.gmail.com>
 <20191115015959.GI22427@linaro.org>
 <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAJ2QiJJOSspLKRh+jRB_o0o9nmeAsiFKzxGJ8R0pYPRM4iptmw@mail.gmail.com>
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
To: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bhupesh Sharma <bhsharma@redhat.com>, Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Bhupesh SHARMA <bhupesh.linux@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Steve Capper <steve.capper@arm.com>, kexec mailing list <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Dave Anderson <anderson@redhat.com>, linuxppc-dev@lists.ozlabs.org

Hi Prabhakar,

On Tue, Nov 19, 2019 at 12:02:46PM +0530, Prabhakar Kushwaha wrote:
> Hi Akashi,
> 
> On Fri, Nov 15, 2019 at 7:29 AM AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Bhupesh,
> >
> > On Fri, Nov 15, 2019 at 01:24:17AM +0530, Bhupesh Sharma wrote:
> > > Hi Akashi,
> > >
> > > On Wed, Nov 13, 2019 at 12:11 PM AKASHI Takahiro
> > > <takahiro.akashi@linaro.org> wrote:
> > > >
> > > > Hi Bhupesh,
> > > >
> > > > Do you have a corresponding patch for userspace tools,
> > > > including crash util and/or makedumpfile?
> > > > Otherwise, we can't verify that a generated core file is
> > > > correctly handled.
> > >
> > > Sure. I am still working on the crash-utility related changes, but you
> > > can find the makedumpfile changes I posted a couple of days ago here
> > > (see [0]) and the github link for the makedumpfile changes can be seen
> > > via [1].
> > >
> > > I will post the crash-util changes shortly as well.
> > > Thanks for having a look at the same.
> >
> > Thank you.
> > I have tested my kdump patch with a hacked version of crash
> > where VA_BITS_ACTUAL is calculated from tcr_el1_t1sz in vmcoreinfo.
> >
> 
> I also did hack to calculate VA_BITS_ACTUAL is calculated from
> tcr_el1_t1sz in vmcoreinfo. Now i am getting error same as mentioned
> by you in other thread last month.
> https://www.mail-archive.com/crash-utility@redhat.com/msg07385.html
> 
> how this error was overcome?
> 
> I am using
>  - crashkernel: https://github.com/crash-utility/crash.git  commit:
> babd7ae62d4e8fd6f93fd30b88040d9376522aa3
> and
>  - Linux: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> commit: af42d3466bdc8f39806b26f593604fdc54140bcb

# I am rather reluctant to cross-post non-kernel patch to lkml/lakml,

The only change I made to crash utility was:
===8<===
diff --git a/arm64.c b/arm64.c
index 5ee5f1a29a41..84e40aeb561b 100644
--- a/arm64.c
+++ b/arm64.c
@@ -3857,8 +3857,8 @@ arm64_calc_VA_BITS(void)
 		} else if (ACTIVE())
 			error(FATAL, "cannot determine VA_BITS_ACTUAL: please use /proc/kcore\n");
 		else {
-			if ((string = pc->read_vmcoreinfo("NUMBER(VA_BITS_ACTUAL)"))) {
-				value = atol(string);
+			if ((string = pc->read_vmcoreinfo("NUMBER(tcr_el1_t1sz)"))) {
+				value = 64 - strtoll(string, NULL, 0);
 				free(string);
 				machdep->machspec->VA_BITS_ACTUAL = value;
 				machdep->machspec->VA_BITS = value;
===>8===

Thanks,
-Takahiro Akashi

> --pk

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
