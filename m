Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from out03.mta.xmission.com ([166.70.13.233])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1Z4wmZ-0000V2-1c
 for kexec@lists.infradead.org; Tue, 16 Jun 2015 19:44:27 +0000
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20150615035051.GA2634@thunk.org>
 <CA+5PVA6t_dEQt1M7HkeHy9znFkPd-a7525vtFq-g4a6VKL+gLQ@mail.gmail.com>
 <20150615131728.GK15793@thunk.org>
 <CA+5PVA6YKR_=uVpM2rW4et3YCJLh9c+uuxt2koH1Fy2ZuR7W-g@mail.gmail.com>
 <20150615200115.GG5003@thunk.org>
Date: Tue, 16 Jun 2015 14:38:31 -0500
In-Reply-To: <20150615200115.GG5003@thunk.org> (Theodore Ts'o's message of
 "Mon, 15 Jun 2015 16:01:15 -0400")
Message-ID: <87zj3zigug.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Subject: Re: kexec_load(2) bypasses signature verification
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
Cc: Josh Boyer <jwboyer@fedoraproject.org>, Petr Tesarik <ptesarik@suse.cz>, kexec <kexec@lists.infradead.org>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>


Adding Vivek as he is the one who implemented kexec_file_load.
I was hoping he would respond to this thread, and it looks like he
simply has not ever been Cc'd.

Theodore Ts'o <tytso@mit.edu> writes:

> On Mon, Jun 15, 2015 at 09:37:05AM -0400, Josh Boyer wrote:
>> The bits that actually read Secure Boot state out of the UEFI
>> variables, and apply protections to the machine to avoid compromise
>> under the SB threat model.  Things like disabling the old kexec...
>
> I don't have any real interest in using Secure Boot, but I *am*
> interested in using CONFIG_KEXEC_VERIFY_SIG[1].  So perhaps we need to
> have something similar to what we have with signed modules in terms of
> CONFIG_MODULE_SIG_FORCE and module/sig_enforce, but for
> KEXEC_VERIFY_SIG.  This would mean creating a separate flag
> independent of the one Linus suggested for Secure Boot, but since we
> have one for signed modules, we do have precedent for this sort of
> thing.

My overall request with respect to kexec has been that we implement
things that make sense outside of the bizarre threat model of the Linux
folks who were talking about secure boot.

nI have not navigated the labyrinth of config options but having a way to
only boot signed things with kexec seems a completely sensible way to
operate in the context of signed images.

I don't know how much that will help given that actors with sufficient
resources have demonstrated the ability to steal private keys, but
assuming binary signing is an effective technique (or why else do it)
then having an option to limit kexec to only loading signed images seems
sensible.

Eric

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
