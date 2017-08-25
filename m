Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]
 helo=mx0a-001b2d01.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dlHHp-0005yF-Ek
 for kexec@lists.infradead.org; Fri, 25 Aug 2017 16:16:47 +0000
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7PGEg2e090662
 for <kexec@lists.infradead.org>; Fri, 25 Aug 2017 12:16:24 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cjpa6kw4g-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <kexec@lists.infradead.org>; Fri, 25 Aug 2017 12:16:24 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 25 Aug 2017 12:16:19 -0400
References: <20170824081811.19299-1-takahiro.akashi@linaro.org>
 <20170824081811.19299-9-takahiro.akashi@linaro.org>
 <20170824165617.GC29665@leverpostej>
 <20170825010054.GC6434@akashi-kouhiroshi-no-MacBook-Air.local>
 <20170825102250.GA3127@leverpostej>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: Re: [PATCH 08/14] arm64: kexec_file: create purgatory
In-reply-to: <20170825102250.GA3127@leverpostej>
Date: Fri, 25 Aug 2017 13:16:06 -0300
MIME-Version: 1.0
Message-Id: <878ti7fws9.fsf@linux.vnet.ibm.com>
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
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, AKASHI Takahiro <takahiro.akashi@linaro.org>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, akpm@linux-foundation.org, dyoung@redhat.com, davem@davemloft.net, vgoyal@redhat.com


Mark Rutland <mark.rutland@arm.com> writes:

> On Fri, Aug 25, 2017 at 10:00:59AM +0900, AKASHI Takahiro wrote:
>> On Thu, Aug 24, 2017 at 05:56:17PM +0100, Mark Rutland wrote:
>> > On Thu, Aug 24, 2017 at 05:18:05PM +0900, AKASHI Takahiro wrote:
>> > > This is a basic purgtory, or a kind of glue code between the two kernel,
>> > > for arm64. We will later add a feature of verifying a digest check against
>> > > loaded memory segments.
>> > > 
>> > > arch_kexec_apply_relocations_add() is responsible for re-linking any
>> > > relative symbols in purgatory. Please note that the purgatory is not
>> > > an executable, but a non-linked archive of binaries so relative symbols
>> > > contained here must be resolved at kexec load time.
>> > > Despite that arm64_kernel_start and arm64_dtb_addr are only such global
>> > > variables now, arch_kexec_apply_relocations_add() can manage more various
>> > > types of relocations.
>> > 
>> > Why does the purgatory code need to be so complex?
>> > 
>> > Why is it not possible to write this as position-independent asm?
>> 
>> I don't get your point, but please note that these values are also
>> re-written by the 1st kernel when it loads the 2nd kernel and so
>> they must appear as globals.
>
> My fear about complexity is that we must "re-link" the purgatory.
>
> I don't understand why that has to be necessary. Surely we can have the
> purgatory code be position independent, and store those globals in a
> single struct purgatory_info that we can fill in from the host?
>
> i.e. similar to what we do for values shared with the VDSO, where we
> just poke vdso_data->field, no re-linking required.

Right. I'm not sure why it is a partially linked object. I believe that
the purgatory could be linked at build time into a PIE executable with
exported symbols for the variables that need to be filled in from the
host.

On some architectures (e.g., powerpc), this would greatly reduce the
number of relocation types that the kernel needs to know how to process.
On x86 it make less of a difference because the partially linked object
already has just a handful of relocation types.

> Otherwise, why can't the purgatory code be written in assembly? AFAICT,
> the only complex part is the hashing code, which I don't beleive is
> strictly necessary.

When I posted a similar series for powerpc with similar changes to
handle a partially linked purgatory in the kernel, Michael Ellerman
preferred to go for a purgatory written in assembly, partially based on
the one from kexec-lite. That purgatory doesn't do the checksum
verification of the segments.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
