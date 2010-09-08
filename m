Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from plane.gmane.org ([80.91.229.3])
	by bombadil.infradead.org with esmtps (Exim 4.72 #1 (Red Hat Linux))
	id 1OtQXW-0005O1-9w
	for kexec@lists.infradead.org; Wed, 08 Sep 2010 19:42:39 +0000
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>) id 1OtQXQ-0007n3-US
	for kexec@lists.infradead.org; Wed, 08 Sep 2010 21:42:32 +0200
From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH] x86: copy_oldmem_page using cached addressing
References: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com>
Date: Wed, 08 Sep 2010 21:42:18 +0200
In-Reply-To: <E1OtMLz-0001yp-Ia@eag09.americas.sgi.com> (Cliff Wickman's
	message of "Wed, 08 Sep 2010 10:14:27 -0500")
Message-ID: <87eid4vx7p.fsf@basil.nowhere.org>
MIME-Version: 1.0
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
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Cliff Wickman <public-cpw-sJ/iWh9BUns@plane.gmane.org>
Cc: public-linux-kernel-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org, public-kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@plane.gmane.org, public-mingo-X9Un+BFzKDI@plane.gmane.org



Cliff Wickman <cpw-sJ/iWh9BUns@public.gmane.org> writes:

> From: Cliff Wickman <cpw-sJ/iWh9BUns@public.gmane.org>
>
> The copy of /proc/vmcore to a user buffer proceeds much faster
> if the kernel addresses memory as cached.
>
> With this patch we have seen an increase in transfer rate from less than
> 15MB/s to 80-460MB/s, depending on size of the transfer.  This makes
> a big difference in time needed to save a system dump.
>
> (Does anyone know of a reason why copy_oldmem_page() would need
>  to use uncached addresses?)
>
> Diffed against 2.6.36-rc3

I had a similar patch somewhere in my private kernels,
yes it's a big win. I think it was simply a bug that was added
when ioremap was changed to default to uncached.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
