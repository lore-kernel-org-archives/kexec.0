Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYHJL-00034i-Fp
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 09:27:31 +0000
Date: Wed, 27 Aug 2008 11:27:28 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Zero size vmcore on ia64
Message-ID: <20080827112728.51024582@halley.suse.de>
In-Reply-To: <4104961b0808270201i64b1914ame2e6e90d316c6c7@mail.gmail.com>
References: <4104961b0808270201i64b1914ame2e6e90d316c6c7@mail.gmail.com>
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
To: jidong xiao <jidong.xiao@gmail.com>
Cc: kexec@lists.infradead.org, linux-ia64@vger.kernel.org

Hi Jidong,

* jidong xiao [2008-08-27 17:01]:
> 
> I encountered the zero-size-vmcore issue on IA64. I remember last year
> Nanhai submitted a patch which was intended to fix this issue, and I
> noticed that patch is merged into mainline kernel. I am using
> 2.6.27-rc2, which means that patch is included in my kernel.And after
> the system
> completed rebooting, there is nothing generated in KDUMP_SAVEDIR. Let
> me know if I need to provide more information.Thanks.

Which version of kexec-tools do you use?

Please always include the kexec list (kexec@lists.infradead.org) on
kdump and kexec issues. I Cc'd it now.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
