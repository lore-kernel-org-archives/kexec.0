Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWleF-0007su-Uk
 for kexec@lists.infradead.org; Thu, 07 May 2020 18:53:33 +0000
Date: Thu, 7 May 2020 14:53:15 -0400
From: Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] kernel: add panic_on_taint
Message-ID: <20200507185315.GH205881@optiplex-lnx>
References: <20200507180631.308441-1-aquini@redhat.com>
 <20200507185046.GY11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200507185046.GY11244@42.do-not-panic.com>
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
Cc: rdunlap@infradead.org, keescook@chromium.org, bhe@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, cai@lca.pw, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, dyoung@redhat.com

On Thu, May 07, 2020 at 06:50:46PM +0000, Luis Chamberlain wrote:
> On Thu, May 07, 2020 at 02:06:31PM -0400, Rafael Aquini wrote:
> > Another, perhaps less frequent, use for this option would be
> > as a mean for assuring a security policy (in paranoid mode)
> > case where no single taint is allowed for the running system.
> 
> If used for this purpose then we must add a new TAINT flag for
> proc_taint() was used, otherwise we can cheat to show a taint
> *did* happen, where in fact it never happened, some punk just
> echo'd a value into the kernel's /proc/sys/kernel/tainted.
>

To accomplish that, the punk would need to be root, though, in which 
case everything else is doomed, already.
 
> Forunately proc_taint() only allows to *increment* the taint, not
> reduce.
> 
>   Luis
> 


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
