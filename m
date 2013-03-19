Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI3e9-0006sA-AL
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 21:00:38 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040132.15064.42257.stgit@localhost6.localdomain6>
Date: Tue, 19 Mar 2013 13:59:57 -0700
In-Reply-To: <20130316040132.15064.42257.stgit@localhost6.localdomain6>
 (HATAYAMA Daisuke's message of "Sat, 16 Mar 2013 13:01:32 +0900")
Message-ID: <878v5jqf5e.fsf@xmission.com>
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/21] vmcore: copy non page-size aligned head and tail
 pages in 2nd kernel
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

> Due to mmap() requirement, we need to copy pages not starting or
> ending with page-size aligned address in 2nd kernel and to map them to
> user-space.
>
> For example, see the map below:
>
>     00000000-00010000 : reserved
>     00010000-0009f800 : System RAM
>     0009f800-000a0000 : reserved
>
> where the System RAM ends with 0x9f800 that is not page-size
> aligned. This map is divided into two parts:
>
>     00010000-0009f000
>     0009f000-0009f800
>
> and the first one is kept in old memory and the 2nd one is copied into
> buffer on 2nd kernel.
>
> This kind of non-page-size-aligned area can always occur since any
> part of System RAM can be converted into reserved area at runtime.
>
> If not doing copying like this and if remapping non page-size aligned
> pages on old memory directly, mmap() had to export memory which is not
> dump target to user-space. In the above example this is reserved
> 0x9f800-0xa0000.

So I have a question.  Would it not be easier to only support mmaping on
the things that are easily mmapable?  And in the oddball corner cases
require reading the data instead.

My gut feel says that would reduce the net complexity of the system a
bit, and would also reduce the amount of memory that the kernel has to
allocate.

Alrernatively and probably better given the nature of what is happening
here.  It seems entirely reasonable to round up the boundaries of the
supported mappings to the nearest page.  A little memory leak of data
in a reserved page should be harmless.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
