Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hqq79-0001P1-CO
	for kexec@lists.infradead.org; Wed, 23 May 2007 08:38:52 -0400
Subject: Re: [PATCH] [makedumpfile] Fix problem with `half' pages
In-reply-to: <20070518105003.GE16227@suse.de>
Message-Id: <20070523213856oomichi@mail.jp.nec.com>
References: <20070518105003.GE16227@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Wed, 23 May 2007 21:38:56 +0900
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
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

2007/05/18 12:50:04 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>We have a system here with following memory map:
>
>/proc/iomem:
>4ffe14000-4ffe7ffff : reserved
>4ffe80000-4fffb5fff : System RAM
>4fffb6000-4ffffffff : reserved
>
>max_pfn = 1310720
>
>In that case, the last page of the "System RAM" is not full in 16K page size
>configuration. That leads to an error in makedumpfile when it checks if that's
>a zero page. It's because it tries to read the whole page and the read()
>fails because it's after the end of the dump file.
>
>That patch fixes this problem.

Thank you for the patch.
I guess there are the other problems because makedumpfile should not access
incomplete page.
To confirm the problem, I'd like to see the makedumpfile log with -D option.
Could you send it ?


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
