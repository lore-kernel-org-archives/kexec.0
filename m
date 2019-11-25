Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZ7IH-00036y-F3
 for kexec@lists.infradead.org; Mon, 25 Nov 2019 05:52:19 +0000
Date: Mon, 25 Nov 2019 13:52:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec_file overwrites reserved EFI ESRT memory
Message-ID: <20191125055201.GA6569@dhcp-128-65.nay.redhat.com>
References: <20191122180552.GA32104@weiser.dinsnail.net>
 <87blt3y949.fsf@x220.int.ebiederm.org>
 <20191122210702.GE32104@weiser.dinsnail.net>
MIME-Version: 1.0
In-Reply-To: <20191122210702.GE32104@weiser.dinsnail.net>
Content-Disposition: inline
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
To: Michael Weiser <michael@weiser.dinsnail.net>
Cc: linux-efi@vger.kernel.org, kexec@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 11/22/19 at 10:07pm, Michael Weiser wrote:
> Hi Eric,
> 
> On Fri, Nov 22, 2019 at 02:00:22PM -0600, Eric W. Biederman wrote:
> 
> > > esrt: Unsupported ESRT version 2904149718861218184.
> > >
> > > (The image is rather large at 18MiB as it has a built-in initrd.)
> > When did x86_64 get support for ARCH_KEEP_MEMBLOCK?  I can't find it
> > anywhere.
> 
> No, is hasn't. I temporarily hacked that in to see if it'd change
> anything and it did. Sorry to not be more clear about that.
> 
> > Fundamentally when deciding where to place a new kernel kexec (either
> > user space or the in kernel kexec_file implementation) needs to be able
> > to ask the question which memory ares are reserved.
> > What the buddy
> > allocator does is unimportant as kexec copies memory from all over
> > the place and places it in the destined memory addresses at the
> > time of the kexec operation.
> 
> > So my question is why doesn't the ESRT reservation wind up in
> > /proc/iomem?
> 
> My guess is that the focus was that some EFI structures need to be kept
> around accross the life cycle of *one* running kernel and
> memblock_reserve() was enough for that. Marking them so they survive
> kexecing another kernel might just never have cropped up thus far. Ard
> or Matt would know.

Can you check your un-reserved memory, if your memory falls into EFI
BOOT* then in X86 you can use something like below if it is not covered:

void __init efi_esrt_init(void)
{
...
	pr_info("Reserving ESRT space from %pa to %pa.\n", &esrt_data, &end);
	if (md.type == EFI_BOOT_SERVICES_DATA)
		efi_mem_reserve(esrt_data, esrt_data_size);
...
}

Unfortunately I noticed there are different requirements/ways for
different types of "reserved" memory.  But that is another topic..

Thanks
Dave 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
