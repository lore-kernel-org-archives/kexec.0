Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ig0-x233.google.com ([2607:f8b0:4001:c05::233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4THl-0005nC-CA
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 12:14:41 +0000
Received: by igboe5 with SMTP id oe5so27973696igb.1
 for <kexec@lists.infradead.org>; Mon, 15 Jun 2015 05:14:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150615035051.GA2634@thunk.org>
References: <20150615035051.GA2634@thunk.org>
Date: Mon, 15 Jun 2015 08:14:19 -0400
Message-ID: <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
Subject: Re: kexec_load(2) bypasses signature verification
From: Josh Boyer <jwboyer@fedoraproject.org>
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
To: Theodore Ts'o <tytso@mit.edu>, Eric Biederman <ebiederm@xmission.com>, David Howells <dhowells@redhat.com>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Sun, Jun 14, 2015 at 11:50 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> From experimentation and from looking at the sources, it appears that
> the signature checking is only done in the kexec_file_load(2) system
> all, and not in the kexec_load(2) system call.  And I understand why
> -- the signature is not sent from userspace to the kernel in the older
> kexec_load(2) system call.
>
> The problem is that if you use an old version of kexec, it will use
> the old kexec_load(2) system call, and even though
> CONFIG_KEXEC_VERIFY_SIG is enabled, kexec_load(2) will happily load an
> unsigned kernel, and then "kexec -e" will happily boot into it.
>
> Correct me if I am wrong, but this appears to be a hole in Secure Boot
> you could drive a Mack Truck through.

Yes, which is why most of the distro vendors carry an out-of-tree
patch that disables the old kexec in an SB setup.  It would be nice if
we could merge said patches.  However, they depend on Matthew's
secure_modules/trusted_kernel/<whatever name that works> patchset
which has gotten little movement since we came up with a tentative
agreement at LPC 2013.

> (I noticed this because Debian is still using a kexec-tools from the
> stone ages, version 2.0.7, and I was wondering **why** I was able to
> kexec boot completely unsigned kernels.)
>
> It would appear to me that if CONFIG_KEXEC_VERIFY_SIG is enabled, the
> old kexec_load(2) system call should be disabled (and a warning be
> placed in the Kconfig help that the user should have at least verision
> 2.X of kexec-tools if they enable this kernel option).
>
> Am I missing something?

Those sound like fine suggestions to me.

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
