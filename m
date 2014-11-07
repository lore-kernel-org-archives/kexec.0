Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x229.google.com ([2607:f8b0:4001:c03::229])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmgaT-00068d-0b
 for kexec@lists.infradead.org; Fri, 07 Nov 2014 10:16:13 +0000
Received: by mail-ie0-f169.google.com with SMTP id tr6so4871681ieb.14
 for <kexec@lists.infradead.org>; Fri, 07 Nov 2014 02:15:48 -0800 (PST)
Date: Fri, 7 Nov 2014 02:15:46 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v8] kernel, add panic_on_warn
In-Reply-To: <20141106220731.GA13590@redhat.com>
Message-ID: <alpine.DEB.2.10.1411070214220.32405@chino.kir.corp.google.com>
References: <1415187736-16242-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.10.1411051357050.31575@chino.kir.corp.google.com>
 <545B733C.6080903@redhat.com>
 <alpine.DEB.2.10.1411061352440.1526@chino.kir.corp.google.com>
 <20141106220731.GA13590@redhat.com>
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
To: Vivek Goyal <vgoyal@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, jbaron@akamai.com, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org

On Thu, 6 Nov 2014, Vivek Goyal wrote:

> On Thu, Nov 06, 2014 at 01:57:36PM -0800, David Rientjes wrote:
> 
> [..]
> > You see that doing
> > 
> > 	if (panic_on_warn) {
> > 		panic_on_warn = 0;
> > 		panic(...);
> > 	}
> > 
> > is racy, I hope.  If two threads WARN() at the same time, then there's 
> > nothing preventing a double panic() because WARN() itself is not 
> > serialized against anything.  So both the current comment and your 
> > suggested revision comment are bogus.
> 
> panic() is serialized on panic_lock. So I guess it is fine to hit WARN()
> on multiple cpus. Do you see an issue there?
> 

No issue at all, what's completely mysterious is the panic_on_warn = 0 and 
the completely bogus comment that says "prevent further WARN()s from 
panicking the system" when that's racy.  There's no need to clear 
panic_on_warn at all.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
