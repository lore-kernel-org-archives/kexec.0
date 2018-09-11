Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from duke.felloff.net ([216.126.196.34])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fzm95-0003pB-Cz
 for kexec@lists.infradead.org; Tue, 11 Sep 2018 17:08:13 +0000
Message-ID: <26D69B9654740B54BC6FFDD09ADDFC3D@felloff.net>
Date: Tue, 11 Sep 2018 19:07:41 +0200
From: cinap_lenrek@felloff.net
Subject: Re: [PATCH] multiboot-x86: support for non-elf kernels
In-Reply-To: 20180911115318.b5hdt6njw6tsjzmi@verge.net.au
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: horms@verge.net.au
Cc: kexec@lists.infradead.org

> Is it desirable for this check to be run for each iteration of the loop.

thats is not really the case. that statemet is executed exactly once.
the first check in the loop body looks for the multiboot header
signature and continues the loop if not found. once that check
passes the iteration ends as we return at the bottom of the loop
body, and there are no other continues.

	for (mbh_offset = 0; mbh_offset <= (len - 12); mbh_offset += 4)
 	{
 		/* Search for a multiboot header */
		mbh = (struct multiboot_header *)(headerbuf + mbh_offset);
 		if (mbh->magic != MULTIBOOT_MAGIC 
 		    || ((mbh->magic+mbh->flags+mbh->checksum) & 0xffffffff))
 		{
			/* Not a multiboot header */
 			continue;
 		}
....

--
cinap

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
