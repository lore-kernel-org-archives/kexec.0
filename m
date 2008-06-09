Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1K5k9I-0007yN-Fa
	for kexec@lists.infradead.org; Mon, 09 Jun 2008 16:23:12 +0000
Date: Mon, 9 Jun 2008 18:23:41 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Add flags parameter to reserve_bootmem_generic()
Message-ID: <20080609182341.00d6e746@halley.suse.de>
In-Reply-To: <20080609132207.GC3542@redhat.com>
References: <20080608134628.757299158@halley.suse.de>
	<20080608134629.743220278@halley.suse.de>
	<87bq2bmvro.fsf@saeurebad.de> <20080609132207.GC3542@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: andi@firstfloor.org, kexec@lists.infradead.org, Johannes Weiner <hannes@saeurebad.de>, linux-kernel@vger.kernel.org, mingo@redhat.com, anderson@redhat.com, hpa@zytor.com, tglx@linutronix.de

* Vivek Goyal [2008-06-09 09:22]:
>
> Kdump first kernel always tries to reserve just physical RAM and nothing
> else. So I am not sure what does above code do. Try to reserve a memory
> which is not RAM but is in the region less than highest mapped entity and
> in that case return silently without any warning. In what case do we
> exercise this path?

I don't know. That code has been introduced in 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=5e58a02a8f6a7a1c9ae41f39286bcd3aea0d6f24

Ccing Andi.

IMO we should not print any warning in that function, leaving the error
handling to the caller.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Maintenance

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
