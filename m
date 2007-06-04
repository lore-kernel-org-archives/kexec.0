Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from fms-01.valinux.co.jp ([210.128.90.1] helo=mail.valinux.co.jp)
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hv3jZ-0003zg-26
	for kexec@lists.infradead.org; Mon, 04 Jun 2007 00:00:01 -0400
Date: Mon, 04 Jun 2007 13:01:44 +0900
From: Itsuro ODA <oda@valinux.co.jp>
Subject: Re: [RFC] makedumpfile: xen extraction
In-Reply-To: <20070601181424oomichi@mail.jp.nec.com>
References: <20070528091114.529F.ODA@valinux.co.jp>
	<20070601181424oomichi@mail.jp.nec.com>
Message-Id: <20070604122722.52E3.ODA@valinux.co.jp>
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
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

Hi Ken'ichi,

> Thank you for the xen patch, I'm interested in your patch.
> I'd like to separate the command of xen from the makedumpfile command,
> because the commandline usage should be simple and the binary file should
> be small in 2nd-kernel memory. Please let me know your opinion.

I think separated command is possible option too.
How about to be "ifdef"ed the part of structures I added and
the main is sepatated ?

BTW,
All pages used by the dom-0 are saved now.
Do you think it is better to be available to select pages like
makedumpfile from the dom-0 ?

Thanks.
-- 
Itsuro ODA <oda@valinux.co.jp>


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
