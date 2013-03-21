Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIYng-0007fn-Jh
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 06:16:33 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130319123005.46e48e3f154acf594da5737c@linux-foundation.org>
 <20130321.125245.142520187.d.hatayama@jp.fujitsu.com>
Date: Wed, 20 Mar 2013 23:16:20 -0700
In-Reply-To: <20130321.125245.142520187.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Thu, 21 Mar 2013 12:52:45 +0900 (JST)")
Message-ID: <87d2ut2s7f.fsf@xmission.com>
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

> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: Re: [PATCH v3 00/21] kdump, vmcore: support mmap() on /proc/vmcore
> Date: Tue, 19 Mar 2013 12:30:05 -0700
>
>> On Sat, 16 Mar 2013 13:00:47 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:
>> 
>>> Currently, read to /proc/vmcore is done by read_oldmem() that uses
>>> ioremap/iounmap per a single page. For example, if memory is 1GB,
>>> ioremap/iounmap is called (1GB / 4KB)-times, that is, 262144
>>> times. This causes big performance degradation.
>>> 
>>> In particular, the current main user of this mmap() is makedumpfile,
>>> which not only reads memory from /proc/vmcore but also does other
>>> processing like filtering, compression and IO work. Update of page
>>> table and the following TLB flush makes such processing much slow;
>>> though I have yet to make patch for makedumpfile and yet to confirm
>>> how it's improved.
>>> 
>>> To address the issue, this patch implements mmap() on /proc/vmcore to
>>> improve read performance. My simple benchmark shows the improvement
>>> from 200 [MiB/sec] to over 50.0 [GiB/sec].
>> 
>> There are quite a lot of userspace-visible vmcore changes here.  Is it
>> all fully back-compatible?  Will all known userspace continue to work
>> OK on newer kernels?
>> 
>
> I designed it to keep backward-compatibility at least for gdb and
> binutils but not less for makedumpfile since it should follow kernel
> changes; old makedumpfile cannot use newer kernels, and this is within
> the range of this review.

To the extent possible we should different versions of tools to be
interchanged.  That helps with bug hunting and for people who are in
resource constrained systems that build old versions of the tools that
are tiny and fit.

Given that rounding the per cpu NOTES turns out to be a waste of memory
I didn't see anything in the patchset that justfies any breakage.

Eric


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
