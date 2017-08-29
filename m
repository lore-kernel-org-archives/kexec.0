Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dmjB2-00079c-V0
 for kexec@lists.infradead.org; Tue, 29 Aug 2017 16:15:51 +0000
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TGFCQe112641
 for <kexec@lists.infradead.org>; Tue, 29 Aug 2017 12:15:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cn9fyexw7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Tue, 29 Aug 2017 12:15:21 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 10:15:20 -0600
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-15-takahiro.akashi@linaro.org>
 <20170824173049.GG29665@leverpostej> <20170829100112.GC2901@leverpostej>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 14/14] arm64: kexec_file: add vmlinux format support
In-reply-to: <20170829100112.GC2901@leverpostej>
Date: Tue, 29 Aug 2017 13:15:08 -0300
MIME-Version: 1.0
Message-Id: <87r2vue4fn.fsf@linux.vnet.ibm.com>
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
To: Mark Rutland <mark.rutland@arm.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, davem@davemloft.net, dhowells@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, arnd@arndb.de, vgoyal@redhat.com, mpe@ellerman.id.au, akpm@linux-foundation.org, dyoung@redhat.com, kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Aug 24, 2017 at 06:30:50PM +0100, Mark Rutland wrote:
>> On Thu, Aug 24, 2017 at 05:18:11PM +0900, AKASHI Takahiro wrote:
>> > The first PT_LOAD segment, which is assumed to be "text" code, in vmlinux
>> > will be loaded at the offset of TEXT_OFFSET from the begining of system
>> > memory. The other PT_LOAD segments are placed relative to the first one.
>> 
>> I really don't like assuming things about the vmlinux ELF file.
>> 
>> > Regarding kernel verification, since there is no standard way to contain
>> > a signature within elf binary, we follow PowerPC's (not yet upstreamed)
>> > approach, that is, appending a signature right after the kernel binary
>> > itself like module signing.
>> 
>> I also *really* don't like this. It's a bizarre in-band mechanism,
>> without explcit information. It's not a nice ABI.
>> 
>> If we can load an Image, why do we need to be able to load a vmlinux?
>
> So IIUC, the whole point of this is to be able to kexec_file_load() a
> vmlinux + signature bundle, for !CONFIG_EFI kernels.
>
> For that, I think that we actually need a new kexec_file_load${N}
> syscall, where we can pass the signature for the kernel as a separate
> file. Ideally also with a flags argument and perhaps the ability to sign
> the initrd too.
>
> That way we don't ahve to come up with a magic vmlinux+signature format,
> as we can just pass a regular image and a signature for that image
> separately. That should work for PPC and others, too.

powerpc uses the same format that is used for signed kernel modules,
which is a signature appended at the end of the file. It doesn't need to
be passed separately since it's embedded in the file itself.

The kernel already has a mechanism to verify signatures that aren't
embedded in the file: it's possible to use IMA via the LSM hook in
kernel_read_file_from_fd (which is called in
kimage_file_prepare_segments) to verify a signature stored in an
extended attribute by using an IMA policy rule such as:

appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig

Of course, that only works if the kernel image is stored in a filesystem
which supports extended attributes. But that is the case of most
filesystems nowadays, with the notable exception of FAT-based
filesystems.

evmctl, the IMA userspace tool, also support signatures stored in a
separate file as well ("sidecar" signatures), but the kernel can only
verify them if they are copied into an xattr (which I believe the
userspace tool can do).

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
