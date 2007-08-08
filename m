Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IIpwI-0002hB-15
	for kexec@lists.infradead.org; Wed, 08 Aug 2007 14:07:24 -0400
Message-ID: <46BA0651.5010708@fujitsu-siemens.com>
Date: Wed, 08 Aug 2007 20:07:13 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: PATCH/RFC: [kdump] fix APIC shutdown sequence
References: <46B73955.2080007@fujitsu-siemens.com>
	<20070808113834.GA26145@in.ibm.com>
In-Reply-To: <20070808113834.GA26145@in.ibm.com>
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
Cc: Haren Myneni <hbabu@us.ibm.com>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Vivek Goyal wrote:

> Got this oops while testing your patch when I did
> "echo c > /proc/sysrq-trigger"

That's bad :-(

...
> Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP:
 [<0000000000000000>]
>  <IRQ>  [<ffffffff8025afd0>] handle_edge_irq+0x5c/0x127
>  [<ffffffff8020e1ae>] do_IRQ+0xf1/0x15f
>  [<ffffffff8020c191>] ret_from_intr+0x0/0xa
>  <EOI>  <NMI>  [<ffffffff80351ae3>] __delay+0x6/0x10
>  [<ffffffff8021e328>] crash_nmi_callback+0x4b/0x77

Obviously, it the oops occurs after the IRQs are re-enabled in crash_nmi_callback().
It appears that desc->chip->mask (in mask_ack_irq(), kernel/irq/chip.c:462) was NULL.
I have no idea how my patch could cause that.

This proves that re-enabling IRQs in this situation is too dangerous :-(.
I really did hundreds of dumps in different ways (echo c>/proc/sysrq-trigger,
forcing Oops and panic(), actually hititng Alt-Sysrq) and this never happened to
me.

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
