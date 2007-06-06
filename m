Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HvtXy-0002qZ-Ee
	for kexec@lists.infradead.org; Wed, 06 Jun 2007 07:19:29 -0400
Subject: Re: [RFC] makedumpfile: xen extraction
In-reply-to: <20070604122722.52E3.ODA@valinux.co.jp>
Message-Id: <20070606201934oomichi@mail.jp.nec.com>
References: <20070604122722.52E3.ODA@valinux.co.jp>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 6 Jun 2007 20:19:34 +0900
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
To: Itsuro ODA <oda@valinux.co.jp>
Cc: kexec@lists.infradead.org


Hi Oda-san,

2007/06/04 13:01:44 +0900, Itsuro ODA <oda@valinux.co.jp> wrote:
>> Thank you for the xen patch, I'm interested in your patch.
>> I'd like to separate the command of xen from the makedumpfile command,
>> because the commandline usage should be simple and the binary file should
>> be small in 2nd-kernel memory. Please let me know your opinion.
>
>I think separated command is possible option too.
>How about to be "ifdef"ed the part of structures I added and
>the main is sepatated ?
>
>BTW,
>All pages used by the dom-0 are saved now.
>Do you think it is better to be available to select pages like
>makedumpfile from the dom-0 ?

Yes, I do. It is a good idea.
I think that it is better that the command for xen isn't separated
from makedumpfile if unnecessary pages will be filtered out from dom-0,
because the command for xen will need almost the same code.

I'll start testing makedumpfile with your patch (2007/05/28) and inform
you of the result.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
