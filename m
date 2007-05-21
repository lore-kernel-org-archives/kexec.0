Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hq4an-0008LL-Rp
	for kexec@lists.infradead.org; Mon, 21 May 2007 05:54:19 -0400
Date: Mon, 21 May 2007 11:54:14 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Implement memory regions on IA64
Message-ID: <20070521095414.GA32741@suse.de>
References: <20070516202000oomichi@mail.jp.nec.com>
	<20070521183227oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070521183227oomichi@mail.jp.nec.com>
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
Cc: Jay Lan <jlan@sgi.com>, Kexec Mailing List <kexec@lists.infradead.org>

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-21 11:32]:
> 2007/05/16 20:20:00 +0900, "Ken'ichi Ohmichi" <oomichi@mxs.nes.nec.co.jp> wrote:
> >I propose that makedumpfile distinguishes the page table (3L or 4L)
> >by checking the defined file name of pud_t.
> >I'm trying for the above implementation.
> >I will send you the patch when it is complete.
> 
> The attached patch is for the above implementation.
> It works fine with linux-2.6.18.
> Could you test it with your environment ?

works, thanks.


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
