Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBmUi-0001fe-O8
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 08:06:17 +0000
Date: Thu, 26 Jun 2008 10:06:03 +0200
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080626080603.GD16168@elte.hu>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1214465001-12338-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com


* Bernhard Walle <bwalle@suse.de> wrote:

> I would suggest to remove the "experimental" status from Kdump. Kdump 
> is now in the kernel since a long time and used by Enterprise 
> distributions. I don't think that "experimental" is true any more.

agreed. I have applied your patch to tip/x86/crashdump (separate topic 
due to its fs/Kconfig impact).

Thanks Bernhard,

	Ingo

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
