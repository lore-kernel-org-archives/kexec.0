Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dNQBs-0002gp-U6
 for kexec@lists.infradead.org; Tue, 20 Jun 2017 20:56:02 +0000
Date: Tue, 20 Jun 2017 22:55:35 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 07/36] x86/mm: Don't use phys_to_virt in ioremap() if
 SME is active
In-Reply-To: <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
Message-ID: <alpine.DEB.2.20.1706202251110.2157@nanos>
References: <20170616184947.18967.84890.stgit@tlendack-t1.amdoffice.net>
 <20170616185104.18967.7867.stgit@tlendack-t1.amdoffice.net>
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
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, "Michael S. Tsirkin" <mst@redhat.com>, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dave Young <dyoung@redhat.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Dmitry Vyukov <dvyukov@google.com>, Juergen Gross <jgross@suse.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, xen-devel@lists.xen.org, iommu@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, 16 Jun 2017, Tom Lendacky wrote:

> Currently there is a check if the address being mapped is in the ISA
> range (is_ISA_range()), and if it is then phys_to_virt() is used to
> perform the mapping.  When SME is active, however, this will result
> in the mapping having the encryption bit set when it is expected that
> an ioremap() should not have the encryption bit set. So only use the
> phys_to_virt() function if SME is not active

This does not make sense to me. What the heck has phys_to_virt() to do with
the encryption bit. Especially why would the encryption bit be set on that
mapping in the first place?

I'm probably missing something, but this want's some coherent explanation
understandable by mere mortals both in the changelog and the code comment.

Thanks,

	tglx

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
