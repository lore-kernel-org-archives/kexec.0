Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19Fd-0003mN-9b
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:10:45 +0000
Date: Wed, 28 May 2008 10:10:38 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] EDD fix
Message-ID: <20080528001037.GG6752@verge.net.au>
References: <1211837191-3850-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1211837191-3850-1-git-send-email-bwalle@suse.de>
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
Cc: kexec@lists.infradead.org

On Mon, May 26, 2008 at 11:26:31PM +0200, Bernhard Walle wrote:
> This patch fixes EDD support where the BIOS reports a length lower than the
> actual length of raw_data in sysfs. That's no problem -- the check only
> needs to catch the case where the sysfs file is *smaller* than the
> BIOS reported length.
> 
> Also add a newline at the end of the error message.
> 
> The problem was introduced in 3bf0213789d56054f601c5a06372f78567aacdd9 by
> myself, the initial EDD implementation.

Thanks Bernhard, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
