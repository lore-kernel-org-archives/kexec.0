Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hu3D5-0000u5-Cr
	for kexec@lists.infradead.org; Fri, 01 Jun 2007 05:14:47 -0400
Subject: Re: [RFC] makedumpfile: xen extraction
In-reply-to: <20070528091114.529F.ODA@valinux.co.jp>
Message-Id: <20070601181424oomichi@mail.jp.nec.com>
References: <20070528091114.529F.ODA@valinux.co.jp>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Fri, 1 Jun 2007 18:14:24 +0900
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

2007/05/28 10:49:49 +0900, Itsuro ODA <oda@valinux.co.jp> wrote:
>I think the part of xen hypervisor and domain-0 is enough to analyze
>a cause of system crash in almost of all cases under xen environment.
>Thus extracting the part of xen and domain-0 from /proc/vmcore under
>the second kernel is useful to reduce down time.
>
>The attached patch enables makedumpfile to extract the part of xen and
>domain-0 from vmcore.
>I implemented this function as an option of makedumpfile since many
>parts of makedumpfile can be used for implement of this function
>and the aim of this function is same as the aim of makedumpfile.
>
>usage: -X option is added for this funtion. -E and "-x xen-syms" must be
>       specified with -X.
>       "makedumpfile -XE -x xen-syms [-D] vmcore output-vmcore"
>
>This patch is for makedumpfile-1.1.3.
>
>This patch supports x86-PAE and ia64 now.
>(x86 and x86_64 is easy to support. I'd like to get feedbacks before
>implement many architectures.)
>
>The output-vmcore can be analyzed by "crash" command for both of
>xen hypervisor and domain-0.
>
>Your comments are welcome.

Thank you for the xen patch, I'm interested in your patch.
I'd like to separate the command of xen from the makedumpfile command,
because the commandline usage should be simple and the binary file should
be small in 2nd-kernel memory. Please let me know your opinion.


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
