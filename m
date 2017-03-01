Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1cj0YR-0000HF-OJ
 for kexec@lists.infradead.org; Wed, 01 Mar 2017 09:28:17 +0000
Date: Wed, 1 Mar 2017 17:27:44 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [RFC PATCH v4 26/28] x86: Allow kexec to be used with SME
Message-ID: <20170301092736.GA8491@dhcp-128-65.nay.redhat.com>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
 <20170216154755.19244.51276.stgit@tlendack-t1.amdoffice.net>
 <20170217155756.GJ30272@char.us.ORACLE.com>
 <d2f16b24-f2ef-a22b-3c72-2d8ad585553e@amd.com>
 <20170301092536.GB8353@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20170301092536.GB8353@dhcp-128-65.nay.redhat.com>
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
Cc: linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Matt Fleming <matt@codeblueprint.co.uk>, x86@kernel.org, linux-mm@kvack.org, Alexander Potapenko <glider@google.com>, "H. Peter Anvin" <hpa@zytor.com>, Larry Woodman <lwoodman@redhat.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Joerg Roedel <joro@8bytes.org>, linux-doc@vger.kernel.org, kasan-dev@googlegroups.com, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Dmitry Vyukov <dvyukov@google.com>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Add kexec list..

On 03/01/17 at 05:25pm, Dave Young wrote:
> Hi Tom,
> 
> On 02/17/17 at 10:43am, Tom Lendacky wrote:
> > On 2/17/2017 9:57 AM, Konrad Rzeszutek Wilk wrote:
> > > On Thu, Feb 16, 2017 at 09:47:55AM -0600, Tom Lendacky wrote:
> > > > Provide support so that kexec can be used to boot a kernel when SME is
> > > > enabled.
> > > 
> > > Is the point of kexec and kdump to ehh, dump memory ? But if the
> > > rest of the memory is encrypted you won't get much, will you?
> > 
> > Kexec can be used to reboot a system without going back through BIOS.
> > So you can use kexec without using kdump.
> > 
> > For kdump, just taking a quick look, the option to enable memory
> > encryption can be provided on the crash kernel command line and then
> 
> Is there a simple way to get the SME status? Probably add some sysfs
> file for this purpose.
> 
> > crash kernel can would be able to copy the memory decrypted if the
> > pagetable is set up properly. It looks like currently ioremap_cache()
> > is used to map the old memory page.  That might be able to be changed
> > to a memremap() so that the encryption bit is set in the mapping. That
> > will mean that memory that is not marked encrypted (EFI tables, swiotlb
> > memory, etc) would not be read correctly.
> 
> Manage to store info about those ranges which are not encrypted so that
> memremap can handle them?
> 
> > 
> > > 
> > > Would it make sense to include some printk to the user if they
> > > are setting up kdump that they won't get anything out of it?
> > 
> > Probably a good idea to add something like that.
> 
> It will break kdump functionality, it should be fixed instead of
> just adding printk to warn user..
> 
> Thanks
> Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
