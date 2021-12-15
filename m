Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxTm1-000qKR-4B
 for kexec@lists.infradead.org; Wed, 15 Dec 2021 12:52:46 +0000
Date: Wed, 15 Dec 2021 13:43:00 +0100
From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/1] s390: handle R_390_PLT32DBL reloc entries in
 machine_apply_elf_rel()
Message-ID: <20211215124300.GA4314@vergenet.net>
References: <20211208125355.256391-1-egorenar@linux.ibm.com>
 <20211213114430.77f28a67@rhtmp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213114430.77f28a67@rhtmp>
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
To: Philipp Rudo <prudo@redhat.com>
Cc: Alexander Egorenkov <egorenar@linux.ibm.com>, ltao@redhat.com, hca@linux.ibm.com, kexec@lists.infradead.org

On Mon, Dec 13, 2021 at 11:44:30AM +0100, Philipp Rudo wrote:
> Hi Alexander,
> 
> @Alexander: Thanks for taking care of this.
> 
> On Wed,  8 Dec 2021 13:53:55 +0100
> Alexander Egorenkov <egorenar@linux.ibm.com> wrote:
> 
> > Starting with gcc 11.3, the C compiler will generate PLT-relative function
> > calls even if they are local and do not require it. Later on during linking,
> > the linker will replace all PLT-relative calls to local functions with
> > PC-relative ones. Unfortunately, the purgatory code of kexec/kdump is
> > not being linked as a regular executable or shared library would have been,
> > and therefore, all PLT-relative addresses remain in the generated purgatory
> > object code unresolved. This leads to the situation where the purgatory
> > code is being executed during kdump with all PLT-relative addresses
> > unresolved. And this results in endless loops within the purgatory code.
> 
> Tiny nit. The last two sentences describe the situation in the kernel.
> Luckily the kexec-tools do proper error checking and die with
> 
> 	"Unknown rela relocation: 0x14 0x73c0901c"
> 
> when they encounter an unknown relocation type.
> 
> Anyway, the code is correct
> 
> Reviewed-by: Philipp Rudo <prudo@redhat.com>

Thanks.

Alexander would you care to post a v2 with an updated patch description?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
