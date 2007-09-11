Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1IV2YV-0000Xv-SW
	for kexec@lists.infradead.org; Tue, 11 Sep 2007 06:01:19 -0400
Date: Tue, 11 Sep 2007 12:01:10 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [patch 1/5] Extended crashkernel command line
Message-ID: <20070911100110.GB31038@suse.de>
References: <20070909083914.065380136@strauss.suse.de>
	<20070909083914.488571169@strauss.suse.de>
	<20070911061522.GD5053@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070911061522.GD5053@in.ibm.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux-arch@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-09-11 08:15]:
> 
> "offset" seems to be optional in the new syntax. What happens if user does
> not specify offset. I think crash_base will be set to zero and system will
> try to reserve x amount of memory start at zero? That would fail?

That's handled in the architecture specific code -- because it's
different on each architecture and the architecture specific code does
memory reservation. IA64 already can handle this case (on IA64,
specifying 0 is the same than leaving out the base address, and that's
why I wanted to keep that semantics). I think it doesn't also make
sense on i386/x86_64 to choose 0 as real base address, because the
value below 1 MB is special for booting ...

> I think we should add some intelligence for automatic selection of "offset"
> if user has not specified one. Automatically choose a chunk of free memory.
> This takes away the headache from user for selecting a right place. In fact
> one "offset" might not be valid for all the systems. I remember, somebody
> had reported that ACPI tables were mapped lower in the address space and
> reserving memory for kdump had failed.

I think you're right -- with the relocatable kernel it makes sense to
have the kernel to decide where to reservate that memory. But that's
beyond of the scope of that patch series -- however, I can come up
with a solution, after that patch has been finished.


Thanks,
   Bernhard


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
