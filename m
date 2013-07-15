Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by merlin.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uyjf4-0005e8-S8
 for kexec@lists.infradead.org; Mon, 15 Jul 2013 14:21:59 +0000
Date: Mon, 15 Jul 2013 10:20:59 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130715142059.GA23772@redhat.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com>
 <51DBA47C.8090708@jp.fujitsu.com> <20130710104252.479a0f92@holzheu>
 <51DD2E5A.1030200@jp.fujitsu.com>
 <20130710143309.GD5819@redhat.com>
 <51DFE2FB.2000804@jp.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51DFE2FB.2000804@jp.fujitsu.com>
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
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>

On Fri, Jul 12, 2013 at 08:05:31PM +0900, HATAYAMA Daisuke wrote:

[..]
> How about
> 
> static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> {
> ...
>         char *buf;
>         int rc;
> 
> #ifndef CONFIG_S390
>         return VM_FAULT_SIGBUS;
> #endif
>         page = find_or_create_page(mapping, index, GFP_KERNEL);
> 
> Considering again, I don't think WARN_ONCE() is good now. The fact that fault occurs on
> mmap() region indicates some kind of buggy situation occurs on the process. The process
> should be killed as soon as possible. If user still wants to get crash dump, he should
> try again in another process.

I don't understand that. Process should be killed only if there was no
mapping created for the region process is trying to access.

If there is a mapping but we are trying to fault in the actual contents,
then it is not a problem of process. Process is accessing a region of 
memory which it is supposed to access.

Potential problem here is that remap_pfn_range() did not map everything
it was expected to so we have to resort on page fault handler to read
that in. So it is more of a kernel issue and not process issue and for
that WARN_ONCE() sounds better?

Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
