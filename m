Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.85_2 #1 (Red Hat Linux))
 id 1c8I97-0003Fw-Op
 for kexec@lists.infradead.org; Sun, 20 Nov 2016 02:46:22 +0000
Date: Sun, 20 Nov 2016 10:45:46 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v10 04/10] kexec_file: Add support for purgatory built as
 PIE.
Message-ID: <20161120024546.GA4413@dhcp-128-65.nay.redhat.com>
References: <1478748449-3894-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1478748449-3894-5-git-send-email-bauerman@linux.vnet.ibm.com>
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
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>, Eric Biederman <ebiederm@xmission.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Mimi Zohar <zohar@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Vivek Goyal <vgoyal@redhat.com>

On 11/10/16 at 01:27am, Thiago Jung Bauermann wrote:
> powerpc's purgatory.ro has 12 relocation types when built as
> a relocatable object. To implement support for them requires
> arch_kexec_apply_relocations_add to duplicate a lot of code with
> module_64.c:apply_relocate_add.
> 
> When built as a Position Independent Executable there are only 4
> relocation types in purgatory.ro, so it becomes practical for the powerpc
> implementation of kexec_file to have its own relocation implementation.
> 
> Also, the purgatory is an executable and not an intermediary output from
> the compiler so it makes sense conceptually that it is easier to build
> it as a PIE than as a partially linked object.
> 
> Apart from the greatly reduced number of relocations, there are two
> differences between a relocatable object and a PIE:
> 
> 1. __kexec_load_purgatory needs to use the program headers rather than the
>    section headers to figure out how to load the binary.
> 2. Symbol values are absolute addresses instead of relative to the
>    start of the section.
> 
> This patch adds the support needed in generic code for the differences
> above and allows powerpc to load and relocate a position independent
> purgatory.
> 

[snip]

The kexec-tools machine_apply_elf_rel is pretty simple for ppc64, it is
not that complex. So could you look into simplify your kexec_file
implementation?

kernel/kexec_file.c kexec_apply_relocations only do limited things
and some of the logic is in arch/x86, so move general code out of arch
code, then I guess the arch code will be simpler and then we probably
do not need this PIE stuff anymore.

BTW, __kexec_really_load_purgatory looks worse than
___kexec_load_purgatory ;)

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
