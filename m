Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from ozlabs.org ([2401:3900:2:1::2])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aitVK-0005LC-Ky
 for kexec@lists.infradead.org; Thu, 24 Mar 2016 00:52:03 +0000
Message-ID: <1458780575.29516.3.camel@ellerman.id.au>
Subject: Re: [PATCH 1/3] Pass struct mem_sym into machine_apply_elf_rel()
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Thu, 24 Mar 2016 11:49:35 +1100
In-Reply-To: <20160323041025.GP46309@thor.bakeyournoodle.com>
References: <20160226180311.2938d804@kryten>
 <20160323041025.GP46309@thor.bakeyournoodle.com>
Mime-Version: 1.0
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
To: Tony Breeds <tony@bakeyournoodle.com>, kexec@lists.infradead.org
Cc: Bill Schmidt <wschmidt@us.ibm.com>, Simon Horman <horms@verge.net.au>, Anton Blanchard <anton@samba.org>, Alan Modra <amodra@gmail.com>

On Wed, 2016-03-23 at 15:10 +1100, Tony Breeds wrote:

> On Fri, Feb 26, 2016 at 06:03:11PM +1100, Anton Blanchard wrote:

> > On PowerPC64 ABIv2 we need to look at the symbol to determine
> > if it has a local entry point. Pass struct mem_sym into
> > machine_apply_elf_rel() so we can.
> >
> > Signed-off-by: Anton Blanchard <anton@samba.org>
>
> Anton, Alan and Bill clearly know this stuff inside and out but can we get a
> review from other PPC folks ?

LGTM.

cheers


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
