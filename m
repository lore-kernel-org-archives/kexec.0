Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mercury.realtime.net ([205.238.132.86])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1KskZC-0006uo-PG
	for kexec@lists.infradead.org; Wed, 22 Oct 2008 20:44:31 +0000
In-Reply-To: <kexec-user-2@bga.com>
References: <kexec-user-2@bga.com>
Mime-Version: 1.0 (Apple Message framework v624)
Message-Id: <85f28cc33f5eb349962712e541762b38@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/2 kexec-tools] ppc64: segemments are sorted
Date: Wed, 22 Oct 2008 15:47:45 -0500
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
To: Milton Miller <miltonm@bga.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, kexec@lists.infradead.org, Simon Horman <horms@verge.net.au>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org


On Oct 22, 2008, at 3:39 PM, Milton Miller wrote:

> Every time add_segment is called, the segments are sorted.  If the 
> first
> hole in memory is not big enough for the kernel then something besides
> the kernel may be at

info->segment[0].

> ---
> Found during custom environment testing with several reserved blocks of
> memory, not the usual case.

milton


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
