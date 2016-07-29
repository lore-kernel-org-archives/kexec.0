Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1469812107.16559.37.camel@infradead.org>
Subject: Re: [PATCH v23 0/9] arm64: add kdump support
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 29 Jul 2016 10:08:27 -0700
In-Reply-To: <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
References: <20160726075659.2290-1-takahiro.akashi@linaro.org>
 <20160726080925.GA2363@linaro.org>
 <CAB=otbTODnOwFiLZT7bm1_MLyORQ1cx-gaeg7bm+bReaMRhYwg@mail.gmail.com>
Mime-Version: 1.0
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
To: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, james.morse@arm.com, bauerman@linux.vnet.ibm.com, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, 2016-07-29 at 19:26 +0300, Ruslan Bilovol wrote:

> Also for some reason in case of 'load and kexec the kernel' it
> takes 1-2 minutes to start booting after I do kexec -e, need to
> investigate it further.

You could try my patch ("purgatory: Change default sha256
optimization to -O2") in my master branch:

  https://git.kernel.org/cgit/linux/kernel/git/geoff/kexec-tools.git/log/

Other have said it helped.

-Geoff

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
