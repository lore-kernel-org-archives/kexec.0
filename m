Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HsgfL-0004m2-Ge
	for kexec@lists.infradead.org; Mon, 28 May 2007 10:57:49 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Date: Mon, 28 May 2007 16:57:26 +0200
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
	<20070528105442.GA25599@suse.de>
In-Reply-To: <20070528105442.GA25599@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705281657.26292.ak@suse.de>
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
To: Bernhard Walle <bwalle@suse.de>
Cc: vgoyal@in.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org

On Monday 28 May 2007 12:54:42 Bernhard Walle wrote:
> * Vivek Goyal <vgoyal@in.ibm.com> [2007-05-01 07:06]:
> > This seems to be a problem with gdb 6.5. I transferred the dump to a
> > different machine having GNU gdb 6.4, and it works fine there.
> 
> What's the state of it? Andy, was the GDB breakage the reason why you
> didn't merge it? 

Yes, I was waiting for Vivek to figure that out.

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
