Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SoWpI-0002nb-5Q
 for kexec@lists.infradead.org; Tue, 10 Jul 2012 09:33:50 +0000
Date: Tue, 10 Jul 2012 11:33:27 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120710093327.GA13864@aepfle.de>
References: <20120705210607.GA26908@aepfle.de>
 <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
 <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
 <20120706172918.GA15222@aepfle.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20120706172918.GA15222@aepfle.de>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Jan Beulich <JBeulich@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

On Fri, Jul 06, Olaf Hering wrote:

> On Fri, Jul 06, Jan Beulich wrote:
> 
> > > Could it be that some code tweaks the stack content used by decompress()
> > > in some odd way? But that would most likely lead to a crash, not to
> > > unexpected uncompressing results.
> > 
> > Especially if the old and new kernel are using the exact same
> > image, how about the decompression writing over the shared
> > info page causing all this? As the decompressor wouldn't
> > expect Xen to possibly write stuff there itself, it could easily be
> > that some repeat count gets altered, thus breaking the
> > decompressed data without the decompression code necessarily
> > noticing.
> 
> In my case the gfn of the shared info page is 1f54.
> Is it possible to move the page at runtime? It looks like it can be done
> because the hvm loader configures fffff initially.
> 
> Perhaps the PVonHVM code has to give up the shared pages or move them to
> some dedicated unused page during the process of booting into the new
> kernel.

The pfn 1f54 of the shared info page is in the middle of the new bzImage:
pfn    32080 KiB
_head  29360 KiB
_text  33826 KiB
_end   33924 KiB

In other words, the compressed vmlinux.bin gets slightly modified during
uncompression. For some reason this does not lead to decompression
errors.

In the patch below the pfn is moved from the bss to the data section. As
a result the new location is now at 28680 KiB, which is outside of the
bzImage.

Maybe there is a way to use another dedicated page as shared info page.

Olaf


diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index ff962d4..258e8f3 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -1469,19 +1469,16 @@ void __ref xen_hvm_init_shared_info(void)
 {
 	int cpu;
 	struct xen_add_to_physmap xatp;
-	static struct shared_info *shared_info_page = 0;
+	static struct shared_info shared_info_page __page_aligned_data = {  };
 
-	if (!shared_info_page)
-		shared_info_page = (struct shared_info *)
-			extend_brk(PAGE_SIZE, PAGE_SIZE);
 	xatp.domid = DOMID_SELF;
 	xatp.idx = 0;
 	xatp.space = XENMAPSPACE_shared_info;
-	xatp.gpfn = __pa(shared_info_page) >> PAGE_SHIFT;
+	xatp.gpfn = __pa(&shared_info_page) >> PAGE_SHIFT;
 	if (HYPERVISOR_memory_op(XENMEM_add_to_physmap, &xatp))
 		BUG();
 
-	HYPERVISOR_shared_info = (struct shared_info *)shared_info_page;
+	HYPERVISOR_shared_info = &shared_info_page;
 
 	/* xen_vcpu is a pointer to the vcpu_info struct in the shared_info
 	 * page, we use it in the event channel upcall and in some pvclock

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
