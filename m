Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5OR6-0005Em-PL
	for kexec@lists.infradead.org; Sun, 08 Jun 2008 17:12:09 +0000
Date: Sun, 8 Jun 2008 19:12:00 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080608191200.529d0619@kopernikus.site>
In-Reply-To: <20080608142606.GE2487@hacking>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<20080608142606.GE2487@hacking>
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de, vgoyal@redhat.com

* WANG Cong <xiyou.wangcong@gmail.com> [2008-06-08 22:26]:
>
> Since 'reserve_bootmem_generic' is changed from 'void' to 'int',
> we should check its return value for failure when possible, right?

That may make sense here, but that's unrelated to my change.

Just because the error *can* be caught by checking the return value
doesn't mean that it *must* be caught always. It was silently ignored
before in the efi_reserve_bootmem() function before, and so is it now.
No behaviour change.



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
