Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIhvk-0001If-NR
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 05:34:19 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l789XKf0027055
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 05:33:20 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l789XKLO527940
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 05:33:20 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l789XJod028184
	for <kexec@lists.infradead.org>; Wed, 8 Aug 2007 05:33:19 -0400
Date: Wed, 8 Aug 2007 15:03:36 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
Message-ID: <20070808093336.GB13808@in.ibm.com>
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
	<46B986D5.2010407@fujitsu-siemens.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46B986D5.2010407@fujitsu-siemens.com>
Reply-To: vgoyal@in.ibm.com
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
To: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 08, 2007 at 11:03:17AM +0200, Martin Wilck wrote:
> Hello Eric,
> 
> > How bad is it if you just run with irqpoll in the kdump kernel?
> > If running with irqpoll is usable that is probably preferable
> > to putting in a hardware work around we can survive without.
> 
> Yes, I tried that. No effect.
> 

Martin, at least irpoll should have worked. I am assuming your timer
interrupts are coming in second kernel. In that case we are not
dependent at all on actually receiving device interrupt. Polling should
take care of it.

What is that device which is not working? What is the success criterion?
I mean, did you check that the irq handler of your driver is now invoked
with irqpoll and now it can drive the device without worrying about
LAPIC and IOAPIC settings?

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
