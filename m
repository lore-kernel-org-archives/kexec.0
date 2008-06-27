Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KCBtZ-00065y-Ha
	for kexec@lists.infradead.org; Fri, 27 Jun 2008 11:13:37 +0000
Date: Fri, 27 Jun 2008 13:14:15 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 2/2] Use FIRMWARE_MEMMAP on x86/E820
Message-ID: <20080627131415.4d482af2@halley.suse.de>
In-Reply-To: <86802c440806261354y673a5521ie615feafae3b2bd8@mail.gmail.com>
References: <1214511542-28458-1-git-send-email-bwalle@suse.de>
	<1214511542-28458-3-git-send-email-bwalle@suse.de>
	<86802c440806261354y673a5521ie615feafae3b2bd8@mail.gmail.com>
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
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com, gregkh@suse.de

* Yinghai Lu [2008-06-26 13:54]:
>
> looks good...
> 
> will produce one patch update early_reserve_e820_mpc_new or
> early_reserve_e820 to update e820_saved too. that contained updated
> mptable for second kernel without acpi support.

You or me? I don't understand ...



Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
