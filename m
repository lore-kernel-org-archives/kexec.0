Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay10.mail.gandi.net ([217.70.178.230])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYvnh-0006yz-C2
 for kexec@lists.infradead.org; Wed, 13 May 2020 18:08:14 +0000
Date: Wed, 13 May 2020 11:07:46 -0700
From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/3] security: add symbol namespace for reading file data
Message-ID: <20200513180746.GA75734@localhost>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-3-mcgrof@kernel.org>
 <87k11fonbk.fsf@x220.int.ebiederm.org>
 <20200513161622.GS11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513161622.GS11244@42.do-not-panic.com>
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
Cc: rafael@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, gregkh@linuxfoundation.org, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Wed, May 13, 2020 at 04:16:22PM +0000, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 10:40:31AM -0500, Eric W. Biederman wrote:
> > Luis Chamberlain <mcgrof@kernel.org> writes:
> > 
> > > Certain symbols are not meant to be used by everybody, the security
> > > helpers for reading files directly is one such case. Use a symbol
> > > namespace for them.
> > >
> > > This will prevent abuse of use of these symbols in places they were
> > > not inteded to be used, and provides an easy way to audit where these
> > > types of operations happen as a whole.
> > 
> > Why not just remove the ability for the firmware loader to be a module?
> > 
> > Is there some important use case that requires the firmware loader
> > to be a module?
> > 
> > We already compile the code in by default.  So it is probably just
> > easier to remove the modular support all together.  Which would allow
> > the export of the security hooks to be removed as well.
> 
> Yeah, that's a better solution. The only constaint I am aware of is
> we *cannot* change the name of the module from firmware_class since the
> old fallback sysfs loader depends on the module name. So, so long as we
> take care with that on built-in and document this very well, I think
> we should be good.
> 
> I checked the commit logs and this was tristate since the code was added
> upstream, so I cannot see any good reason it was enabled as modular.
> 
> Speaking with a *backports experience* hat on, we did have a use case
> to use a module for it in case a new feature was added upstream which
> was not present on older kernels. However I think that using a separate
> symbol prefix would help with that.
> 
> Would any Android stakeholders / small / embedded folks whave any issue
> with this?

As long as you can still *completely* compile out firmware loading, I
don't think there's a huge use case for making it modular. y/n seems
fine.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
