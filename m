Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by bombadil.infradead.org with esmtps (Exim 4.68 #1 (Red Hat Linux))
	id 1KO4ea-0003R3-LG
	for kexec@lists.infradead.org; Wed, 30 Jul 2008 05:55:16 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6U5tCBV030105
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 01:55:12 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6U5tCwM191234
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 01:55:12 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6U5tBTg013989
	for <kexec@lists.infradead.org>; Wed, 30 Jul 2008 01:55:12 -0400
Date: Wed, 30 Jul 2008 11:24:04 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: linux-next: build failure
Message-ID: <20080730055404.GA6154@in.ibm.com>
References: <20080730153028.95226354.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080730153028.95226354.sfr@canb.auug.org.au>
Reply-To: ananth@in.ibm.com
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
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Haren Myneni <hbabu@us.ibm.com>, linux-next@vger.kernel.org, kexec@lists.infradead.org, Ankita Garg <ankita@in.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, Jul 30, 2008 at 03:30:28PM +1000, Stephen Rothwell wrote:
> Hi Ananth,
> 
> Today's linux-next build (powerpc allyesconfig) failed like this:
> 
> tests/lkdtm.c:182: error: expected ')' before '*' token
> 
> I have no idea why this fails now when it did not before.
> 
> I applied the following patch.

Thanks Stephen!

Ankita, any ideas?

Ananth


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
