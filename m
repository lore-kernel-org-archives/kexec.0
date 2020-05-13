Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYtwx-0000Fp-3a
 for kexec@lists.infradead.org; Wed, 13 May 2020 16:09:40 +0000
Date: Wed, 13 May 2020 18:09:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] security: add symbol namespace for reading file data
Message-ID: <20200513160936.GC1362525@kroah.com>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513152108.25669-3-mcgrof@kernel.org>
 <87k11fonbk.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87k11fonbk.fsf@x220.int.ebiederm.org>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: rafael@kernel.org, zohar@linux.ibm.com, dhowells@redhat.com, Luis Chamberlain <mcgrof@kernel.org>, paul@paul-moore.com, nayna@linux.ibm.com, jmorris@namei.org, geert@linux-m68k.org, dan.carpenter@oracle.com, keescook@chromium.org, scott.branden@broadcom.com, selinux@vger.kernel.org, viro@zeniv.linux.org.uk, skhan@linuxfoundation.org, eparis@parisplace.org, tglx@linutronix.de, stephen.smalley.work@gmail.com, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, jeyu@kernel.org, linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, bauerman@linux.ibm.com

On Wed, May 13, 2020 at 10:40:31AM -0500, Eric W. Biederman wrote:
> Luis Chamberlain <mcgrof@kernel.org> writes:
> 
> > Certain symbols are not meant to be used by everybody, the security
> > helpers for reading files directly is one such case. Use a symbol
> > namespace for them.
> >
> > This will prevent abuse of use of these symbols in places they were
> > not inteded to be used, and provides an easy way to audit where these
> > types of operations happen as a whole.
> 
> Why not just remove the ability for the firmware loader to be a module?

I agree, it's been a mess of build options to try to keep alive over
time.

> Is there some important use case that requires the firmware loader
> to be a module?

I don't think so anymore.

> We already compile the code in by default.  So it is probably just
> easier to remove the modular support all together.  Which would allow
> the export of the security hooks to be removed as well.

Agreed.

thanks,

greg k-h

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
