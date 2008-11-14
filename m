Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo202.gate.nec.co.jp ([202.32.8.206])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L0oJc-0006jL-07
	for kexec@lists.infradead.org; Fri, 14 Nov 2008 02:21:44 +0000
Message-ID: <491CDDCE.2060307@mxs.nes.nec.co.jp>
Date: Fri, 14 Nov 2008 11:09:18 +0900
From: "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp>
MIME-Version: 1.0
Subject: Re: [PATCH] makedumpfile: Claim to support 2.6.27
References: <109842e145d381000c4c.1226482968@hale.suse.de>	<491BEE34.6070501@mxs.nes.nec.co.jp>
	<20081113121506.3a3b72b1@hale.suse.de>
In-Reply-To: <20081113121506.3a3b72b1@hale.suse.de>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1006151455=="
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org

--===============1006151455==
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit


Hi Bernhard,

Bernhard Walle wrote:
> * Ken'ichi Ohmichi [2008-11-13 18:07]:
>> Bernhard Walle wrote:
>>> According to the changelog and my tests, 2.6.27 kernel is supported. Express
>>> that in the LATEST_VERSION check.
>> Thank your for your tests and your patch.
>> I also tested makedumpfile on linux-2.6.27 of both i386 and x86_64,
>> but I have not tested on ia64 yet.
>> So I want to know the CPU architecture of your machine to fill the
>> supporting table of makedumpfile's "README" file.
> 
> I tested on ia64 in that case.

Is your ia64 kernel discontigmem, or sparsemem ?


Thanks
Ken'ichi Ohmichi


--===============1006151455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec

--===============1006151455==--
