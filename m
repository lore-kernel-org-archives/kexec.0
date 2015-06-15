Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imap.thunk.org ([2600:3c02::f03c:91ff:fe96:be03])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4aZg-00086c-Bh
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 20:01:41 +0000
Date: Mon, 15 Jun 2015 16:01:15 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150615200115.GG5003@thunk.org>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
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
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: David Howells <dhowells@redhat.com>, kexec <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On Mon, Jun 15, 2015 at 09:37:05AM -0400, Josh Boyer wrote:
> The bits that actually read Secure Boot state out of the UEFI
> variables, and apply protections to the machine to avoid compromise
> under the SB threat model.  Things like disabling the old kexec...

I don't have any real interest in using Secure Boot, but I *am*
interested in using CONFIG_KEXEC_VERIFY_SIG[1].  So perhaps we need to
have something similar to what we have with signed modules in terms of
CONFIG_MODULE_SIG_FORCE and module/sig_enforce, but for
KEXEC_VERIFY_SIG.  This would mean creating a separate flag
independent of the one Linus suggested for Secure Boot, but since we
have one for signed modules, we do have precedent for this sort of
thing.

						- Ted

[1] Yes, it doesn't buy all that much, since if the system is rooted
the adversary can just replace the kernel in /boot and force a normal,
slower reboot, but the same could be said for signed modules --- the
adversary could just replace all of /boot/vmlinux-<kver> and
/lib/modules/<kver>.  But both measures make it a tad more bit
difficult, especially for the adversary to do this replacement without
being noticed (for example linode will send me e-mail if the system
reboots normally, but not with a kexec-mediated reboot), and for cloud
systems where we don't have secure boot anyway, it's about the best we
can do.

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
