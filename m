Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Date: Tue, 4 Aug 2015 09:46:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] perf: Clear MSRs on kexec
Message-ID: <20150804074641.GI25159@twins.programming.kicks-ass.net>
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
Cc: Don Zickus <dzickus@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Haren Myneni <hbabu@us.ibm.com>, dong.su@ericsson.com, Vivek Goyal <vgoyal@redhat.com>

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

Not really. The previous kernel being the BIOS in this case did
leave the counters in a funky state.

> I wouldn't think anyone wants to use perf under kdump kernel,
> but you never know ;-)

Yeah, I think we knew about this back then (might've been 2010) and
chose to not 'fix' it.

http://lkml.iu.edu/hypermail/linux/kernel/1012.1/00380.html

Is what google finds me.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
