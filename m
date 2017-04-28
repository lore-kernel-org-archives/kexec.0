Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1d3yWw-0005tL-Jf
 for kexec@lists.infradead.org; Fri, 28 Apr 2017 05:33:24 +0000
Date: Fri, 28 Apr 2017 13:32:33 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 31/32] x86: Add sysfs support for Secure Memory
 Encryption
Message-ID: <20170428053233.GA6149@dhcp-128-65.nay.redhat.com>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212212.10190.73484.stgit@tlendack-t1.amdoffice.net>
 <1498ec98-b19d-c47d-902b-a68870a3f860@intel.com>
 <20170427072547.GB15297@dhcp-128-65.nay.redhat.com>
 <1f034974-20e6-b5e9-e6ff-434b634e1522@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1f034974-20e6-b5e9-e6ff-434b634e1522@intel.com>
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
To: Dave Hansen <dave.hansen@intel.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tom Lendacky <thomas.lendacky@amd.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 04/27/17 at 08:52am, Dave Hansen wrote:
> On 04/27/2017 12:25 AM, Dave Young wrote:
> > On 04/21/17 at 02:55pm, Dave Hansen wrote:
> >> On 04/18/2017 02:22 PM, Tom Lendacky wrote:
> >>> Add sysfs support for SME so that user-space utilities (kdump, etc.) can
> >>> determine if SME is active.
> >>>
> >>> A new directory will be created:
> >>>   /sys/kernel/mm/sme/
> >>>
> >>> And two entries within the new directory:
> >>>   /sys/kernel/mm/sme/active
> >>>   /sys/kernel/mm/sme/encryption_mask
> >>
> >> Why do they care, and what will they be doing with this information?
> > 
> > Since kdump will copy old memory but need this to know if the old memory
> > was encrypted or not. With this sysfs file we can know the previous SME
> > status and pass to kdump kernel as like a kernel param.
> > 
> > Tom, have you got chance to try if it works or not?
> 
> What will the kdump kernel do with it though?  We kexec() into that
> kernel so the SME keys will all be the same, right?  So, will the kdump
> kernel be just setting the encryption bit in the PTE so it can copy the
> old plaintext out?

I assume it is for active -> non active case, the new boot need to know
the old memory is encrypted. But I think I did not read all the patches
I may miss things.

> 
> Why do we need both 'active' and 'encryption_mask'?  How could it be
> that the hardware-enumerated 'encryption_mask' changes across a kexec()?

Leave this question to Tom..

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
