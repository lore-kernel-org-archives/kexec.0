Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from e06smtp18.uk.ibm.com ([195.75.94.114])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Vj5LZ-00039b-MN
 for kexec@lists.infradead.org; Wed, 20 Nov 2013 10:49:26 +0000
Received: from /spool/local
 by e06smtp18.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <kexec@lists.infradead.org> from <ldufour@linux.vnet.ibm.com>;
 Wed, 20 Nov 2013 10:49:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 412BA219006C
 for <kexec@lists.infradead.org>; Wed, 20 Nov 2013 10:49:00 +0000 (GMT)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAKAmlBf31391860
 for <kexec@lists.infradead.org>; Wed, 20 Nov 2013 10:48:47 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAKAmx1p000457
 for <kexec@lists.infradead.org>; Wed, 20 Nov 2013 03:48:59 -0700
Message-ID: <528C939A.80507@linux.vnet.ibm.com>
Date: Wed, 20 Nov 2013 11:48:58 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kexec/ppc64: bring up new ppc64le architecture
References: <20131115150151.25401.49768.stgit@nimbus>
 <20131119010140.GA17628@verge.net.au>
In-Reply-To: <20131119010140.GA17628@verge.net.au>
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Simon Horman <horms@verge.net.au>
Cc: kexec@lists.infradead.org

On 19/11/2013 02:01, Simon Horman wrote:
> On Fri, Nov 15, 2013 at 04:01:51PM +0100, Laurent Dufour wrote:
>> This patch provides support for the new Power PC litte endian (LE) mode. The
>> LE mode only differs in the way the instructions and data are stored in memory
>> thus there is no real need to duplicate the ppc64 code.
>>
>> However some compilation's options, especially for the purgatory, differ
>> between little and big endian mode's support. A new "SUBARCH" build variable
>> is introduced which is currently only used for PPC64 to specify the
>> endianness.
>>
>> Another set of changes in this patch is fixing minor endianess issues in the
>> ppc64 code and fix an alignment issue raised on Power7 little endian mode.
>> Among these fixes, the check on the kernel binary endianess is removed,
>> since we can imagine kexecing a LE kernel from a BE environment, as far as
>> the specified root filesystem and initrd file are containing the right
>> binaries.
>>
>> This patch depends on the patch "kexec/ppc64: use common architecture
>> fs2dt.c file" I sent earlier on the kexec mailing list.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> 
> Hi Laurent,
> 
> I have applied this. But could you let me know how to (cross) compile it?

Hi Simon,

Thanks for applying the patches.

I didn't use the cross the compilation mechanism. I tried to make it run
but I faced some issues and looking at the Makefile, especially the
kexec/Makefile file it doesn't look to be designed to do cross
compilation since there is no reference to TARGET_CC. May be I didn't
use it in the right way. If you have any tips on that...

I did my builds and tests using a qemu guest and KVM running ppc64 LE
binaries since currently there is no other way to run a Power in little
endian mode.

Unfortunately, such a root file system image is not currently available
outside of IBM and the Open Power's partners. Despite must of the patch
have been pushed to the community, I'm sorry to not being allowed to
provide you with a root file system image with LE binaries. Be sure I'd
do otherwise.

Theoretically all the parts needed to build a PPC64 LE rootfs are
available, binutils/gcc/glibc/buildroot, but that's a lot of effort.

Please note that the PPC64 LE support is still a moving target, and an
ABI change is about to be released which would imply a massive rebuild.
I hope once this will be done this will be easier to get LE root file
system outside of IBM.

Cheers,
Laurent.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
