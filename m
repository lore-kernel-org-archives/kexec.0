Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1T9gKg-0007YQ-Br
 for kexec@lists.infradead.org; Thu, 06 Sep 2012 17:57:42 +0000
Message-ID: <5048E40E.7040003@hp.com>
Date: Thu, 06 Sep 2012 11:57:34 -0600
From: Khalid Aziz <khalid.aziz@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH]kdump: pass noefi and acpi_rsdp= to 2nd kernel
References: <20120905054445.GA6370@dhcp-16-143.nay.redhat.com>
 <5047DBA9.8030000@hp.com> <504815EB.9000701@redhat.com>
In-Reply-To: <504815EB.9000701@redhat.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Dave Young <dyoung@redhat.com>
Cc: horms@verge.net.au, kexec@lists.infradead.org, vgoyal@redhat.com

On 09/05/2012 09:18 PM, Dave Young wrote:
>
>> I think running a kexec/kdump kernel with "noefi" is not a good idea.
>> Today kernel makes very little use of UEFI run time services but this
>> might change shortly. I have already seen ideas being proposed to use
>> UEFI variables to store kernel panic information which would require
>> accessing UEFI runtime services. If the kdump kernel runs into a panic,
>> it would be good to be able to use UEFI variables to store some sort of
>> tombstone. We might also start using UEFI runtime clock services one of
>> these days especially now that all PCs soon will have UEFI due to
>> Windows 8 requirements. There might be other ways to deal with EFI
>> virtualization issue. I have solved it on a custom ia64 kernel by
>> passing the kexec'd kernel a "kexec_reboot" on command line, although I
>> wouldn't recommend that approach as a general approach. Creating a new
>> kernel command line parameter just to tell the kernel to not virtualize
>> EFI sounds excessive. May be we can come up with a different way to tell
>> a kexec/kdump kernel to not virtualize EFI, like create a new signature,
>> for example "EL32_KEXEC" and "EL64_KEXEC", for
>> boot_params.efi_info.efi_loader_signature which tells the kexec/kdump
>> kernel to enable EFI but skip the step of virtualizing it. More work
>> will be needed to make this work, for example pass the EFI runtime
>> service memory map from one kernel to the next so we keep it mapped in
>> exact same spot, and other similar mapping issues.
>>
>
> I'm not so familiar with uefi detail, is the virtualization issue mean
> "virtual mode" of efi?  From my understanding for kdump kernel I would
> vote for not interacting with bios at all. We have use "noefi" for long
> time by passing it to 2nd kernel while kexecing. I prefer to do this way
> until we have to switch to other approach.
>
Yes, that is what I mean by virtualizing issue. Using "noefi" for kdump 
kernel will keep it from using any runtime EFI services. That could mean 
kdump kernel may not be able to read clock or use EFI variables to store 
a tombstone in case it runs into trouble. Is that acceptable?

For the kexec'd kernel (not kdump kernel), being able to use runtime EFI 
services will be essential as we move to EFI machines. We will have to 
support enabling EFI on a kexec'd kernel. Does that sound reasonable?

-- 
Khalid

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
