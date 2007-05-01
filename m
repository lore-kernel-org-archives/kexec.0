Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ns.suse.de ([195.135.220.2] helo=mx1.suse.de)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HikuY-0006Rr-RN
	for kexec@lists.infradead.org; Tue, 01 May 2007 01:28:31 -0400
Date: Tue, 1 May 2007 08:25:55 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
Message-ID: <20070501062554.GT25929@bingen.suse.de>
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
	<m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
	<m1zm4pyuzp.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <m1zm4pyuzp.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Andi Kleen <ak@suse.de>, Jurriaan <thunder7@xs4all.nl>, Helge Hafting <helgehaf@aitel.hist.no>, vgoyal@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 30, 2007 at 11:26:50PM -0600, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> 
> >> At least without a core file it is working on with gdb 6.4.
> >>
> >
> > This seems to be a problem with gdb 6.5. I transferred the dump to a
> > different machine having GNU gdb 6.4, and it works fine there.
> 
> Ok.  The difference between those two symbols didn't seem to make
> any sense, so a gdb bug makes sense.
> 
> Cool.  Then the patch is good. :)

It would still make any gdb 6.5 users unhappy. If no workaround can be found
I guess we'll need a CONFIG of some sort?

-Andi

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
