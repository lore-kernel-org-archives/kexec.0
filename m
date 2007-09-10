Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from xenotime.net ([66.160.160.81])
	by canuck.infradead.org with smtp (Exim 4.63 #1 (Red Hat Linux))
	id 1IUo6a-0000GI-2r
	for kexec@lists.infradead.org; Mon, 10 Sep 2007 14:35:32 -0400
Received: from midway.site ([96.225.192.201]) by xenotime.net for
	<kexec@lists.infradead.org>; Mon, 10 Sep 2007 11:35:21 -0700
Date: Mon, 10 Sep 2007 11:35:21 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 0/2] vmcoreinfo support for dump filtering #2
Message-Id: <20070910113521.755d0433.rdunlap@xenotime.net>
In-Reply-To: <20070907175746oomichi@mail.jp.nec.com>
References: <20070907175746oomichi@mail.jp.nec.com>
Mime-Version: 1.0
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
Cc: Vivek Goyal <vgoyal@in.ibm.com>, kexec-ml <kexec@lists.infradead.org>, Dan Aloni <da-x@monatomic.org>

On Fri, 7 Sep 2007 17:57:46 +0900 Ken'ichi Ohmichi wrote:

> Hi,

> I released a new makedumpfile (version 1.2.0) with vmcoreinfo support.
> I updated the patches for linux and kexec-tools.
> 
> PATCH SET:
> [1/2] [linux-2.6.22] Add vmcoreinfo
>   The patch is for linux-2.6.22.
>   The patch adds the vmcoreinfo data. Its address and size are output
>   to /sys/kernel/vmcoreinfo.
> 
> [2/2] [kexec-tools] Pass vmcoreinfo's address and size
>   The patch is for kexec-tools-testing-20070330.
>   (http://www.kernel.org/pub/linux/kernel/people/horms/kexec-tools/)
>   kexec command gets the address and size of the vmcoreinfo data from
>   /sys/kernel/vmcoreinfo, and passes them to the second kernel through
>   ELF header of /proc/vmcore. When the second kernel is booting, the
>   kernel gets them from the ELF header and creates vmcoreinfo's PT_NOTE
>   segment into /proc/vmcore.

Hi,
When using the vmcoreinfo patches, what tool(s) are available for
analyzing the vmcore (dump) file?  E.g., lkcd or crash or just gdb?

gdb works for me, but I tried to use crash (4.0-4.6 from
http://people.redhat.com/anderson/) and crash complained:

crash: invalid kernel virtual address: 0  type: "cpu_pda entry"

Should crash work, or does it need to be modified?

This is on a 2.6.23-rc3 kernel with vmcoreinfo patches and a dump file
with -l 31 (dump level 31, omitting all possible pages).

Thanks,
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
