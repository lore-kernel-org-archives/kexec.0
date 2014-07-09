Return-path: <kexec-bounces+dwmw2=infradead.org@lists.infradead.org>
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.80.1 #2 (Red Hat Linux))
 id 1X4udf-00018z-W9
 for kexec@lists.infradead.org; Wed, 09 Jul 2014 16:22:36 +0000
Date: Wed, 9 Jul 2014 12:21:52 -0400
From: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 00/17] KEYS: PKCS#7 and PE file signature checking for
 kexec
Message-ID: <20140709162152.GA3894@redhat.com>
References: <20140709151525.23074.32315.stgit@warthog.procyon.org.uk>
 <20140709160349.GA5292@pd.tnic>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20140709160349.GA5292@pd.tnic>
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
Cc: keyrings@linux-nfs.org, x86-ml <x86@kernel.org>, kexec@lists.infradead.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-security-module@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>

On Wed, Jul 09, 2014 at 06:03:49PM +0200, Borislav Petkov wrote:
> Hi David,
> 
> On Wed, Jul 09, 2014 at 04:15:25PM +0100, David Howells wrote:
> > David Howells (16):
> >       X.509: Add bits needed for PKCS#7
> >       X.509: Export certificate parse and free functions
> >       PKCS#7: Implement a parser [RFC 2315]
> >       PKCS#7: Digest the data in a signed-data message
> >       PKCS#7: Find the right key in the PKCS#7 key list and verify the signature
> >       PKCS#7: Verify internal certificate chain
> >       PKCS#7: Find intersection between PKCS#7 message and known, trusted keys
> >       PKCS#7: Provide a key type for testing PKCS#7
> >       KEYS: X.509: Fix a spelling mistake
> >       Provide PE binary definitions
> >       pefile: Parse a PE binary to find a key and a signature contained therein
> >       pefile: Strip the wrapper off of the cert data block
> >       pefile: Parse the presumed PKCS#7 content of the certificate blob
> >       pefile: Parse the "Microsoft individual code signing" data blob
> >       pefile: Digest the PE binary and compare to the PKCS#7 data
> >       pefile: Validate PKCS#7 trust chain
> > 
> > Vivek Goyal (1):
> >       pefile: Handle pesign using the wrong OID
> 
> let me see if I get this straight:
> 
> this current submission is supposed to replace
> 
> http://lkml.kernel.org/r/20140708131504.28621.61165.stgit@warthog.procyon.org.uk
> 
> and Vivek's one:
> 
> http://lkml.kernel.org/r/1404421641-12691-1-git-send-email-vgoyal@redhat.com
> 
> (which added those parsers to arch/x86/kernel/ - not a good place anyway.)
> 
> ?
> 
> The kexec bits with the sig verif will come ontop, it seems. What's the
> story guys?

[CC akpm and hpa]

Hi Boris,

Yes, this posting will replace above two postings as you said. David
howells anyway did all the original work. So he has refreshed all the
paches, fixed things, put them in right order and reposted.

These are the core patches required to make signature verification work
in bzImage.  We just need one more kexec patch on top which can call into
pefile logic to verify signature of file.

And that patch is sitting right now here.

https://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-modsign.git/commit/?h=kexec-pefile&id=7de6fb25559c1dc42e203646c44202cbe2e2fc2c

I am planning to post this single patch for review with explicit mention
to david howells's posting.

So now we have 3 pieces.

- Kexec new system call patches in -mm tree.
- PKCS7 and PEFILE signature verification patches as posted in this
  patch series.
- Final kexec patch which makes use of PEFILE function to do singature
  verification. I will post that patch soon.

I am hoping that last patch can go through david howells tree as it is
dependent on PKCS7 and PEFILE changes.

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/kexec
