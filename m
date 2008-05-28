Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1K19Ev-0001Wu-QJ
	for kexec@lists.infradead.org; Wed, 28 May 2008 00:10:02 +0000
Date: Wed, 28 May 2008 10:09:55 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Don't run libtoolize and automake in bootstrap.
Message-ID: <20080528000953.GF6752@verge.net.au>
References: <1211824802-7205-1-git-send-email-bwalle@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1211824802-7205-1-git-send-email-bwalle@suse.de>
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

On Mon, May 26, 2008 at 08:00:02PM +0200, Bernhard Walle wrote:
> This patch removes the 'automake' and 'libtoolize' calls from the 'bootstrap'.
> The bug has been introduced by commit 6f65cb623cdb82f712144e438d9aa2f097376251
> by myself. Automake and Libtool are not used in kexec-tools.

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
