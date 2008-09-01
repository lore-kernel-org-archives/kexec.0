Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KZzrz-0008Rb-VW
	for kexec@lists.infradead.org; Mon, 01 Sep 2008 03:14:25 +0000
Message-ID: <48BB4FE5.3050004@mxs.nes.nec.co.jp>
Date: Mon, 01 Sep 2008 11:13:57 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH][ia64] Fix the difference between node_mem_map
	and	node_start_pfn. (Re: makedumpfile fails on SGI machine)
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>	<20080805171143.773c2465@halley.suse.de>	<48A9228A.3070005@mxs.nes.nec.co.jp>	<20080818130025.0282e471@halley.suse.de>	<48B517A2.5010508@mxs.nes.nec.co.jp>
	<48B602CF.5040809@sgi.com>	<20080828092519.5d2d8838@halley.suse.de>	<48B79B17.8050307@mxs.nes.nec.co.jp>
	<20080829185436.106fcdca@halley.suse.de>
In-Reply-To: <20080829185436.106fcdca@halley.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1208115213=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: Jay Lan <jlan@sgi.com>, kexec@lists.infradead.org

--===============1208115213==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
>>> However, shouldn't we add that vmem_map to VMCOREINFO of the kernel?
>> I think that we would rather fix the kernel bug than add vmem_map to
>> VMCOREINFO of the kernel. If fixing it, makedumpfile does not need
>> vmem_map.
>>
>> The attached patch fixes the kernel bug, and makedumpfile can work without
>> '-x' option. I tested it on my ia64 none-NUMA machine, and it works fine.
>> Could you test the attached patch on your machine again ?
> 
> Thanks for the patch! This works fine on my machine.

Thank you for the testing !
I'll send this patch to linux-mm.


Thanks
Ken'ichi Ohmichi


--===============1208115213==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1208115213==--
