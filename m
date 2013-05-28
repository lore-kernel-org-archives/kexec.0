Return-path: <kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org>
Received: from out01.mta.xmission.com ([166.70.13.231])
 by merlin.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1UhP9X-0004yW-5F
 for kexec@lists.infradead.org; Tue, 28 May 2013 19:01:47 +0000
In-Reply-To: <20130528143756.GD7088@redhat.com>
References: <51A02E50.5020507@gmail.com> <87mwri8wwu.fsf@xmission.com>
 <20130528143756.GD7088@redhat.com>
MIME-Version: 1.0
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 28 May 2013 12:00:45 -0700
Message-ID: <ec5cd077-c314-49d5-8970-439ffb9539fa@email.android.com>
Subject: Re: [PATCH 0/7] Remove unused /dev/oldmem interface
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
Errors-To: kexec-bounces+dwmw2=twosheds.infradead.org@lists.infradead.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "kexec@lists.infradead.org" <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Zhang Yanfei <zhangyanfei.yes@gmail.com>




>
>Should we schedule the removal of this interface after 1-2 releases
>and give a warning once if anybody opens /dev/oldmem and tell them
>to use /proc/vmcore instead? 

How can anyone use /dev/oldmem correctly?  To the best of
my knowledge there are no parsers of the ELF header passed
by /sbin/kexec in userspace.

If there is anyone who cares they can complain and we can
revert the removal. All of the evidence is that everyone uses
/proc/vmcore.

>I am kind of inclined towards warning approarch. If there is any xyz
>/dev/oldmem user in the wild out there, he/she atleast gets a chance to
>migrate to /proc/vmcore.

If there is a user out there that does not choose to participate
in the community, or pay someone to participate on their
behalf, it saddens me but I don't care.

All someone has to do is to keep a weather eye on the kexec
mailing list, the linux kernel mailing list or simply run a test
kernel, and tell us that they use /dev/oldmem.  That is grounds
under the no regression rule for a revert.

At a practical level a user who does not care will likely be using
a frozen kernel and won't notice until they finally decide to
upgrade their kernel, in several years time.

I don't think we should carry an apparently dead interface
around for the next five years on the off chance someone uses
it.  Especially with no users and no one who cares we won't
maintain the interface properly and it will bit rot and be
broken.

Which means if there is someone using /dev/oldmem we have
a choice of what to do in 5 years time when someone notices.
- Field a bug report about someones kdump implementation
  acting weird.
- Deal with a report of someones kdump implementation not
  working because /dev/oldmem is gone.

With /dev/oldmem gone at least we will be able to get to the root cause of the problem.  -ENODEV.

Which is a long way of saying this is the time for anyone who uses /dev/oldmem to speak now or forever hold their piece.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
