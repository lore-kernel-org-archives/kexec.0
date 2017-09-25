Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236])
 by bombadil.infradead.org with esmtps (Exim 4.87 #1 (Red Hat Linux))
 id 1dwXxo-0005VA-Gh
 for kexec@lists.infradead.org; Mon, 25 Sep 2017 18:18:42 +0000
Received: by mail-pg0-x236.google.com with SMTP id m30so4440546pgn.6
 for <kexec@lists.infradead.org>; Mon, 25 Sep 2017 11:18:19 -0700 (PDT)
Date: Mon, 25 Sep 2017 11:18:08 -0700
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
Message-ID: <20170925181806.kd567i4xpquueqw5@dragonfly>
References: <20170922075807.GM17186@linaro.org>
 <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
 <1623.1506353803@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1623.1506353803@warthog.procyon.org.uk>
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
To: David Howells <dhowells@redhat.com>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, davem@davemloft.net, vgoyal@redhat.com

On Mon, Sep 25, 2017 at 04:36:43PM +0100, David Howells wrote:
> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
> 
> > > > -static struct kexec_file_ops *kexec_file_loaders[] = {
> > > > +struct kexec_file_ops *kexec_file_loaders[] = {
> > > >  	&kexec_elf64_ops,
> > > > +	NULL
> > > >  };
> 
> const?

Yes, it makes sense.

-Takahiro AKASHI

> 
> David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
