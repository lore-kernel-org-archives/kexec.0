Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from bisque.oak.relay.mailchannels.net ([23.83.215.18])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1aqns8-0002BN-Q2
 for kexec@lists.infradead.org; Thu, 14 Apr 2016 20:28:17 +0000
MIME-Version: 1.0
Date: Thu, 14 Apr 2016 16:27:48 -0400
From: Emrah Demir <ed@abdsec.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
In-Reply-To: <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
Message-ID: <f80ca230bf1fab7527d355e535de305f@abdsec.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "kexec" <kexec-bounces@lists.infradead.org>
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Freeman Zhang <freeman.zhang1992@gmail.com>, linus971@gmail.com, kexec@lists.infradead.org

On 2016-04-14 13:40, Linus Torvalds wrote:
> 
> Actually, %pK is horrible in /proc and /sys files, and does the wrong 
> thing.
> 

I agree with that, but for now there is no way to make things right in 
/proc or /sys.


> 
> A file access should use "file->f_cred", but the seq_file interface
> sadly doesn't expose any way to do that.
> 
> I'll take a look, but it's non-trivial to get right. %pK turns out to
> have been seriously mis-designed, and is basically almost always a
> bug.
> 
>           Linus

In another way, maybe it's good to remove code dependencies on /proc 
sensitive files like /proc/iomem.

Kees Coook: "it looks like at least Ubuntu's kernel security test suite
expects to find these entries (when it verifies that STRICT_DEVMEM
hasn't regressed)"

Freeman Zhang: "Removal of these information causes 'kexec/kdump' to 
fail in the newer
kernel"

Removing such dependencies would make things better and code/bss/data 
sections could be removed.



_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
