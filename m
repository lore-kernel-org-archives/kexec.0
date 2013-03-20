Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UIJWE-00032V-Lu
 for kexec@lists.infradead.org; Wed, 20 Mar 2013 13:57:31 +0000
Date: Wed, 20 Mar 2013 09:57:16 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v3 18/21] vmcore: check if vmcore objects satify mmap()'s
 page-size boundary requirement
Message-ID: <20130320135716.GE17274@redhat.com>
References: <20130316040003.15064.62308.stgit@localhost6.localdomain6>
 <20130316040228.15064.28019.stgit@localhost6.localdomain6>
 <877gl3koay.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <877gl3koay.fsf@xmission.com>
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

On Tue, Mar 19, 2013 at 03:38:45PM -0700, Eric W. Biederman wrote:
> HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> writes:
> 
> > If there's some vmcore object that doesn't satisfy page-size boundary
> > requirement, remap_pfn_range() fails to remap it to user-space.
> >
> > Objects that posisbly don't satisfy the requirement are ELF note
> > segments only. The memory chunks corresponding to PT_LOAD entries are
> > guaranteed to satisfy page-size boundary requirement by the copy from
> > old memory to buffer in 2nd kernel done in later patch.
> >
> > This patch doesn't copy each note segment into the 2nd kernel since
> > they amount to so large in total if there are multiple CPUs. For
> > example, current maximum number of CPUs in x86_64 is 5120, where note
> > segments exceed 1MB with NT_PRSTATUS only.
> 
> So you require the first kernel to reserve an additional 20MB, instead
> of just 1.6MB.  336 bytes versus 4096 bytes.
> 
> That seems like completely the wrong tradeoff in memory consumption,
> filesize, and backwards compatibility.

Agreed. 

So we already copy ELF headers in second kernel's memory. If we start
copying notes too, then both headers and notes will support mmap().

For mmap() of memory regions which are not page aligned, we can map
extra bytes (as you suggested in one of the mails). Given the fact
that we have one ELF header for every memory range, we can always modify
the file offset where phdr data is starting to make space for mapping
of extra bytes.

That way whole of vmcore should be mmappable and user does not have
to worry about reading part of the file and mmaping the rest.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
