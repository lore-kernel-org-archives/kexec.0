Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from p02c12o144.mxlogic.net ([208.65.145.77])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1S2HPm-0004EQ-B1
 for kexec@lists.infradead.org; Tue, 28 Feb 2012 07:24:03 +0000
From: ANDY KENNEDY <ANDY.KENNEDY@adtran.com>
Subject: Debugging on MIPS.
Date: Tue, 28 Feb 2012 07:24:23 +0000
Message-ID: <F9C551623D2CBB4C9488801D14F864C610AA6F@ex-mb1.corp.adtran.com>
Content-Language: en-US
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
To: "kexec@lists.infradead.org" <kexec@lists.infradead.org>

I got *I hope* the tip from @ ~midnight US Central time:

git clone git://github.com/horms/kexec-tools.git

My issue (in case you have forgotten -- it has been a few months) is
that since version 2.0.1 (a couple steps after that), I cannot use
kexec on my MIPS core with 2.6.36.1.  I get nothing.  I've done a bit of
poking around and I can make the kernel boot, however, command line
parameters are missing.

Comparing 2.0.1 with the tip and looking at kexec_load (via adding in
printf's just before the syscall), I see that entry = 0x0,
nr_segments = 2, (didn't print the segments), and the flags = 0x0.

Running the same command with the tip, I get:

entry = 0x1042d0, nr_segments = 2, flags = 0x00080000.

Interestingly, my bootloader determines that the entry point of this
kernel is 0x104290, but sets this address as a virtual.  So, following
that lead, just before the syscall:

entry += 0x80000000;

Boom, the kernel boots.  I get a kernel panic, however, since it cannot
find my RFS.

Further annoyances are that I changed the #if 0 to 1 around the
following code:

#if 0
        fprintf(stdout, "kexec_load: entry = %p flags = %lx\n", 
                info.entry, info.kexec_flags);
        print_segments(stdout, &info);
#endif

Which would have given me all sorts of cool stuff.  Problem is that it
will only output:

kexec_load: entry = 0x1042d0 flags = 80000
nr_segments = 2 
segment[0].buf   = 0x2b1a6008 
segment[0].bufsz = 377b5c 
segment[0].mem   = 0x100000 
segment[0].m

Even more curious is that after the call to my_load, I can printf()
exactly 16 chars before we lock hard.

Testing this information a bit further on the system, I see that at the
top of my_load, before the memset, I can printf() about 1500 chars
before the lockup.

Something is probing destructively.  Any ideas where I should look?

Thanks,
Andy

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
