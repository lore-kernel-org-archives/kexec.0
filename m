Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KFkkv-0001YM-W2
	for kexec@lists.infradead.org; Mon, 07 Jul 2008 07:03:26 +0000
Date: Mon, 7 Jul 2008 17:03:24 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/5] Fix compiler warning in kexec-x86.c
Message-ID: <20080707070323.GC788@verge.net.au>
References: <1215385571-11844-1-git-send-email-bwalle@suse.de>
	<1215385571-11844-3-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1215385571-11844-3-git-send-email-bwalle@suse.de>
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
Cc: Bernhard Walle <bernhard.walle@gmx.de>, kexec@lists.infradead.org, vgoyal@redhat.com

On Mon, Jul 07, 2008 at 01:06:08AM +0200, Bernhard Walle wrote:
> From: Bernhard Walle <bernhard.walle@gmx.de>
> 
> This patch fixes following compiler warning:
> 
>     kexec/arch/i386/kexec-x86.c:234: \
>         warning: missing initializer
>     kexec/arch/i386/kexec-x86.c:234: \
>         warning: (near initialization for 'arches[5].arch')

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
