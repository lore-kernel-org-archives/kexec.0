Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.skyhub.de ([5.9.137.197])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj7o4-00026T-F3
 for kexec@lists.infradead.org; Mon, 14 Jan 2019 19:21:57 +0000
Date: Mon, 14 Jan 2019 20:21:44 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2 v6] kdump: add the vmcoreinfo documentation
Message-ID: <20190114192144.GQ2773@zn.tnic>
References: <20190110121944.6050-1-lijiang@redhat.com>
 <20190110121944.6050-2-lijiang@redhat.com>
 <20190111123300.GE4729@zn.tnic>
 <4AE2DC15AC0B8543882A74EA0D43DBEC035661E8@BPXM09GP.gisp.nec.co.jp>
 <20190114180142.GO2773@zn.tnic>
 <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2126185079.69727846.1547492312033.JavaMail.zimbra@redhat.com>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Anderson <anderson@redhat.com>
Cc: Kazuhito Hagio <k-hagio@ab.jp.nec.com>, Lianbo Jiang <lijiang@redhat.com>, bhe@redhat.com, linux-doc@vger.kernel.org, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, dyoung@redhat.com, akpm@linux-foundation.org

On Mon, Jan 14, 2019 at 01:58:32PM -0500, Dave Anderson wrote:
> Preferably it would be left as-is.  The crash utility has a "crash --osrelease vmcore"
> option that only looks at the dumpfile header, and just dump the string.  With respect
> to compressed kdumps, crash could alternatively look at the utsname data that is stored
> in the diskdump_header.utsname field, but with ELF vmcores, there is no such back-up.

Well, there is:

00000000  4f 53 52 45 4c 45 41 53  45 3d 35 2e 30 2e 30 2d  |OSRELEASE=5.0.0-|
00000010  72 63 32 2b 0a 50 41 47  45 53 49 5a 45 3d 34 30  |rc2+.PAGESIZE=40|
00000020  39 36 0a 53 59 4d 42 4f  4c 28 6d 65 6d 5f 73 65  |96.SYMBOL(mem_se|
00000030  63 74 69 6f 6e 29 3d 66  66 66 66 66 66 66 66 38  |ction)=ffffffff8|
00000040  34 35 31 61 31 61 38 0a  53 59 4d 42 4f 4c 28 69  |451a1a8.SYMBOL(i|
00000050  6e 69 74 5f 75 74 73 5f  6e 73 29 3d 66 66 66 66  |nit_uts_ns)=ffff|
									 ^^^^
00000060  66 66 66 66 38 32 30 31  33 35 34 30 0a 53 59 4d  |ffff82013540
							     ^^^^^^^^^^^^

This address has it.

> What's the problem with leaving it alone?

The problem is that I'd like to get all those vmcoreinfo exports under
control and to not have people frivolously export whatever they feel
like, for obvious reasons, and to get rid of the duplicate/unused pieces
being part of vmcoreinfo.

I'm guessing removing OSRELEASE would simplify the kernel a bit by
getting rid of the VMCOREINFO_OSRELEASE define and export, and userspace
can read out the kernel version from init_uts_ns which is also exported.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
