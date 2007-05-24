Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by canuck.infradead.org with esmtp (Exim 4.63 #1 (Red Hat Linux))
	id 1Hr1Iu-0001mE-VQ
	for kexec@lists.infradead.org; Wed, 23 May 2007 20:35:47 -0400
Subject: Re: [PATCH] [makedumpfile] Follow debuginfo link of vmlinux file
In-reply-to: <20070501133912.GA8247@suse.de>
Message-Id: <20070524093556oomichi@mail.jp.nec.com>
References: <20070501133912.GA8247@suse.de>
Mime-Version: 1.0
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
Date: Thu, 24 May 2007 09:35:56 +0900
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org


Hi Bernhard,

2007/05/01 15:39:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
>This patch implements support for following the debug information link in the
>.gnu_debuginfo section if the specified binary contains one. That makes it
>possible to call makedumpfile with -x /boot/vmlinux-<version> on distributions
>that ship extra -debuginfo packages for the kernel.

Isn't it good to specify the debuginfo file directly instead of your patch ?
I confirmed that makedumpfile without your patch can run by specifying the
debuginfo file directly.

makedumpfile needs only .debug_info section and doesn't need other sections,
so it needs only the debuginfo file. I will add the following comment to the
manual for "Debugging Information in Separate Files". Please let me know your
opinion.

-------------------------------------------------------------------------------
       -x VMLINUX
              Specify the first kernel’s VMLINUX  with  debug  information  to
              analyze the first kernel’s memory usage.
+             If there is a file containing debug information and separated from
+             VMLINUX, the file should be specified instead of VMLINUX.
              The  page  size of the first kernel and the second kernel should
              match.
              Example:
              # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile
-------------------------------------------------------------------------------


Thanks
Ken'ichi Ohmichi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
