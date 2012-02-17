Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from gate.crashing.org ([63.228.1.57])
 by bombadil.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RyJM4-0000Zt-3v
 for kexec@lists.infradead.org; Fri, 17 Feb 2012 08:39:49 +0000
Message-ID: <1329467969.2892.58.camel@pasglop>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 17 Feb 2012 19:39:29 +1100
In-Reply-To: <4F3DEBCF.8000201@in.ibm.com>
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com>
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: "Suzuki K. Poulose" <suzuki@in.ibm.com>
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>, Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>, kexec@lists.infradead.org

On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
> > Could you tell me what kind of data is stored in vmalloc region in
> PPC ?
> > I want to estimate importance of your patches for makedumpfile.
> I know at least the modules are loaded in the vmalloc'd region. I have
> Cc'ed linux-ppc dev. We should be able to get enough info from the
> experts here.
> 
> Josh / Kumar / Others,
> 
> Could you please let us know your thoughts ?

Modules, driver IO mappings, etc... I can see that being useful for
crashdumps.

Cheers,
Ben.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
