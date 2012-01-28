Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-yx0-f177.google.com ([209.85.213.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1Rr9wC-0005H9-Eb
 for kexec@lists.infradead.org; Sat, 28 Jan 2012 15:11:32 +0000
Received: by yenm4 with SMTP id m4so1242973yen.36
 for <kexec@lists.infradead.org>; Sat, 28 Jan 2012 07:11:30 -0800 (PST)
Message-ID: <1327763490.16907.1.camel@lappy>
Subject: Re: BUG: unable to handle kernel paging request at ffffc7ff81000398
 (sys_kexec_load)
From: Sasha Levin <levinsasha928@gmail.com>
Date: Sat, 28 Jan 2012 10:11:30 -0500
In-Reply-To: <m1lip0s5nt.fsf@fess.ebiederm.org>
References: <1327212367.32115.4.camel@lappy> <m1lip0s5nt.fsf@fess.ebiederm.org>
Mime-Version: 1.0
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Jones <davej@redhat.com>, kexec@lists.infradead.org, linux-kernel <linux-kernel@vger.kernel.org>

On Sat, 2012-01-21 at 20:49 -0800, Eric W. Biederman wrote:
> Interesting.
> 
> The fact that this happens in native_set_pte would suggest that we are
> trying to write to a page table that does not exist.  So this might
> be a layer below kexec_load that has the problem.
> 
> Do you have the kernel you were testing?    A disassembly of the
> native_set_pte, machine_kexec_prepare and sys_kexec_load
> would be interesting, for attempting to trace this back to what went
> wrong.

I did some work into investigating it today, looks like it's simple to trigger it using the following code:

	#include <fcntl.h>
	int main(void)
	{
		char dummy[4096] = {0};
		syscall(246, 0xffffffff81008000, 1, dummy, 2);
		return 0;
	}

I'll continue trying to figure out whats wrong, but hopefully this lead will help in reproducing it easily.

-- 

Sasha.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
