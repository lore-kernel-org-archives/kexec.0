Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-by2on0133.outbound.protection.outlook.com
 ([207.46.100.133] helo=na01-by2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1ZuDun-0004wu-HH
 for kexec@lists.infradead.org; Thu, 05 Nov 2015 06:20:54 +0000
Message-ID: <1446704423.12676.91.camel@freescale.com>
Subject: Re: [PATCH] kexec: Add --lite option
From: Scott Wood <scottwood@freescale.com>
Date: Thu, 5 Nov 2015 00:20:23 -0600
In-Reply-To: <1445474248.30908.115.camel@infradead.org>
References: <1445469125.30908.105.camel@infradead.org>
 <5628279C.7030104@ozlabs.org> <1445474248.30908.115.camel@infradead.org>
MIME-Version: 1.0
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
To: Geoff Levand <geoff@infradead.org>
Cc: kexec@lists.infradead.org, Jeremy Kerr <jk@ozlabs.org>, Petitboot@lists.ozlabs.org, Anton Blanchard <anton@samba.org>

On Wed, 2015-10-21 at 17:37 -0700, Geoff Levand wrote:
> Hi Jeremy,
> 
> On Thu, 2015-10-22 at 08:02 +0800, Jeremy Kerr wrote:
> > Add a new option --lite to kexec that allows for a fast reboot
> > > by avoiding the purgatory integrity checks.  This option is
> > > intended for use by kexec based bootloaders that load a new
> > > image and then immediately transfer control to it.
> > 
> > Can we call this something other than 'lite'? I'd want to prevent any
> > confusion when referring to 'kexec-lite', which is a separate
> > project.
> 
> Well, that is why I chose the name 'lite', because it mimics what kexec
> -lite does...
> 
> What do others think?

I don't think it's a good name.  Even if the user has any idea what the kexec-
lite project is and that this is a reference to it, you're mimicking a 
specific aspect of kexec-lite behavior, not kexec-lite in general.

If it's an option to skip sha256 verification, then call it something like "--
skip-sha256".

-Scott


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
