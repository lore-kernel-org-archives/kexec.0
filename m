Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KYZEc-0001gy-97
	for kexec@lists.infradead.org; Thu, 28 Aug 2008 04:35:51 +0000
Message-ID: <48B62AA8.3080409@mxs.nes.nec.co.jp>
Date: Thu, 28 Aug 2008 13:33:44 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: makedumpfile fails on SGI machine
References: <20080730161416.47605c30@halley.suse.de>	<4891197D.10400@mxs.nes.nec.co.jp>	<20080731104726.035850be@halley.suse.de>	<48919306.80103@mxs.nes.nec.co.jp>	<20080731131823.3c7c97b2@halley.suse.de>	<4891A3CB.9040805@mxs.nes.nec.co.jp>	<48984275.5070409@mxs.nes.nec.co.jp>	<20080805171143.773c2465@halley.suse.de>	<48A9228A.3070005@mxs.nes.nec.co.jp>	<20080818130025.0282e471@halley.suse.de>	<48B517A2.5010508@mxs.nes.nec.co.jp>
	<48B602CF.5040809@sgi.com>
In-Reply-To: <48B602CF.5040809@sgi.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0004457112=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jay Lan <jlan@sgi.com>
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org

--===============0004457112==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Jay,

Jay Lan wrote:
>> I found an ia64 discontigmem kernel problem that the 'pgdat_list.node_mem_map'
>> has an unexpected value, and I created the attached patch for avoiding the
>> problem. If applying this patch, makedumpfile takes mem_map's information
>> from a symbol 'vmem_map' instead of 'pgdat_list.node_mem_map'.
>> It is for makedumpfile-1.2.8.  Could you please test it ?
>>
>> Note:
>>  This solution needs a symbol 'vmem_map', but vmcoreinfo data in /proc/vmcore
>>  does not contain it. So "-x" option is necessary for running makedumpfile
>>  like the following.
>>
>>  # makedumpfile -c -d31 -x vmlinux /proc/vmcore dumpfile
> 
> Hi Ken'ichi,
> 
> Thanks for your patch!
> 
> I am wondering if the discontigmem kernel has a legitimate bug,
> we probably should report it?

Yes, we should.
I'm investigating this problem more to report it.


> I tested your patch on a machine that used to fail in executing
> 'makedumpfile'. It now generated a dump file fine.
> 
> Running 4.0.7.1 crash against the dump file looked good!

Thank you for your testing.
It is a good news to me, and I will merge the patch into the next
makedumpfile.


> I will test on other types machines later.

Thanks too.


Thanks
Ken'ichi Ohmichi



--===============0004457112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============0004457112==--
