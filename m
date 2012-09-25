Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay2.sgi.com ([192.48.179.30] helo=relay.sgi.com)
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TGVwi-0001Fy-91
 for kexec@lists.infradead.org; Tue, 25 Sep 2012 14:17:09 +0000
Date: Tue, 25 Sep 2012 09:18:34 -0500
From: Cliff Wickman <cpw@sgi.com>
Subject: Re: 896MB address limit
Message-ID: <20120925141834.GA6184@sgi.com>
References: <E1TGHkf-0006ZB-22@eag09.americas.sgi.com>
 <877grissof.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877grissof.fsf@xmission.com>
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
Cc: kexec@lists.infradead.org

Hi Eric, and all,

On Mon, Sep 24, 2012 at 08:11:12PM -0700, Eric W. Biederman wrote:
> Cliff Wickman <cpw@sgi.com> writes:
> 
> > Gentlemen,
> >
> > In dumping very large memories we are running up against the 896MB 
> > limit in SLES11SP2 (3.0.38 kernel).
> 
> Odd.  That limit should be the maximum address in memory to load the
> crash kernel.  Tha limit should have nothing to do with the dump process
> itself.
> 
> Are you saying you need more that 512MiB reserved for the crash kernel
> to be able to dump all of the memory in your system?
> 
> Eric

As I noted to Eric privately, yes we need to bump up to crashkernel=1G
or more for some very large memories.

As an experiment I bumped
+++ linux/arch/x86/kernel/setup.c
@@ -528,7 +528,7 @@ static inline unsigned long long get_tot
 #ifdef CONFIG_X86_32
 # define CRASH_KERNEL_ADDR_MAX (512 << 20)
 #else
-# define CRASH_KERNEL_ADDR_MAX (896 << 20)
+# define CRASH_KERNEL_ADDR_MAX (1700 << 20)

And that seems to work.  i.e. I'm currently dumping a system where
crashkernel=1G and it seems to be working.

Am I just living dangerously? 

-Cliff
-- 
Cliff Wickman
SGI
cpw@sgi.com
(651) 683-3824

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
