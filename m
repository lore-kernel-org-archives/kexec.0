Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI5ll-0003gS-MM
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 23:16:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 16:16:25 -0700
In-Reply-To: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:00:47 +0900")
Message-ID: <87ip4nj7zq.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 00/21] kdump, vmcore: support mmap() on /proc/vmcore
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, vgoyal@redhat.com

HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:

> Currently, read to /proc/vmcore is done by read_oldmem() that uses
> ioremap/iounmap per a single page. For example, if memory is 1GB,
> ioremap/iounmap is called (1GB / 4KB)-times, that is, 262144
> times. This causes big performance degradation.
>
> In particular, the current main user of this mmap() is makedumpfile,
> which not only reads memory from /proc/vmcore but also does other
> processing like filtering, compression and IO work. Update of page
> table and the following TLB flush makes such processing much slow;
> though I have yet to make patch for makedumpfile and yet to confirm
> how it's improved.
>
> To address the issue, this patch implements mmap() on /proc/vmcore to
> improve read performance. My simple benchmark shows the improvement
> from 200 [MiB/sec] to over 50.0 [GiB/sec].

I am in favor of this direction and the performance and other gains look
good.

I am not in favor of the ABI changes nor of the nearly order of
magnitude memory usage increase for elf notes by rounding everything up
to a page size boundary.

As a general note it is possible to support mmaping any partial page
by just rounding inside of your mmap function so you should not need to
copy partial pages.

If you don't want the memory overhead of merging the ELF notes in memory
in the second kernel you can simply require that the ELF header, the ELF
program header, and the PT_NOTE section be read from /proc/vmcore
instead of mmaped.

I did the math and with your changes to note generation in the worst
case you are reserving 20MiB in the first kernel to replace a 1.6MiB
with a 240KiB allocation in the second kernel.  That is the wrong
tradeoff, especially when you require an ABI change at the same time,
and the 5120+ entries in vmcore_list will likely measurably slow down
setting up your mappings with mmap.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
