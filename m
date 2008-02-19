Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from koto.vergenet.net ([210.128.90.7])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1JRLlw-0008O7-NY
	for kexec@lists.infradead.org; Tue, 19 Feb 2008 06:16:09 +0000
Date: Tue, 19 Feb 2008 15:16:03 +0900
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] Add ARM support to kexec
Message-ID: <20080219061603.GC8917@verge.net.au>
References: <1202160243.4788.103.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1202160243.4788.103.camel@localhost.localdomain>
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
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Uli Luckas <u.luckas@road.de>, kexec@lists.infradead.org, ebiederm@xmission.com

On Mon, Feb 04, 2008 at 09:24:03PM +0000, Richard Purdie wrote:
> Add ARM support to kexec including commandline support through ATAGs.
> The kernel syscall support has already been merged and kernel ATAG
> exporting is queued for 2.6.25 (its optional for kexec).
> 
> Based on work by various people, notably Uli Luckas <u.luckas@road.de>
> for adding ATAG support.

Thanks, that looks quite nice indeed. Applied.

-- 
Horms


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
