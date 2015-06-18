Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z5Oah-0006wL-SY
 for kexec@lists.infradead.org; Thu, 18 Jun 2015 01:26:04 +0000
Date: Thu, 18 Jun 2015 09:25:36 +0800
From: Dave Young <dyoung@redhat.com>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150618012536.GC8718@dhcp-128-32.nay.redhat.com>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20150615200115.GG5003@thunk.org>
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
To: Theodore Ts'o <tytso@mit.edu>, Josh Boyer <jwboyer@fedoraproject.org>, Eric Biederman <ebiederm@xmission.com>, David Howells <dhowells@redhat.com>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>

On 06/15/15 at 04:01pm, Theodore Ts'o wrote:
> On Mon, Jun 15, 2015 at 09:37:05AM -0400, Josh Boyer wrote:
> > The bits that actually read Secure Boot state out of the UEFI
> > variables, and apply protections to the machine to avoid compromise
> > under the SB threat model.  Things like disabling the old kexec...
> 
> I don't have any real interest in using Secure Boot, but I *am*
> interested in using CONFIG_KEXEC_VERIFY_SIG[1].  So perhaps we need to
> have something similar to what we have with signed modules in terms of
> CONFIG_MODULE_SIG_FORCE and module/sig_enforce, but for
> KEXEC_VERIFY_SIG.  This would mean creating a separate flag
> independent of the one Linus suggested for Secure Boot, but since we
> have one for signed modules, we do have precedent for this sort of
> thing.

Agree and vote for this way as I replied in another email about
CONFIG_KEXEC_VERIFY_SIG_FORCE.

Thanks
Dave

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
