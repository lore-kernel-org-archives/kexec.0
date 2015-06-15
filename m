Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from imap.thunk.org ([2600:3c02::f03c:91ff:fe96:be03])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4UGu-00017a-Hg
 for kexec@lists.infradead.org; Mon, 15 Jun 2015 13:17:53 +0000
Date: Mon, 15 Jun 2015 09:17:28 -0400
From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: kexec_load(2) bypasses signature verification
Message-ID: <20150615131728.GK15793@thunk.org>
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
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

On Mon, Jun 15, 2015 at 08:14:19AM -0400, Josh Boyer wrote:
> Yes, which is why most of the distro vendors carry an out-of-tree
> patch that disables the old kexec in an SB setup.  It would be nice if
> we could merge said patches.  However, they depend on Matthew's
> secure_modules/trusted_kernel/<whatever name that works> patchset
> which has gotten little movement since we came up with a tentative
> agreement at LPC 2013.

Signed modules is in, though, right?  And the fact that we have
CONFIG_SIGNED_PE_FILE_VERIFICATION means we're doing unatural file
signatures w/o using ELF, which I thought was the basis of Linus's
accusation that Red Hat was performing intimate/physical acts with
Microsoft.  :-)

I would have thought those were the nasty bits to get in; out of
curiosity, what's still missing?

Regards,

						- Ted

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
