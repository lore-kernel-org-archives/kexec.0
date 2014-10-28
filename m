Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj6DH-0001vT-CO
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 12:49:28 +0000
Message-ID: <544F90B1.1070102@redhat.com>
Date: Tue, 28 Oct 2014 08:48:49 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V4] kernel, add bug_on_warn
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <20141028121636.GC3274@tassilo.jf.intel.com> <544F8A78.9070008@redhat.com>
 <20141028122900.GA10632@redhat.com>
 <20141028124425.GD3274@tassilo.jf.intel.com>
In-Reply-To: <20141028124425.GD3274@tassilo.jf.intel.com>
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



On 10/28/2014 08:44 AM, Andi Kleen wrote:
>>> I suppose ... but that would mean I would have to explain to an end user the
>>> elaborate process of enabling kdb, inserting a break point, etc.  The whole
>>> purpose of this is to let an end user panic on WARN() easily.
>>>
>>> Asking an end user to enable kdb is magnitudes worse than asking them to
>>> recompile a kernel.
>>
>> Agreed. Asking a customer to setup and run kdb and put breakpoints is much
>> more pain than simply asking to reboot kernel with a command line option.
> 
> If you have a command line option to execute kdb commands you still
> would only have a command line option, just a slightly longer one.
> 
> kdb="on, bp warn_slowpath_common sr c, go" 

KDB is not on all kernels.  This would require me to go to great lengths to
explain to a user how to set it up, etc., rather than saying "Hi, please add
panic_on_warn as a kernel parameter/echo 1 into /proc/sys/kernel/panic_on_warn
and on the next time you see that WARN() the system will panic and kdump.  Send
me that kdump."

> 
> But it would be a generic facility instead of a special purpose hack.

Generic to KDB be configured on and it is in no way trivial to use.

P.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
