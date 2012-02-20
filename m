Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from tyo201.gate.nec.co.jp ([202.32.8.193])
 by casper.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1RzQ3L-0002Ct-CS
 for kexec@lists.infradead.org; Mon, 20 Feb 2012 10:01:08 +0000
Date: Mon, 20 Feb 2012 18:56:01 +0900
From: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Subject: Re: [PATCH v1 0/4][makedumpfile] vmalloc translation support for PPC32
Message-Id: <20120220185601.d08b8864.kumagai-atsushi@mxc.nes.nec.co.jp>
In-Reply-To: <1329467969.2892.58.camel@pasglop>
References: <20120216033411.7972.77705.stgit@suzukikp>
 <20120217093220.0c2993a1.kumagai-atsushi@mxc.nes.nec.co.jp>
 <4F3DEBCF.8000201@in.ibm.com> <1329467969.2892.58.camel@pasglop>
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
To: benh@kernel.crashing.org, suzuki@in.ibm.com
Cc: kexec@lists.infradead.org, linuxppc-dev@lists.ozlabs.org

Hi, Benjamin
Hi, Suzuki

On Fri, 17 Feb 2012 19:39:29 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2012-02-17 at 11:25 +0530, Suzuki K. Poulose wrote:
> > > Could you tell me what kind of data is stored in vmalloc region in
> > PPC ?
> > > I want to estimate importance of your patches for makedumpfile.
> > I know at least the modules are loaded in the vmalloc'd region. I have
> > Cc'ed linux-ppc dev. We should be able to get enough info from the
> > experts here.
> > 
> > Josh / Kumar / Others,
> > 
> > Could you please let us know your thoughts ?
> 
> Modules, driver IO mappings, etc... I can see that being useful for
> crashdumps.

Thank you for your information.

The above data may be required for one function of makedumpfile (filter
out kernel data) but not so crucial for makedumpfile as page descriptors
and related data(e.g. pglist_data).

Moreover, I'm preparing the release of v1.4.3 now, so I'll merge vmalloc
support for PPC32 into v1.4.4. Is it all right for you, Suzuki ?


Thanks
Atsushi Kumagai

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
