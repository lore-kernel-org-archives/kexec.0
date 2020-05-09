Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXQu6-0007ol-0D
 for kexec@lists.infradead.org; Sat, 09 May 2020 14:56:39 +0000
Date: Sat, 9 May 2020 10:56:14 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200509145614.GA6704@x1-fbsd>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507182257.GX11244@42.do-not-panic.com>
 <20200507184307.GF205881@optiplex-lnx>
 <20200507184705.GG205881@optiplex-lnx>
 <20200507203340.GZ11244@42.do-not-panic.com>
 <20200507220606.GK205881@optiplex-lnx>
 <20200507222558.GA11244@42.do-not-panic.com>
 <20200508124719.GB367616@optiplex-lnx>
 <20200509034854.GI11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509034854.GI11244@42.do-not-panic.com>
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

On Sat, May 09, 2020 at 03:48:54AM +0000, Luis Chamberlain wrote:
> On Fri, May 08, 2020 at 08:47:19AM -0400, Rafael Aquini wrote:
> > On Thu, May 07, 2020 at 10:25:58PM +0000, Luis Chamberlain wrote:
> > > On Thu, May 07, 2020 at 06:06:06PM -0400, Rafael Aquini wrote:
> > > > On Thu, May 07, 2020 at 08:33:40PM +0000, Luis Chamberlain wrote:
> > > > > I *think* that a cmdline route to enable this would likely remove the
> > > > > need for the kernel config for this. But even with Vlastimil's work
> > > > > merged, I think we'd want yet-another value to enable / disable this
> > > > > feature. Do we need yet-another-taint flag to tell us that this feature
> > > > > was enabled?
> > > > >
> > > > 
> > > > I guess it makes sense to get rid of the sysctl interface for
> > > > proc_on_taint, and only keep it as a cmdline option. 
> > > 
> > > That would be easier to support and k3eps this simple.
> > > 
> > > > But the real issue seems to be, regardless we go with a cmdline-only option
> > > > or not, the ability of proc_taint() to set any arbitrary taint flag 
> > > > other than just marking the kernel with TAINT_USER. 
> > > 
> > > I think we would have no other option but to add a new TAINT flag so
> > > that we know that the taint flag was modified by a user. Perhaps just
> > > re-using TAINT_USER when proc_taint() would suffice.
> > >
> > 
> > We might not need an extra taint flag if, perhaps, we could make these
> > two features mutually exclusive. The idea here is that bitmasks added 
> > via panic_on_taint get filtered out in proc_taint(), so a malicious 
> > user couldn't exploit the latter interface to easily panic the system,
> > when the first one is also in use. 
> 
> I get it, however I I can still see the person who enables enabling
> panic-on-tain wanting to know if proc_taint() was used. So even if
> it was not on their mask, if it was modified that seems like important
> information for a bug report analysis.
>

For that purpose (tracking user taints) I think sth between these lines
would work:

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 8a176d8727a3..651a82c13621 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2602,6 +2602,9 @@ int proc_douintvec(struct ctl_table *table, int write,
                                 do_proc_douintvec_conv, NULL);
 }

+/* track which taint bits were set by the user */
+static unsigned long user_tainted;
+
 /*
  * Taint values can only be increased
  * This means we can safely use a temporary.
@@ -2629,11 +2632,20 @@ static int proc_taint(struct ctl_table *table, int write,
                 */
                int i;
                for (i = 0; i < BITS_PER_LONG && tmptaint >> i; i++) {
-                       if ((tmptaint >> i) & 1)
+                       if ((tmptaint >> i) & 1) {
+                               set_bit(i, &user_tainted);
                                add_taint(i, LOCKDEP_STILL_OK);
+                       }
                }
        }

+       /*
+        * Users with SYS_ADMIN capability can fiddle with any arbitrary
+        * taint flag through this interface.
+        * If that's the case, we also need to mark the kernel "tainted by user"
+        */
+       add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
        return err;
 }


I don't think, though, it's panic_on_taint work to track that. I posted a v3 for
this feature with a way to select if one wants to avoid user forced taints
triggering panic() for flags also set for panic_on_taint.

Cheers,

-- Rafael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
