Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp17.uk.ibm.com ([195.75.94.113])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uws8e-0000a4-FR
 for kexec@lists.infradead.org; Wed, 10 Jul 2013 11:00:49 +0000
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <holzheu@linux.vnet.ibm.com>;
 Wed, 10 Jul 2013 11:56:12 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 78A2817D8025
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 12:01:56 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6AB0A7g26542240
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 11:00:10 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6AB0K8W027258
 for <kexec@lists.infradead.org>; Wed, 10 Jul 2013 05:00:21 -0600
Date: Wed, 10 Jul 2013 13:00:17 +0200
From: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/5] vmcore: Introduce remap_oldmem_pfn_range()
Message-ID: <20130710130017.468e0bdf@holzheu>
In-Reply-To: <51DD2E5A.1030200@jp.fujitsu.com>
References: <1372707159-10425-1-git-send-email-holzheu@linux.vnet.ibm.com>
 <1372707159-10425-4-git-send-email-holzheu@linux.vnet.ibm.com>
 <51DA4ED9.60903@jp.fujitsu.com> <20130708112839.498ccfc6@holzheu>
 <20130708142826.GA9094@redhat.com>
 <51DBA47C.8090708@jp.fujitsu.com> <20130710104252.479a0f92@holzheu>
 <51DD2E5A.1030200@jp.fujitsu.com>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>
Cc: kexec@lists.infradead.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Willeke <willeke@de.ibm.com>, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Vivek Goyal <vgoyal@redhat.com>

On Wed, 10 Jul 2013 18:50:18 +0900
HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com> wrote:

[snip]

> (2013/07/10 17:42), Michael Holzheu wrote:
> > My suggestion is to add the WARN_ONCE() for #ifndef CONFIG_S390. This has the same
> > effect as your suggestion for all architectures besides of s390. And for s390 we
> > take the risk that a programming error would result in poor /proc/vmcore
> > performance.
> >
> 
> If you want to avoid looking up vmcore_list that takes linear time w.r.t. the number
> of the elements, you can still calculate the range of offsets in /proc/vmcore
> corresponding to HSA during /proc/vmcore initialization.
> 
> Also, could you tell me how often and how much the HSA region is during crash dumping?
> I guess the read to HSA is done mainly during early part of crash dumping process only.
> According to the code, it appears at most 64MiB only. Then, I feel performance is not
> a big issue.

Currently it is 32 MiB and normally it is read only once.

> 
> Also, cost of WARN_ONCE() is one memory access only in the 2nd and later calls. I don't
> think it too much overhead...

I was more concerned about in_valid_fault_range(). But I was most concerned the additional
interface that introduces more complexity to the code. And that just to implement a
sanity check that in our opinion we don't really need.

And what makes it even worse:

With the current patch series this check is only relevant for s390 :-)

> 
> > So, at least for this patch series I would implement the fault handler as follows:
> >
> > static int mmap_vmcore_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
> > {
> > ...
> >          char *buf;
> >          int rc;
> >
> > #ifndef CONFIG_S390
> >          WARN_ONCE(1, "vmcore: Unexpected call of mmap_vmcore_fault()");
> > #endif
> >          page = find_or_create_page(mapping, index, GFP_KERNEL);
> >
> > At this point I have to tell you that we plan another vmcore patch series where
> > the fault handler might be called also for other architectures. But I think we
> > should *then* discuss your issue again.
> >
> 
> Could you explain the plan in more detail? Or I cannot review correctly since I don't
> know whether there's really usecase of this generic fault handler for other
> architectures.
> This is the issue for architectures other than s390, not mine; now we
> don't need it at all.

I would have preferred to do the things one after the other. Otherwise I fear
that this discussion will never come to an end. This patch series is needed
to get zfcpdump running with /proc/vmcore. And for that reason the patch series
makes sense for itself.

But FYI:

The other patch series deals with the problem that we have additional
information for s390 that we want to include in /proc/vmcore. We have a one
byte storage key per memory page. This storage keys are stored in the
s390 firmware and can be read using a s390 specific machine instruction.
We plan to put that information into the ELF notes section. For a 1 TiB
dump we will have 256 MiB storage keys.

Currently the notes section is preallocated in vmcore.c. Because we do
not want to preallocate so much memory we would like to read the notes
section on demand. Similar to the HSA memory for zfcpdump. To get this
work with your mmap code, we would then also use the fault handler to
get the notes sections on demand. Our current patch does this for all
notes and therefore also the other architectures would then use the
fault handler.

One advantage for the common code is that no additional memory has
to be allocated for the notes buffer.

The storage key patch series is currently not final because it depends
on the zfcpdump patch series. 

Michael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
