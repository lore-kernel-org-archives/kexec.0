Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from terminus.zytor.com ([2001:1868:205::10] helo=mail.zytor.com)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1XjtT6-0005Rd-FU
 for kexec@lists.infradead.org; Thu, 30 Oct 2014 17:25:06 +0000
Message-ID: <54527443.6030007@zytor.com>
Date: Thu, 30 Oct 2014 10:24:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] kernel, add panic_on_warn
References: <1414688627-5298-1-git-send-email-prarit@redhat.com>
In-Reply-To: <1414688627-5298-1-git-send-email-prarit@redhat.com>
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
To: Prarit Bhargava <prarit@redhat.com>, linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, kexec@lists.infradead.org, Rusty Russell <rusty@rustcorp.com.au>, linux-doc@vger.kernel.org, jbaron@akamai.com, Fabian Frederick <fabf@skynet.be>, isimatu.yasuaki@jp.fujitsu.com, linux-api@vger.kernel.org, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

On 10/30/2014 10:03 AM, Prarit Bhargava wrote:
> There have been several times where I have had to rebuild a kernel to
> cause a panic when hitting a WARN() in the code in order to get a crash
> dump from a system.  Sometimes this is easy to do, other times (such as
> in the case of a remote admin) it is not trivial to send new images to the
> user.
> 
> A much easier method would be a switch to change the WARN() over to a
> panic.  This makes debugging easier in that I can now test the actual
> image the WARN() was seen on and I do not have to engage in remote
> debugging.
> 
> This patch adds a panic_on_warn kernel parameter and
> /proc/sys/kernel/panic_on_warn calls panic() in the warn_slowpath_common()
> path.  The function will still print out the location of the warning.
> 
> An example of the panic_on_warn output:
> 
> The first line below is from the WARN_ON() to output the WARN_ON()'s location.
> After that the panic() output is displayed.
> 

There is another very valid use for this: many operators would rather a
machine shuts down than being potentially compromised either
functionally or security-wise.

	-hpa



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
