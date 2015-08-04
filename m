Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMcj8-00012J-0O
 for kexec@lists.infradead.org; Tue, 04 Aug 2015 13:58:03 +0000
Date: Tue, 4 Aug 2015 09:57:35 -0400
From: Don Zickus <dzickus@redhat.com>
Subject: Re: [RFC] perf: Clear MSRs on kexec
Message-ID: <20150804135735.GP42530@redhat.com>
References: <20150803213228.GC14481@krava.redhat.com>
 <20150803215417.GG25159@twins.programming.kicks-ass.net>
 <20150804055229.GD14481@krava.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150804055229.GD14481@krava.redhat.com>
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
To: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Haren Myneni <hbabu@us.ibm.com>, dong.su@ericsson.com, Vivek Goyal <vgoyal@redhat.com>

On Tue, Aug 04, 2015 at 07:52:29AM +0200, Jiri Olsa wrote:
> On Mon, Aug 03, 2015 at 11:54:17PM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 03, 2015 at 11:32:28PM +0200, Jiri Olsa wrote:
> > > hi,
> > > I'm getting following message on the kdump kernel start
> > > 
> > >   Broken BIOS detected, complain to your hardware vendor.\
> > >   [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR 38d is b0)
> > > 
> > > it seems to be caused by NMI watchdog being configured
> > > and fixed counter values stays in MSRs, which triggers
> > > warning in check_hw_exists and disables perf support
> > > in kdump kernel.. which probably does not hurt ;-)
> > > 
> > > zeroing MSRs during kdump shutdown seems to work (attached)
> > > but I'm not sure thats correct place for kdump perf callback
> > 
> > Right, but why bother? All that kernel needs to do is write a memory
> > dump to someplace and reboot, right? The less you do, the less can go
> > wrong.
> 
> well, I was hunting that 'Broken BIOS..' message which is wrong

It was the limitation we understood, when we implemented the
check_hw_exists() years ago.

> 
> I wouldn't think anyone wants to use perf under kdump kernel,
> but you never know ;-)

The amount of warning messages in the kdump kernel is significant, this
message is just another message to add to the noise.  Heck we have to poll
irqs because if we enable them, drivers would crash left and right due to
left over pending irqs from the previous kernel.

As Peter said, how much code are we going to put in the crash path to make
kdump less noisy?

Eric B.  usually frowns pretty heavily on this.

Cheers,
Don

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
