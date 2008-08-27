Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KYJ8P-0004g4-Lo
	for kexec@lists.infradead.org; Wed, 27 Aug 2008 11:24:22 +0000
Date: Wed, 27 Aug 2008 13:24:19 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: Zero size vmcore on ia64
Message-ID: <20080827132419.6b77f01c@halley.suse.de>
In-Reply-To: <4104961b0808270354y267145e7l637b70ee4c8a384a@mail.gmail.com>
References: <4104961b0808270201i64b1914ame2e6e90d316c6c7@mail.gmail.com>
	<20080827112728.51024582@halley.suse.de>
	<4104961b0808270251n1e7250dbn656ae77d2f8bc3d3@mail.gmail.com>
	<20080827121443.396d8bac@halley.suse.de>
	<4104961b0808270354y267145e7l637b70ee4c8a384a@mail.gmail.com>
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

* jidong xiao [2008-08-27 18:54]:
> >
> > With the SP2 default kernel, it should work. At lest /proc/vmcore
> > should have a normal size. Can you set KDUMP_IMMEDIATE_REBOOT to "no",
> > then log in in the serial console and execute
> >
> >        # ls -l /proc/vmcore
> I am sorry to say, I tried to follow your instruction but finally the
> out put is zero.
> lfg-ia64:~ # ls -l /proc/vmcore
> -r-------- 1 root root 0 2008-08-27 18:40 /proc/vmcore

Strange. Which hardware is that?


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
