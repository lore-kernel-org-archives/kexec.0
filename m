Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIgoH-00012N-6U
 for kexec@lists.infradead.org; Thu, 21 Mar 2013 14:49:42 +0000
Date: Thu, 21 Mar 2013 10:49:29 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Message-ID: <20130321144929.GH3934@redhat.com>
References: <87txo5bxk4.fsf@xmission.com>
 <20130321.122501.82758179.d.hatayama@jp.fujitsu.com>
 <8738vp75cy.fsf@xmission.com>
 <20130321.151428.393714972.d.hatayama@jp.fujitsu.com>
 <87y5dhw71o.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y5dhw71o.fsf@xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, lisa.mitchell@hp.com, HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>, kumagai-atsushi@mxc.nes.nec.co.jp, zhangyanfei@cn.fujitsu.com, akpm@linux-foundation.org, cpw@sgi.com

On Thu, Mar 21, 2013 at 12:22:59AM -0700, Eric W. Biederman wrote:
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> 
> > OK, rigorously, suceess or faliure of the requested free pages
> > allocation depends on actual memory layout at the 2nd kernel boot. To
> > increase the possibility of allocating memory, we have no method but
> > reserve more memory for the 2nd kernel now.
> 
> Good enough.   If there are fragmentation issues that cause allocation
> problems on larger boxes we can use vmalloc and remap_vmalloc_range, but
> we certainly don't need to start there.
> 
> Especialy as for most 8 or 16 core boxes we are talking about a 4KiB or
> an 8KiBP allocation.  Aka order 0 or order 1.
> 

Actually we are already handling the large SGI machines so we need
to plan for 4096 cpus now while we write these patches.

vmalloc() and remap_vmalloc_range() sounds reasonable. So that's what
we should probaly use.

Alternatively why not allocate everything in 4K pages and use vmcore_list
to map offset into right addresses and call remap_pfn_range() on these
addresses.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
