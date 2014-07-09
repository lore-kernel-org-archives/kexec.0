Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4ukQ-0003dY-TQ
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 16:29:35 +0000
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20140709160349.GA5292@pd.tnic>
References: <20140709160349.GA5292@pd.tnic>
 <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
Subject: Re: [PATCH 00/17] KEYS: PKCS#7 and PE file signature checking for
 kexec
MIME-Version: 1.0
Content-ID: <7856.1404923329.1@warthog.procyon.org.uk>
Date: Wed, 09 Jul 2014 17:28:49 +0100
Message-ID: <7857.1404923329@warthog.procyon.org.uk>
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
To: Borislav Petkov <bp@alien8.de>
Cc: keyrings@linux-nfs.org, x86-ml <x86@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>

Borislav Petkov <bp@alien8.de> wrote:

> let me see if I get this straight:
> 
> this current submission is supposed to replace
> 
> http://lkml.kernel.org/r/20140708131504.28621.61165.stgit@warthog.procyon.org.uk

Yes.  It's an extension of that.  Plus I did it wrong and managed to lose the
actual first patch, I realise.

> and Vivek's one:
> 
> http://lkml.kernel.org/r/1404421641-12691-1-git-send-email-vgoyal@redhat.com
> 
> (which added those parsers to arch/x86/kernel/ - not a good place anyway.)

Yep.

> The kexec bits with the sig verif will come ontop, it seems. What's the
> story guys?

Here's an example of what I think it could look like:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-modsign.git/log/?h=kexec-pefile

I did the following:

 (1) Rebased all but the last of Vivek's patches onto the same base as my
     pkcs7 and pefile patches.

 (2) Substituted on of Andrew Morton's patches for one of Vivek's.

 (3) Stacked a merge of my stuff on top of Vivek's.

 (4) Stacked Vivek's final patch on top of that and fixed it to work with my
     changed stuff.

I'm leaving that to Vivek as to when he wants to push that out, though - and
whether or not he wants to push from my tree or his own.

David

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
