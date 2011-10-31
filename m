Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
	by canuck.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
	id 1RKpDq-0001Uh-RG
	for kexec@lists.infradead.org; Mon, 31 Oct 2011 10:36:07 +0000
Date: Mon, 31 Oct 2011 03:39:48 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kdump: Fix crash_kexec - smp_send_stop race in panic
Message-Id: <20111031033948.a0edb7f3.akpm@linux-foundation.org>
In-Reply-To: <1320055036.2796.8.camel@br98xy6r>
References: <1319639649.3321.11.camel@br98xy6r>
	<20111028161143.e5ebf617.akpm@linux-foundation.org>
	<1320055036.2796.8.camel@br98xy6r>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: holzheu@linux.vnet.ibm.com
Cc: heiko.carstens@de.ibm.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, schwidefsky@de.ibm.com, Vivek Goyal <vgoyal@redhat.com>

On Mon, 31 Oct 2011 10:57:16 +0100 Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> > Should this be done earlier in the function?  As it stands we'll have
> > multiple CPUs scribbling on buf[] at the same time and all trying to
> > print the same thing at the same time, dumping their stacks, etc. 
> > Perhaps it would be better to single-thread all that stuff
> 
> My fist patch took the spinlock at the beginning of panic(). But then
> Eric asked, if it wouldn't be better to get both panic printk's and I
> agreed.

Hm, why?  It will make a big mess.

> > Also...  this patch affects all CPU architectures, all configs, etc. 
> > So we're expecting that every architecture's smp_send_stop() is able to
> > stop a CPU which is spinning in spin_lock(), possibly with local
> > interrupts disabled.  Will this work?
> 
> At least on s390 it will work. If there are architectures that can't
> stop disabled CPUs then this problem is already there without this
> patch.
> 
> Example:
> 
> 1. 1st CPU gets lock X and panics
> 2. 2nd CPU is disabled and gets lock X

(irq-disabled)

> 3. 1st CPU calls smp_send_stop()
>    -> 2nd CPU loops disabled and can't be stopped

Well OK.  Maybe some architectures do have this problem - who would
notice?  If that is the case, we just made the failure cases much more
common.  Could you check, please?


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
