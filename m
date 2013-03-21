Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out02.mta.xmission.com ([166.70.13.232])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIYzx-00011L-9d
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 06:29:13 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87txo5bxk4.fsf@xmission.com>
 <20130321.122501.82758179.d.hatayama@jp.fujitsu.com>
 <8738vp75cy.fsf@xmission.com>
 <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
Date: Wed, 20 Mar 2013 23:29:05 -0700
In-Reply-To: <20130321.151428.393714972.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Thu, 21 Mar 2013 15:14:28 +0900 (JST)")
Message-ID: <87ip4l1d1q.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
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
>
> Do you mean for each range represented by each PT_LOAD entry, say:
>
>   [p_paddr, p_paddr + p_memsz]
>
> extend it as:
>
>   [rounddown(p_paddr, PAGE_SIZE), roundup(p_paddr + p_memsz, PAGE_SIZE)].
>
> not only objects in vmcore_list, but also updating p_paddr and p_memsz
> members themselves of each PT_LOAD entry? In other words, there's no
> new holes not referenced by any PT_LOAD entry since the regions
> referenced by some PT_LOAD entry, themselves are extended.

No.  p_paddr and p_memsz as exported should remain the same.
I am suggesting that we change p_offset.

I am suggesting to include the data in the file as if we had changed
p_paddr and p_memsz.

> Then, the vmcores seen from read and mmap methods are coincide in the
> direction of including both ranges
>
>   [rounddown(p_paddr, PAGE_SIZE), p_paddr]
>
> and
>
>   [p_paddr + p_memsz, roundup(p_paddr + p_memsz, PAGE_SIZE)]
>
> are included in both vmcores seen from read and mmap methods, although
> they are originally not dump target memory, which you are not
> problematic for ease of implementation.
>
> Is there difference here from you understanding?

Preserving the actual PT_LOAD segments p_paddr and p_memsz values is
important. p_offset we can change as much as we want.  Which means there
can be logical holes in the file between PT_LOAD segments, where we put
the extra data needed to keep everything page aligned.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
