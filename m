Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KZzTS-0002m5-J7
	for kexec@lists.infradead.org; Mon, 01 Sep 2008 02:49:03 +0000
Message-ID: <48BB544E.7060508@mxs.nes.nec.co.jp>
Date: Mon, 01 Sep 2008 11:32:46 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH][ia64] Fix the difference
	between	node_mem_map	and	node_start_pfn.
	(Re: makedumpfile fails on SGI machine)
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>	<20080805171143.773c2465@halley.suse.de>	<48A9228A.3070005@mxs.nes.nec.co.jp>	<20080818130025.0282e471@halley.suse.de>	<48B517A2.5010508@mxs.nes.nec.co.jp>	<48B602CF.5040809@sgi.com>	<20080828092519.5d2d8838@halley.suse.de>	<48B79B17.8050307@mxs.nes.nec.co.jp>	<48B83C82.3060100@sgi.com>
	<48B85813.2030709@sgi.com>
In-Reply-To: <48B85813.2030709@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0751698104=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

--===============0751698104==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Jay Lan wrote:
> Copying data                       : [  0 %]
> 
> Oops, the kdump kernel MCA'ed at this point! The system was rebooted.
> But at least makedumpfile understood the /proc/vmcore.

Thank you for the test.
It is a good news that makedumpfile understood /proc/vmcore.


> I think MCA on copying data is a different issue. It MCA'ed even on
> 'cp /proc/vmcore /diskdump/vmcore' :(

I also think that is a different issue.


Thanks
Ken'ichi Ohmichi



--===============0751698104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0751698104==--
