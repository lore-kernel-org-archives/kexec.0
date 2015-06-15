Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4Qgu-0004rV-Oe
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 09:28:29 +0000
Date: Mon, 15 Jun 2015 11:28:00 +0200
From: Petr Tesarik <ptesarik@suse.cz>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150615112800.273e42d4@hananiah.suse.cz>
In-Reply-To: <20150615091100.GA15858@dhcp-128-59.nay.redhat.com>
References: <20150615035051.GA2634@thunk.org>
 <20150615091100.GA15858@dhcp-128-59.nay.redhat.com>
MIME-Version: 1.0
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
To: Dave Young <dyoung@redhat.com>
Cc: dhowells@redhat.com, kexec@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>, Eric Biederman <ebiederm@xmission.com>

On Mon, 15 Jun 2015 17:11:00 +0800
Dave Young <dyoung@redhat.com> wrote:

> On 06/14/15 at 11:50pm, Theodore Ts'o wrote:
> > From experimentation and from looking at the sources, it appears that
> > the signature checking is only done in the kexec_file_load(2) system
> > all, and not in the kexec_load(2) system call.  And I understand why
> > -- the signature is not sent from userspace to the kernel in the older
> > kexec_load(2) system call.
> > 
> > The problem is that if you use an old version of kexec, it will use
> > the old kexec_load(2) system call, and even though
> > CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_load(2) will happily load an
> > unsigned kernel, and then "kexec -e" will happily boot into it.
> > 
> > Correct me if I am wrong, but this appears to be a hole in Secure Boot
> > you could drive a Mack Truck through.
> > 
> > (I noticed this because Debian is still using a kexec-tools from the
> > stone ages, version 2.0.7, and I was wondering **why** I was able to
> > kexec boot completely unsigned kernels.)
> > 
> > It would appear to me that if CONFIG_KEXEC_VERIFY_SIG is enabled, the
> > old kexec_load(2) system call should be disabled (and a warning be
> > placed in the Kconfig help that the user should have at least verision
> > 2.X of kexec-tools if they enable this kernel option).
> 
> IMO it is fine to disable old syscall incase CONFIG_KEXEC_VERIFY=y

Definitely. It is not possible to to sign all code passed through
kexec_load(2), at least not without giving kexec-tools the private part
of the key (which would effectively destroy the goal of Secure Boot).

Whenever signature verification is required, kexec_load(2) must be
disabled.

Petr Tesarik

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
