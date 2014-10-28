Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xj5nS-0002tB-GG
 for kexec@lists.infradead.org; Tue, 28 Oct 2014 12:22:46 +0000
Message-ID: <544F8A78.9070008@redhat.com>
Date: Tue, 28 Oct 2014 08:22:16 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH V4] kernel, add bug_on_warn
References: <1414155207-29839-1-git-send-email-prarit@redhat.com>
 <20141028121636.GC3274@tassilo.jf.intel.com>
In-Reply-To: <20141028121636.GC3274@tassilo.jf.intel.com>
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
Cc: Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, jason.wessel@windriver.com, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, linux-api@vger.kernel.org, vgoyal@redhat.com



On 10/28/2014 08:16 AM, Andi Kleen wrote:
> On Fri, Oct 24, 2014 at 08:53:27AM -0400, Prarit Bhargava wrote:
>> There have been several times where I have had to rebuild a kernel to
>> cause a panic when hitting a WARN() in the code in order to get a crash
>> dump from a system.  Sometimes this is easy to do, other times (such as
>> in the case of a remote admin) it is not trivial to send new images to the
>> user.
>>
>> A much easier method would be a switch to change the WARN() over to a
>> BUG().  This makes debugging easier in that I can now test the actual
>> image the WARN() was seen on and I do not have to engage in remote
>> debugging.
> 
> IMHO this would be better and far more generically done with kdb. 
> You would need two things:
> 
> - Extend the break point command to run another command on a break point.
> - Add a command line (or possibly /proc) option to execute some kdb commands at
> kernel boot.

I suppose ... but that would mean I would have to explain to an end user the
elaborate process of enabling kdb, inserting a break point, etc.  The whole
purpose of this is to let an end user panic on WARN() easily.

Asking an end user to enable kdb is magnitudes worse than asking them to
recompile a kernel.

P.

> 
> Then just set a break point on the warn function and execute magic sysrq c
> from kdb.
> 
> -Andi
> 

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
