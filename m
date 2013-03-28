Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ULCDW-0007Kh-Lj
 for kexec@lists.infradead.org; Thu, 28 Mar 2013 12:46:07 +0000
Received: by mail-oa0-f52.google.com with SMTP id k14so10006396oag.11
 for <kexec@lists.infradead.org>; Thu, 28 Mar 2013 05:46:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130327150807.GC14004@redacted.bos.redhat.com>
References: <1363642353-30749-1-git-send-email-matthew.garrett@nebula.com>
 <1363642353-30749-5-git-send-email-matthew.garrett@nebula.com>
 <CA+5PVA4VFgExGNrt5Yh+F4f48amAXKYAbdNFDy7VTFTguh6qTA@mail.gmail.com>
 <20130327150807.GC14004@redacted.bos.redhat.com>
Date: Thu, 28 Mar 2013 08:46:04 -0400
Message-ID: <CA+5PVA6zYkjnzgHvso4zwg_PRZ+kssU76Fugc4p5rw3RDnYhpA@mail.gmail.com>
Subject: Re: [PATCH 05/12] PCI: Require CAP_COMPROMISE_KERNEL for PCI BAR
 access
From: Josh Boyer <jwboyer@gmail.com>
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
To: Kyle McMartin <kmcmarti@redhat.com>
Cc: Matthew Garrett <matthew.garrett@nebula.com>, linux-efi@vger.kernel.org, linux-pci@vger.kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org

On Wed, Mar 27, 2013 at 11:08 AM, Kyle McMartin <kmcmarti@redhat.com> wrote:
> On Wed, Mar 27, 2013 at 11:03:26AM -0400, Josh Boyer wrote:
>> On Mon, Mar 18, 2013 at 5:32 PM, Matthew Garrett
>> <matthew.garrett@nebula.com> wrote:
>> > Any hardware that can potentially generate DMA has to be locked down from
>> > userspace in order to avoid it being possible for an attacker to cause
>> > arbitrary kernel behaviour. Default to paranoid - in future we can
>> > potentially relax this for sufficiently IOMMU-isolated devices.
>> >
>> > Signed-off-by: Matthew Garrett <matthew.garrett@nebula.com>
>>
>> As noted here:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=908888
>>
>> this breaks pci passthru with QEMU.  The suggestion in the bug is to move
>> the check from read/write to open, but sysfs makes that somewhat
>> difficult.  The open code is part of the core sysfs functionality shared
>> with the majority of sysfs files, so adding a check there would restrict
>> things that clearly don't need to be restricted.
>>
>> Kyle had the idea to add a cap field to the attribute structure, and do
>> a capable check if that is set.  That would allow for a more generic
>> usage of capabilities in sysfs code, at the cost of slightly increasing
>> the structure size and open path.  That seems somewhat promising if we
>> stick with capabilities.
>>
>> I would love to just squarely blame capabilities for causing this, but we
>> can't just replace it with an efi_enabled(EFI_SECURE_BOOT) check because
>> of the sysfs open case.  I'm not sure there are great answers here.
>>
>
> Yeah, that was something like this (I don't even remember which Fedora
> kernel version this was against.)

Mostly an FYI for the peanut gallery, but we noticed moving the cap check
to open breaks lspci being run by an unprivileged user.  It also doesn't
fix pci passthrough because QEMU opens the PCI resource files by itself
after it's already dropped all caps.

More thinking required.

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
