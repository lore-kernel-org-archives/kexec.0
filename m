Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI5BG-00037n-5V
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 22:38:55 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040228.15064.28019.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 15:38:45 -0700
In-Reply-To: <20130316040228.15064.28019.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:02:29 +0900")
Message-ID: <877gl3koay.fsf@xmission.com>
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

> If there's some vmcore object that doesn't satisfy page-size boundary
> requirement, remap_pfn_range() fails to remap it to user-space.
>
> Objects that posisbly don't satisfy the requirement are ELF note
> segments only. The memory chunks corresponding to PT_LOAD entries are
> guaranteed to satisfy page-size boundary requirement by the copy from
> old memory to buffer in 2nd kernel done in later patch.
>
> This patch doesn't copy each note segment into the 2nd kernel since
> they amount to so large in total if there are multiple CPUs. For
> example, current maximum number of CPUs in x86_64 is 5120, where note
> segments exceed 1MB with NT_PRSTATUS only.

So you require the first kernel to reserve an additional 20MB, instead
of just 1.6MB.  336 bytes versus 4096 bytes.

That seems like completely the wrong tradeoff in memory consumption,
filesize, and backwards compatibility.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
