Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1asRa8-0002oi-70
 for kexec@lists.infradead.org; Tue, 19 Apr 2016 09:04:29 +0000
Date: Tue, 19 Apr 2016 17:04:01 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: Removal of the kernel code/data/bss resources does break
 kexec/kdump
Message-ID: <20160419090401.GA4348@dhcp-128-65.nay.redhat.com>
References: <570F6D99.6090400@gmail.com>
 <2f4d7dee6bb0e4afdc05f2b7457fcf79@abdsec.com>
 <CA+55aFwprUFh+cjB2fWmkMJ3Zgh6XSan0VO8Vr-80Qh0n0Rx+A@mail.gmail.com>
 <f80ca230bf1fab7527d355e535de305f@abdsec.com>
 <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+55aFxtuUBBJS4xxM5OiyZs04xjrpHPif+cO4U_s4OppeN-gg@mail.gmail.com>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Baoquan He <bhe@redhat.com>, Freeman Zhang <freeman.zhang1992@gmail.com>, kexec@lists.infradead.org, Zhengyu Zhang <zhezhang@redhat.com>, Emrah Demir <ed@abdsec.com>

On 04/14/16 at 06:02pm, Linus Torvalds wrote:
> On Thu, Apr 14, 2016 at 1:27 PM, Emrah Demir <ed@abdsec.com> wrote:
> > On 2016-04-14 13:40, Linus Torvalds wrote:
> >>
> >>
> >> Actually, %pK is horrible in /proc and /sys files, and does the wrong
> >> thing.
> >
> > I agree with that, but for now there is no way to make things right in /proc
> > or /sys.
> 
> Well, there is now.
> 
> I've pushed out my attempt at fixing things properly. Please check
> that kexec works - and if kexec ends up reading that file as non-root,
> I don't know what to say/do.
> 

Checked kexec/kdump, for kdump it will read /proc/kcore, /proc/kcore is root
only thus it will be fine with the changes.

Though in the comment of kexec_load syscall it says "for obvious reasons only
root may call it", but in the code it is using:
        if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
                return -EPERM;

So for kexec CAP_SYS_BOOT is enough, not necessarily to be root.

It is not clear how to handle it, maybe we can assume nobody is using it as
non-root, leave it as is or just add |CAP_SYS_BOOT for /proc/iomem?

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
