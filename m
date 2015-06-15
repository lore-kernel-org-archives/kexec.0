Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mail-ie0-x232.google.com ([2607:f8b0:4001:c03::232])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4UZt-0002oV-KE
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 13:37:30 +0000
Received: by iebgx4 with SMTP id gx4so62383181ieb.0
 for <kexec@lists.infradead.org>; Mon, 15 Jun 2015 06:37:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150615131728.GK15793@thunk.org>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
Date: Mon, 15 Jun 2015 09:37:05 -0400
Message-ID: <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
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

On Mon, Jun 15, 2015 at 9:17 AM, Theodore Ts'o <tytso@mit.edu> wrote:
> On Mon, Jun 15, 2015 at 08:14:19AM -0400, Josh Boyer wrote:
>> Yes, which is why most of the distro vendors carry an out-of-tree
>> patch that disables the old kexec in an SB setup.  It would be nice if
>> we could merge said patches.  However, they depend on Matthew's
>> secure_modules/trusted_kernel/<whatever name that works> patchset
>> which has gotten little movement since we came up with a tentative
>> agreement at LPC 2013.
>
> Signed modules is in, though, right?  And the fact that we have

Yes.

> CONFIG_SIGNED_PE_FILE_VERIFICATION means we're doing unatural file
> signatures w/o using ELF, which I thought was the basis of Linus's
> accusation that Red Hat was performing intimate/physical acts with
> Microsoft.  :-)
>
> I would have thought those were the nasty bits to get in; out of
> curiosity, what's still missing?

The bits that actually read Secure Boot state out of the UEFI
variables, and apply protections to the machine to avoid compromise
under the SB threat model.  Things like disabling the old kexec,
enforcing module signatures at runtime, restricting various access
(like /dev/mem, /dev/kmem), adding certs in UEFI db to the system
keyring, and enforcing the UEFI dbx blacklist.  So most of the patches
in Matthew's set relate to enforcement using the bits of functionality
already merged.  They aren't even strictly tied to UEFI or SB, but
some of the other patches distos carry are.  We had tentative
agreement even from Linus on much of this (his words were along the
lines of "create a flag and use the flag"), but it's failed to
actually get carried in any tree for a few reasons.

josh

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
