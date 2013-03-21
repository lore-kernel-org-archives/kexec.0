Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIWaV-00036h-5r
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 03:54:48 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040223.15064.77472.stgit@localhost6.localdomain6>
 <87ppyvp014.fsf@xmission.com>
 <20130321.115920.339923125.d.hatayama@jp.fujitsu.com>
Date: Wed, 20 Mar 2013 20:54:25 -0700
In-Reply-To: <20130321.115920.339923125.d.hatayama@jp.fujitsu.com> (HATAYAMA
 Daisuke's message of "Thu, 21 Mar 2013 11:59:20 +0900 (JST)")
Message-ID: <87r4j98l1q.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating
 the end of ELF note buffer
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

> From: "Eric W. Biederman" <ebiederm@xmission.com>
> Subject: Re: [PATCH v3 17/21] vmcore: check NT_VMCORE_PAD as a mark indicating the end of ELF note buffer
> Date: Tue, 19 Mar 2013 14:11:51 -0700
>
>> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
>> 
>>> Modern kernel marks the end of ELF note buffer with NT_VMCORE_PAD type
>>> note in order to make the buffer satisfy mmap()'s page-size boundary
>>> requirement. This patch makes finishing reading each buffer if the
>>> note type now being read is NT_VMCORE_PAD type.
>> 
>> Ick.  Even with a pad header you can mark the end with an empty header,
>> and my memory may be deceiving me but I believe an empty header is
>> specified by the ELF ABI docs.
>> 
>> Beyond which I don't quite see the point of any of this as all of these
>> headers need to be combined into a single note section before being
>> presented to user space.
>
> Though this patch might get unecessary later, I cannot find part
> explaining necessity of marking end of ELF segmetns with an empty
> header in ELF spec. For example:

You are right.  It appears to be our own invention and just part of
the ABI of taking a crash dump.  Something we should sit down and
document someday.

> Also, it's possible to get size of a whole part of ELF note segments
> from p_memsz or p_filesz, and gdb and binutils are reading the note
> segments until reaching the size.

Agreed.  Except in our weird case where we generate the notes on the
fly, and generate the NOTE segment header much earlier.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
