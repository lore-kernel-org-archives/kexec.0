Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JyhSq-0004DB-Lj
	for kexec@lists.infradead.org; Wed, 21 May 2008 06:06:17 +0000
Received: from yukiko.shinjuku.tokyo.vergenet.net (unknown [202.128.116.96])
	by koto.vergenet.net (Postfix) with ESMTP id D6ED23406E
	for <kexec@lists.infradead.org>; Wed, 21 May 2008 15:06:11 +0900 (JST)
Date: Wed, 21 May 2008 16:06:08 +1000
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Document kexec without -e/-l/-f/-p and clarify -f
Message-ID: <20080521060607.GC3714@verge.net.au>
References: <20080508170412.GA6588@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080508170412.GA6588@suse.de>
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
To: kexec@lists.infradead.org

On Thu, May 08, 2008 at 07:04:12PM +0200, Bernhard Walle wrote:
> This patch tries to clarify the manpage in two aspects:
> 
> It describes the meaning of kexec without an -e / -l / -f / -p option (i.e. 
> only with kernel, initrd and command line).
> 
> It also documents the difference between -f and normal kexec call better.
> 
> I made the patch to clarify the manpage because there was some confusion in
> https://bugzilla.novell.com/show_bug.cgi?id=387601.
> 
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>

Thanks, applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
