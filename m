Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIqQZ-0004Ve-MU
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 14:39:20 -0400
Message-ID: <46BA0DA8.6000904@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 20:38:32 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>	<20070807142928.GA18839@in.ibm.com>	<46B8AECA.7050908@fujitsu-siemens.com>	<m1ir7qg7kd.fsf@ebiederm.dsl.xmission.com>	<46B986D5.2010407@fujitsu-siemens.com>	<m1myx2dpcc.fsf@ebiederm.dsl.xmission.com>	<46B9FEC8.20004@fujitsu-siemens.com>
	<m1myx1c3lj.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1myx1c3lj.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Haren Myneni <hbabu@us.ibm.com>, "vgoyal@in.ibm.com" <vgoyal@in.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Eric W. Biederman wrote:

>>> irqpoll is working now.
>> Yes. I'd give a lot to know what went wrong when I tried that in April.
>> It'd have saved me many hours of work if I had discovered this workaround
>> before.
> 
> Yes that is odd.

Got it. At that time I was using "noirqdebug" because we had a FW problem that
caused a lot of misrouted IRQs. With "noirqdebug", "irqpoll" has no effect.
Bummer.

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
