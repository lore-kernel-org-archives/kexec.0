Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by pentafluge.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1HhNji-0001Ud-Qy
	for kexec@lists.infradead.org; Fri, 27 Apr 2007 11:31:37 +0100
Received: from mailgate3.nec.co.jp (mailgate53.nec.co.jp [10.7.69.162])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id l3RAVKpQ020852
	for <kexec@lists.infradead.org>; Fri, 27 Apr 2007 19:31:20 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp
	(8.11.7/3.7W-MAILGATE-NEC)
	id l3RAVJu15886 for kexec@lists.infradead.org;
	Fri, 27 Apr 2007 19:31:19 +0900 (JST)
Received: from yonosuke.jp.nec.com (yonosuke.jp.nec.com [10.26.220.15]) by
	mailsv3.nec.co.jp (8.11.7/3.7W-MAILSV4-NEC) with ESMTP
	id l3RAVJL24077 for <kexec@lists.infradead.org>;
	Fri, 27 Apr 2007 19:31:19 +0900 (JST)
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-Id: <20070427193140tachibana@mail.jp.nec.com>
Mime-Version: 1.0
From: tachibana@mxm.nes.nec.co.jp
Date: Fri, 27 Apr 2007 19:31:40 +0900
Reply-To: tachibana@mxm.nes.nec.co.jp
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
To: kexec@lists.infradead.org

Hi Bernhard-san,

Sorry, the subject was wrong.
I send my reply again.

2007/04/26 14:21:53 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>
>Hello,
>
>I found in your announcment of makedumpfile 1.1.1:
>
>  Todo:
>     - ia64 DISCONTIGMEM support
>
>Did you already do something in this area? If you have something to
>test, I'd be happy. :)

Thank you for your vaddr_to_offset_ia64() patch.
We are currently investigating ia64 discontigmem, and
your patch will be our help.
I think your patch has problems when translating virtual address into
physical address for ia64 discontigmem if layer 3 (or layer 4)
paging is necessary.

In Japan, we have a vacation on April 28th - May 6th.
Sorry, we will reply again after the vacation.


Thanks
tachibana

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
