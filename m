Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvwft-0001Or-9r
 for kexec@lists.infradead.org; Thu, 16 Jul 2020 05:43:18 +0000
References: <159466074408.24747.10036072269371204890.stgit@hbathini.in.ibm.com>
 <159466101903.24747.7234708045729315954.stgit@hbathini.in.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: Re: [PATCH v3 12/12] ppc64/kexec_file: fix kexec load failure with
 lack of memory hole
In-reply-to: <159466101903.24747.7234708045729315954.stgit@hbathini.in.ibm.com>
Date: Thu, 16 Jul 2020 02:43:01 -0300
Message-ID: <87r1tc817e.fsf@morokweng.localdomain>
MIME-Version: 1.0
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
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.ibm.com>, Kexec-ml <kexec@lists.infradead.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, lkml <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Petr Tesarik <ptesarik@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Eric Biederman <ebiederm@xmission.com>


Hari Bathini <hbathini@linux.ibm.com> writes:

> The kexec purgatory has to run in real mode. Only the first memory
> block maybe accessible in real mode. And, unlike the case with panic
> kernel, no memory is set aside for regular kexec load. Another thing
> to note is, the memory for crashkernel is reserved at an offset of
> 128MB. So, when crashkernel memory is reserved, the memory ranges to
> load kexec segments shrink further as the generic code only looks for
> memblock free memory ranges and in all likelihood only a tiny bit of
> memory from 0 to 128MB would be available to load kexec segments.
>
> With kdump being used by default in general, kexec file load is likely
> to fail almost always.

Ah. I wasn't aware of this problem.

> This can be fixed by changing the memory hole
> lookup logic for regular kexec to use the same method as kdump.

Right. It doesn't make that much sense to use memblock to find free
memory areas for the kexec kernel, because memblock tracks which memory
areas are free for the currently running kernel. But that's not what
matters for the kernel that will be kexec'd into. In this case, regions
which may be reserved for the current OS instance may well be free for a
freshly started kernel. The kdump method is better at knowing which
memory regions are actually reserved by the firmware/hardware.

> This
> would mean that most kexec segments will overlap with crashkernel
> memory region. That should still be ok as the pages, whose destination
> address isn't available while loading, are placed in an intermediate
> location till a flush to the actual destination address happens during
> kexec boot sequence.

Yes, since the kdump kernel and the "regular" kexec kernel can't be both
booted at the same time, it's not a problem if both plan to use the same
region of memory.

>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Tested-by: Pingfan Liu <piliu@redhat.com>

Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>

> ---
>
> v2 -> v3:
> * Unchanged. Added Tested-by tag from Pingfan.
>
> v1 -> v2:
> * New patch to fix locating memory hole for kexec_file_load (kexec -s -l)
>   when memory is reserved for crashkernel.
>
>
>  arch/powerpc/kexec/file_load_64.c |   33 ++++++++++++++-------------------
>  1 file changed, 14 insertions(+), 19 deletions(-)

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
