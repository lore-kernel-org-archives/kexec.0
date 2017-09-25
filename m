Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20170922075807.GM17186@linaro.org>
References: <20170922075807.GM17186@linaro.org>
 <20170915105932.25338-1-takahiro.akashi@linaro.org>
 <20170915105932.25338-4-takahiro.akashi@linaro.org>
 <20170921073516.GA6643@dhcp-128-65.nay.redhat.com>
Subject: Re: [PATCH v3 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
MIME-Version: 1.0
Content-ID: <1622.1506353803.1@warthog.procyon.org.uk>
Date: Mon, 25 Sep 2017 16:36:43 +0100
Message-ID: <1623.1506353803@warthog.procyon.org.uk>
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
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: herbert@gondor.apana.org.au, bhe@redhat.com, ard.biesheuvel@linaro.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org, dhowells@redhat.com, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mpe@ellerman.id.au, bauerman@linux.vnet.ibm.com, akpm@linux-foundation.org, Dave Young <dyoung@redhat.com>, davem@davemloft.net, vgoyal@redhat.com

AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:

> > > -static struct kexec_file_ops *kexec_file_loaders[] = {
> > > +struct kexec_file_ops *kexec_file_loaders[] = {
> > >  	&kexec_elf64_ops,
> > > +	NULL
> > >  };

const?

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
