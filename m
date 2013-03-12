Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UFVBb-0006Vl-Bq
 for kexec@lists.infradead.org; Tue, 12 Mar 2013 19:48:42 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130307145808.29098.41592.stgit@k.asiapacific.hpqcorp.net>
 <20130307152108.GC2790@redhat.com> <87k3piri3e.fsf@xmission.com>
 <20130308155216.GB8219@redhat.com> <513D9338.20402@hp.com>
 <87wqtenug7.fsf@xmission.com> <513EFDD6.806@hp.com>
Date: Tue, 12 Mar 2013 12:48:07 -0700
In-Reply-To: <513EFDD6.806@hp.com> (Jingbai Ma's message of "Tue, 12 Mar 2013
 18:05:10 +0800")
Message-ID: <87sj408knc.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 0/5] crash dump bitmap: scan memory pages in kernel to
 speedup kernel dump process
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
To: Jingbai Ma <jingbai.ma@hp.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, kumagai-atsushi@mxc.nes.nec.co.jp, hpa@zytor.com, yinghai@kernel.org, Vivek Goyal <vgoyal@redhat.com>

Jingbai Ma <jingbai.ma@hp.com> writes:

> On 03/11/2013 05:42 PM, Eric W. Biederman wrote:

>> The kernel is known bad.  What is bad is unclear.
>> Executing any extra code is a bad idea.
>>
>> The history here is that before kexec-on-panic there were lots of dump
>> routines that did all of the crashdump logic in the kernel before they
>> shutdown.  They all worked beautifully during development, and on
>> developers test machines and were absolutely worthless in real world
>> situations.
>
> I also have learned some from the old style kernel dump. Yes, they do have some
> problems in real world situations. The primary problems come from I/O operations
> (disk writing/network sending) and invalid page table.

That and they provide no guarantee that you won't write corrupt data.

The kdump based solutions fail safe.  The worst that will happen is that
you don't take a crash dump.  There is no chance of corrupting your
system.


>> A piece of code that walks all of the page tables is most definitely
>> opening itself up to all kinds of failure situations I can't even
>> imagine.
>
> Agree, invalid page table will cause disaster.
> But even in the capture kernel with user space program, it may only causes a
> core dump, user still have chance to dump the crashed system by themselves with
> some special tools, It's possible, but should be very rare in real world.
> I doubt how many users be able to handle it in such kind of situations.
> So in most cases, if page tables have corrupted, and can not dump it normally,
> user would like to reboot the system directly.

For whatever it is worth corrupted page tables.  Or at least page tables
that the cpu thinks are invalid are one of the crash scenarios that I
have seen in the wild on enough occasions to remember them.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
