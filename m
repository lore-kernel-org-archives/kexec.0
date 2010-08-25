Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux))
	id 1OoGkW-0006hg-ML
	for kexec@lists.infradead.org; Wed, 25 Aug 2010 14:14:46 +0000
Date: Wed, 25 Aug 2010 10:14:41 -0400 (EDT)
From: Dave Anderson <anderson@redhat.com>
Message-ID: <1215336770.533261282745681107.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
In-Reply-To: <262397977.533211282745644401.JavaMail.root@zmail05.collab.prod.int.phx2.redhat.com>
Subject: Re: [PATCH 0/4] crash utility: add ARM crashdump support
MIME-Version: 1.0
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Lei Wen <adrian.wenl@gmail.com>, Thomas Fange <Thomas.Fange@sonyericsson.com>, Jan Karlsson <Jan.Karlsson@sonyericsson.com>
Cc: kexec@lists.infradead.org, Mika Westerberg <ext-mika.1.westerberg@nokia.com>, "Discussion list for crash utility usage,
	maintenance and development\\\"Thomas.Fange" <crash-utility@redhat.com>


----- "Lei Wen" <adrian.wenl@gmail.com> wrote:

> Hi Dave,
> 
> What the status of this patch series now? Could crash utilities
> support analyzing arm machine core dump in the x86 host?

That is the plan, i.e., supporting the analysis of ARM dumpfiles
on both x86 and ARM hosts (and by extension on x86_64 hosts using
the x86 binary), and presumably "live" on ARM hosts.

> This is very useful feature, since the arm kernel already support the
> core dump by kdump enabled.

I'm waiting for the results of the Nokia/Sony-Ericsson collaboration
efforts.  I've added Jan and Thomas's names to the cc: list.

Dave


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
