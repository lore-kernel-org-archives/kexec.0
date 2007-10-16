Return-path: <kexec-bounces@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by pentafluge.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IhjEP-0004Vv-67
	for kexec@lists.infradead.org; Tue, 16 Oct 2007 11:01:00 +0100
Subject: Re: [patch 0/2] Protect crashkernel against BSS overlap
References: <20071015115042.391348549@strauss.suse.de>
	<20071016054956.GA4659@in.ibm.com>
From: Andi Kleen <andi@firstfloor.org>
Date: 16 Oct 2007 11:59:55 +0200
In-Reply-To: <20071016054956.GA4659@in.ibm.com>
Message-ID: <p738x63z8f8.fsf@crumb.suse.de>
MIME-Version: 1.0
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
To: vgoyal@in.ibm.com
Cc: Bernhard Walle <bwalle@suse.de>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> Wouldn't it be better if we reserve the code, data and bss memory also
> using bootmem allocator and when somebody tries to reserve craskernel memory
> and if there is an overlap, boot memory allocator should scream?

Some x86 bootmem code right now relies on it not screaming (or at least not
erroring out). That would need to be fixed first. Or you make it a flag.
Would probably make sense, except that we already have too many bootmem
allocation variants :/

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
