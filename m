Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dERJQ-0005iq-R0
 for kexec@lists.infradead.org; Sat, 27 May 2017 02:18:42 +0000
Date: Sat, 27 May 2017 10:17:57 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5 28/32] x86/mm, kexec: Allow kexec to be used with SME
Message-ID: <20170527021757.GA3132@dhcp-128-65.nay.redhat.com>
References: <20170418211612.10190.82788.stgit@tlendack-t1.amdoffice.net>
 <20170418212121.10190.94885.stgit@tlendack-t1.amdoffice.net>
 <5927AC6E.8080209@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5927AC6E.8080209@redhat.com>
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
To: xlpang@redhat.com
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, linux-doc@vger.kernel.org, Matt Fleming <matt@codeblueprint.co.uk>, linux-mm@kvack.org, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Tom Lendacky <thomas.lendacky@amd.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/26/17 at 12:17pm, Xunlei Pang wrote:
> On 04/19/2017 at 05:21 AM, Tom Lendacky wrote:
> > Provide support so that kexec can be used to boot a kernel when SME is
> > enabled.
> >
> > Support is needed to allocate pages for kexec without encryption.  This
> > is needed in order to be able to reboot in the kernel in the same manner
> > as originally booted.
> 
> Hi Tom,
> 
> Looks like kdump will break, I didn't see the similar handling for kdump cases, see kernel:
>     kimage_alloc_crash_control_pages(), kimage_load_crash_segment(), etc.
> 
> We need to support kdump with SME, kdump kernel/initramfs/purgatory/elfcorehdr/etc
> are all loaded into the reserved memory(see crashkernel=X) by userspace kexec-tools.

For kexec_load, it is loaded by kexec-tools, we have in kernel loader
syscall kexec_file_load, it is handled in kernel.

> I think a straightforward way would be to mark the whole reserved memory range without
> encryption before loading all the kexec segments for kdump, I guess we can handle this
> easily in arch_kexec_unprotect_crashkres().
> 
> Moreover, now that "elfcorehdr=X" is left as decrypted, it needs to be remapped to the
> encrypted data.

Tom, could you have a try on kdump according to suggestion from Xunlei?
It is just based on theoretical patch understanding, there could be
other issues when you work on it. Feel free to ask if we can help on
anything.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
