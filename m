Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UZjVw-00064k-Vq
 for kexec@lists.infradead.org; Tue, 07 May 2013 15:09:13 +0000
Date: Tue, 7 May 2013 11:08:40 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 5/8] vmcore: copy ELF note segments in the 2nd kernel
 per page vmcore objects
Message-ID: <20130507150840.GA12965@redhat.com>
References: <20130413002000.18245.21513.stgit@localhost6.localdomain6>
 <20130413002133.18245.91528.stgit@localhost6.localdomain6>
 <20130429193611.GQ8204@redhat.com>
 <5188B3BE.9040104@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5188B3BE.9040104@jp.fujitsu.com>
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
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, kumagai-atsushi@mxc.nes.nec.co.jp, ebiederm@xmission.com, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com, jingbai.ma@hp.com

On Tue, May 07, 2013 at 04:56:46PM +0900, HATAYAMA Daisuke wrote:
> (2013/04/30 4:36), Vivek Goyal wrote:
> >On Sat, Apr 13, 2013 at 09:21:33AM +0900, HATAYAMA Daisuke wrote:
> >
> >[..]
> >>ELF notes are per-cpu, so total size of ELF note segments increases
> >>according to the number of CPUs. The current maximum number of CPUs on
> >>x86_64 is 5192, and there's already system with 4192 CPUs in SGI,
> >>where total size amounts to 1MB. This can be larger in the neare
> >>futrue or possibly even now on another architecture. Thus, to avoid
> >>the case where memory allocation for large block fails, we allocate
> >>vmcore objects per pages.
> >
> >IIRC, eric had suggested using vmalloc() and remap_vmalloc_range(). What's
> >wrong with that? That should keep your vc_list relatively smaller.
> >
> 
> Yes, it's handy if it's possible to remap them in vmalloc space, but
> the problem here is that remap_vmalloc_range requires the first
> argument vma to cover full range of the requested map. This becomes
> problem when requested area for mmap() overlaps multiple objects,
> for example, ELF headers and memory refered to by the first PT_LOAD
> program header.
> 
> To use remap_vmalloc_range, it's necessary to prepare a new variant
> similar to remap_pfn_range by which we can remap different objects
> separately to a single vma.

Ok. Is it hard to prepare one such variant. If we can write one, it will
simplify the vmcore code.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
