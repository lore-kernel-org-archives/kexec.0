Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj6KT-0006CX-KZ
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 12:56:54 +0000
Date: Tue, 28 Oct 2014 05:56:30 -0700
From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH V4] kernel, add bug_on_warn
Message-ID: <20141028125630.GF3274@tassilo.jf.intel.com>
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <20141028121636.GC3274@tassilo.jf.intel.com>
 <544F8A78.9070008@redhat.com> <20141028122900.GA10632@redhat.com>
 <20141028124425.GD3274@tassilo.jf.intel.com>
 <544F90B1.1070102@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <544F90B1.1070102@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, jason.wessel@windriver.com, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

> > If you have a command line option to execute kdb commands you still
> > would only have a command line option, just a slightly longer one.
> > 
> > kdb="on, bp warn_slowpath_common sr c, go" 
> 
> KDB is not on all kernels.  This would require me to go to great lengths to

Repeating incorrect statements doesn't suddenly make them correct.

Assuming KDB is compiled in the only setup needed would be the line above.

-Andi


_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
