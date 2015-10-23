Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Message-ID: <1445626183.30908.198.camel@infradead.org>
Subject: Re: [PATCH] kexec: Add --lite option
From: Geoff Levand <geoff@infradead.org>
Date: Fri, 23 Oct 2015 11:49:43 -0700
In-Reply-To: <20151023094620.GG11227@dhcp-129-115.nay.redhat.com>
References: <1445469125.30908.105.camel@infradead.org>
 <20151022031718.GB11227@dhcp-129-115.nay.redhat.com>
 <1445540240.30908.134.camel@infradead.org>
 <20151023094620.GG11227@dhcp-129-115.nay.redhat.com>
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
To: Dave Young <dyoung@redhat.com>
Cc: panand@redhat.com, Simon Horman <horms@verge.net.au>, kexec@lists.infradead.org, Petitboot@lists.ozlabs.org, vgoyal@redhat.com

Hi Dave,

On Fri, 2015-10-23 at 17:46 +0800, Dave Young wrote:
> On 10/22/15 at 11:57am, Geoff Levand wrote:
> > As stated, this is not intended for use by kdump.
> > 
> > This is an optional feature.  It does not remove the integrity
> > checks, but provides the user a way to bypass them if they so
> > desire.
> 
> Problem is why they so desire to skip purgatory? what is the background?

This doesn't remove or skip purgatory.  Purgatory is still used.

What it does do is skip the digest calculations that are done
when an image is loaded (kexec --load), and it skips the digest
calculations and comparison when the new image is run
(kexec --exec).

The digest check is great for kdump, where the crash kernel is
loaded, and some time later a possibly unstable system tries to
do a kexec and we want to assure the integrity of the new image.
Kexec based bootloaders are very different.  They are running
in a stable state.  They load a new image and immediately
transfer control to that new image.  Because the system is in a
stable state, and very little is done between the time the image
is loaded and the time it is entered, there is little reason to
do an integrity check, and by avoiding it we can speed up the
boot process.


Faster boot (and re-boot) time is important to users, vendors,
highly available systems, they all want it.

-Geoff


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
