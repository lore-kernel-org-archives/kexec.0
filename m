Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYD6p-0003sR-Al
 for kexec@lists.infradead.org; Mon, 11 May 2020 18:25:00 +0000
Received: by mail-pj1-f66.google.com with SMTP id q24so8190972pjd.1
 for <kexec@lists.infradead.org>; Mon, 11 May 2020 11:24:58 -0700 (PDT)
Date: Mon, 11 May 2020 18:24:55 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v3] kernel: add panic_on_taint
Message-ID: <20200511182455.GR11244@42.do-not-panic.com>
References: <20200509135737.622299-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200509135737.622299-1-aquini@redhat.com>
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
To: Rafael Aquini <aquini@redhat.com>
Cc: linux-doc@vger.kernel.org, tiwai@suse.de, jeffm@suse.com, bhe@redhat.com, corbet@lwn.net, labbott@redhat.com, dyoung@redhat.com, AnDavis@suse.com, rpalethorpe@suse.de, keescook@chromium.org, jikos@kernel.org, cai@lca.pw, bunk@kernel.org, tytso@mit.edu, jeyu@suse.de, gregkh@linuxfoundation.org, rdunlap@infradead.org, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org

On Sat, May 09, 2020 at 09:57:37AM -0400, Rafael Aquini wrote:
> +Trigger Kdump on add_taint()
> +============================
> +
> +The kernel parameter, panic_on_taint, calls panic() from within add_taint(),
> +whenever the value set in this bitmask matches with the bit flag being set
> +by add_taint(). This will cause a kdump to occur at the panic() call.
> +In cases where a user wants to specify this during runtime,
> +/proc/sys/kernel/panic_on_taint can be set to a respective bitmask value
> +to achieve the same behaviour.
> +
>  Contact
>  =======
>  
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 7bc83f3d9bdf..4a69fe49a70d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3404,6 +3404,21 @@
>  	panic_on_warn	panic() instead of WARN().  Useful to cause kdump
>  			on a WARN().
>  
> +	panic_on_taint=	[KNL] conditionally panic() in add_taint()
> +			Format: <str>
> +			Specifies, as a string, the TAINT flag set that will
> +			compose a bitmask for calling panic() when the kernel
> +			gets tainted.
> +			See Documentation/admin-guide/tainted-kernels.rst for
> +			details on the taint flags that users can pick to
> +			compose the bitmask to assign to panic_on_taint.
> +			When the string is prefixed with a '-' the bitmask
> +			set in panic_on_taint will be mutually exclusive
> +			with the sysctl knob kernel.tainted, and any attempt
> +			to write to that sysctl will fail with -EINVAL for
> +			any taint value that masks with the flags set for
> +			this option.

This talks about using a string, but that it sets a bitmask. Its not
very clear that one must use the string representation from each taint
flag. Also, I don't think to use the character representation as we
limit ourselves to the alphabet and quirky what-should-be-arbitrary
characters that represent the taint flags. The taint flag character
representation is juse useful for human reading of a panic, but I think
because of the limitation of the mask with the alphabet this was not
such a great idea long term.

So, I don't think we should keep on extending the alphabet use case, a
simple digit representation would suffice. I think this means we'd need
two params one for exclusive and one for the value of the taint.

Using a hex value or number also lets us make the input value shorter.

If a kernel boots with panic-on-taint flag not yet supported, we don't
complain, therefore getting a false sense of security that we will panic
with a not yet supported taint flag. I think we should pr_warn() or
fail to boot when that happens.

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
