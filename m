Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from relay3.sgi.com ([192.48.152.1] helo=relay.sgi.com)
 by bombadil.infradead.org with esmtp (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Xk1Ub-00032n-Lv
 for kexec@lists.infradead.org; Fri, 31 Oct 2014 01:59:11 +0000
Date: Fri, 31 Oct 2014 01:58:43 +0000
From: Hedi Berriche <hedi@sgi.com>
Subject: Re: [PATCH] kernel, add panic_on_warn
Message-ID: <20141031015843.GW9743@dangermouse.emea.sgi.com>
References: <1414688627-5298-1-git-send-email-prarit@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
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
To: Prarit Bhargava <prarit@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, isimatu.yasuaki@jp.fujitsu.com, Andi Kleen <ak@linux.intel.com>, linux-doc@vger.kernel.org, linux-api@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, jbaron@akamai.com, "H. Peter Anvin" <hpa@zytor.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Andrew Morton <akpm@linux-foundation.org>, vgoyal@redhat.com

On Thu, Oct 30, 2014 at 17:06 Prarit Bhargava wrote:
| There have been several times where I have had to rebuild a kernel to
| cause a panic when hitting a WARN() in the code in order to get a crash
| dump from a system.  Sometimes this is easy to do, other times (such as
| in the case of a remote admin) it is not trivial to send new images to the
| user.
| 
| A much easier method would be a switch to change the WARN() over to a
| panic.  This makes debugging easier in that I can now test the actual
| image the WARN() was seen on and I do not have to engage in remote
| debugging.

Do we want to leave it to usersspace[1] to ensure panic_on_warn is out
of the way in when the kdump kernel boots? or would a self-contained
approach be more preferable i.e. test whether we're a kdump kernel
before bothering with panic_on_warn?

Cheers,
Hedi.

[1] kexec-tools in the case of the boot param by filtering it out of the
    kdump kernel cmdline. In the case of sysctl.conf, it would depend on
    whether there are distros out there that  include it in the kdump
    initrd.

-- 
Hedi Berriche
Linux Kernel Engineer
http://www.sgi.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
