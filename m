Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x230.google.com ([2607:f8b0:4001:c03::230])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XmqnD-0000kR-C9
 for kexec@lists.infradead.org; Fri, 07 Nov 2014 21:10:04 +0000
Received: by mail-ie0-f176.google.com with SMTP id rd18so5821637iec.7
 for <kexec@lists.infradead.org>; Fri, 07 Nov 2014 13:09:42 -0800 (PST)
Date: Fri, 7 Nov 2014 13:09:40 -0800 (PST)
From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v8] kernel, add panic_on_warn
In-Reply-To: <545CA765.8010403@redhat.com>
Message-ID: <alpine.DEB.2.10.1411071306370.12192@chino.kir.corp.google.com>
References: <1415187736-16242-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.10.1411051357050.31575@chino.kir.corp.google.com>
 <545B733C.6080903@redhat.com>
 <alpine.DEB.2.10.1411061352440.1526@chino.kir.corp.google.com>
 <20141106220731.GA13590@redhat.com>
 <alpine.DEB.2.10.1411070214220.32405@chino.kir.corp.google.com>
 <545CA765.8010403@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, jbaron@akamai.com, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

On Fri, 7 Nov 2014, Prarit Bhargava wrote:

> There very much is.  Consider a thread that hits a WARN() and then panics.  Then
> somewhere in the panic code the thread hits another WARN() ... and then panics
> again.  Previously this would have caused the system to "finish" panick'ing.
> Now it makes the system hang.
> 

Then we're back to square one which is what is obviously the intent of 
your patch and the comment that goes along with it: we want to clear 
panic_on_warn once and not allow multiple panic().  So why not just add 
the necessary synchronization to make sure that happens when WARN() 
happens on two cpus simultaneously?

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
