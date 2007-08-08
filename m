Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIqBO-0003X9-70
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 14:23:04 -0400
Message-ID: <46BA09FE.2070909@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 20:22:54 +0200
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

>> I think a lot would be gained if disable_IO_APIC() would just mask the IRQs
>> (like the function in my patch does), and perhaps fix the dest ID, instead of
>> totally clearing the registers.
> 
> Even masked we still won't see the EOI, because then we are in i8259
> mode.  So masked versus totally cleared really should make no
> difference.

You are talking about EOI sent in the kdump kernel, correct? With my patch
the EOI (sent in the "old" kernel) is seen.

> I guess right now I can see work put into cleaning things up a little
> or not having to call disable_IO_APIC() at all.  that was supposed
> to be a short term hack, until we fixed things properly.
> 
> So far no one has been brave enough to mess with the kernel apic
> initialization order so we can remove disable_IO_APIC.  If our
> goal isn't to fix things properly by removing the need for
> disable_IO_APIC I don't feel like putting much effort into this
> code path.

Who is working on this? Can you give a reference to a list of things that
would need to be done to do this right?

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
