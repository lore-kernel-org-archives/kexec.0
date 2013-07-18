Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from aserp1040.oracle.com ([141.146.126.69])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Uzni6-0001Sq-Mt
 for kexec@lists.infradead.org; Thu, 18 Jul 2013 12:53:31 +0000
Date: Thu, 18 Jul 2013 14:52:58 +0200
From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [PATCH v2 7/7] Use elf_getshdrstrndx() instead of
 elf_getshstrndx()
Message-ID: <20130718125258.GB11233@debian70-amd64.local.net-space.pl>
References: <1373977929-4253-1-git-send-email-daniel.kiper@oracle.com>
 <1373977929-4253-8-git-send-email-daniel.kiper@oracle.com>
 <20130718170322.ea01294e20c9cdc810b40eb9@mxc.nes.nec.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20130718170322.ea01294e20c9cdc810b40eb9@mxc.nes.nec.co.jp>
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
To: Atsushi Kumagai <kumagai-atsushi@mxc.nes.nec.co.jp>
Cc: andrew.cooper3@citrix.com, xen-devel@lists.xensource.com, kexec@lists.infradead.org

On Thu, Jul 18, 2013 at 05:03:22PM +0900, Atsushi Kumagai wrote:
> On Tue, 16 Jul 2013 14:32:09 +0200
> Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> > Use elf_getshdrstrndx() instead of elf_getshstrndx()
> > because later is marked as deprecated.
> >
> > Signed-off-by: Daniel Kiper <daniel.kiper@oracle.com>
>
> Good, I'll merge this patch into v1.5.5.

Thanks. What about patches 4, 5 and 6.
Do you have any comments about them?
Should I fix something?

Daniel

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
