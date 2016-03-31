Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <56FCFA6F.7040800@arm.com>
Date: Thu, 31 Mar 2016 11:22:39 +0100
From: James Morse <james.morse@arm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v15 17/20] arm64: kdump: implement machine_crash_shutdown()
References: <cover.1457977401.git.geoff@infradead.org>
 <8f53a31cf8bbfdd73eb289e078addc31c5a19fcf.1457977403.git.geoff@infradead.org>
 <56EC440F.4050406@arm.com> <20160331074635.GC2267@linaro.org>
In-Reply-To: <20160331074635.GC2267@linaro.org>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, marc.zyngier@arm.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On 31/03/16 08:46, AKASHI Takahiro wrote:
> James Morse wrote:
> > This made me jump: irq_exit() may end up in the __do_softirq() (with irqs turned
> > back on!) ... but these lines are impossible to reach. Maybe get the compiler to
> > enforce this with an unreachable() instead?
>
> I'm not sure how effective unreachable() is here, but OK I will add it.

I thought '__builtin_unreachable()' would generate a warning if it was
reachable, but from [0] it looks like it just suppresses warnings.

You're right, it won't help.

Thanks,


James

[0] https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
