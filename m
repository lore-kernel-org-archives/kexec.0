Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Date: Sat, 22 Oct 2011 11:20:16 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
Message-ID: <20111022022016.GA9208@verge.net.au>
References: <20111020042444.GA20260@verge.net.au>
	<20111020070105.GA28548@mudshark.cambridge.arm.com>
	<20111020080823.GA2716@verge.net.au>
	<20111021083426.GA16088@verge.net.au>
	<20111021084641.GA30168@mudshark.cambridge.arm.com>
	<20111021085958.GC21850@verge.net.au>
	<20111021091524.GB30168@mudshark.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20111021091524.GB30168@mudshark.cambridge.arm.com>
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
To: Will Deacon <will.deacon@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, Frank Hofmann <frank.hofmann@tomtom.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 21, 2011 at 10:15:24AM +0100, Will Deacon wrote:
> On Fri, Oct 21, 2011 at 09:59:58AM +0100, Simon Horman wrote:
> > On Fri, Oct 21, 2011 at 09:46:41AM +0100, Will Deacon wrote:
> > > The more difficult case is when you want to offline the secondary CPUs into
> > > a pen and then boot them in the new kernel. I did get some of this working,
> > > but there are outstanding issues with whether the pen should be at a fixed
> > > location or not. If not, then we need a way to tell the new kernel where it
> > > is, which may involve updating the DT blob...
> > 
> > Is the implication that the (working) callback method does not
> > give the second kernel any secondary CPUs?
> 
> What the callback does it up to you. You just need to make sure that you can
> cope with the kernel disappearing later on, so you'll probably need some
> hardware mechanism for offlining a CPU (for example, placing it in SRAM
> or cutting the power).

Thanks, it seems that I now have a bit of work to do implementing
a callback.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
