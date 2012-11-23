Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from youngberry.canonical.com ([91.189.89.112])
 by merlin.infradead.org with esmtp (Exim 4.76 #1 (Red Hat Linux))
 id 1TboCU-0007z4-Ov
 for kexec@lists.infradead.org; Fri, 23 Nov 2012 08:01:30 +0000
Message-ID: <50AF2D42.8000707@canonical.com>
Date: Fri, 23 Nov 2012 09:01:06 +0100
From: Bouchard Louis <louis.bouchard@canonical.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 01/11] kexec: introduce kexec_ops struct
References: <1353423893-23125-1-git-send-email-daniel.kiper@oracle.com>
 <1353423893-23125-2-git-send-email-daniel.kiper@oracle.com>
 <87lidwtego.fsf@xmission.com>
 <20121121105221.GA2925@host-192-168-1-59.local.net-space.pl>
 <87txshx28b.fsf@xmission.com> <50AE6542.3020302@zytor.com>
 <50AEBF86.50501@citrix.com>
 <18e831d4-910d-4f58-8911-1398b96e3a47@email.android.com>
 <50AED7B8.7040902@citrix.com>
In-Reply-To: <50AED7B8.7040902@citrix.com>
List-Id: <kexec.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec@lists.infradead.org>
List-Help: <mailto:kexec-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: kexec-bounces@lists.infradead.org
Errors-To: kexec-bounces+dwmw2=infradead.org@lists.infradead.org
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, Daniel Kiper <daniel.kiper@oracle.com>, "x86@kernel.org" <x86@kernel.org>, "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "mingo@redhat.com" <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "jbeulich@suse.com" <jbeulich@suse.com>, "H. Peter Anvin" <hpa@zytor.com>, "tglx@linutronix.de" <tglx@linutronix.de>

Hi,

Le 23/11/2012 02:56, Andrew Cooper a =E9crit :
> For within-guest kexec/kdump functionality, I agree that it is barking
> mad.  However, we do see cloud operators interested in the idea so VM
> administrators can look after their crashes themselves.

It's not "barking mad" when your dayjob is to investigate and fix other
people's kernel problems.  Right now, it's impossible to get a kernel
image of a failing EC2 instance, so every time someone shows up with a
"my kernel crashes in my instance", we're lest with mostly unusable
backtraces and oops messages.

When I'm able to reproduce someone's kernel panic, I'm quite happy to be
able to use virtualization to run a kernel dump analysis on a locally
reproduced context.

It's also quite useful when packaging things like makedumpfile,
kdump-tools to be able to avoid having to rely on bare metal to test new
releases. So yes, in theory it may look barking mad, but real life is
somewhat different.

Kind regards,

...Louis
-- =

Louis Bouchard
Backline Support Analyst
Canonical Ltd
Ubuntu support: http://landscape.canonical.com

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
