Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IiTMe-0001tn-JI
	for kexec@lists.infradead.org; Thu, 18 Oct 2007 12:16:35 +0100
Date: Thu, 18 Oct 2007 13:15:30 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 2/3] Introduce BOOTMEM_EXCLUSIVE
Message-ID: <20071018111530.GA10028@suse.de>
References: <20071016162857.635479952@strauss.suse.de>
	<20071016162858.545617122@strauss.suse.de>
	<20071017110550.GB17565@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071017110550.GB17565@in.ibm.com>
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
Errors-To: kexec-bounces@lists.infradead.org
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-10-17 13:05]:
> 
> 
> I think we should unreserve the chunks of memory we have reserved so
> far (Memory reserved from sidx to i), in case of error.

True. Next version is coming.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
