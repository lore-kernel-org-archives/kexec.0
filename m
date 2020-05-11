Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYEeS-0002Cx-T0
 for kexec@lists.infradead.org; Mon, 11 May 2020 20:03:50 +0000
Date: Mon, 11 May 2020 16:03:25 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200511200325.GE367616@optiplex-lnx>
References: <20200509135737.622299-1-aquini@redhat.com>
 <20200511182455.GR11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200511182455.GR11244@42.do-not-panic.com>
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
Cc: linux-doc@vger.kernel.org, tiwai@suse.de, jeffm@suse.com, bhe@redhat.com, corbet@lwn.net, labbott@redhat.com, dyoung@redhat.com, AnDavis@suse.com, rpalethorpe@suse.de, keescook@chromium.org, jikos@kernel.org, cai@lca.pw, bunk@kernel.org, tytso@mit.edu, jeyu@suse.de, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Mon, May 11, 2020 at 06:24:55PM +0000, Luis Chamberlain wrote:
> On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> > +Trigger Kdump on add_taint()
> > +============================
> > +
> > +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> > +whenever the value set in this bitmask matches with the bit flag being set
> > +by add_taint(). This will cause a kdump to occur at the panic() call.
> > +In cases where a user wants to specify this during runtime,
> > +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> > +to achieve the same behaviour.
> > +
> >  Contact
> >  =======
> >  
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 7bc83f3d9bdf..4a69fe49a70d 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -3404,6 +3404,21 @@
> >  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
> >  			on a WARN().
> >  
> > +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> > +			Format: <str>
> > +			Specifies, as a string, the TAINT flag set that will
> > +			compose a bitmask for calling panic() when the kernel
> > +			gets tainted.
> > +			See Documentation/admin-guide/tainted-kernels.rst for
> > +			details on the taint flags that users can pick to
> > +			compose the bitmask to assign to panic_on_taint.
> > +			When the string is prefixed with a '-' the bitmask
> > +			set in panic_on_taint will be mutually exclusive
> > +			with the sysctl knob kernel.tainted, and any attempt
> > +			to write to that sysctl will fail with -EINVAL for
> > +			any taint value that masks with the flags set for
> > +			this option.
> 
> This talks about using a string, but that it sets a bitmask. Its not
> very clear that one must use the string representation from each taint
> flag. Also, I don't think to use the character representation as we
> limit ourselves to the alphabet and quirky what-should-be-arbitrary
> characters that represent the taint flags. The taint flag character
> representation is juse useful for human reading of a panic, but I think
> because of the limitation of the mask with the alphabet this was not
> such a great idea long term.
>

I respectfully disagree with you on this one, but that might be just
because I'm a non-native English speaker and the cause of confusion is 
not very clear to me. Would you mind providing a blurb with a text that
you think it would be clearer on this regard?

Also, making the input of the option to match with something one
is used to see in taint reports make it easier to use. It would
be still a human setting the boot option, so it makes sense to
utilize a known/meaningful representation for panic_on_taint input.

 
> So, I don't think we should keep on extending the alphabet use case, a
> simple digit representation would suffice. I think this means we'd need
> two params one for exclusive and one for the value of the taint.
> 
> Using a hex value or number also lets us make the input value shorter.
>

Albeit you're right on the limitation of an alphabetical representation, 
the truth is that taint flags are not introduced that frequently.
Considering how many times these flags were introduced in the past,
one could infer we probably will not run out of alphabet in the next 20 
years (a couple of new flags gets introduced every 2 years, or so, in
average), and the rate of change in these seems to be slowing down
considerably, as in the past 5 years, we've seen only 2 new flags.

I'm not against your suggestion, though, but I think it makes
clumsier to utilize the feature as you now require 2 kernel
cmdline options, instead of just one, and a less intuitive
way of setting it via base16 values. All at the expense of 
a theoretical shortage of taint flags. 

If the others that were already OK with the simple string interface 
don't object your change suggestions in that regard, I'll refactor
the parser to meet them. 


> If a kernel boots with panic-on-taint flag not yet supported, we don't
> complain, therefore getting a false sense of security that we will panic
> with a not yet supported taint flag. I think we should pr_warn() or
> fail to boot when that happens.
>

Bear in mind that these very early print outs (like the ones eventually
produced by setting panic_on_taint) to the log buffer might get lost in 
verbose-logging long-running time systems, but apart from that, I see no 
problems in being a little bit more verbose in that parser. I'll make
the changes for a next revision, if no one else objects them.

Cheers!
-- Rafael


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
