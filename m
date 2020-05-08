Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX2Po-0004HU-OR
 for kexec@lists.infradead.org; Fri, 08 May 2020 12:47:46 +0000
Date: Fri, 8 May 2020 08:47:19 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200508124719.GB367616@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
 <20200507220606.GK205881@optiplex-lnx>
 <20200507222558.GA11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200507222558.GA11244@42.do-not-panic.com>
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
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-doc@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Jeff Mahoney <jeffm@suse.com>, bhe@redhat.com, corbet@lwn.net, Laura Abbott <labbott@redhat.com>, dyoung@redhat.com, Ann Davis <AnDavis@suse.com>, Richard Palethorpe <rpalethorpe@suse.de>, keescook@chromium.org, Jiri Kosina <jikos@kernel.org>, cai@lca.pw, Adrian Bunk <bunk@kernel.org>, Tso Ted <tytso@mit.edu>, Jessica Yu <jeyu@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, May 07, 2020 at 10:25:58PM +0000, Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 06:06:06PM -0400, Rafael Aquini wrote:
> > On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> > > I *think* that a cmdline route to enable this would likely remove the
> > > need for the kernel config for this. But even with Vlastimil's work
> > > merged, I think we'd want yet-another value to enable / disable this
> > > feature. Do we need yet-another-taint flag to tell us that this feature
> > > was enabled?
> > >
> > 
> > I guess it makes sense to get rid of the sysctl interface for
> > proc_on_taint, and only keep it as a cmdline option. 
> 
> That would be easier to support and k3eps this simple.
> 
> > But the real issue seems to be, regardless we go with a cmdline-only option
> > or not, the ability of proc_taint() to set any arbitrary taint flag 
> > other than just marking the kernel with TAINT_USER. 
> 
> I think we would have no other option but to add a new TAINT flag so
> that we know that the taint flag was modified by a user. Perhaps just
> re-using TAINT_USER when proc_taint() would suffice.
>

We might not need an extra taint flag if, perhaps, we could make these
two features mutually exclusive. The idea here is that bitmasks added 
via panic_on_taint get filtered out in proc_taint(), so a malicious 
user couldn't exploit the latter interface to easily panic the system,
when the first one is also in use. 
 
-- Rafael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
