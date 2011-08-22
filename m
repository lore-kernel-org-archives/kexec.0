Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mtagate1.uk.ibm.com ([194.196.100.161])
	by canuck.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
	id 1QvO6S-0000BK-Nb
	for kexec@lists.infradead.org; Mon, 22 Aug 2011 06:35:22 +0000
Received: from d06nrmr1507.portsmouth.uk.ibm.com
	(d06nrmr1507.portsmouth.uk.ibm.com [9.149.38.233])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p7M6Z4gk017556
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 06:35:04 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p7M6Z4pT2531364
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 07:35:04 +0100
Received: from d06av03.portsmouth.uk.ibm.com (localhost.localdomain
	[127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p7M6Z3ax004755
	for <kexec@lists.infradead.org>; Mon, 22 Aug 2011 00:35:04 -0600
Date: Mon, 22 Aug 2011 08:34:59 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 0/2] kdump: Common code changes for s390 kdump support
Message-ID: <20110822083459.2cc52fc8@mschwide>
In-Reply-To: <20110819150353.bf58c7e0.akpm@linux-foundation.org>
References: <20110819141857.052232873@linux.vnet.ibm.com>
	<20110819150353.bf58c7e0.akpm@linux-foundation.org>
Mime-Version: 1.0
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
	<mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: oomichi@mxs.nes.nec.co.jp, linux-s390@vger.kernel.org, mahesh@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, hbabu@us.ibm.com, horms@verge.net.au, ebiederm@xmission.com, Michael Holzheu <holzheu@linux.vnet.ibm.com>, kexec@lists.infradead.org, vgoyal@redhat.com

On Fri, 19 Aug 2011 15:03:53 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Fri, 19 Aug 2011 16:18:57 +0200
> Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:
> 
> > I had a long discussion with Vivek Goyal on the s390 kdump support (thanks
> > Vivek for all the time!). As a result of this, here are two common code
> > patches that are required for the s390 port. Could you please integrate them
> > upstream in the next merge window? The s390 specific part will be integrated
> > by our s390 maintainer Martin Schwidefsky.
> 
> The patches look OK to me.  I suggest that they be carried in Martin's
> tree, alongside the s390 kdump support.  That will somewhat simplify
> things during the merge window, and will greatly simplify getting the
> entire feature into linux-next.
> 
> You can put my acked-by's on them if you like.
> 
> > I will be on vacation for the next two weeks. Therefore if you have comments
> > or questions, please contact also Martin Schwidefsky and Heiko Carstens.
> 
> I'll put the patches into my tree (and hence linux-next) now, because I
> need the typing practice ;) I'll drop them again if/when they turn up
> in linux-next's s390 tree.

Ok, sounds reasonable to me. I'll take them via the s390 tree and add
you acked-by. Thanks Andrew. 


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
