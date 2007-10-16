Return-path: <kexec-bounces@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhpI3-0001Gp-UY
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 17:29:11 +0100
Date: Tue, 16 Oct 2007 18:28:06 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 0/2] Protect crashkernel against BSS overlap
Message-ID: <20071016162806.GB16521@suse.de>
References: <20071015115042.391348549@strauss.suse.de>
	<20071016054956.GA4659@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071016054956.GA4659@in.ibm.com>
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
Cc: akpm@linux-foundation.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ak@suse.de

* Vivek Goyal <vgoyal@in.ibm.com> [2007-10-16 07:49]:
> 
> Shouldn't bootmem allocator have the functionality to flag an error if
> we try to reserve a memory which is already reserved? I see that bootmem
> allocator is currently printing a warning under CONFIG_DEBUG_BOOTMEM.

That's probably better, yes. See the next version.

> Wouldn't it be better if we reserve the code, data and bss memory also
> using bootmem allocator and when somebody tries to reserve craskernel memory
> and if there is an overlap, boot memory allocator should scream?

It's already marked as reserved. At least on i386 in my test.

> In second patch, you are checking for crash kernel reserved memory being
> beyond _end. That will make sure that there is no overlap with kernel
> text, data or bss. I am wondering then why do we need first patch and
> why should we register bss memory in the resources list. Second patch 
> would make sure that there is no overlap with crash kernel memory and kexec
> will not place any segment outside crashkernel memory.

I think we should also present the BSS to the user like we present
text and data.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
