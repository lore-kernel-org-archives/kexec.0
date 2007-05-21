Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1Hq3zU-0007cr-2s
	for kexec@lists.infradead.org; Mon, 21 May 2007 05:15:45 -0400
Date: Mon, 21 May 2007 11:15:03 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH] [makedumpfile] Fix missing last node
Message-ID: <20070521091503.GA3363@suse.de>
References: <20070518105012.GF16227@suse.de>
	<20070521164518oomichi@mail.jp.nec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070521164518oomichi@mail.jp.nec.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp>
Cc: kexec@lists.infradead.org

* Ken'ichi Ohmichi <oomichi@mxs.nes.nec.co.jp> [2007-05-21 09:45]:
> 2007/05/18 12:50:12 +0200, Bernhard Walle <bwalle@suse.de> wrote:
> >This patch fixes a typo which results in duplication of the first node (and the
> >last node was missing then).
> 
> I think the cause of this problem is the other typo.
> Does the attached patch fix it ?

Yes, thanks!


Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
