Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail-oa0-x22c.google.com ([2607:f8b0:4003:c02::22c])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBrMM-0005QX-PB
 for kexec@lists.infradead.org; Fri, 07 Feb 2014 19:45:11 +0000
Received: by mail-oa0-f44.google.com with SMTP id g12so4806598oah.31
 for <kexec@lists.infradead.org>; Fri, 07 Feb 2014 11:44:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52F52EDA.4080007@linux.intel.com>
References: <201401201647.s0KGlZdh004167@tazenda.hos.anvin.org>
 <CAFLxGvxO1MPDDjEh3FU5Gv2-eb6zBJxYtTnKdABDTTpbMxxYAw@mail.gmail.com>
 <52E5EFAF.3060609@linux.intel.com>
 <CAFLxGvxJ0A6hZ52RWffkg_zXXScyPn10P4HcKvdAXfE43h32Eg@mail.gmail.com>
 <52E601DA.7010605@zytor.com> <20140130220708.GP9951@redhat.com>
 <CAGXu5jKp0j71ucE7uOWRa+gQM1Wzp=_KdByJK4XnACTwiCW4ow@mail.gmail.com>
 <20140207144914.GA5949@redhat.com>
 <52F52EDA.4080007@linux.intel.com>
Date: Fri, 7 Feb 2014 11:44:47 -0800
Message-ID: <CAGXu5jKTr1udKiD7mhVEkN2W4z0w687DS=jJMORTT+ny+DqGCg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/kaslr for v3.14
From: Kees Cook <keescook@chromium.org>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Cong Ding <dinggnu@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>, Dave Young <dyoung@redhat.com>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mathias Krause <minipli@googlemail.com>, Michael Davidson <md@google.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>

On Fri, Feb 7, 2014 at 11:07 AM, H. Peter Anvin <hpa@linux.intel.com> wrote:
> On 02/07/2014 06:49 AM, Vivek Goyal wrote:
>>
>> As a workaround, Dave is currently using "nokaslr" command line parameter
>> for second kernel. He is still facing issues where makedumpfile segment
>> faults. He is looking into it further.
>>
>
> Now, let's state this: kaslr for kdump is almost certainly useless (the
> amount of reserved memory is not enough to provide any meaningful
> randomization, so any randomization needs to happen during the memory
> reservation phase.)  So disabling kaslr in the kdump kernel is entirely
> appropriate.

Peter covered everything already, but yeah, kaslr and kdump may not
make a lot of sense together, but regardless, yes, it only examines
e820 for memory space. It has to do all this work before the kernel
decompresses, so it's very early.

-Kees

-- 
Kees Cook
Chrome OS Security

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
