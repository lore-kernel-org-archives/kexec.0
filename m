Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1WBuqj-00033y-36
 for kexec@lists.infradead.org; Fri, 07 Feb 2014 23:28:45 +0000
Date: Sat, 8 Feb 2014 07:28:15 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [GIT PULL] x86/kaslr for v3.14
Message-ID: <20140207232815.GD3840@dhcp-16-126.nay.redhat.com>
References: <52E5EFAF.3060609@linux.intel.com>
 <CAFLxGvxJ0A6hZ52RWffkg_zXXScyPn10P4HcKvdAXfE43h32Eg@mail.gmail.com>
 <52E601DA.7010605@zytor.com> <20140130220708.GP9951@redhat.com>
 <CAGXu5jKp0j71ucE7uOWRa+gQM1Wzp=_KdByJK4XnACTwiCW4ow@mail.gmail.com>
 <20140207144914.GA5949@redhat.com>
 <52F503FD.8080607@linux.intel.com>
 <20140207162408.GD6967@redhat.com>
 <20140207231626.GA3840@dhcp-16-126.nay.redhat.com>
 <52F56A40.60707@zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52F56A40.60707@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>, Cong Ding <dinggnu@gmail.com>, Richard Weinberger <richard.weinberger@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Kexec Mailing List <kexec@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Michael Davidson <md@google.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@linux.intel.com>, Yinghai Lu <yinghai@kernel.org>, Mathias Krause <minipli@googlemail.com>, Vivek Goyal <vgoyal@redhat.com>

On 02/07/14 at 03:20pm, H. Peter Anvin wrote:
> On 02/07/2014 03:16 PM, Dave Young wrote:
> > 
> > Hi Vivek,
> > 
> > Chaowang <chaowang@redhat.com> is looking into passing setup_data SETUP_E820_EXT
> > instead of using exactmap. Previously Thomas Renninger tried passing them in e820.
> > I did not find the old thread, but I remember it's not enough because of the
> > 128 entries limitation. 
> > 
> 
> THERE IS NO SUCH LIMITATION.
> 
> Only 128 slots fit in struct boot_params, but additional entries can be
> added to the setup_data linked list.

Ok, I did not describe it right, I actually means the space limit. Thanks for
clarifying. 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
