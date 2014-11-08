Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xn65c-0004gC-B6
 for kexec@lists.infradead.org; Sat, 08 Nov 2014 13:30:05 +0000
Message-ID: <545E1AB1.9030001@redhat.com>
Date: Sat, 08 Nov 2014 08:29:21 -0500
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8] kernel, add panic_on_warn
References: <1415187736-16242-1-git-send-email-prarit@redhat.com>
 <alpine.DEB.2.10.1411051357050.31575@chino.kir.corp.google.com>
 <545B733C.6080903@redhat.com>
 <alpine.DEB.2.10.1411061352440.1526@chino.kir.corp.google.com>
 <20141106220731.GA13590@redhat.com>
 <alpine.DEB.2.10.1411070214220.32405@chino.kir.corp.google.com>
 <545CA765.8010403@redhat.com>
 <alpine.DEB.2.10.1411071306370.12192@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.10.1411071306370.12192@chino.kir.corp.google.com>
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
To: David Rientjes <rientjes@google.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, jbaron@akamai.com, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>



On 11/07/2014 04:09 PM, David Rientjes wrote:
> On Fri, 7 Nov 2014, Prarit Bhargava wrote:
> 
>> There very much is.  Consider a thread that hits a WARN() and then panics.  Then
>> somewhere in the panic code the thread hits another WARN() ... and then panics
>> again.  Previously this would have caused the system to "finish" panick'ing.
>> Now it makes the system hang.
>>
> 
> Then we're back to square one which is what is obviously the intent of 
> your patch and the comment that goes along with it: 

My original reply pointed out that the comment was wrong.

we want to clear
> panic_on_warn once and not allow multiple panic().  

On _this_ thread.  The multiple panic across threads cannot occur.

So why not just add
> the necessary synchronization to make sure that happens when WARN() 
> happens on two cpus simultaneously?

See above.

P.

> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
