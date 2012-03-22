Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-gx0-f177.google.com ([209.85.161.177])
 by merlin.infradead.org with esmtps (Exim 4.76 #1 (Red Hat Linux))
 id 1SAnU5-0008D2-71
 for kexec@lists.infradead.org; Thu, 22 Mar 2012 19:15:42 +0000
Received: by ggnk1 with SMTP id k1so2395033ggn.36
 for <kexec@lists.infradead.org>; Thu, 22 Mar 2012 12:15:37 -0700 (PDT)
MIME-Version: 1.0
From: Marti Raudsepp <marti@juffo.org>
Date: Thu, 22 Mar 2012 21:14:56 +0200
Message-ID: <CABRT9RAB--szWwmYO9_JyjXRP-9YYgkG-TsAg8jS=birUF2e=w@mail.gmail.com>
Subject: Doing kexec reboot right in systemd
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
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: kexec list <kexec@lists.infradead.org>
Cc: Simon Horman <horms@verge.net.au>, systemd-devel <systemd-devel@lists.freedesktop.org>, Lennart Poettering <lennart@poettering.net>

Hi list,

I was recently pondering how systemd could use kexec "properly", in a
reasonably general way, to make reboots faster. I exchanged an email
with Poettering on the systemd list and he suggested me to ask here.

My current proposal:
1. Include a template 'kexec-load.service' with kexec-tools, which
distros/users could customize to load the right kernel and initrd via
/sbin/kexec

2. If the user does 'systemctl enable kexec-load.service', then this
service would trigger before every reboot. Loading the kernel any
earlier would waste memory (5+14 MB on Ubuntu Server). Also a common
reason for rebooting is to boot into a newly-installed kernel. Loading
it any earlier would boot you into an older kernel.

3. During a reboot, after systemd has finished shutting down, it
detects via /sys/kernel/kexec_loaded whether the kexec kernel is
loaded. If 1, it performs a 'kexec -e'. If not, it does a normal
reboot.

----

Lennart commented on #2 that kexec might have problems finding
contiguous memory to load the kernel into, this late in the lifecycle.
Do you think this is a deal-breaker for such a feature? If it's rare
enough, then it might not be a problem -- we can always fall back to a
normal reboot.

I'm also assuming that "kexec --load" will fail atomically -- that it
won't try to boot a half-loaded kernel, or boot a kernel whose initrd
failed to load.

Also, #3 doesn't yet work that way in systemd (currently it detects
before shutdown) and Poettering hasn't agreed yet.

Does this proposal seem sane to kexec folks? Did I miss anything?

----

Here are my and Poettering's initial thoughts on this matter:
http://lists.freedesktop.org/archives/systemd-devel/2012-March/004760.html
http://lists.freedesktop.org/archives/systemd-devel/2012-March/004764.html

PS: I hope I haven't broken any rules by cross-posting this. This
question seems relevant to both projects.

Regards,
Marti

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
