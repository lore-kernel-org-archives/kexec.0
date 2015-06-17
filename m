Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from
 7.3.c.8.2.a.e.f.f.f.8.1.0.3.2.0.9.6.0.7.2.3.f.b.0.b.8.0.1.0.0.2.ip6.arpa
 ([2001:8b0:bf32:7069:230:18ff:fea2:8c37] helo=lxorguk.ukuu.org.uk)
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5B0s-0003Na-AY
 for kexec@lists.infradead.org; Wed, 17 Jun 2015 10:56:11 +0000
Date: Wed, 17 Jun 2015 11:55:20 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150617115520.5eec8224@lxorguk.ukuu.org.uk>
In-Reply-To: <20150615200115.GG5003@thunk.org>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
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
To: Theodore Ts'o <tytso@mit.edu>
Cc: David Howells <dhowells@redhat.com>, Josh Boyer <jwboyer@fedoraproject.org>, kexec <kexec@lists.infradead.org>, Eric Biederman <ebiederm@xmission.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

> [1] Yes, it doesn't buy all that much, since if the system is rooted
> the adversary can just replace the kernel in /boot and force a normal,
> slower reboot, but the same could be said for signed modules --- the
> adversary could just replace all of /boot/vmlinux-<kver> and
> /lib/modules/<kver>.  But both measures make it a tad more bit
> difficult, especially for the adversary to do this replacement without
> being noticed (for example linode will send me e-mail if the system
> reboots normally, but not with a kexec-mediated reboot), and for cloud
> systems where we don't have secure boot anyway, it's about the best we
> can do.

It's about the same as the protection offered by the "secure" boot
patches I've seen because they don't block all kernel boot parameters
except a whitelist and because there are a pile of other fairly
fundamental problems that probably require you also sign the root file
system, which is itself a world of pain.

Alan

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
