Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KUz1t-0001na-80
	for kexec@lists.infradead.org; Mon, 18 Aug 2008 07:19:53 +0000
Message-Id: <48A9228A.3070005@mxs.nes.nec.co.jp>
Date: Mon, 18 Aug 2008 16:19:38 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>
	<20080805171143.773c2465@halley.suse.de>
In-Reply-To: <20080805171143.773c2465@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2077505746=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============2077505746==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-08-05 21:07]:
>> BTW, I'd like to know some conditions of this problem.
>> So please let me know the makedumpfile commandline which you run.
>>  Ex. # makedumpfile -d 31 -x vmlinux /proc/vmcore dumpfile
> 
>   # makedumpfile -d 3 -D vmcore.sles11 vmcore.sles11.filtered
> 
>> I doubt that makedumpfile cannot distinguish the pgtable correctly.
>> I created the debugging patch. Please run makedumpfile-1.2.7 applied
>> with it by '-D' option, and report the output.
>> According to your kernel .config file, the output should contain
>> "PAGETABLE_4L : ON".
> 
> See the attachment.

Thanks for the log.
makedumpfile can distinguish the pgtable correctly.

Can the crash utility translate the virtual address 0xa0007fff8f900000
to physical address ? Please run the following subcommand on the crash
utility.

crash> vtop 0xa0007fff8f900000


Thanks
Ken'ichi Ohmichi


--===============2077505746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============2077505746==--
