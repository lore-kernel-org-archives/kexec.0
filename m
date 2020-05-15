Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZgv8-0002hx-MR
 for kexec@lists.infradead.org; Fri, 15 May 2020 20:27:04 +0000
Received: by mail-pg1-f196.google.com with SMTP id f6so1537286pgm.1
 for <kexec@lists.infradead.org>; Fri, 15 May 2020 13:26:59 -0700 (PDT)
Date: Fri, 15 May 2020 20:26:56 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v5] kernel: add panic_on_taint
Message-ID: <20200515202656.GZ11244@42.do-not-panic.com>
References: <20200515175502.146720-1-aquini@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200515175502.146720-1-aquini@redhat.com>
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

On Fri, May 15, 2020 at 01:55:02PM -0400, Rafael Aquini wrote:
> Analogously to the introduction of panic_on_warn, this patch introduces a kernel
> option named panic_on_taint in order to provide a simple and generic way to stop
> execution and catch a coredump when the kernel gets tainted by any given flag.
> 
> This is useful for debugging sessions as it avoids having to rebuild the kernel
> to explicitly add calls to panic() into the code sites that introduce the taint
> flags of interest. For instance, if one is interested in proceeding with a
> post-mortem analysis at the point a given code path is hitting a bad page
> (i.e. unaccount_page_cache_page(), or slab_bug()), a coredump can be collected
> by rebooting the kernel with 'panic_on_taint=0x20' amended to the command line.
> 
> Another, perhaps less frequent, use for this option would be as a mean for
> assuring a security policy case where only a subset of taints, or no single
> taint (in paranoid mode), is allowed for the running system.
> The optional switch 'nousertaint' is handy in this particular scenario,
> as it will avoid userspace induced crashes by writes to sysctl interface
> /proc/sys/kernel/tainted causing false positive hits for such policies.
> 
> Suggested-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Rafael Aquini <aquini@redhat.com>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
