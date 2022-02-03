From: Michal =?unknown-8bit?q?Such=C3=A1nek?= <msuchanek@suse.de>
Date: Thu, 3 Feb 2022 11:49:26 +0100
Subject: [PATCH v5 3/6] kexec_file: Don't opencode appended signature
 verification.
In-Reply-To: <YfBafIXgnLzf0QMb@bombadil.infradead.org>
References: <cover.1641900831.git.msuchanek@suse.de>
 <7834eb187ef67cd88fc67f10e831130e3717d776.1641900831.git.msuchanek@suse.de>
 <YfBafIXgnLzf0QMb@bombadil.infradead.org>
Message-ID: <20220203104926.GA3113@kunlun.suse.cz>
List-Id: <kexec.lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kexec@lists.infradead.org

Hello,

thanks for the review.

On Tue, Jan 25, 2022 at 12:15:56PM -0800, Luis Chamberlain wrote:
> On Tue, Jan 11, 2022 at 12:37:45PM +0100, Michal Suchanek wrote:
> > diff --git a/include/linux/verification.h b/include/linux/verification.h
> > index a655923335ae..32db9287a7b0 100644
> > --- a/include/linux/verification.h
> > +++ b/include/linux/verification.h
> > @@ -60,5 +60,8 @@ extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
> >  				   enum key_being_used_for usage);
> >  #endif
> >  
> > +int verify_appended_signature(const void *data, unsigned long *len,
> > +			      struct key *trusted_keys, const char *what);
> > +
> 
> Looks very non-module specific.

Which it is now that the same signature format is used for kernels.

> 
> > diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> > index 8723ae70ea1f..30149969f21f 100644
> > --- a/kernel/module_signing.c
> > +++ b/kernel/module_signing.c
> > @@ -14,32 +14,38 @@
> >  #include <crypto/public_key.h>
> >  #include "module-internal.h"
> >  
> > -/*
> > - * Verify the signature on a module.
> > +/**
> > + * verify_appended_signature - Verify the signature on a module with the
> > + * signature marker stripped.
> > + * @data: The data to be verified
> > + * @len: Size of @data.
> > + * @trusted_keys: Keyring to use for verification
> > + * @what: Informational string for log messages
> >   */
> > -int mod_verify_sig(const void *mod, struct load_info *info)
> > +int verify_appended_signature(const void *data, unsigned long *len,
> > +			      struct key *trusted_keys, const char *what)
> >  {
> > -	struct module_signature ms;
> > -	size_t sig_len, modlen = info->len;
> > +	struct module_signature *ms;
> 
> There goes the abstraction, so why not make this clear where we re-use
> the struct module_signature for various things and call it as it is,
> verify_mod_appended_signature() or some such?

It sounds like the abstraction is actually improved by callers no longer
dealing with struct module_signature when verifying signature on a
kernel. That is the structure is misnamed but it is now hidden behind
an abstraction.

Or am I missing something?

Thanks

Michal

