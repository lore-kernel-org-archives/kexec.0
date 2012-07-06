Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mo6-p00-ob.rzone.de ([2a01:238:20a:202:5300::1])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SnCLW-0000uD-D7
 for kexec@lists.infradead.org; Fri, 06 Jul 2012 17:29:35 +0000
Date: Fri, 6 Jul 2012 19:29:18 +0200
From: Olaf Hering <olaf@aepfle.de>
Subject: Re: [Xen-devel] incorrect layout of globals from head_64.S during
 kexec boot
Message-ID: <20120706172918.GA15222@aepfle.de>
References: <20120705210607.GA26908@aepfle.de>
 <20120706084120.GA31219@router-fw-old.local.net-space.pl>
 <20120706120750.GA8970@aepfle.de>
 <4FF6FCA9020000780008E0BB@nat28.tlf.novell.com>
 <20120706133105.GA20600@aepfle.de>
 <20120706141419.GA21951@aepfle.de>
 <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4FF7174C020000780008E1FF@nat28.tlf.novell.com>
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
To: Jan Beulich <JBeulich@suse.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: xen-devel@lists.xensource.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Kiper <dkiper@net-space.pl>

On Fri, Jul 06, Jan Beulich wrote:

> > Could it be that some code tweaks the stack content used by decompress()
> > in some odd way? But that would most likely lead to a crash, not to
> > unexpected uncompressing results.
> 
> Especially if the old and new kernel are using the exact same
> image, how about the decompression writing over the shared
> info page causing all this? As the decompressor wouldn't
> expect Xen to possibly write stuff there itself, it could easily be
> that some repeat count gets altered, thus breaking the
> decompressed data without the decompression code necessarily
> noticing.

In my case the gfn of the shared info page is 1f54.
Is it possible to move the page at runtime? It looks like it can be done
because the hvm loader configures fffff initially.

Perhaps the PVonHVM code has to give up the shared pages or move them to
some dedicated unused page during the process of booting into the new
kernel.

Konrad, any idea how that could be done?

> If that's the case, there would be a more general problem here
> (for kdump at least), as granted pages could also still get written
> to when the new kernel already is in the process of launching.

Maybe you meant to say kexec instead of kdump?
kdump runs in its own memory area, so I think the worst thing is that
some pages of the crashed kernel get modified.

Olaf

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
