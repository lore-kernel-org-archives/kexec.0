Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([66.187.233.31])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IImBs-0004Bu-7B
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 10:07:16 -0400
Date: Wed, 8 Aug 2007 10:06:13 -0400 (EDT)
From: Chip Coldwell <coldwell@redhat.com>
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
In-Reply-To: <20070808103603.GC13808@in.ibm.com>
Message-ID: <Pine.LNX.4.64.0708081003000.29193@bogart.boston.redhat.com>
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<20070808103603.GC13808@in.ibm.com>
MIME-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Martin Wilck <martin.wilck@fujitsu-siemens.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haren Myneni <hbabu@us.ibm.com>

On Wed, 8 Aug 2007, Vivek Goyal wrote:

> On Tue, Aug 07, 2007 at 07:41:30PM +0200, Martin Wilck wrote:
> > 
> > Can you explain how, on the front side bus, the IO-APIC knows whether
> > a CPU has accepted the INT message? There is no response
> > to the INT message on the bus, except for the EOI which comes much later.
> > I'm not saying that you're wrong, I just really don't understand this
> > point.
> > 
> 
> I don't know what is exactly hardware protocol. I am just going by 
> intel documentation. 

I think it's important to distinguish between the LAPIC receiving an
interrupt and the CPU receiving an interrupt.  The former could happen
without the latter if the CPU has set the TPR above the priority of
the interrupt received by the LAPIC.  In that case, the interrupt is
kept pending in the LAPIC and recorded in the IRR if I understand the
Intel documentation correctly.

So I think the scenario which leaves IRR set when the kdump kernel
starts is possible.

Chip

-- 
Charles M. "Chip" Coldwell
Senior Software Engineer
Red Hat, Inc
978-392-2426


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
