Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.linuxfoundation.org ([140.211.169.12])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UI2Lz-00023q-Vi
 for kexec@lists.infradead.org; Tue, 19 Mar 2013 19:37:48 +0000
Date: Tue, 19 Mar 2013 12:37:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 08/21] vmcore: copy non page-size aligned head and
 tail pages in 2nd kernel
Message-Id: <20130319123746.595a38d90c6071730ed6364b@linux-foundation.org>
In-Reply-To: <20130316040132.15064.42257.stgit@localhost6.localdomain6>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040132.15064.42257.stgit@localhost6.localdomain6>
Mime-Version: 1.0
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
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, cpw@sgi.com, vgoyal@redhat.com

On Sat, 16 Mar 2013 13:01:32 +0900 HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

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

Ah.  This is all the missing info from [patch 07/21].  I suggest we
join 7 and 8 into a single patch, use the above changelog, add the
MEM_TYPE_CURRENT_KERNEL code comments.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
