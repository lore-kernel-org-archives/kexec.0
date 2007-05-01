Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from [2002:a646:1c45::1] (helo=ebiederm.dsl.xmission.com)
	by canuck.infradead.org with esmtps (Exim 4.63 #1 (Red Hat Linux))
	id 1HiktP-0006Qa-5T
	for kexec@lists.infradead.org; Tue, 01 May 2007 01:27:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 1/2] x86_64: Reflect the relocatability of the kernel in
	the ELF header.
References: <m1slah6gm0.fsf@ebiederm.dsl.xmission.com>
	<200704301717.08230.ak@suse.de> <20070501035539.GA15472@in.ibm.com>
	<m14pmx18ey.fsf@ebiederm.dsl.xmission.com>
	<20070501050657.GA23111@in.ibm.com>
Date: Mon, 30 Apr 2007 23:26:50 -0600
In-Reply-To: <20070501050657.GA23111@in.ibm.com> (Vivek Goyal's message of
	"Tue, 1 May 2007 10:36:57 +0530")
Message-ID: <m1zm4pyuzp.fsf@ebiederm.dsl.xmission.com>
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
Errors-To: kexec-bounces+dwmw2=infradead.org+dwmw2=infradead.org@lists.infradead.org
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Kexec Mailing List <kexec@lists.infradead.org>, Andi Kleen <ak@suse.de>, Jurriaan <thunder7@xs4all.nl>, Helge Hafting <helgehaf@aitel.hist.no>, Horms <horms@verge.net.au>, Andrew Morton <akpm@linux-foundation.org>

Vivek Goyal <vgoyal@in.ibm.com> writes:


>> At least without a core file it is working on with gdb 6.4.
>>
>
> This seems to be a problem with gdb 6.5. I transferred the dump to a
> different machine having GNU gdb 6.4, and it works fine there.

Ok.  The difference between those two symbols didn't seem to make
any sense, so a gdb bug makes sense.

Cool.  Then the patch is good. :)

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
