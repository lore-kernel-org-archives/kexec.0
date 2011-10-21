Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Fri, 21 Oct 2011 09:46:41 +0100
From: Will Deacon <will.deacon@arm.com>
Subject: Re: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-ID: <20111021084641.GA30168@mudshark.cambridge.arm.com>
References: <20111020042444.GA20260@verge.net.au>
	<20111020070105.GA28548@mudshark.cambridge.arm.com>
	<20111020080823.GA2716@verge.net.au>
	<20111021083426.GA16088@verge.net.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111021083426.GA16088@verge.net.au>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Frank Hofmann <frank.hofmann@tomtom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 21, 2011 at 09:34:26AM +0100, Simon Horman wrote:
> I have tested the kexec/mmu-off branch of your tree on the UP board
> I mentioned above and kexec works :)

Hurrah! Thanks for giving it a spin.

> > You mention UP in particular, which I will test.
> > Do you have any thoughts on SMP?

Yes. Currently [i.e. on my branch above] you can do SMP kexec using the CPU
hotplug platform_cpu_kill callback to take down the CPUs in some
platform-specific manner.

The more difficult case is when you want to offline the secondary CPUs into
a pen and then boot them in the new kernel. I did get some of this working,
but there are outstanding issues with whether the pen should be at a fixed
location or not. If not, then we need a way to tell the new kernel where it
is, which may involve updating the DT blob...

Will

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
