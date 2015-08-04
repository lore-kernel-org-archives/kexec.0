Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZMV9k-000818-TT
 for kexec@lists.infradead.org; Tue, 04 Aug 2015 05:52:57 +0000
Date: Tue, 4 Aug 2015 07:52:29 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [RFC] perf: Clear MSRs on kexec
Message-ID: <20150804055229.GD14481@krava.redhat.com>
References: <20150803213228.GC14481@krava.redhat.com>
 <20150803215417.GG25159@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150803215417.GG25159@twins.programming.kicks-ass.net>
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
To: Peter Zijlstra <peterz@infradead.org>
Cc: Don Zickus <dzickus@redhat.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Haren Myneni <hbabu@us.ibm.com>, dong.su@ericsson.com, Vivek Goyal <vgoyal@redhat.com>

On Mon, Aug 03, 2015 at 11:54:17PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 03, 2015 at 11:32:28PM +0200, Jiri Olsa wrote:
> > hi,
> > I'm getting following message on the kdump kernel start
> > 
> >   Broken BIOS detected, complain to your hardware vendor.\
> >   [Firmware Bug]: the BIOS has corrupted hw-PMU resources (MSR 38d is b0)
> > 
> > it seems to be caused by NMI watchdog being configured
> > and fixed counter values stays in MSRs, which triggers
> > warning in check_hw_exists and disables perf support
> > in kdump kernel.. which probably does not hurt ;-)
> > 
> > zeroing MSRs during kdump shutdown seems to work (attached)
> > but I'm not sure thats correct place for kdump perf callback
> 
> Right, but why bother? All that kernel needs to do is write a memory
> dump to someplace and reboot, right? The less you do, the less can go
> wrong.

well, I was hunting that 'Broken BIOS..' message which is wrong

I wouldn't think anyone wants to use perf under kdump kernel,
but you never know ;-)

jirka

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
