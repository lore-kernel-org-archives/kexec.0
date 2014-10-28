Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj6gN-0005Xo-TK
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 13:19:32 +0000
Message-ID: <544F97C4.8000203@redhat.com>
Date: Tue, 28 Oct 2014 09:19:00 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V4] kernel, add bug_on_warn
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <20141028121636.GC3274@tassilo.jf.intel.com> <544F8A78.9070008@redhat.com>
 <20141028122900.GA10632@redhat.com>
 <20141028124425.GD3274@tassilo.jf.intel.com> <544F90B1.1070102@redhat.com>
 <20141028125630.GF3274@tassilo.jf.intel.com>
In-Reply-To: <20141028125630.GF3274@tassilo.jf.intel.com>
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
To: Andi Kleen <ak@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, jason.wessel@windriver.com, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>



On 10/28/2014 08:56 AM, Andi Kleen wrote:
>>> If you have a command line option to execute kdb commands you still
>>> would only have a command line option, just a slightly longer one.
>>>
>>> kdb="on, bp warn_slowpath_common sr c, go" 
>>
>> KDB is not on all kernels.  This would require me to go to great lengths to
> 
> Repeating incorrect statements doesn't suddenly make them correct.

It does when you're introducing unnecessary complexity here Andi.  You're not
listening to the original statement: I do not want to provide a modified kernel
to an end user for this simple situation anymore.

> 
> Assuming KDB is compiled in the only setup needed would be the line above.

That's a HUGE assumption.  It isn't and I'm still stuck in the same mess of
explaining how to recompile a kernel and/or providing a modified kernel to an
end user.  That isn't a good solution.

P.

> 
> -Andi
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
