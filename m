Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from g2t2354.austin.hp.com ([15.217.128.53])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aNonV-0006fC-Te
 for kexec@lists.infradead.org; Mon, 25 Jan 2016 21:35:42 +0000
Message-ID: <1453757661.834.99.camel@hpe.com>
Subject: Re: [PATCH v3 00/17] Enhance iomem search interfaces and support
 EINJ to NVDIMM
From: Toshi Kani <toshi.kani@hpe.com>
Date: Mon, 25 Jan 2016 14:34:21 -0700
In-Reply-To: <20160125191804.GE14030@pd.tnic>
References: <1452020068-26492-1-git-send-email-toshi.kani@hpe.com>
 <20160125191804.GE14030@pd.tnic>
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
To: Borislav Petkov <bp@alien8.de>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, linux-acpi@vger.kernel.org, linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org, torvalds@linux-foundation.org, rafael.j.wysocki@intel.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-samsung-soc@vger.kernel.org, xen-devel@lists.xenproject.org, akpm@linux-foundation.org, dyoung@redhat.com, dan.j.williams@intel.com, linux-nvdimm@lists.01.org

On Mon, 2016-01-25 at 20:18 +0100, Borislav Petkov wrote:
> On Tue, Jan 05, 2016 at 11:54:28AM -0700, Toshi Kani wrote:
> > This patch-set enhances the iomem table and its search interfacs, and
> > then changes EINJ to support NVDIMM.
> > 
 :
> 
> Ok, all applied ontop of 4.5-rc1.
> 
> You could take a look if everything's still fine and I haven't botched
> anything:
> 
> http://git.kernel.org/cgit/linux/kernel/git/bp/bp.git/log/?h=tip-mm

I verified the patches and tested the kernel in the tree.  All look good.

> I'll let the build bot chew on it and then test it here and send it out
> again to everyone on CC so that people don't act surprised.

Sounds great.

> Thanks for this cleanup, code looks much better now!

Thanks!
-Toshi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
