Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1hkXnm-0003im-LT
 for kexec@lists.infradead.org; Mon, 08 Jul 2019 17:51:48 +0000
Date: Mon, 8 Jul 2019 19:51:39 +0200
From: Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH using git format-patch -C] kexec: add generic support for
 elf kernel images
Message-ID: <20190708175139.GA11402@t470p.stackframe.org>
References: <20190708100624.EBCDF68DB2@pc17473vm.idsi0.si.c-s.fr>
 <e016c0bb-c857-b78c-a159-120e42d0db03@c-s.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e016c0bb-c857-b78c-a159-120e42d0db03@c-s.fr>
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
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, deller@gmx.de, kexec@lists.infradead.org

Hi Christophe,

On Mon, Jul 08, 2019 at 12:40:52PM +0200, Christophe Leroy wrote:
> > From: Sven Schnelle <svens@stackframe.org>
> 
> Please describe you patch.
> 
> All the changes you are doing to the ppc64 version in order to make it
> generic should be described.
> 
> Those changes are also maybe worth splitting the patch in several parts,
> either preparing the ppc64 for generic then moving to kernel/kexec_elf.c or
> moving to kernel/kexec_elf.c without modifications, then modifying it to
> make it generic.
> 
> Note that your patch only applies on Linux 5.1, it doesn't apply on
> powerpc/next.
> 
> I think it also be worth taking the opportunity to fix the sparse warnings,
> see https://patchwork.ozlabs.org/patch/1128720/
> 
> checkpatch comments should also be fixed, see https://openpower.xyz/job/snowpatch/job/snowpatch-linux-checkpatch/8044//artifact/linux/checkpatch.log

Actually this patch shouldn't have been sent out, that was my fault. Appologies
for that. Thanks for your review, i will split up the patch and resent it.

Regards
Sven

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
