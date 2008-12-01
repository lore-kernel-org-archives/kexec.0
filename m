Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1L75Yn-0000xI-2m
	for kexec@lists.infradead.org; Mon, 01 Dec 2008 09:59:21 +0000
Date: Mon, 1 Dec 2008 10:59:15 +0100
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Parse 64 bit VMCOREINFO on 32 bit userland
Message-ID: <20081201105915.6166e35f@hale.suse.de>
In-Reply-To: <49336802.2020102@mxs.nes.nec.co.jp>
References: <20081127160034.121f5911@hale.suse.de>
	<492F465D.6000609@mxs.nes.nec.co.jp>
	<20081128083852.330bd44a@kopernikus.site>
	<49336802.2020102@mxs.nes.nec.co.jp>
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi [2008-12-01 13:28]:
> 
> 'unsigned long' of PPC32 is 32 bit, so PPC32 makedumpfile cannot read
> 64 bit pointer. If they will be changed to 'unsigned long long'(64 bit),
> makedumpfile reads invalid area on 32 bit machine. Then this change is
> not acceptable.

Agreed. I think we need to ship 64 bit makedumpfile.


    Bernhard
-- 
Bernhard Walle, SUSE Linux Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
