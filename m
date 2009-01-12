Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
	by bombadil.infradead.org with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LMGDU-0001Nu-M5
	for kexec@lists.infradead.org; Mon, 12 Jan 2009 06:24:21 +0000
Date: Mon, 12 Jan 2009 17:24:02 +1100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/5 + 2] kexec updates
Message-ID: <20090112062359.GK7337@verge.net.au>
References: <kexec-29-1.miltonm@bga.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <kexec-29-1.miltonm@bga.com>
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
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org, "M. Mohan Kumar" <mohan@in.ibm.com>, Paul Mackerras <paulus@samba.org>, kexec@lists.infradead.org

On Fri, Jan 02, 2009 at 02:42:38PM -0600, Milton Miller wrote:
> Follwing this mail are 5 patches for kexec userspace and two for the
> kernel.  The first fixes an array overflow and the second updates
> userspace to the merged 2.6.28 kdump support.  The remaining are
> cleanups and warning fixes, including one for the common code.
> 
> The two patchs for the kernel are independent.

Hi all,

sorry to be a bit slow in responding, this email landed just
as I was leaving for a weeks holiday.

The kexec-tools patches seem reasonable to me and I'm happy to merge what I
think are the latest versions - thanks Michael for your review.

Milton, here are the Subjects, Dates and Message-Ids of what I have in my
queue.  If you could confirm this or repost that would be great.

#1
Subject: [PATCH kexec-tools v2] ppc64: always check number of ranges when adding them
Date: Thu, 08 Jan 2009 06:33:50 -0600
Message-ID: <1231418030_141769@mercury.realtime.net>

#2
Subject: [PATCH kexec-tools 2/5] ppc64: update kdump for 2.6.28 relocatable kernel
Date: Fri, 02 Jan 2009 15:04:42 -0600
Message-Id: <kexec-29-1-2r.miltonm@bga.com>

#3
Subject: [PATCH kexec-tools 3/5] ppc64: segments may be reordered
Date: Fri, 02 Jan 2009 15:04:45 -0600
Message-Id: <kexec-29-1-3r.miltonm@bga.com>

#4
Subject: [PATCH kexec-tools 4/5] ppc64: cleanups
Date: Fri, 02 Jan 2009 15:04:48 -0600
Message-Id: <kexec-29-1-4r.miltonm@bga.com>

#5
Subject: [PATCH kexec-tools 5/5] entry wants to be void *
Date: Fri, 02 Jan 2009 15:04:51 -0600
Message-Id: <kexec-29-1-5r.miltonm@bga.com>

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
