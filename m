Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIkHO-0002ua-VU
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 08:04:50 -0400
Message-ID: <46B9B156.20802@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 14:04:38 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070807142928.GA18839@in.ibm.com>
	<46B8AECA.7050908@fujitsu-siemens.com>
	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>
	<46B986D5.2010407@fujitsu-siemens.com>
	<20070808093336.GB13808@in.ibm.com>
In-Reply-To: <20070808093336.GB13808@in.ibm.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Vivek,

>>> How bad is it if you just run with irqpoll in the kdump kernel?
>>> If running with irqpoll is usable that is probably preferable
>>> to putting in a hardware work around we can survive without.
>> Yes, I tried that. No effect.
>>
> 
> Martin, at least irpoll should have worked. I am assuming your timer
> interrupts are coming in second kernel. In that case we are not
> dependent at all on actually receiving device interrupt. Polling should
> take care of it.

You are right. I just tested irqpoll again , and it does works even if the error
(detected by the IRR bit set in the IO-APIC) occurs.

I have no idea what went wrong when I tried "irqpoll" last time. But I was
using a different kernel, controller firmware, driver, and HW configuration,
so it can probably be explained somehow. Unfortunately, the unsuccessful early
attempts caused me to conclude prematurely that "irqpoll" didn't help. I admit
I didn't understand "irqpoll" fully until just now.

> What is that device which is not working? What is the success criterion?

It's a LSI megaraid_sas "zero channel RAID" (ZCR) controller. The system has an
on-board LSI 1068 (mptsas). If you put the ZCR in a certain PCI slot, the
1068 is hidden from the system, which sees the megaraid_sas controller
(1000:0413) instead of the 1068. The ZCR internally uses the 1068 as low-level
controller.

The success criterion was that the disks on the ZCR were successfully detected
and the dump was written.

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
