Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UdAoM-0005QE-Ed
 for kexec@lists.infradead.org; Fri, 17 May 2013 02:54:27 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130515090507.28109.28956.stgit@localhost6.localdomain6>
 <51957469.2000008@zytor.com>
Date: Thu, 16 May 2013 19:53:31 -0700
In-Reply-To: <51957469.2000008@zytor.com> (H. Peter Anvin's message of "Thu,
 16 May 2013 17:06:01 -0700")
Message-ID: <87y5bee2qc.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v6 0/8] kdump, vmcore: support mmap() on /proc/vmcore
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: riel@redhat.com, hughd@google.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, linux-mm@kvack.org, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, jingbai.ma@hp.com, kosaki.motohiro@jp.fujitsu.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, walken@google.com, cpw@sgi.com, vgoyal@redhat.com

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 05/15/2013 02:05 AM, HATAYAMA Daisuke wrote:
>> Currently, read to /proc/vmcore is done by read_oldmem() that uses
>> ioremap/iounmap per a single page. For example, if memory is 1GB,
>> ioremap/iounmap is called (1GB / 4KB)-times, that is, 262144
>> times. This causes big performance degradation.
>
> read_oldmem() is fundamentally broken and unsafe.  It needs to be
> unified with the plain /dev/mem code and any missing functionality fixed
> instead of "let's just do a whole new driver".

That is completely and totally orthogonal to this change.

read_oldmem may have problems but in practice on a large systems those
problems are totally dwarfed by real life performance issues that come
from playing too much with the page tables.

I really don't find bringing up whatever foundational issues you have
with read_oldmem() appropriate or relevant here.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
