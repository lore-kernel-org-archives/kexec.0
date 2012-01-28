Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1RrFGB-0000Jg-TJ
 for kexec@lists.infradead.org; Sat, 28 Jan 2012 20:52:32 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: BUG: unable to handle kernel paging request at ffffc7ff81000398
 (sys_kexec_load)
References: <1327212367.32115.4.camel@lappy>
 <m1lip0s5nt.fsf@fess.ebiederm.org> <1327763490.16907.1.camel@lappy>
Date: Sat, 28 Jan 2012 12:54:43 -0800
In-Reply-To: <1327763490.16907.1.camel@lappy> (Sasha Levin's message of "Sat, 
 28 Jan 2012 10:11:30 -0500")
Message-ID: <m1y5sro8do.fsf@fess.ebiederm.org>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Dave Jones <davej@redhat.com>, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

Sasha Levin <levinsasha928@gmail.com> writes:

> On Sat, 2012-01-21 at 20:49 -0800, Eric W. Biederman wrote:
>> Interesting.
>> 
>> The fact that this happens in native_set_pte would suggest that we are
>> trying to write to a page table that does not exist.  So this might
>> be a layer below kexec_load that has the problem.
>> 
>> Do you have the kernel you were testing?    A disassembly of the
>> native_set_pte, machine_kexec_prepare and sys_kexec_load
>> would be interesting, for attempting to trace this back to what went
>> wrong.
>
> I did some work into investigating it today, looks like it's simple to trigger it using the following code:
>
> 	#include <fcntl.h>
> 	int main(void)
> 	{
> 		char dummy[4096] = {0};
> 		syscall(246, 0xffffffff81008000, 1, dummy, 2);
> 		return 0;
> 	}
>
> I'll continue trying to figure out whats wrong, but hopefully this
> lead will help in reproducing it easily.

Yes that helps, and that matches the backtrace.

So the question becomes why does a strange entry point address cause problems.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
