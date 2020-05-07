Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWonW-0007Bi-AD
 for kexec@lists.infradead.org; Thu, 07 May 2020 22:15:19 +0000
Date: Thu, 7 May 2020 18:15:03 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] kernel: add panic_on_taint
Message-ID: <20200507221503.GL205881@optiplex-lnx>
References: <20200506222815.274570-1-aquini@redhat.com>
 <C5E11731-5503-45CC-9F72-41E8863ACD27@lca.pw>
 <20200507204219.GJ205881@optiplex-lnx>
 <27AA744E-930A-492A-BE87-05A119FE1549@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27AA744E-930A-492A-BE87-05A119FE1549@lca.pw>
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
To: Qian Cai <cai@lca.pw>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, dyoung@redhat.com

On Thu, May 07, 2020 at 06:05:27PM -0400, Qian Cai wrote:
> 
> 
> > On May 7, 2020, at 4:42 PM, Rafael Aquini <aquini@redhat.com> wrote:
> > 
> > On Wed, May 06, 2020 at 10:50:19PM -0400, Qian Cai wrote:
> >> 
> >> 
> >>> On May 6, 2020, at 6:28 PM, Rafael Aquini <aquini@redhat.com> wrote:
> >>> 
> >>> Analogously to the introduction of panic_on_warn, this patch
> >>> introduces a kernel option named panic_on_taint in order to
> >>> provide a simple and generic way to stop execution and catch
> >>> a coredump when the kernel gets tainted by any given taint flag.
> >>> 
> >>> This is useful for debugging sessions as it avoids rebuilding
> >>> the kernel to explicitly add calls to panic() or BUG() into
> >>> code sites that introduce the taint flags of interest.
> >>> Another, perhaps less frequent, use for this option would be
> >>> as a mean for assuring a security policy (in paranoid mode)
> >>> case where no single taint is allowed for the running system.
> >> 
> >> Andrew, you can drop the patch below from -mm now because that one is now obsolete,
> >> 
> >> mm-slub-add-panic_on_error-to-the-debug-facilities.patch
> >> 
> > Please, don't drop it yet. I'll send a patch to get rid of the bits,
> > once this one gets accepted, if it gets accepted.
> 
> Why do you ever want that obsolete patch even show up in linux-next to potentailly waste other people/bots time to test it and develop things on top of it?
>

It's a reasonable and self-contained feature that we have a valid use for. 
I honestly fail to see it causing that amount of annoyance as you are 
suggesting here.


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
