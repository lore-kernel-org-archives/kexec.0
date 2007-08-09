Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IJBuj-0000oh-LU
	for kexec@lists.infradead.org; Thu, 09 Aug 2007 13:35:18 -0400
Message-ID: <46BB504A.9000100@fujitsu-siemens.com>
Date: Thu, 09 Aug 2007 19:35:06 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<20070808103603.GC13808@in.ibm.com>
	<Pine.LNX.4.64.0708081003000.29193@bogart.boston.redhat.com>
	<20070808144239.GA1499@in.ibm.com>
	<46BA0844.9080703@fujitsu-siemens.com>
	<20070809101128.GA14738@in.ibm.com>
In-Reply-To: <20070809101128.GA14738@in.ibm.com>
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
To: "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Chip Coldwell <coldwell@redhat.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Vivek Goyal wrote:

> Did you also check IRR bits on LAPIC. May be some interrupt is already
> being served and your new interrupts has been queued on LAPIC and IRR bit
> on LAPIC is set?

That's it. Whenever the IO-APIC IRR bit is set, I see the LAPIC IRR bit set, too.
I never see any ISR bits set. Very rarely I see that IRQs are IRQ_PENDING or
IRQ_INPROGRESS, but that's apparently unrelated to the problem.

Actually, I often see APIC IRR bits set, but it only seems to matter for
IRQs coming from the secondary IO-APIC.

Unfortunately, just writng APIC_EOI in this situation (when an IRR bit is set)
has no effect.

I have tried to set the IRQ_DISABLED flag for all IRQs. From my understanding,
if I re-enable IRQs, that disables the actual IRQ handlers, but the ack()
function of the IRQ chip (which, in our case, sends EOI) is called anyway.
*That appears to work*, in the kdump kernel the IRR is cleared.

I'll run an overnight test with that technique tonight.

Martin

-- 
Martin Wilck
PRIMERGY System Software Engineer
FSC IP ESP DE6

Fujitsu Siemens Computers GmbH
Heinz-Nixdorf-Ring 1
33106 Paderborn
Germany

Tel:			++49 5251 8 15113
Fax:			++49 5251 8 20409
Email:			mailto:martin.wilck@fujitsu-siemens.com
Internet:		http://www.fujitsu-siemens.com
Company Details:	http://www.fujitsu-siemens.com/imprint.html

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
