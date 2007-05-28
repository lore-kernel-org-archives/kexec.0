Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx2.suse.de ([195.135.220.15])
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HsgO6-0004dB-Vf
	for kexec@lists.infradead.org; Mon, 28 May 2007 10:40:00 -0400
Date: Mon, 28 May 2007 16:39:39 +0200
From: Bernhard Walle <bwalle@suse.de>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070528143939.GA16026@suse.de>
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
	<m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
	<20070528105442.GA25599@suse.de>
	<20070528110944.GE32045@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20070528110944.GE32045@in.ibm.com>
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
Cc: kexec@lists.infradead.org, Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org

* Vivek Goyal <vgoyal@in.ibm.com> [2007-05-28 13:09]:
> On Mon, May 28, 2007 at 12:54:42PM +0200, Bernhard Walle wrote:
> > * Vivek Goyal <vgoyal@in.ibm.com> [2007-05-01 07:06]:
> > > This seems to be a problem with gdb 6.5. I transferred the dump to a
> > > different machine having GNU gdb 6.4, and it works fine there.
> > 
> > What's the state of it? Andy, was the GDB breakage the reason why you
> > didn't merge it? Did someone file a GDB bug?
> 
> I had sent a mail to gdb mailing list but no response. Did not raise
> a bug though.

BTW: Did anyone test with GDB 6.6?


Thanks,
   Bernhard

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
