Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhpGq-0001F5-Lc
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 17:27:55 +0100
Date: Tue, 16 Oct 2007 18:26:46 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 0/2] Protect crashkernel against BSS overlap
Message-ID: <20071016162646.GA16521@suse.de>
References: <20071015115042.391348549@strauss.suse.de>
	<20071016054956.GA4659@in.ibm.com> <p738x63z8f8.fsf@crumb.suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <p738x63z8f8.fsf@crumb.suse.de>
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
To: Andi Kleen <andi@firstfloor.org>
Cc: akpm@linux-foundation.org, vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Andi Kleen <andi@firstfloor.org> [2007-10-16 11:59]:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > Wouldn't it be better if we reserve the code, data and bss memory also
> > using bootmem allocator and when somebody tries to reserve craskernel memory
> > and if there is an overlap, boot memory allocator should scream?
> 
> Some x86 bootmem code right now relies on it not screaming (or at least not
> erroring out). That would need to be fixed first. Or you make it a flag.
> Would probably make sense, except that we already have too many bootmem
> allocation variants :/

Ok, I made a flag, see the next version of the patch.


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
