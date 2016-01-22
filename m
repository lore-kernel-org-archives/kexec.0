Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from userp1040.oracle.com ([156.151.31.81])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMcbr-0003WR-Mx
 for kexec@lists.infradead.org; Fri, 22 Jan 2016 14:22:44 +0000
Date: Fri, 22 Jan 2016 15:22:06 +0100
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [Xen-devel] [PATCH] xen: Add support for dom0 with Linux kernel
 3.19 and newer
Message-ID: <20160122142206.GZ3485@olila.local.net-space.pl>
References: <1453407231-25432-1-git-send-email-daniel.kiper@oracle.com>
 <56A1FE76.40201@citrix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <56A1FE76.40201@citrix.com>
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
To: David Vrabel <david.vrabel@citrix.com>
Cc: jgross@suse.com, olaf@aepfle.de, keir@xen.org, andrew.cooper3@citrix.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, ptesarik@suse.cz, anderson@redhat.com, dslutz@verizon.com, dmair@suse.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, crash-utility@redhat.com

On Fri, Jan 22, 2016 at 10:03:34AM +0000, David Vrabel wrote:
> On 21/01/16 20:13, Daniel Kiper wrote:
> > Linux kernel commit 054954eb051f35e74b75a566a96fe756015352c8
> > (xen: switch to linear virtual mapped sparse p2m list), which
> > appeared in 3.19, introduced linear virtual mapped sparse p2m
> > list. If readmem() reads p2m then it access this list using
> > physical addresses. Sadly, VMA to physical address translation
> > in crash requires access to p2m list. This means that we have
> > a chicken and egg problem. In general this issue must be solved
> > by introducing some changes in libxl, Linux kernel and crash
> > (I have added this task to my long TODO list). However, in dom0
> > case we can use crash_xen_info_t.dom0_pfn_to_mfn_frame_list_list
> > which is available out of the box. So, let's use it and make
> > at least some users happy.
>
> I'm confused.  How does a virtual address to (pseudo-)physical address
> lookup require access to the p2m?  Surely this is a walk of the page
> tables followed by a M2P lookup on the MFN in the L1 PTE?

Correct but crash does it a bit backward and scans p2m. I am not sure way,
however, I am going to look at it during work on PV guests support.

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
