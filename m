Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.suse.de ([195.135.220.2])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KBlq7-0001S4-J9
	for kexec@lists.infradead.org; Thu, 26 Jun 2008 07:24:19 +0000
Date: Thu, 26 Jun 2008 09:24:57 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] Remove CONFIG_EXPERIMENTAL from kdump
Message-ID: <20080626092457.50c58bc2@halley.suse.de>
In-Reply-To: <1214465001-12338-1-git-send-email-bwalle@suse.de>
References: <20080625221635.GD32344@redhat.com>
	<1214465001-12338-1-git-send-email-bwalle@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, vgoyal@redhat.com

* Bernhard Walle [2008-06-26 09:23]:
>
> I would suggest to remove the "experimental" status from Kdump.
> Kdump is now in the kernel since a long time and used by Enterprise
> distributions. I don't think that "experimental" is true any more.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Sorry, forgot the Acked-by which was the intention to resend it to
Andrew. :-| Sent again.


Bernhard
-- 
Bernhard Walle, SUSE LINUX Products GmbH, Architecture Development

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
