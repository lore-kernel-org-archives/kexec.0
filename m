Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp02.citrix.com ([66.165.176.63])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aMYZW-0001un-Qg
 for kexec@lists.infradead.org; Fri, 22 Jan 2016 10:04:04 +0000
Subject: Re: [Xen-devel] [PATCH] xen: Add support for dom0 with Linux kernel
 3.19 and newer
References: <1453407231-25432-1-git-send-email-daniel.kiper@oracle.com>
From: David Vrabel <david.vrabel@citrix.com>
Message-ID: <56A1FE76.40201@citrix.com>
Date: Fri, 22 Jan 2016 10:03:34 +0000
MIME-Version: 1.0
In-Reply-To: <1453407231-25432-1-git-send-email-daniel.kiper@oracle.com>
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
To: Daniel Kiper <daniel.kiper@oracle.com>, crash-utility@redhat.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: jgross@suse.com, olaf@aepfle.de, keir@xen.org, dmair@suse.com, andrew.cooper3@citrix.com, ptesarik@suse.cz, dslutz@verizon.com, anderson@redhat.com, david.vrabel@citrix.com, jbeulich@suse.com, boris.ostrovsky@oracle.com

On 21/01/16 20:13, Daniel Kiper wrote:
> Linux kernel commit 054954eb051f35e74b75a566a96fe756015352c8
> (xen: switch to linear virtual mapped sparse p2m list), which
> appeared in 3.19, introduced linear virtual mapped sparse p2m
> list. If readmem() reads p2m then it access this list using
> physical addresses. Sadly, VMA to physical address translation
> in crash requires access to p2m list. This means that we have
> a chicken and egg problem. In general this issue must be solved
> by introducing some changes in libxl, Linux kernel and crash
> (I have added this task to my long TODO list). However, in dom0
> case we can use crash_xen_info_t.dom0_pfn_to_mfn_frame_list_list
> which is available out of the box. So, let's use it and make
> at least some users happy.

I'm confused.  How does a virtual address to (pseudo-)physical address
lookup require access to the p2m?  Surely this is a walk of the page
tables followed by a M2P lookup on the MFN in the L1 PTE?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
