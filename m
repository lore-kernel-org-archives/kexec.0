Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1YSjkP-0002Td-Bt
 for kexec@lists.infradead.org; Tue, 03 Mar 2015 10:08:18 +0000
Date: Tue, 3 Mar 2015 11:07:50 +0100
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] makedumpfile: Use file offset in initialize_mmap()
Message-ID: <20150303110750.3feed6ec@hananiah.suse.cz>
In-Reply-To: <20150303101543.416b5cb4@holzheu>
References: <20150227131409.33dd14a4@hananiah.suse.cz>
 <20150303101543.416b5cb4@holzheu>
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
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: kexec mailing list <kexec@lists.infradead.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, Jan Willeke <willeke@de.ibm.com>

On Tue, 3 Mar 2015 10:15:43 +0100
Michael Holzheu <holzheu@linux.vnet.ibm.com> wrote:

> Hello Petr,
> 
> Thanks for the fix!
> 
> Hard to believe that makedumpfile mmap mode on s390 has never worked.
> 
> On Fri, 27 Feb 2015 13:14:09 +0100
> Petr Tesarik <ptesarik@suse.cz> wrote:
> 
> > Hi all,
> > 
> > update_mmap_range() expects a file offset as its first argument, but
> > initialize_mmap() passes a physical address. Since the first segment
> > usually starts at physical addr 0 on S/390, but there is no segment 
> > at file offset 0, update_mmap_range() fails, and makedumpfile falls
> > back to read().
> 
> And for other architectures the wrong parameter was no problem?

I noticed it while testing mmap on s390x. It is not a problem on
x86_64, because the first LOAD segment is the kernel text mapping, and
due to certain legacy addressing peculiarities on x86 hardware, the
kernel is never loaded at physical offset 0. In fact, it is always
loaded high enough that there is a LOAD segment at the corresponding
file offset. It's not the "correct" one, but initialize_mmap() does not
care. It only checks if it can be mmapped.

Theoretically, you may hit the bug on x86_64 if enough data goes before
the first LOAD segment. However, only program headers and ELF notes do,
so on a typical system (kernel at 16M) you would need an extremely
fragmented memory map (approx. 300k segments; not even possible with
ELF) and/or a lot of CPUs (50k or so).

I haven't checked any other architectures.

> > 
> > @Michael: I wonder how you actually tested the kernel mmap patches;
> > this bug has prevented mmap on all my s390 systems...
> 
> We tested /proc/vmcore mmap with our SCSI stand-alone dump (zfcpdump) and
> with small test programs that used mmap.
> 
> I did a quick test with your patch and it looks like the mmap mode
> on my s390 system is slower than the read mode:

That's sad. OTOH I had similar results on a file mmap some time ago.
The cost of copying data was less than the cost of handling a series of
minor page faults. I wonder if adding MAP_POPULATE to the mmap flags
makes any difference for you.

Petr T

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
